import 'dart:async';

import 'package:vocadb/models/album_model.dart';
import 'package:vocadb/services/base_rest_service.dart';
import 'package:vocadb/services/web_service.dart';

class AlbumRestService extends BaseRestService {
  AlbumRestService(RestService restService) : super(restService);

  Future<List<AlbumModel>> latest({String lang = 'Default'}) async {
    final String endpoint = '/api/albums/new';
    final Map<String, String> params = {'fields': 'MainPicture'};
    params['languagePreference'] = lang;
    return super
        .query(endpoint, params)
        .then((items) => AlbumModel.jsonToList(items));
  }

  Future<List<AlbumModel>> top({String lang = 'Default'}) async {
    final String endpoint = '/api/albums/top';
    final Map<String, String> params = {'fields': 'MainPicture'};
    params['languagePreference'] = lang;
    return super
        .query(endpoint, params)
        .then((items) => AlbumModel.jsonToList(items));
  }
}
