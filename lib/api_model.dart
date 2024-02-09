class ApiModel {
  final int id;
  final String title;
  final String body;

  ApiModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory ApiModel.fromJson(Map<String, dynamic> json) {
    return ApiModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'title': title,
      'body': body,
    };
  }
}
