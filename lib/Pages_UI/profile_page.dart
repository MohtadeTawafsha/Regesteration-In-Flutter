import 'package:flutter/material.dart';
import 'package:flutter_conection/Pages_Controller/backend.dart';
import 'edit_profile_page.dart'; // Import backend functions

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Create variables to hold the user data
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  // Fetch the user data from Supabase
  void fetchProfileData() async {
    final data = await getUserProfile();
    setState(() {
      userData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("First Name: ${userData!['firstName']}"),
            Text("Last Name: ${userData!['lastName']}"),
            Text("Phone Number: ${userData!['phoneNumber']}"),
            Text("Date of Birth: ${userData!['dateOfBirth']}"),
            Text("Role: ${userData!['role']}"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(userData: userData!),
                  ),
                );
              },
              child: Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}
