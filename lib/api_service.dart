import 'dart:convert';
import 'package:crud_app/api_model.dart';
import 'package:http/http.dart' as http;

class ApiService {

Future<List<ApiModel>> fetchItems() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    // print(response.body);
    if (response.statusCode == 200) {
      // final Map<String, dynamic> data = json.decode(response.body);
      // final List<dynamic> jsonData = data['data'];
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => ApiModel.fromJson(item)).toList();
      // return jsonData.cast<ApiModel>();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<bool> addItem(Map<String, dynamic> data) async {
    final response = await http.post(Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    
    print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to Post data'); 
    }
  }

  Future<bool> updateItem(Map<String, dynamic> data, String itemId) async {
    final response = await http.put(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<bool> deleteItem(String itemId) async {
    final response = await http.delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$itemId'));

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to Delete data');
    }
  }
}
