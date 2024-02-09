import 'package:crud_app/add_screen.dart';
import 'package:crud_app/api_model.dart';
import 'package:crud_app/detail_screen.dart';
import 'package:flutter/material.dart';
import 'api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();

  late Future<List<ApiModel>> itemList;
  
  @override
  void initState() {
    super.initState();
    itemList = apiService.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter API App'),
        ),
        body: FutureBuilder<List<ApiModel>>(
          future: itemList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final List<ApiModel> items = snapshot.data!;
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final ApiModel item = items[index];
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DetailScreen(item: items[index]))
                          );
                        },
                        leading: CircleAvatar(
                          child: Text(item.id.toString()),
                        ),
                        title: Text(item.title),
                        subtitle: Text(item.body),
                        // trailing : Text(item.id.toString()),
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddScreen())
          );
        },
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}


