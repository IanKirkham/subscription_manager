import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:subscription_manager/main.dart';
import 'package:subscription_manager/screens/subscription_view/subscription_view.dart';

import '../../data.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              elevation: 0,
              //snap: true,
              //forceElevated: true,
              //floating: true,
              //pinned: true,
              toolbarHeight: MediaQuery.of(context).size.height / 4,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: EdgeInsets.only(left: 15),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Remaining costs for this month",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 5),
                    Consumer(builder: (context, watch, child) {
                      final subscriptionList =
                          watch(subscriptionsProvider.state);

                      List<Subscription> list = subscriptionList
                          .where((item) =>
                              item.billDate.month == DateTime.now().month)
                          .toList();

                      double total = 0;
                      list.forEach((item) => total += item.amount);

                      return Text("\$" + total.toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 70, fontWeight: FontWeight.bold));
                    }),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            _buildFullList(),
          ],
        ),
      ),
    );
  }

  MultiSliver _buildFullList() {
    return MultiSliver(
      pushPinnedChildren: true,
      children: [
        _sliverHeader("This month"),
        Consumer(builder: (context, watch, child) {
          final subscriptionList = watch(subscriptionsProvider.state);
          return _sliverList(subscriptionList
              .where((item) => item.billDate.month == DateTime.now().month)
              .toList());
        }),
        _sliverHeader("Next month"),
        Consumer(builder: (context, watch, child) {
          final subscriptionList = watch(subscriptionsProvider.state);
          return _sliverList(subscriptionList
              .where((item) => item.billDate.month == DateTime.now().month + 1)
              .toList());
        }),
      ],
    );
  }

  SliverPinnedHeader _sliverHeader(String title) {
    return SliverPinnedHeader(
      child: Container(
        height: 50,
        padding: EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        color: Color(0xff2e2e2e),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  SliverList _sliverList(List<Subscription> subscriptionList) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              child: Stack(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(8),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SubscriptionView(subscriptionList[index]),
                        ),
                      );
                    },
                    leading: SizedBox(
                        height: 35,
                        width: 35,
                        child: subscriptionList[index].serviceIcon),
                    title: Text(
                      subscriptionList[index].service,
                      style: TextStyle(fontSize: 18),
                    ),
                    //subtitle: Text("Billed on 3/18/21"),
                    trailing: Text(
                      "\$ ${subscriptionList[index].amount.toStringAsFixed(2)}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 5),
                      child: Text(
                        "Bill due on " +
                            DateFormat.yMd()
                                .format(subscriptionList[index].billDate),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: subscriptionList.length,
      ),
    );
  }
}
