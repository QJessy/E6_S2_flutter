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

Future<int> registerUser(
  String firstName,
  String lastName,
  String email,
  String password,
) async {
  final String baseUrl = dotenv.env['API_BASE_URL']!;
  final uri = Uri.parse("$baseUrl/users");
  // API Platform demande pour le POST application/ld+json' pour le Content-Type et le Accept
  final headers = {
    'Content-Type': 'application/ld+json',
    'Accept': 'application/ld+json',
  };
  // Construction du corps de la requête avec les données d’inscription
  final body = json.encode({
    'prenom': firstName,
    'nom': lastName,
    'email': email,
    'password': password,
  });
  try {
    final response = await http.post(uri, headers: headers, body: body);
    if (response.statusCode == 201) {
      return 201;
    } else {
      print("Échec : ${response.statusCode}\nRéponse : ${response.body}");
      return response.statusCode;
    }
  } catch (e) {
    print("Exception lors de la requête : $e");
    return 0; // Erreur réseau
  }
}
