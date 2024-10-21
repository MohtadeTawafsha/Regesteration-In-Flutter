import 'package:supabase_flutter/supabase_flutter.dart';

// Fetch user profile data from Supabase
Future<Map<String, dynamic>?> getUserProfile() async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return null;

  final response = await Supabase.instance.client
      .from('users')
      .select()
      .eq('id', user.id)
      .single();

  if (response != null && response.isNotEmpty) {
    return response; // Directly return the response if it's valid and contains data
  } else {
    print('Error fetching user data');
    return null;
  }

}

// Update user profile in Supabase
Future<void> updateUserProfile(Map<String, dynamic> updatedUser) async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) return;

  final response = await Supabase.instance.client
      .from('users')
      .update(updatedUser)
      .eq('id', user.id);

  if (response.error != null) {
    print('Error updating user data: ${response.error?.message}');
  }
}
