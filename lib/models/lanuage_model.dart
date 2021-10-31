class Language{
  String language;
  Language.fromJson(Map<String,dynamic>json):
      language= json['language'];
}