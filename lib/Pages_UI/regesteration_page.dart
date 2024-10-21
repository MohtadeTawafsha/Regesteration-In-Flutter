import 'package:flutter/material.dart';
import 'package:flutter_conection/Pages_UI/profile_page.dart';

import '../Pages_Controller/backend.dart';
import '../Pages_Controller/supabase_service.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  // Role selection
  String? _selectedRole;

  final SupabaseService _supabaseService = SupabaseService(); // Initialize the service

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // First Name
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),

              // Last Name
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),

              // Phone Number
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),

              // Date of Birth
              TextFormField(
                controller: _dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _dobController.text = "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your date of birth';
                  }
                  return null;
                },
              ),

              // Role Selection
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items: const [
                  DropdownMenuItem(value: 'Craftsman', child: Text('Craftsman')),
                  DropdownMenuItem(value: 'Customer', child: Text('Customer')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                decoration: const InputDecoration(labelText: 'Role'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a role';
                  }
                  return null;
                },
              ),

              // Submit Button
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      // Insert user data into the database
                      await _supabaseService.insertUser(
                        firstName: _firstNameController.text,
                        lastName: _lastNameController.text,
                        phoneNumber: _phoneController.text,
                        dateOfBirth: _dobController.text,
                        role: _selectedRole!,
                      );

                      // Navigate to ProfilePage after successful registration
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(), // Ensure ProfilePage is properly set up
                        ),
                      );
                    } catch (e) {
                      // Handle the error by logging it, but don't block navigation
                      print('Error during registration: $e');

                      // Optionally, you can show a snackbar or alert here instead of blocking
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('An error occurred, but registration was successful')),
                      );

                      // Still navigate to the ProfilePage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfilePage(), // Ensure ProfilePage is properly set up
                        ),
                      );
                    }
                  }
                },
                child: const Text('Submit'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
