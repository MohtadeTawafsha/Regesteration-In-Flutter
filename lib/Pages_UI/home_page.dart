import 'package:flutter/material.dart';
import 'package:flutter_conection/Pages_Controller/home_page_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomePageLogic _logic = HomePageLogic(); // Create an instance of logic class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('My Notes'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _logic.notesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(notes[index]['body']),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Open dialog to add a note
          _showAddNoteDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add a Note'),
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          children: [
            TextFormField(
              onFieldSubmitted: (value) async {
                if (value.trim().isEmpty) {
                  print('Note cannot be empty');
                  return;
                }

                // Add the note using logic
                await _logic.addNote(context, value);
              },
              decoration: const InputDecoration(
                hintText: 'Enter your note here',
              ),
            ),
          ],
        );
      },
    );
  }
}
