import 'package:crud_app/api_service.dart';
import 'package:flutter/material.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Add a title'
                ),
                controller: _controllerTitle,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Add a body'
                ),
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                onPressed: () async {
                  Map<String, String> dataToPost = {
                    'title': _controllerTitle.text,
                    'body': _controllerBody.text,
                  };

                  bool status = await ApiService().addItem(dataToPost);

                  if (status) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Post added')));
                  }
                  else
                  {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Failed to add the post')));
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