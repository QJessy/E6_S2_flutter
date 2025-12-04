import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/User.dart';

class UserApi {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  Future<List<UserModel>> fetchUsers() async {
    final url = "$baseUrl/users";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> members = data['member'] ?? [];
      return members.map((item) => UserModel.fromJson(item)).toList();
    } else {
      throw Exception('Erreur HTTP ${response.statusCode}');
    }
  }
}
