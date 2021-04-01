import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subscription_manager/main.dart';
import 'package:subscription_manager/screens/subscription_view/subscription_view.dart';
import '../../data.dart';

class Categories extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final subscriptionList = watch(subscriptionsProvider.state);

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: double.infinity,
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 48,
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      child: Text("Edit"),
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 10, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Category", style: TextStyle(color: Colors.grey)),
                  Text("Amount / mo", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            ListView.builder(
              itemCount: myCategories.length,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ExpansionTile(
                      leading: SizedBox(
                          height: 35,
                          width: 35,
                          child: myCategories[index].icon),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(myCategories[index].name),
                          Text(_getCategoryTotal(
                              myCategories[index].name,
                              subscriptionList
                                  .where((item) =>
                                      item.billDate.month ==
                                      DateTime.now().month + 1)
                                  .toList())),
                        ],
                      ),
                      children: _getChildren(
                          myCategories[index].name,
                          context,
                          subscriptionList
                              .where((item) =>
                                  item.billDate.month ==
                                  DateTime.now().month + 1)
                              .toList()),
                    ),
                  ],
                );
              },
              shrinkWrap: true,
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryTotal(String name, List<Subscription> subscriptionList) {
    double total = 0.0;
    subscriptionList.forEach((item) {
      if (item.category == name) {
        total += item.amount;
      }
    });
    return "\$ " + total.toStringAsFixed(2);
  }

  List<Widget> _getChildren(
      String name, BuildContext context, List<Subscription> subscriptionList) {
    List<Widget> list = [];

    subscriptionList.forEach((item) {
      if (item.category == name) {
        list.add(GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubscriptionView(item),
              ),
            );
          },
          child: Container(
            color: Color(0xff424242),
            child: ListTile(
              leading: SizedBox(),
              title: Row(
                children: [
                  SizedBox(height: 35, width: 35, child: item.serviceIcon),
                  Text(item.service),
                ],
              ),
              trailing: Text("\$ " + item.amount.toStringAsFixed(2)),
            ),
          ),
        ));
      }
    });

    return list;
  }
}
