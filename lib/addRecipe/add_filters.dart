import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:foodboard_admin_application/widgets/filter_chip.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

class AddFilters extends StatefulWidget {
  const AddFilters({Key? key}) : super(key: key);

  @override
  State<AddFilters> createState() => _AddFiltersState();
}

class _AddFiltersState extends State<AddFilters> {
  Map filterMap = {};
  List<String> typeMap = [
    "BreakFast",
    "Lunch",
    "Dinner",
    "Brunch",
  ];
  List<String> timeMap = ["10 min", "< 30 min", "< 30 min", "> 1 hr"];
  List<String> foodMap = [
    "Cake",
    "Salad",
    "Pasta",
    "Desert",
    "Main Course",
    "Appetizer",
    "Soup",
    "Veg",
    "Non-Veg"
  ];
  late List<String> selectedItems = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModal>(builder: (context, modal, child) {
      return Scaffold(
          backgroundColor: AppColors.greyShade,
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: DotStepper(
                            activeStep: modal.activeStep,
                            dotCount: modal.totalIndex,
                            dotRadius: 20.0,
                            shape: Shape.pipe,
                            spacing: 10.0,
                            indicatorDecoration: const IndicatorDecoration(
                                color: AppColors.darkOcean),
                          ),
                        ),
                        Center(
                          child: BigText(
                            size: 16,
                            text:
                                "Step ${modal.activeStep + 1} of ${modal.totalIndex}",
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        BigText(text: "Add 3 Filters"),
                        const SizedBox(
                          height: 20,
                        ),
                        BigText(
                          text: "Type",
                          size: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 15.0,
                            runSpacing: 15.0,
                            children: List<Widget>.generate(typeMap.length,
                                (int index) {
                              return FilterChipWidget(
                                  chipName: typeMap[index],
                                  onSelected: (isChecked, item) {
                                    if (selectedItems.length < 3 ||
                                        selectedItems.contains(item) ||
                                        selectedItems.contains(item)) {
                                      if (isChecked) {
                                        // Check the value exists in the list: add if NOT EXISTS
                                        if (!selectedItems.contains(item)) {
                                          selectedItems.add(item);
                                        }
                                      } else {
                                        // Check the value exists in the list: remove if EXISTS
                                        if (selectedItems.contains(item)) {
                                          selectedItems.remove(item);
                                        }
                                      }
                                    }
                                  });
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BigText(
                          text: "Time",
                          size: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            spacing: 15.0,
                            runSpacing: 15.0,
                            children: List<Widget>.generate(timeMap.length,
                                (int index) {
                              return FilterChipWidget(
                                  chipName: timeMap[index],
                                  onSelected: (isChecked, item) {
                                    if (selectedItems.length < 3 ||
                                        selectedItems.contains(item)) {
                                      if (isChecked) {
                                        // Check the value exists in the list: add if NOT EXISTS
                                        if (!selectedItems.contains(item)) {
                                          selectedItems.add(item);
                                        }
                                      } else {
                                        // Check the value exists in the list: remove if EXISTS
                                        if (selectedItems.contains(item)) {
                                          selectedItems.remove(item);
                                        }
                                      }
                                    }
                                  });
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BigText(
                          text: "Food",
                          size: 16,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Wrap(
                            spacing: 15.0,
                            runSpacing: 15.0,
                            children: List<Widget>.generate(foodMap.length,
                                (int index) {
                              return FilterChipWidget(
                                  chipName: foodMap[index],
                                  onSelected: (isChecked, item) {
                                    if (selectedItems.length < 3 ||
                                        selectedItems.contains(item)) {
                                      if (isChecked) {
                                        // Check the value exists in the list: add if NOT EXISTS
                                        if (!selectedItems.contains(item)) {
                                          selectedItems.add(item);
                                        }
                                      } else {
                                        // Check the value exists in the list: remove if EXISTS
                                        if (selectedItems.contains(item)) {
                                          selectedItems.remove(item);
                                        }
                                      }
                                    }
                                  });
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        AppBtn(
                            name: "Proceed To Final View",
                            fun: () async {
                              //firebase code here
                              print(selectedItems);
                              setState(() {
                                for (int i = 0; i < selectedItems.length; i++) {
                                  String j = i.toString();
                                  filterMap[j] = selectedItems[i];
                                }
                                modal.filters = filterMap;
                              });

                              modal.changeStep(5);
                            }),
                      ]))));
    });
  }
}
