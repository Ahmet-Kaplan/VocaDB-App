import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vocadb/models/song_model.dart';
import 'package:vocadb/services/song_rest_service.dart';
import 'package:vocadb/services/web_service.dart';

class MockRestService extends Mock implements RestService {}

main() {
  final mockRestService = MockRestService();
  final service = SongRestService(mockRestService);

  test('should return future list of songs', () {
    final mockResult = {
      'items': [
        {'id': 1, 'name': 'A'},
        {'id': 2, 'name': 'B'}
      ]
    };

    when(mockRestService.get(any, any))
        .thenAnswer((_) => Future.value(mockResult));

    expect(service.highlighted(), completion(isA<List<SongModel>>()));
  });
}
