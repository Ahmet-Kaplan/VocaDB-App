import 'package:flutter/material.dart';
import 'package:vocadb/blocs/search_tag_bloc.dart';
import 'package:vocadb/models/tag_model.dart';
import 'package:vocadb/pages/tag/tag_category_names.dart';
import 'package:vocadb/widgets/infinite_list_view.dart';
import 'package:vocadb/widgets/result.dart';

class SearchTagPage extends StatefulWidget {
  final Function onSelected;

  const SearchTagPage({Key key, this.onSelected}) : super(key: key);

  @override
  _SearchTagPageState createState() => _SearchTagPageState();
}

class _SearchTagPageState extends State<SearchTagPage> {
  final SearchTagBloc bloc = SearchTagBloc();

  Widget buildData(List<TagModel> tags) {
    return InfiniteListView(
      itemCount: tags.length,
      onReachLastItem: () {
        bloc.fetchMore();
      },
      progressIndicator:
          InfiniteListView.streamShowProgressIndicator(bloc.noMoreResult$),
      itemBuilder: (context, index) {
        TagModel tag = tags[index];
        return ListTile(
          onTap: () {
            widget.onSelected(tag);
            Navigator.pop(context);
          },
          title: Text(tag.name),
        );
      },
    );
  }

  Widget buildError(String message) {
    return Center(
      child: Result.error("Something wrongs", subtitle: message),
    );
  }

  Widget buildDefault() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildSearchResult() {
    return StreamBuilder(
      stream: bloc.result$,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return buildData(snapshot.data);
        } else if (snapshot.hasError) {
          return buildError(snapshot.error.toString());
        }

        return buildDefault();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                onChanged: bloc.updateQuery,
                style: Theme.of(context).primaryTextTheme.title,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: "Find tag"),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: bloc.query$,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != '') {
            return buildSearchResult();
          } else if (snapshot.hasError) {
            return buildError(snapshot.error.toString());
          }

          return TagCategoryNames(onSelectTag: (tag) {
            widget.onSelected(tag);
            Navigator.pop(context);
            Navigator.pop(context);
          });
        },
      ),
    );
  }
}
