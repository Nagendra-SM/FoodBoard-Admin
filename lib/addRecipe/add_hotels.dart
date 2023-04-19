import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/add_btn.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:foodboard_admin_application/widgets/custom_text_field.dart';
import 'package:foodboard_admin_application/widgets/show_dialog.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';

class AddHotels extends StatefulWidget {
  const AddHotels({Key? key}) : super(key: key);

  @override
  State<AddHotels> createState() => _AddHotelsState();
}

class _AddHotelsState extends State<AddHotels> {
  GlobalKey<FormState> hotelFormKey = GlobalKey<FormState>();

  Map hotelMap = {};

  final List<TextEditingController> _nameControllers = [];
  final List<CustomTextField> _nameFields = [];
  final List<TextEditingController> _typeControllers = [];
  final List<CustomTextField> _typeFields = [];
  final List<TextEditingController> _urlControllers = [];
  final List<CustomTextField> _urlFields = [];
  final List<TextEditingController> _reviewsControllers = [];
  final List<CustomTextField> _reviewsFields = [];
  final List<TextEditingController> _ratingControllers = [];
  final List<CustomTextField> _ratingFields = [];

  @override
  void dispose() {
    for (final controller in _nameControllers) {
      controller.dispose();
    }
    for (final controller in _typeControllers) {
      controller.dispose();
    }
    for (final controller in _urlControllers) {
      controller.dispose();
    }
    for (final controller in _reviewsControllers) {
      controller.dispose();
    }
    for (final controller in _ratingControllers) {
      controller.dispose();
    }
    _okController.dispose();
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
                        text: "Hotel List",
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
                    name: "Proceed To Filter List",
                    fun: () {
                      if (hotelFormKey.currentState?.validate() ?? false) {
                        //firebase code goes here
                        print(modal);

                        setState(() {
                          for (int i = 0; i < _nameControllers.length; i++) {
                            String j = i.toString();
                            hotelMap[j] = {
                              'hotelName': _nameControllers[i].text,
                              'hotelType': _typeControllers[i].text,
                              'hotelUrl': _urlControllers[i].text,
                              'hotelReviews': _reviewsControllers[i].text,
                              'hotelRating': _ratingControllers[i].text,
                            };
                          }
                          modal.hotels = hotelMap;
                        });
                        modal.changeStep(4);
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
        final type = TextEditingController();
        final url = TextEditingController();
        final reviews = TextEditingController();
        final rating = TextEditingController();

        final nameField = _generateTextField(
          name,
          "Name",
          (value) {
            RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

            if (value!.isEmpty) {
              return ("Hotel Name is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Valid Hotel Name");
            }
            return null;
          },
        );
        final typeField = _generateTextField(
          type,
          "Type",
          (value) {
            RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

            if (value!.isEmpty) {
              return ("Recipe Type is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Type Valid Recipe Type");
            }
            return null;
          },
        );
        final urlField = _generateTextField(
          url,
          "Logo Url",
          (value) {
            RegExp regex = RegExp(
                r"^(http[s]?:\/\/)?[www.]?[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}[\/\w \.-]*\/?$");

            if (value!.isEmpty) {
              return ("Logo Url is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Type Valid Logo Url");
            }
            return null;
          },
        );
        final reviewsField = _generateTextField(
          reviews,
          "Total Reviews",
          (value) {
            RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

            if (value!.isEmpty) {
              return ("Hotel Review is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Valid Hotel Review");
            }
            return null;
          },
        );
        final ratingField = _generateTextField(
          rating,
          "Rating",
          (value) {
            RegExp regex = RegExp(r"^(?:[1-5](?:\.[0-9])?|5)$");

            if (value!.isEmpty) {
              return ("Recipe Rating is required");
            }
            if (!regex.hasMatch(value)) {
              return ("Please Enter Rating between 1 to 5");
            }
            return null;
          },
        );

        setState(() {
          _nameControllers.add(name);
          _typeControllers.add(type);
          _urlControllers.add(url);
          _reviewsControllers.add(reviews);
          _ratingControllers.add(rating);
          _nameFields.add(nameField);
          _typeFields.add(typeField);
          _urlFields.add(urlField);
          _reviewsFields.add(reviewsField);
          _ratingFields.add(ratingField);
        });
      },
      child: AddButton(),
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
                  _typeFields[i],
                  const SizedBox(
                    height: 10,
                  ),
                  _urlFields[i],
                  const SizedBox(
                    height: 10,
                  ),
                  _reviewsFields[i],
                  const SizedBox(
                    height: 10,
                  ),
                  _ratingFields[i],
                ],
              ),
              decoration: InputDecoration(
                labelText: "Hotel " + (i + 1).toString(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _typeFields
                    .removeAt(_typeControllers.indexOf(_typeControllers[i]));
                _typeControllers
                    .removeAt(_typeControllers.indexOf(_typeControllers[i]));
                _nameFields
                    .removeAt(_nameControllers.indexOf(_nameControllers[i]));
                _nameControllers
                    .removeAt(_nameControllers.indexOf(_nameControllers[i]));
                _urlFields
                    .removeAt(_urlControllers.indexOf(_urlControllers[i]));
                _urlControllers
                    .removeAt(_urlControllers.indexOf(_urlControllers[i]));
                _reviewsFields.removeAt(
                    _reviewsControllers.indexOf(_reviewsControllers[i]));
                _reviewsControllers.removeAt(
                    _reviewsControllers.indexOf(_reviewsControllers[i]));
                _ratingFields.removeAt(
                    _ratingControllers.indexOf(_ratingControllers[i]));
                _ratingControllers.removeAt(
                    _ratingControllers.indexOf(_ratingControllers[i]));
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
        key: hotelFormKey,
        child: Wrap(
          runSpacing: 5,
          children: children,
        ),
      ),
    );
  }

  final _okController = TextEditingController();
  Widget _okButton(BuildContext context) {
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColors.darkOcean,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () async {
        const index = 0;
        String text = "name: ${_nameControllers[index].text}\n"
            "type: ${_typeControllers[index].text}\n"
            "url: ${_urlControllers[index].text}\n"
            "reviews: ${_reviewsControllers[index].text}\n"
            "rating: ${_ratingControllers[index].text}\n";
        await showMessage(context, text, "Result");
      },
      child: const Text("Proceed to Directions"),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _addButton(),
        button,
      ],
    );
  }
}
