import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data.dart';

// ignore: must_be_immutable
class SubscriptionView extends StatefulWidget {
  Subscription subscription;

  SubscriptionView(Subscription subscription) {
    this.subscription = subscription;
  }

  @override
  _SubscriptionViewState createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 18),
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: widget.subscription.serviceIcon),
                  SizedBox(height: 10),
                  Text(widget.subscription.service,
                      style: TextStyle(
                        fontSize: 48,
                      )),
                  Text(
                    widget.subscription.category,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _getDateInfoCard(
                        "Subscriber since",
                        DateFormat.yMd().format(widget.subscription.startDate),
                        context), // TODO: change DateTime.now() to real data
                    _getAmountInfoCard(
                        "Bill amount",
                        widget.subscription.amount,
                        widget.subscription.recurring,
                        context),
                  ],
                ),
                Row(
                  children: [
                    Text("Notify me"),
                    MaterialButton(
                      child: Text(_formatNotification(
                          widget.subscription.notification)),
                      onPressed: () {},
                      color: Color(0xFF424242),
                    ),
                    Text("prior to charge")
                  ],
                ),
                Text("Billing History"),
                ListView.builder(
                  itemCount: widget.subscription.billingHistory.length,
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title:
                              Text(widget.subscription.billingHistory[index]),
                        ),
                        Divider(),
                      ],
                    );
                  },
                  shrinkWrap: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatNotification(List<dynamic> notification) {
    if (notification[0].toString() != "1") {
      return notification[0].toString() + " " + notification[1] + "s";
    }
    return notification[0].toString() + " " + notification[1];
  }

  Container _getDateInfoCard(String title, dynamic data, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 5,
      color: Color(0xff424242),
      child: Column(
        children: [
          Text(title),
          Text(data.toString()),
        ],
      ),
    );
  }

  Container _getAmountInfoCard(
      String title, double amount, String recurring, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height / 5,
      color: Color(0xff424242),
      child: Column(
        children: [
          Text(title),
          Text(_formatAmount(amount, recurring)),
        ],
      ),
    );
  }

  String _formatAmount(double amount, String recurring) {
    if (recurring == "Day") {
      return "\$ " + amount.toString() + " / day";
    }
    if (recurring == "Week") {
      return "\$ " + amount.toString() + " / wk";
    }
    if (recurring == "Month") {
      return "\$ " + amount.toString() + " / mo";
    }
    if (recurring == "Year") {
      return "\$ " + amount.toString() + " / yr";
    }
    return "Error";
  }
}
