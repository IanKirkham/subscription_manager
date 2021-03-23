import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              snap: true,
              forceElevated: true,
              floating: true,
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
                child: ListTile(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Tapped item $index")));
                  },
                  leading: FlutterLogo(size: 72.0),
                  title: Text("List item $index"),
                  subtitle: Text("blah blah blah blah blah"),
                  trailing: Icon(Icons.more_vert),
                ),
              );
            })),
          ],
        ),
      ),
    );
  }
}
