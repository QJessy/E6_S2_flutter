import 'package:flutter/material.dart';
import '../api/message_api.dart';

class AjoutMessageScreen extends StatefulWidget {
  const AjoutMessageScreen({super.key});

  @override
  State<AjoutMessageScreen> createState() => _AjoutMessageScreenState();
}

class _AjoutMessageScreenState extends State<AjoutMessageScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool _isLoading = false;

  void _submitMessage() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      final success = await MessageApi().postMessage(
        _titleController.text,
        _contentController.text,
      );

      setState(() => _isLoading = false);

      if (mounted) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message publié !')),
          );
          Navigator.pop(context, true); // On renvoie true pour rafraîchir la liste
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Erreur lors de l\'envoi.')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nouveau Message')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) => value!.isEmpty ? 'Entrez un titre' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Contenu'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Entrez un contenu' : null,
              ),
              const SizedBox(height: 24),
              _isLoading 
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitMessage,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
                    child: const Text('Envoyer'),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}