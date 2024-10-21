import 'package:flutter/material.dart';
import 'package:flutter_conection/Pages_UI/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Pages_UI/regesteration_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://kcdopzqsaoqjtuyawvqg.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImtjZG9wenFzYW9xanR1eWF3dnFnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjk0OTI2ODcsImV4cCI6MjA0NTA2ODY4N30.Pc3GxgIgV0Y1ZR1Z1B5v2o6JluarHL2XvnoWCKMS7AY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Supabase Demo',
      home: RegistrationForm(),
    );
  }
}
