import 'package:infinite_scroll_pagination/src/core/paged_child_builder_delegate.dart';
import 'package:infinite_scroll_pagination/src/core/paging_controller.dart';

class ListViewWithoutSeparatorStyle<ItemType> {
  ListViewWithoutSeparatorStyle({
    required this.pagingController,
    required this.itemBuilder,
    this.needRefreshIndicator = true,
    this.onPageRefresh,
    this.animateTransitions,
  });

  PagingController<int, ItemType> pagingController;
  ItemWidgetBuilder<ItemType> itemBuilder;
  bool? animateTransitions;
  Future<void> Function()? onPageRefresh;
  bool needRefreshIndicator;
}
