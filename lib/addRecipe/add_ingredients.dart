import 'package:flutter/material.dart';

import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/add_btn.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:foodboard_admin_application/widgets/custom_text_field.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

class AddIngredients extends StatefulWidget {
  const AddIngredients({
    Key? key,
  }) : super(key: key);

  @override
  State<AddIngredients> createState() => _AddIngredientsState();
}

class _AddIngredientsState extends State<AddIngredients> {
  GlobalKey<FormState> ingredientFormKey = GlobalKey<FormState>();
  final List<TextEditingController> _nameControllers = [];
  final List<CustomTextField> _nameFields = [];
  final List<TextEditingController> _countControllers = [];
  final List<CustomTextField> _countFields = [];
  final List<TextEditingController> _urlControllers = [];
  final List<CustomTextField> _urlFields = [];

  Map ingredientMap = {};

  @override
  void dispose() {
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    for (final controller in _countControllers) {
      controller.dispose();
    }
    for (final controller in _urlControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
                        text: "Ingredients List",
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
                    name: "Proceed To Directions",
                    fun: () {
                      if (ingredientFormKey.currentState?.validate() ?? false) {
                        //firebase code goes here
                        print(modal);

                        setState(() {
                          for (int i = 0; i < _nameControllers.length; i++) {
                            String j = i.toString();
                            ingredientMap[j] = {
                              'ingredientName': _nameControllers[i].text,
                              'ingredientCount': _countControllers[i].text,
                              'ingredientUrl': _urlControllers[i].text,
                            };
                          }
                          modal.ingredients = ingredientMap;
                        });
                        modal.changeStep(2);
                      }
                    }),
              ],
            )),
      );
    });
  }

  Widget _addButton() {
    return InkWell(
      onTap: () {
        final name = TextEditingController();
        final count = TextEditingController();
        final url = TextEditingController();

        final nameField = _generateTextField(
          name,
          "Name",
          (value) {
            RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

            if (value!.isEmpty) {
              return ("Ingredient Name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Valid Recipe Ingredient");
            }
            return null;
          },
        );
        final countField = _generateTextField(
          count,
          "Count",
          (value) {
            RegExp regex = RegExp(r"^(\d+\s*)?[a-zA-Z\s]+$");

            if (value!.isEmpty) {
              return ("Ingredient Count is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Valid Ingredient Count");
            }
            return null;
          },
        );
        final urlField = _generateTextField(
          url,
          "url",
          (value) {
            RegExp regex = RegExp(
                r"^(http[s]?:\/\/)?[www.]?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}[\/\w \.-]*\/?$");

            if (value!.isEmpty) {
              return ("Ingredient Image Url is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Type Valid Ingredient Image Url");
            }
            return null;
          },
        );

        setState(() {
          _nameControllers.add(name);
          _countControllers.add(count);
          _urlControllers.add(url);
          _nameFields.add(nameField);
          _countFields.add(countField);
          _urlFields.add(urlField);
        });
      },
      child: const AddButton(),
    );
  }

  CustomTextField _generateTextField(TextEditingController controller,
      String hint, String? Function(String?)? valid) {
    return CustomTextField(
      name: hint,
      controller: controller,
      hint: hint,
      valid: valid,
    );
  }

  Widget _listView() {
    final children = [
      for (var i = 0; i < _nameControllers.length; i++)
        Stack(alignment: AlignmentDirectional.topEnd, children: [
          Container(
            margin: const EdgeInsets.all(5),
            child: InputDecorator(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  _nameFields[i],
                  const SizedBox(
                    height: 10,
                  ),
                  _countFields[i],
                  const SizedBox(
                    height: 10,
                  ),
                  _urlFields[i],
                ],
              ),
              decoration: InputDecoration(
                labelText: "Ingredient " + (i + 1).toString(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _countFields
                    .removeAt(_countControllers.indexOf(_countControllers[i]));
                _countControllers
                    .removeAt(_countControllers.indexOf(_countControllers[i]));
                _nameFields
                    .removeAt(_nameControllers.indexOf(_nameControllers[i]));
                _nameControllers
                    .removeAt(_nameControllers.indexOf(_nameControllers[i]));
                _urlFields
                    .removeAt(_urlControllers.indexOf(_urlControllers[i]));
                _urlControllers
                    .removeAt(_urlControllers.indexOf(_urlControllers[i]));
              });
            },
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              width: 40,
              child: const Align(
                alignment: Alignment(0, 0),
                //Alignment(1, -1) place the image at the top & far left.
                //Alignment (0, 0) is the center of the container
                //You can change the value of x and y to any number between -1 and 1
                child: Icon(Icons.close, color: Colors.red, size: 25),
              ),
            ),
          ),
        ]),
    ];
    return SingleChildScrollView(
      child: Form(
        key: ingredientFormKey,
        child: Wrap(
          runSpacing: 5,
          children: children,
        ),
      ),
    );
  }

  // final _okController = TextEditingController();
  // Widget _okButton(BuildContext context) {
  //   final button = ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //         primary: AppColors.darkOcean,
  //         textStyle: const TextStyle(fontWeight: FontWeight.bold)),
  //     onPressed: () async {
  //       // const index = 0;
  //       // String text = "name: ${_nameControllers[index].text}\n"
  //       //     "count: ${_countControllers[index].text}\n"
  //       //     "url: ${_urlControllers[index].text}";
  //       // await showMessage(context, text, "Result");

  //       // Navigator.push(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //       builder: (context) => AddRecipeForm(step: 2),
  //       //     ));
  //     },
  //     child: const Text("Proceed to Directions"),
  //   );

  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //     children: [
  //       _addButton(),
  //       button,
  //     ],
  //   );
}
