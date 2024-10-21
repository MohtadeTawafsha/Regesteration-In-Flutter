import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../Pages_Controller/backend.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData; // Pass user data

  EditProfilePage({required this.userData});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  // Controllers to edit fields
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneNumberController;
  late TextEditingController dateOfBirthController;
  String? role;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with existing user data
    firstNameController = TextEditingController(text: widget.userData['firstName']);
    lastNameController = TextEditingController(text: widget.userData['lastName']);
    phoneNumberController = TextEditingController(text: widget.userData['phoneNumber']);
    dateOfBirthController = TextEditingController(text: widget.userData['dateOfBirth']);
    role = widget.userData['role'];
  }

  void saveProfile() async {
    // Create an updated user data map
    Map<String, dynamic> updatedUser = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'phoneNumber': phoneNumberController.text,
      'dateOfBirth': dateOfBirthController.text,
      'role': role,
    };

    // Call the backend update function
// Update user profile in Supabase
    Future<void> updateUserProfile(Map<String, dynamic> updatedUser) async {
      final user = Supabase.instance.client.auth.currentUser;
      if (user == null) {
        print('No user is authenticated.');
        return;
      }

      final response = await Supabase.instance.client
          .from('users')
          .update(updatedUser)
          .eq('id', user.id);

      if (response.hasError) {
        // Handle error
        print('Error updating user data: ${response.error?.message}');
      } else {
        print('User data updated successfully');
      }
    }

    // Navigate back to profile after saving
    Navigator.pop(context, updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            DropdownButton<String>(
              value: role,
              onChanged: (newRole) {
                setState(() {
                  role = newRole;
                });
              },
              items: ['Customer', 'Craftsman']
                  .map((role) => DropdownMenuItem(
                value: role,
                child: Text(role),
              ))
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveProfile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
