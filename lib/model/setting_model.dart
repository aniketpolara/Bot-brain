class SettingModel {
  String? image;
  String? text;
  String? url;

  SettingModel({this.image, this.text, this.url});

  SettingModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    text = json['text'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['text'] = text;
    data['url'] = url;
    return data;
  }
}
