import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/Message.dart';
import '../services/secure_storage.dart';

class MessageApi {
  final String baseUrl = dotenv.env['API_BASE_URL']!;

  Future<List<MessageModel>> fetchMessages() async {
    final url = "$baseUrl/messages";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> members = data['member'] ?? [];
      return members.map((item) => MessageModel.fromJson(item)).toList();
    } else {
      throw Exception('Erreur HTTP ${response.statusCode}');
    }
  }

  Future<bool> postMessage(String title, String content) async {
    final url = Uri.parse("$baseUrl/messages");
    final SecureStorage secureStorage =
        SecureStorage(); // Instance de votre service

    final token = await secureStorage.readToken();
    final userId = await secureStorage
        .readUserId(); // Utilisation de la nouvelle méthode

    if (userId == null) {
      print("Erreur : ID utilisateur introuvable. Connectez-vous à nouveau.");
      return false;
    }

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/ld+json',
        'Accept': 'application/ld+json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'titre': title,
        'contenu': content,
        'datePoste': DateTime.now().toIso8601String(),
        'user': '/E6_S2/api/users/$userId',
      }),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      print('Erreur lors de la requête: ${response.statusCode}');
      print('Corps de la réponse: ${response.body}');
      return false;
    }
  }
}
