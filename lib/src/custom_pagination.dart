import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CustomScrollPagination<PageKeyType, ItemType> {
  CustomScrollPagination(
      {required this.pagingController,
      required this.itemBuilder,
      this.onRefresh,
      this.separatorBuilder,
      this.onPageRefresh,
      this.needRefreshIndicator});

  final IndexedWidgetBuilder? separatorBuilder;
  final Future<void> Function()? onPageRefresh;
  bool? needRefreshIndicator = false;
  final PagingController<int, ItemType> pagingController;
  final ItemWidgetBuilder<ItemType> itemBuilder;
  final Future<void> Function()? onRefresh;

  Widget listViewWithSeparator(
          {required PagingController<int, ItemType> pagingController,
          required ItemWidgetBuilder<ItemType> itemBuilder,
          required PageKeyType pageNumber,
          required ItemType itemModel,
          bool? animateTransitions,
          bool needRefreshIndicator = true}) =>
      needRefreshIndicator
          ? RefreshIndicator(
              onRefresh: onRefresh?.call ?? () async {},
              child: PagedListView<int, ItemType>.separated(
                pagingController: pagingController,
                builderDelegate: PagedChildBuilderDelegate<ItemType>(
                  animateTransitions: animateTransitions ?? true,
                  itemBuilder: itemBuilder,
                ),
                separatorBuilder:
                    separatorBuilder ?? (context, index) => const Divider(),
              ),
            )
          : PagedListView<int, ItemType>.separated(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<ItemType>(
                animateTransitions: animateTransitions ?? true,
                itemBuilder: itemBuilder,
              ),
              separatorBuilder:
                  separatorBuilder ?? (context, index) => const Divider(),
            );

  Widget listViewWithoutSeparator() => PagedListView<int, ItemType>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate<ItemType>(
          animateTransitions: true,
          itemBuilder: itemBuilder,
        ),
      );

  // Widget buildChildLayout(BuildContext context) {
  //   if (needRefreshIndicator == true) {
  //     return RefreshIndicator(
  //         onRefresh: onRefresh?.call ?? () async {},
  //         child: separatorBuilder != null
  //             ? listViewWithSeparator()
  //             : listViewWithoutSeparator());
  //   } else {
  //     return separatorBuilder != null
  //         ? listViewWithSeparator()
  //         : listViewWithoutSeparator();
  //   }
  // }
}

Widget ListViewWithSeparator<PageKeyType, ItemType>(
        {required PagingController<int, ItemType> pagingController,
        required ItemWidgetBuilder<ItemType> itemBuilder,
        bool? animateTransitions,
        IndexedWidgetBuilder? separatorBuilder,
        Future<void> Function()? onPageRefresh,
        bool needRefreshIndicator = true}) =>
    needRefreshIndicator
        ? RefreshIndicator(
            onRefresh: onPageRefresh?.call ?? () async {},
            child: PagedListView<int, ItemType>.separated(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<ItemType>(
                animateTransitions: animateTransitions ?? true,
                itemBuilder: itemBuilder,
              ),
              separatorBuilder:
                  separatorBuilder ?? (context, index) => const Divider(),
            ),
          )
        : PagedListView<int, ItemType>.separated(
            pagingController: pagingController,
            builderDelegate: PagedChildBuilderDelegate<ItemType>(
              animateTransitions: animateTransitions ?? true,
              itemBuilder: itemBuilder,
            ),
            separatorBuilder:
                separatorBuilder ?? (context, index) => const Divider(),
          );

Widget ListViewWithoutSeparator<PageKeyType, ItemType>(
        {required ListViewWithoutSeparatorStyle<ItemType> listStyle}) =>
    listStyle.needRefreshIndicator
        ? RefreshIndicator(
            onRefresh: listStyle.onPageRefresh?.call ?? () async {},
            child: PagedListView<int, ItemType>(
              pagingController: listStyle.pagingController,
              builderDelegate: PagedChildBuilderDelegate<ItemType>(
                animateTransitions: listStyle.animateTransitions ?? true,
                itemBuilder: listStyle.itemBuilder,
              ),
            ),
          )
        : PagedListView<int, ItemType>(
            pagingController: listStyle.pagingController,
            builderDelegate: PagedChildBuilderDelegate<ItemType>(
              animateTransitions: listStyle.animateTransitions ?? true,
              itemBuilder: listStyle.itemBuilder,
            ),
          );
