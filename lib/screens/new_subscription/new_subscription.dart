import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:subscription_manager/models/listItem.dart';

class NewSubscription extends StatefulWidget {
  @override
  _NewSubscriptionState createState() => _NewSubscriptionState();
}

class _NewSubscriptionState extends State<NewSubscription> {
  ListItem service;
  ListItem category;
  DateTime date;

  _NewSubscriptionState() {
    date = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("New Subscription"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Subscription Service"),
          getDropdown(getServicesList(), "Subscription", service),
          Text("Category (optional)"),
          getDropdown(getCategoriesList(), "Category", category),
          Text("Amount"),
          Row(
            children: [
              Column(
                children: [
                  Text("Start date"),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 24,
                          color: Color(0xFFBB86FC),
                          child: Center(
                              child: Text(DateFormat.MMMM().format(date))),
                        ),
                        Container(
                          color: Color(0xFF424242),
                          height: MediaQuery.of(context).size.height / 12,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              DateFormat.d().format(date),
                              style: TextStyle(fontSize: 50),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF424242),
                          height: MediaQuery.of(context).size.height / 34,
                          child: Center(
                            child: Text(DateFormat.EEEE().format(date) +
                                ", " +
                                DateFormat.y().format(date)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Billed every"),
                  Container(),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text("Notify me"),
              MaterialButton(
                child: Text("1 day"),
                onPressed: () {},
                color: Color(0xFF424242),
              ),
              Text("prior to charge"),
            ],
          ),
          MaterialButton(
            child: Text("Save"),
            onPressed: () {},
            color: Color(0xFF424242),
          ),
        ],
      ),
    );
  }

  Container getDropdown(List<ListItem> items, String title, ListItem current) {
    return Container(
      //margin: EdgeInsets.all(12),
      child: DropdownSearch<ListItem>(
        showSelectedItem: true,
        autoFocusSearchBox: true,
        items: items,
        onChanged: (newItem) {
          setState(() {
            if (title == "Subscription") {
              this.service = newItem;
            } else {
              this.category = newItem;
            }
          });
        },
        compareFn: (ListItem i, ListItem s) => i.isEqual(s),
        showSearchBox: true,
        popupTitle: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(title, style: TextStyle(fontSize: 28))),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            decoration: !isSelected
                ? null
                : BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
            child: ListTile(
              selected: isSelected,
              title: Text(item.name),
              leading: item.icon,
            ),
          );
        },
        dropdownBuilder: (context, selectedItem, itemAsString) {
          if (current == null) {
            return Text("Select " + title);
          }
          return Text(selectedItem.name);
        },
        dropdownSearchDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: current == null ? null : current.icon,
          filled: true,
        ),
        dropDownButton: DropdownButton(
          items: [],
          onChanged: null,
          iconSize: 0.0,
        ),
        emptyBuilder: (context, string) {
          return Container(
            child: Center(
              child: Text("No Results"),
            ),
          );
        },
      ),
    );
  }

  List<ListItem> getServicesList() {
    List<ListItem> services = [];
    for (int i = 0; i < 10; i++) {
      services.add(ListItem(name: "Service $i", icon: Icon(Icons.ac_unit)));
    }
    return services;
  }

  List<ListItem> getCategoriesList() {
    List<ListItem> categories = [];
    for (int i = 0; i < 10; i++) {
      categories.add(ListItem(name: "Category $i", icon: Icon(Icons.alarm)));
    }
    return categories;
  }
}
