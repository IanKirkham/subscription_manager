import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data.dart';

class SubscriptionsList extends StateNotifier<List<Subscription>> {
  SubscriptionsList(List<Subscription> state) : super(state);

  void update() {
    subscriptions.sort((a, b) => a.billDate.compareTo(b.billDate));
    state = subscriptions;
  }
}

class CategoriesList extends StateNotifier<List<ListItem>> {
  CategoriesList(List<ListItem> state) : super(state);

  void update() {
    myCategories.sort((a, b) => a.name.compareTo(b.name));
    state = myCategories;
  }
}
