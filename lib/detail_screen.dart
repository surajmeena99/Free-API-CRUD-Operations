import 'package:crud_app/api_model.dart';
import 'package:crud_app/api_service.dart';
import 'package:crud_app/edit_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.item});

  final ApiModel item;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selected Item Details'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => EditScreen(editItem: widget.item,))
            );
          }, icon: const Icon(Icons.edit)),
          IconButton(
            onPressed: () async {
              bool deleted = await _apiService.deleteItem(widget.item.id.toString());

              if (deleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Post deleted')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed to delete')),
                );
              }
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          title: Text(widget.item.title),
          subtitle: Text(widget.item.body),
          leading: Text(widget.item.id.toString()),
        ),
      ),
    );
  }
}