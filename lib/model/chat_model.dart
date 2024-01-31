class ChatModel {
  String? text;
  bool? isuser;

  ChatModel({this.text, this.isuser});

  ChatModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    isuser = json['isuser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['isuser'] = isuser;
    return data;
  }
}
