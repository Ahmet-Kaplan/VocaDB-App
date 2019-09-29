import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:vocadb/models/tag_model.dart';

class SearchEntryFilterBloc {
  final _sort = BehaviorSubject<String>();
  final _tags = BehaviorSubject<Map<int, TagModel>>();

  Observable get sort$ => _sort.stream;
  Observable get tags$ => _tags.stream;

  String get sort => _sort.value;
  Map<int, TagModel> get tags => _tags.value;
  List<TagModel> get tagList => tags?.values?.toList();

  Observable get params$ => Observable.merge([sort$, tags$]);

  void updateSort(String sort) {
    _sort.add(sort);
  }

  Future<void> addTag(TagModel tag) {
    Map<int, TagModel> a = tags ?? {};
    a.putIfAbsent(tag.id, () => tag);
    _tags.add(a);

    return Future.value();
  }

  void removeTag(int id) {
    Map<int, TagModel> a = tags;
    a.remove(id);
    _tags.add(a);
  }

  Map<String, String> params() {
    Map<String, String> params = {'sort': sort ?? 'Name'};
    if (tagList != null && tagList.length > 0)
      params['tagId'] = tags.keys.join(',');

    return params;
  }

  void dispose() {
    _sort.close();
    _tags.close();
  }
}
