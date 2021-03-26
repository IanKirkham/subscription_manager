import 'listItem.dart';

class Subscription {
  ListItem service;
  String category;
  double amount;
  String currency;
  String date; // change this to a date object or something?
  String recurring;
  int notify;
  String subscriptionStart;
  List<String> billingHistory;
}
