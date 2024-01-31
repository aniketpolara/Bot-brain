class OnBoardingModel {
  String? image;
  String? text;
  String? text1;

  OnBoardingModel({this.image, this.text, this.text1});

  OnBoardingModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    text = json['text'];
    text1 = json['text1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['text'] = text;
    data['text1'] = text1;
    return data;
  }
}
