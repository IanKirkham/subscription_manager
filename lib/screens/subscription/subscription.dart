import 'package:flutter/material.dart';

class SubscriptionView extends StatefulWidget {
  @override
  _SubscriptionViewState createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Center(
          child: Text("subscription page"),
        ),
      ),
    );
  }
}
