import 'package:flutter/material.dart';
import 'package:vocadb/models/album_model.dart';
import 'package:vocadb/providers/global_provider.dart';
import 'package:vocadb/widgets/album_card.dart';
import 'package:vocadb/widgets/model_future_builder.dart';
import 'package:vocadb/widgets/section.dart';

class LatestAlbumList extends StatefulWidget {
  @override
  _LatestAlbumListState createState() => _LatestAlbumListState();
}

class _LatestAlbumListState extends State<LatestAlbumList> {
  buildHasData(List<AlbumModel> albums) {
    List<AlbumCard> albumCards = albums
        .map((album) =>
            AlbumCard.album(album, tag: 'latest_album_list_${album.id}'))
        .toList();
    return Section(
        title: 'Recent or upcoming albums',
        horizontal: true,
        children: albumCards);
  }

  buildDefault() {
    return Section(
        title: 'Recent or upcoming albums',
        horizontal: true,
        children: [0, 1, 2].map((i) => AlbumCardPlaceholder()).toList());
  }

  @override
  Widget build(BuildContext context) {
    final albumService = GlobalProvider.of(context).albumService;
    final config = GlobalProvider.of(context).configBloc;

    return ModelFutureBuilder<List<AlbumModel>>(
        future: albumService.latest(lang: config.contentLang),
        buildData: buildHasData,
        buildLoading: buildDefault,
        buildError: print,
    );
  }
}
