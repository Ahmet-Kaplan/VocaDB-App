import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:vocadb/blocs/favorite_song_bloc.dart';
import 'package:vocadb/models/song_model.dart';

class MockBox extends Mock implements Box {}

main() {
  test('should add and remove song', () async {
    final song = SongModel.fromJson({'id': 1, 'name': 'A'});
    final box = MockBox();

    when(box.put(any, any)).thenAnswer((_) => Future.value());
    when(box.get(any)).thenReturn(null);

    final bloc = FavoriteSongBloc(personalBox: box);

    expect(bloc.songs, isEmpty);

    bloc.add(song);

    final expected = {1: song};

    await expectLater(bloc.songs$, emits(expected));

    expect(bloc.songs, isNotNull);

    bloc.remove(1);

    await expectLater(bloc.songs$, emits({}));
  });
}
