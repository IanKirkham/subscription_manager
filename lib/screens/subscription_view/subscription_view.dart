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
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _getDateInfoCard(
                        "Subscriber since",
                        DateFormat.yMd().format(widget.subscription.startDate),
                        context),
                    _getAmountInfoCard(
                        "Bill amount",
                        widget.subscription.amount,
                        widget.subscription.recurring,
                        context),
                  ],
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text("Notify me   "),
                      MaterialButton(
                        child: Text(_formatNotification(
                            widget.subscription.notification)),
                        onPressed: () {},
                        color: Color(0xFF444444),
                      ),
                      Text("   prior to charge"),
                    ],
                  ),
                ),
                sectionTitle("Billing History"),
                widget.subscription.billingHistory.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height / 15,
                        child: Center(
                            child: Text("No billing history found",
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white60))),
                      )
                    : ListView.builder(
                        itemCount: widget.subscription.billingHistory.length,
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.check_box_outlined),
                                title: Text(
                                    widget.subscription.billingHistory[index]),
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

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 15, 0, 10),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
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
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: Color(0xff424242),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Icon(Icons.flag, size: 60),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 2),
                  Text(data.toString(),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _getAmountInfoCard(
      String title, double amount, String recurring, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      height: MediaQuery.of(context).size.height / 5,
      decoration: BoxDecoration(
        color: Color(0xff424242),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.all(13),
                child: Icon(Icons.attach_money_rounded, size: 60),
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(title, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 2),
                  Text(_formatAmount(amount, recurring),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 24,
                      )),
                ],
              ),
            ),
          ),
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
