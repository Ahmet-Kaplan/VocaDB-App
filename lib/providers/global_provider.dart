import 'package:flutter/widgets.dart';
import 'package:vocadb/blocs/config_bloc.dart';
import 'package:vocadb/services/song_rest_service.dart';

class GlobalProvider extends InheritedWidget {
  final ConfigBloc configBloc;
  final SongRestService songService;

  const GlobalProvider({
    Key key,
    @required this.configBloc,
    @required this.songService,
    @required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  static GlobalProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(GlobalProvider)
        as GlobalProvider;
  }

  @override
  bool updateShouldNotify(GlobalProvider old) {
    return true;
  }
}
