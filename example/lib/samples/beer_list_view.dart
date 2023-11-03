import 'package:brewtiful/remote/beer_summary.dart';
import 'package:brewtiful/remote/remote_api.dart';
import 'package:brewtiful/samples/common/beer_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class BeerListView extends StatefulWidget {
  @override
  BeerListViewState createState() => BeerListViewState();
}

class BeerListViewState extends State<BeerListView> {
  static const pageSize = 20;

  final PagingController<int, BeerSummary> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await RemoteApi.getBeerList(pageKey, pageSize);

      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // CustomScrollPagination<int, BeerSummary>(
      //   pagingController: pagingController,
      //   itemBuilder: (context, item) => BeerListItem(
      //     beer: item,
      //   ),
      //   separatorBuilder: (context, index) => const Divider(
      //     color: Colors.red,
      //     height: 2.5,
      //   ),
      //   needRefreshIndicator: true,
      //   onRefresh: () => Future.sync(() => pagingController.refresh()),
      // ).listViewWithoutSeparator();

      ListViewWithoutSeparator<int, BeerSummary>(
        listStyle: ListViewWithoutSeparatorStyle<BeerSummary>(
          pagingController: pagingController,
          itemBuilder: (context, item) => BeerListItem(
            beer: item,
          ),
          onPageRefresh: () => Future.sync(
            () => pagingController.refresh(),
          ),
        ),
      );

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }
}
