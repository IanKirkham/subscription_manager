import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:subscription_manager/main.dart';
import 'package:subscription_manager/widgets/customTextField.dart';

import '../../data.dart';

// ignore: must_be_immutable
class NewSubscription extends StatefulWidget {
  @override
  _NewSubscriptionState createState() => _NewSubscriptionState();
}

class _NewSubscriptionState extends State<NewSubscription> {
  ListItem service;
  ListItem category;
  final textController = new TextEditingController();
  DateTime date;
  List<dynamic> notification;
  List<int> pickerIndex;
  String dropdownValue;

  final buttonList = ["Day", "Week", "Month", "Year"];

  @override
  void initState() {
    super.initState();
    date = DateTime.now();
    if (notification == null) {
      notification = [1, "day"];
    }
    if (pickerIndex == null) {
      pickerIndex = [0, 2];
    }
    if (dropdownValue == null) {
      dropdownValue = "Month";
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("New Subscription"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            sectionTitle("Subscription Service"),
            getDropdown(services, "Subscription", service),
            sectionTitle("Category"),
            getDropdown(myCategories, "Category", category),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Amount"),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: CustomTextFormField(
                        obscureText: false,
                        hintText: "Enter cost",
                        controller: textController,
                        inputFormatters: [
                          CurrencyTextInputFormatter(
                            symbol: '\$ ',
                          )
                        ],
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Notifications"),
                    GestureDetector(
                      onTap: () {
                        showNotificationPicker(context, pickerIndex);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height / 12.5,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFF444444),
                        ),
                        child: Center(
                          child: Text(
                            _formatNotification() + " before",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    // MaterialButton(
                    //   child: Text(_formatNotification() + " before"),
                    //   onPressed: () {
                    //     showNotificationPicker(context, pickerIndex);
                    //   },
                    //   color: Color(0xFF444444),
                    // ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Start date"),
                    GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 10),
                        ).then((selectedDate) {
                          if (selectedDate != null) {
                            setState(() {
                              date = selectedDate;
                            });
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 24,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    topRight: Radius.circular(5),
                                  ),
                                ),
                                child: Center(
                                    child:
                                        Text(DateFormat.MMMM().format(date))),
                              ),
                              Container(
                                color: Color(0xFF444444),
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
                                decoration: BoxDecoration(
                                  color: Color(0xFF444444),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                ),
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
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sectionTitle("Billed every"),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      //padding: const EdgeInsets.all(0),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            //color: Colors.pink,
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(5),
                            // ),
                            ),
                        child: Stack(
                          children: [
                            //Container(color: Colors.blue), // delete me
                            GroupButton(
                              selectedButtons: ["Month"],
                              spacing: 10,
                              borderRadius: BorderRadius.circular(5),
                              onSelected: (index, isSelected) => setState(() {
                                dropdownValue = buttonList[index];
                              }),
                              buttonWidth: 93,
                              buttonHeight: 51,
                              selectedColor: Theme.of(context).accentColor,
                              unselectedColor: Color(0xff444444),
                              unselectedTextStyle:
                                  TextStyle(fontSize: 14, color: Colors.white),
                              buttons: buttonList,
                            ),
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: Text("Next bill: " +
                            //       DateFormat.yMd()
                            //           .format(_getNextBillDate(date))),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 48),
                  child: Text("Next bill: " +
                      DateFormat.yMd().format(_getNextBillDate(date))),
                ),
              ],
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: Row(
            //     children: [
            //       Icon(Icons.notifications, size: 25),
            //       SizedBox(width: 5),
            //       // Text("Notify me   "),
            //       MaterialButton(
            //         child: Text(_formatNotification() + " before"),
            //         onPressed: () {
            //           showNotificationPicker(context, pickerIndex);
            //         },
            //         color: Color(0xFF444444),
            //       ),
            //       SizedBox(width: 10),
            //       //Text("prior to charge"),
            //     ],
            //   ),
            // ),
            SizedBox(height: 25),
            Container(
              height: MediaQuery.of(context).size.height / 15,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Consumer(builder: (context, watch, child) {
                return MaterialButton(
                  child:
                      Text("Save", style: Theme.of(context).textTheme.button),
                  onPressed: () {
                    if (service == null) {
                      displayError("Must select a subscription", context);
                    } else if (category == null) {
                      displayError("Must select a category", context);
                    } else if (textController.text.length == 0) {
                      displayError("Must enter an amount", context);
                    } else {
                      addSubscriptions();
                    }
                  },
                  color: Theme.of(context).accentColor,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void addSubscriptions() {
    DateTime current = date;
    int nextMonth = DateTime.now().month + 1;
    DateTime billDate = current;

    while (billDate.month <= nextMonth) {
      Subscription subscription = new Subscription(
        startDate: date,
        amount:
            double.parse(textController.text.substring(2).replaceAll(',', '')),
        notification: notification,
        category: category.name,
        recurring: dropdownValue,
        service: service.name,
        serviceIcon: service.icon,
        billDate: billDate,
        billingHistory: [],
        //   "Billed " +
        //       textController.text +
        //       " on " +
        //       DateFormat.yMd().format(date)
        // ],
      );
      subscriptions.add(subscription);
      current = billDate;
      billDate = _getNextBillDate(current);
    }
    context.read(subscriptionsProvider).update();
    Navigator.pop(context);
  }

  void displayError(String title, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).errorColor,
      content: Text(title, style: Theme.of(context).textTheme.headline6),
    ));
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
      child: Text(title, style: Theme.of(context).textTheme.headline6),
    );
  }

  DateTime _getNextBillDate(DateTime myDate) {
    DateTime nextBill;
    if (dropdownValue == "Day") {
      nextBill = DateTime(myDate.year, myDate.month, myDate.day + 1);
    } else if (dropdownValue == "Week") {
      nextBill = DateTime(myDate.year, myDate.month, myDate.day + 7);
    } else if (dropdownValue == "Month") {
      nextBill = DateTime(myDate.year, myDate.month + 1, myDate.day);
    } else if (dropdownValue == "Year") {
      nextBill = DateTime(myDate.year + 1, myDate.month, myDate.day);
    } else {
      return null;
    }
    return nextBill;
  }

  String _formatNotification() {
    if (notification[0].toString() != "1") {
      return notification[0].toString() + " " + notification[1] + "s";
    }
    return notification[0].toString() + " " + notification[1];
  }

  void showNotificationPicker(BuildContext context, selectedList) {
    Picker(
      backgroundColor: Color(0xFF444444),
      selecteds: selectedList,
      adapter: PickerDataAdapter<String>(
        pickerdata: [
          List<int>.generate(60, (i) => i + 1),
          [
            "minute",
            "hour",
            "day",
            "week",
            "month",
          ]
        ],
        isArray: true,
      ),
      hideHeader: true,
      textScaleFactor: 1.4,
      textStyle: TextStyle(color: Colors.white),
      confirmText: "OK",
      cancelText: "CANCEL",
      title: new Text(
        "Notifications",
        style: TextStyle(color: Colors.white),
      ),
      height: MediaQuery.of(context).size.height / 3,
      onConfirm: (Picker picker, List value) {
        if (picker == null) {
          return;
        }
        setState(() {
          pickerIndex = value;
          notification = picker.getSelectedValues();
        });
      },
    ).showDialog(context);
  }

  Container getDropdown(List<ListItem> items, String title, ListItem current) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: DropdownSearch<ListItem>(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
        searchDelay: Duration(milliseconds: 0),
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
          padding: const EdgeInsets.only(
            left: 15,
            top: 15,
          ),
          child: Text(
            "Select " + title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        popupItemBuilder: (context, item, isSelected) {
          return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Theme.of(context).dividerColor,
            ))),
            child: ListTile(
              selected: isSelected,
              title: Text(item.name),
              leading: SizedBox(height: 35, width: 35, child: item.icon),
            ),
          );
        },
        dropdownBuilder: (context, selectedItem, itemAsString) {
          if (current == null) {
            return Text("Select " + title.toLowerCase(),
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ));
          }
          return Text(selectedItem.name);
          // return Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 15),
          //   child: Text(selectedItem.name),
          // );
        },
        dropdownSearchDecoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: current == null
              ? null
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(height: 35, width: 35, child: current.icon),
                ),
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
}
