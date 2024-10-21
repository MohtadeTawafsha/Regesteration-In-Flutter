import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Method to insert user data into the "users" table
  Future<void> insertUser({
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String dateOfBirth,
    required String role,
  }) async {
    final response = await _client.from('users').insert({
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'dateOfBirth': dateOfBirth,
      'role': role,
    });

    if (response.error != null) {
      throw Exception('Failed to insert user: ${response.error!.message}');
    }
  }
}
