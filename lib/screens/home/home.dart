import 'package:flutter/material.dart';
import 'package:subscription_manager/screens/subscription/subscription.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              //snap: true,
              forceElevated: true,
              //floating: true,
              toolbarHeight: MediaQuery.of(context).size.height / 3.5,
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
                    Text(
                      "\$23.99",
                      style: TextStyle(fontSize: 70),
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index) {
              if (index == 0 || index == 4) {
                return Container(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Title here",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                );
              }
              return Card(
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: Center(
                    child: ListTile(
                      onTap: () {
                        // Scaffold.of(context).showSnackBar(
                        //     SnackBar(content: Text("Tapped item $index")));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SubscriptionView(),
                          ),
                        );
                      },
                      leading: FlutterLogo(size: 50.0),
                      title: Text(
                        "List item $index",
                        style: TextStyle(fontSize: 18),
                      ),
                      //subtitle: Text("Billed on 3/18/21"),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "\$9.99",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Billed on 3/18/21",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
