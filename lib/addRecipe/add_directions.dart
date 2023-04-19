import 'package:flutter/material.dart';

import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/add_btn.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

class AddDirections extends StatefulWidget {
  const AddDirections({
    Key? key,
  }) : super(key: key);

  @override
  State<AddDirections> createState() => _AddDirectionsState();
}

class _AddDirectionsState extends State<AddDirections> {
  GlobalKey<FormState> directionsFormKey = GlobalKey<FormState>();
  Map directionsMap = {};
  final List<TextEditingController> _controllers = [];
  final List<TextFormField> _fields = [];
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeModal>(builder: (context, modal, child) {
      return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.greyShade,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: DotStepper(
                    activeStep: modal.activeStep,
                    dotCount: modal.totalIndex,
                    dotRadius: 20.0,
                    shape: Shape.pipe,
                    spacing: 10.0,
                    indicatorDecoration:
                        const IndicatorDecoration(color: AppColors.darkOcean),
                  ),
                ),
                Center(
                  child: BigText(
                    size: 16,
                    text: "Step ${modal.activeStep + 1} of ${modal.totalIndex}",
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BigText(
                        text: "Directions List",
                      ),
                      _addButton(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(child: _listView()),
                const SizedBox(
                  height: 15,
                ),
                AppBtn(
                    name: "Proceed To Hotel List",
                    fun: () {
                      if (directionsFormKey.currentState?.validate() ?? false) {
                        //firebase code goes here
                        print(modal);
                        setState(() {
                          for (int i = 0; i < _controllers.length; i++) {
                            String j = i.toString();
                            directionsMap[j] = _controllers[i].text;
                          }
                          print(directionsMap);
                          modal.directions = directionsMap;
                        });

                        modal.changeStep(3);
                      }
                    }),
              ],
            ),
          ));
    });
  }

  Widget _listView() {
    return Form(
      key: directionsFormKey,
      child: ListView.builder(
        itemCount: _fields.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(5),
            child: _fields[index],
          );
        },
      ),
    );
  }

  Widget _okButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColors.darkOcean,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () async {
        String text = _controllers
            .where((element) => element.text != "")
            .fold("", (acc, element) => acc += "${element.text}\n");
        final alert = AlertDialog(
          title: Text("Count: ${_controllers.length}"),
          content: Text(text.trim()),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
        await showDialog(
          context: context,
          builder: (BuildContext context) => alert,
        );
        setState(() {});
      },
      child: const Text("Proceed to Hotel List"),
    );
  }

  Widget _addButton() {
    return InkWell(
      onTap: () {
        final controller = TextEditingController();
        final field = TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            RegExp regex = RegExp(r"^[a-zA-Z0-9\s\.,?!]+$");

            if (value!.isEmpty) {
              return ("Recipe Directions is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Valid Recipe directions");
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Step ${_controllers.length + 1}",
            hintText: "Enter Step ${_controllers.length + 1}",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _fields.removeAt(_controllers.indexOf(controller));
                    _controllers.removeAt(_controllers.indexOf(controller));
                  });
                },
                icon: const Icon(Icons.delete)),
          ),
        );

        setState(() {
          _controllers.add(controller);
          _fields.add(field);
        });
      },
      child: AddButton(),
    );
  }
}
