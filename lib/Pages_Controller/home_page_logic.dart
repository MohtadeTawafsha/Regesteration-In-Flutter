import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePageLogic {
  final SupabaseClient _client = Supabase.instance.client;
  final _notesStream = Supabase.instance.client.from('notes').stream(primaryKey: ['id']);

  Stream<List<Map<String, dynamic>>> get notesStream => _notesStream;

  Future<void> addNote(BuildContext context, String noteBody) async {
    final response = await _client.from('notes').insert({'body': noteBody});

    if (response.error != null) {
      print('Error: ${response.error!.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${response.error!.message}')),
      );
    } else {
      print('Note added successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Note added successfully')),
      );
      Navigator.pop(context); // Close the dialog
    }
  }
}
