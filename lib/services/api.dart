import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SetakApi {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  Future<String?> get base => storage.read(key: 'base_url');

  Future<Map<String, String>> _headers() async {
    final user = await storage.read(key: 'username');
    final pass = await storage.read(key: 'app_password');
    final token = base64Encode(utf8.encode('${user ?? ''}:${pass ?? ''}'));
    return {'Authorization': 'Basic $token', 'Accept': 'application/json', 'Content-Type': 'application/json'};
  }

  Future<dynamic> request(String method, String path, {Map<String, dynamic>? body, Map<String, String>? query}) async {
    var root = (await base ?? '').trim().replaceAll(RegExp(r'/$'), '');
    if (root.endsWith('/wp-json')) root = root.substring(0, root.length - 8);
    final uri = Uri.parse('$root/wp-json/setak-repair/v1$path').replace(queryParameters: query);
    final h = await _headers();
    late http.Response res;
    if (method == 'GET') res = await http.get(uri, headers: h);
    else if (method == 'POST') res = await http.post(uri, headers: h, body: jsonEncode(body ?? {}));
    else res = await http.put(uri, headers: h, body: jsonEncode(body ?? {}));
    dynamic data;
    try { data = jsonDecode(res.body); } catch (_) { data = {'message': res.body}; }
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ApiException((data is Map ? data['message'] : null)?.toString() ?? 'خطا در ارتباط با سرور', res.statusCode);
    }
    return data;
  }

  Future<Map<String, dynamic>> me() async => Map<String, dynamic>.from(await request('GET', '/me'));
  Future<Map<String, dynamic>> dashboard() async => Map<String, dynamic>.from(await request('GET', '/dashboard'));
  Future<Map<String, dynamic>> options() async => Map<String, dynamic>.from(await request('GET', '/options'));
  Future<List<dynamic>> technicians() async => List<dynamic>.from(await request('GET', '/technicians'));
  Future<Map<String, dynamic>> repairs({String search = '', String status = '', int page = 1}) async => Map<String, dynamic>.from(await request('GET', '/repairs', query: {'page':'$page','per_page':'30','search':search,'status':status}));
  Future<Map<String, dynamic>> repair(int id) async => Map<String, dynamic>.from(await request('GET', '/repairs/$id'));
  Future<Map<String, dynamic>> createRepair(Map<String, dynamic> data) async => Map<String, dynamic>.from(await request('POST', '/repairs', body: data));
  Future<Map<String, dynamic>> changeStatus(int id, String status, {String publicMessage = '', String internalNote = '', String reason = ''}) async => Map<String, dynamic>.from(await request('PUT', '/repairs/$id/status', body: {'status':status,'public_message':publicMessage,'internal_note':internalNote,'reason':reason}));
  Future<Map<String, dynamic>> saveSection(int id, String section, Map<String, dynamic> data) async => Map<String, dynamic>.from(await request('PUT', '/repairs/$id/$section', body: data));
}

class ApiException implements Exception {
  final String message; final int status;
  ApiException(this.message, this.status);
  @override String toString() => message;
}
