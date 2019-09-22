import 'package:flutter/material.dart';
import 'package:vocadb/models/song_model.dart';
import 'package:vocadb/pages/youtube_playlist/youtube_playlist_page.dart';
import 'package:vocadb/services/web_service.dart';
import 'package:vocadb/widgets/section.dart';
import 'package:vocadb/widgets/song_card.dart';

class HighlightedList extends StatefulWidget {
  @override
  _HighlightedListState createState() => _HighlightedListState();
}

class _HighlightedListState extends State<HighlightedList> {
  void openPlaylist(List<SongModel> songs) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => YoutubePlaylistPage(songs: songs)));
  }

  buildHasData(List<SongModel> songs) {
    List<SongCard> songCards = songs
        .map((song) => SongCard.song(song, tag: 'highlighted_list_${song.id}'))
        .toList();
    return Section(
      title: 'Highlighted',
      horizontal: true,
      children: songCards,
      extraMenus: FlatButton(
        onPressed: () {
          openPlaylist(songs);
        },
        child: Row(
          children: <Widget>[Icon(Icons.play_arrow), Text('Play all')],
        ),
      ),
    );
  }

  buildDefault() {
    return Section(
        title: 'Highlighted',
        horizontal: true,
        children: [0, 1, 2].map((i) => SongCardPlaceholder()).toList());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      future: WebService().load(SongModel.all),
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return buildHasData(snapshot.data);
        else if (snapshot.hasError) {
          print(snapshot.error);
        }

        return buildDefault();
      },
    );
  }
}
