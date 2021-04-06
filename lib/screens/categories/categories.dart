import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
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
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Categories"),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.6,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: GroupButton(
                                    spacing: 7,
                                    borderRadius: BorderRadius.circular(5),
                                    onSelected: (index, isSelected) {
                                      if (isSelected) {
                                        myCategories.add(categories[index]);
                                      } else {
                                        ListItem found;
                                        myCategories.forEach((item) {
                                          if (item.name ==
                                              categories[index].name) {
                                            found = item;
                                          }
                                        });
                                        myCategories.remove(found);
                                      }
                                    },
                                    buttonWidth:
                                        MediaQuery.of(context).size.width * 0.8,
                                    buttonHeight: 43,
                                    selectedColor:
                                        Theme.of(context).accentColor,
                                    unselectedColor: Color(0xff444444),
                                    unselectedTextStyle: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                    unselectedBorderColor:
                                        Theme.of(context).accentColor,
                                    buttons: categories
                                        .map((item) => item.name)
                                        .toList(),
                                    selectedButtons: myCategories
                                        .map((item) => item.name)
                                        .toList(),
                                    isRadio: false,
                                  ),
                                ),
                              );
                            }).then((value) => print(value));
                      },
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

  Color checkColor(ListItem item) {
    Color color;
    myCategories.forEach((element) {
      if (item.name == element.name) {
        color = Colors.pink;
      }
    });
    if (color == null) {
      color = Colors.grey;
    }
    return color;
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
