import 'package:crud_app/api_model.dart';
import 'package:crud_app/api_service.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.editItem});

  final ApiModel editItem;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {

  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();

  @override
  initState() {
    super.initState();
    _controllerTitle.text = widget.editItem.title;
    _controllerBody.text = widget.editItem.body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
              ),
              TextFormField(
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };

                    bool status = await ApiService().updateItem(dataToUpdate, widget.editItem.id.toString());

                    if (status) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Post updated')));
                    }
                    else
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Failed to update the post')));
                      }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}