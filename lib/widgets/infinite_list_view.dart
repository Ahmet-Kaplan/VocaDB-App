import 'package:flutter/material.dart';

class InfiniteListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Function onReachLastItem;
  final bool showProgressIndicator;

  const InfiniteListView(
      {Key key,
      this.itemCount,
      this.itemBuilder,
      this.onReachLastItem,
      this.showProgressIndicator = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount + 1,
      itemBuilder: (context, index) {
        if (index == itemCount) {
          this.onReachLastItem();

          if (!this.showProgressIndicator) {
            return Container();
          }

          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          );
        }

        return itemBuilder(context, index);
      },
    );
  }
}