import 'package:vocadb/models/base_model.dart';

class LyricModel extends BaseModel {
  int id;
  String translationType;
  String value;

  LyricModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        translationType = json['translationType'],
        value = json['value'];
}

class LyricList {
  final List<LyricModel> lyrics;

  LyricList(this.lyrics);

  List<String> get translationTypes =>
      lyrics.map<String>((l) => l.translationType).toList();
}
