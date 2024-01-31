class FirebaseModel {
  String? apiKey;
  int? chatSearchCount;
  int? imageSearchCount;
  int? codeSearchCount;
  String? bannerAndroidAdmobAdId;
  String? interstitialAndroidAdmobAdId;
  String? bannerIOSAdmobAdId;
  String? interstitialIOSAdmobAdId;
  String? shareAppUrl;
  String? privacyPolicyUrl;
  String? termsAndConditionAppUrl;
  String? supportEmail;
  bool? isAdEnable;
  String? appVersion;

  FirebaseModel(
      {this.apiKey,
      this.chatSearchCount,
      this.imageSearchCount,
      this.codeSearchCount,
      this.bannerAndroidAdmobAdId,
      this.interstitialAndroidAdmobAdId,
      this.bannerIOSAdmobAdId,
      this.interstitialIOSAdmobAdId,
      this.shareAppUrl,
      this.privacyPolicyUrl,
      this.termsAndConditionAppUrl,
      this.supportEmail,
      this.isAdEnable,
      this.appVersion});

  FirebaseModel.fromJson(Map<String, dynamic> json) {
    apiKey = json['apiKey'];
    chatSearchCount = json['chatSearchCount'];
    imageSearchCount = json['imageSearchCount'];
    codeSearchCount = json['codeSearchCount'];
    bannerAndroidAdmobAdId = json['bannerAndroidAdmobAdId'];
    interstitialAndroidAdmobAdId = json['interstitialAndroidAdmobAdId'];
    bannerIOSAdmobAdId = json['bannerIOSAdmobAdId'];
    interstitialIOSAdmobAdId = json['interstitialIOSAdmobAdId'];
    shareAppUrl = json['shareAppUrl'];
    privacyPolicyUrl = json['privacyPolicyUrl'];
    termsAndConditionAppUrl = json['termsAndConditionAppUrl'];
    supportEmail = json['supportEmail'];
    isAdEnable = json['isAdEnable'];
    appVersion = json['appVersion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apiKey'] = this.apiKey;
    data['chatSearchCount'] = this.chatSearchCount;
    data['imageSearchCount'] = this.imageSearchCount;
    data['codeSearchCount'] = this.codeSearchCount;
    data['bannerAndroidAdmobAdId'] = this.bannerAndroidAdmobAdId;
    data['interstitialAndroidAdmobAdId'] = this.interstitialAndroidAdmobAdId;
    data['bannerIOSAdmobAdId'] = this.bannerIOSAdmobAdId;
    data['interstitialIOSAdmobAdId'] = this.interstitialIOSAdmobAdId;
    data['shareAppUrl'] = this.shareAppUrl;
    data['privacyPolicyUrl'] = this.privacyPolicyUrl;
    data['termsAndConditionAppUrl'] = this.termsAndConditionAppUrl;
    data['supportEmail'] = this.supportEmail;
    data['isAdEnable'] = this.isAdEnable;
    data['appVersion'] = this.appVersion;
    return data;
  }
}
