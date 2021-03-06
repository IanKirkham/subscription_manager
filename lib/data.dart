import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ListItem {
  String name;
  Image icon;

  ListItem({
    @required this.name,
    @required this.icon,
  });

  bool isEqual(ListItem model) {
    return this?.name == model?.name;
  }

  @override
  String toString() => name;
}

class Subscription {
  String service;
  Image serviceIcon;
  String category;
  double amount;
  DateTime startDate;
  DateTime billDate;
  String recurring;
  List<dynamic> notification;
  List<String> billingHistory;

  Subscription({
    @required this.service,
    @required this.serviceIcon,
    @required this.category,
    @required this.amount,
    @required this.startDate,
    @required this.billDate,
    @required this.recurring,
    @required this.notification,
    @required this.billingHistory,
  });
}

final List<ListItem> services = [
  ListItem(name: "Amazon Prime", icon: Image.asset("assets/amazon_prime.png")),
  ListItem(name: "Apple Music", icon: Image.asset("assets/apple_music.png")),
  ListItem(name: "AT&T", icon: Image.asset("assets/atnt.png")),
  ListItem(name: "Audible", icon: Image.asset("assets/audible.png")),
  ListItem(name: "AWS", icon: Image.asset("assets/aws.png")),
  ListItem(name: "Comcast", icon: Image.asset("assets/comcast.png")),
  ListItem(name: "Disney+", icon: Image.asset("assets/disney_plus.png")),
  ListItem(name: "ESPN+", icon: Image.asset("assets/espn_plus.png")),
  ListItem(name: "Hulu", icon: Image.asset("assets/hulu.png")),
  ListItem(name: "Internet", icon: Image.asset("assets/internet.png")),
  ListItem(name: "Last Pass", icon: Image.asset("assets/lastpass.png")),
  ListItem(name: "Netflix", icon: Image.asset("assets/netflix.png")),
  ListItem(name: "OneDrive", icon: Image.asset("assets/onedrive.png")),
  ListItem(name: "Rent", icon: Image.asset("assets/rent.png")),
  ListItem(name: "Spotify", icon: Image.asset("assets/spotify.png")),
  ListItem(name: "Verizon", icon: Image.asset("assets/verizon.png")),
  ListItem(name: "Xbox Live", icon: Image.asset("assets/xbox_live.png")),
  ListItem(name: "Youtube Premium", icon: Image.asset("assets/youtube.png")),
];

final List<ListItem> categories = [
  ListItem(name: "Books", icon: Image.asset("assets/categories/books.png")),
  ListItem(
      name: "Buisness", icon: Image.asset("assets/categories/buisness.png")),
  ListItem(
      name: "Education", icon: Image.asset("assets/categories/education.png")),
  ListItem(
      name: "Entertainment",
      icon: Image.asset("assets/categories/entertainment.png")),
  ListItem(name: "Finance", icon: Image.asset("assets/categories/finance.png")),
  ListItem(name: "Gaming", icon: Image.asset("assets/categories/games.png")),
  ListItem(name: "Music", icon: Image.asset("assets/categories/music.png")),
  ListItem(
      name: "Shopping", icon: Image.asset("assets/categories/shopping.png")),
  ListItem(name: "Sports", icon: Image.asset("assets/categories/sports.png")),
];

final List<Subscription> subscriptions = [
  Subscription(
    service: "Xbox Live",
    serviceIcon: Image.asset("assets/xbox_live.png"),
    category: "Gaming",
    amount: 14.98,
    startDate: DateTime(2021, 3, 20),
    billDate: DateTime(2021, 4, 20),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$12.99 on 3/20/2021",
    ],
  ),
  Subscription(
    service: "Netflix",
    serviceIcon: Image.asset("assets/netflix.png"),
    category: "Entertainment",
    amount: 12.99,
    startDate: DateTime(2021, 1, 24),
    billDate: DateTime(2021, 4, 24),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$12.99 on 1/24/2021",
      "Billed \$12.99 on 2/24/2021",
      "Billed \$12.99 on 3/24/2021",
    ],
  ),
  Subscription(
    service: "Spotify",
    serviceIcon: Image.asset("assets/spotify.png"),
    category: "Music",
    amount: 8.99,
    startDate: DateTime(2020, 3, 27),
    billDate: DateTime(2021, 4, 27),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$8.99 on 3/27/2021",
    ],
  ),
  Subscription(
    service: "Rent",
    serviceIcon: Image.asset("assets/rent.png"),
    category: "Finance",
    amount: 312.00,
    startDate: DateTime(2020, 10, 1),
    billDate: DateTime(2021, 5, 1),
    recurring: "Month",
    notification: [12, "hour"],
    billingHistory: [
      "Billed \$312.00 on 3/1/2021",
      "Billed \$312.00 on 2/1/2021",
      "Billed \$312.00 on 1/1/2021",
      "Billed \$312.00 on 12/1/2020",
      "Billed \$312.00 on 11/1/2020",
      "Billed \$312.00 on 10/1/2020",
    ],
  ),
  Subscription(
    service: "OneDrive",
    serviceIcon: Image.asset("assets/onedrive.png"),
    category: "Education",
    amount: 7.94,
    startDate: DateTime(2021, 2, 1),
    billDate: DateTime(2021, 5, 1),
    recurring: "Month",
    notification: [2, "day"],
    billingHistory: [
      "Billed \$7.94 on 2/1/2021",
      "Billed \$7.94 on 3/1/2021",
      "Billed \$7.94 on 4/1/2021",
    ],
  ),
  Subscription(
    service: "Apple Music",
    serviceIcon: Image.asset("assets/apple_music.png"),
    category: "Music",
    amount: 5.08,
    startDate: DateTime(2020, 4, 3),
    billDate: DateTime(2021, 5, 3),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$8.99 on 4/3/2021",
    ],
  ),
  Subscription(
    service: "Xbox Live",
    serviceIcon: Image.asset("assets/xbox_live.png"),
    category: "Gaming",
    amount: 14.98,
    startDate: DateTime(2021, 3, 20),
    billDate: DateTime(2021, 5, 20),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$12.99 on 3/20/2021",
    ],
  ),
  Subscription(
    service: "Netflix",
    serviceIcon: Image.asset("assets/netflix.png"),
    category: "Entertainment",
    amount: 12.99,
    startDate: DateTime(2021, 1, 18),
    billDate: DateTime(2021, 5, 18),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$12.99 on 1/18/2021",
      "Billed \$12.99 on 2/18/2021",
      "Billed \$12.99 on 3/18/2021",
    ],
  ),
  Subscription(
    service: "Spotify",
    serviceIcon: Image.asset("assets/spotify.png"),
    category: "Music",
    amount: 8.99,
    startDate: DateTime(2020, 3, 27),
    billDate: DateTime(2021, 5, 27),
    recurring: "Month",
    notification: [1, "day"],
    billingHistory: [
      "Billed \$8.99 on 3/27/2021",
    ],
  ),
];

final List<ListItem> myCategories = [
  ListItem(
      name: "Education", icon: Image.asset("assets/categories/education.png")),
  ListItem(
      name: "Entertainment",
      icon: Image.asset("assets/categories/entertainment.png")),
  ListItem(name: "Finance", icon: Image.asset("assets/categories/finance.png")),
  ListItem(name: "Gaming", icon: Image.asset("assets/categories/games.png")),
  ListItem(name: "Music", icon: Image.asset("assets/categories/music.png")),
  ListItem(
      name: "Shopping", icon: Image.asset("assets/categories/shopping.png")),
];
