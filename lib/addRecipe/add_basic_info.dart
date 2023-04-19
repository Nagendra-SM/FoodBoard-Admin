import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';

import 'package:foodboard_admin_application/addRecipe/select_photo_options_screen.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:foodboard_admin_application/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddBasicInfo extends StatefulWidget {
  const AddBasicInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBasicInfo> createState() => _AddBasicInfoState();
}

class _AddBasicInfoState extends State<AddBasicInfo> {
  GlobalKey<FormState> basicFormKey = GlobalKey<FormState>();
  File? _image;

  final recipeNameController = TextEditingController();
  final recipeTypeController = TextEditingController();
  final recipeTimeController = TextEditingController();
  final cookNameController = TextEditingController();
  final recipeReviewController = TextEditingController();
  final recipeRatingController = TextEditingController();

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);

      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    recipeNameController.dispose();
    recipeTypeController.dispose();
    cookNameController.dispose();
    recipeReviewController.dispose();
    recipeRatingController.dispose();
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
          body: Form(
            key: basicFormKey,
            child: SingleChildScrollView(
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
                      indicatorDecoration:
                          IndicatorDecoration(color: AppColors.darkOcean),
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
                  BigText(text: "Basic Recipe Information"),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Recipe Name :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Recipe Name",
                    controller: recipeNameController,
                    hint: 'Enter recipe name',
                    valid: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

                      if (value!.isEmpty) {
                        return ("Recipe Name is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Enter Valid Recipe Name");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Add Image :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Container(
                      height: 200,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: AppColors.lightOcean),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Center(
                          child: _image == null
                              ? IconButton(
                                  iconSize: 100,
                                  color: AppColors.darkOcean,
                                  onPressed: () {
                                    _showSelectPhotoOptions(context);
                                  },
                                  icon: const Icon(Icons.add))
                              : SizedBox.expand(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    child: Image(
                                        fit: BoxFit.cover,
                                        image: FileImage(_image!)),
                                  ),
                                )),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Recipe Type :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Recipe Type",
                    controller: recipeTypeController,
                    hint: 'Enter recipe type',
                    valid: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

                      if (value!.isEmpty) {
                        return ("Recipe Type is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Type Valid Recipe Name");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Recipe Preparation Time :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Recipe Preparation Time",
                    controller: recipeTimeController,
                    hint: 'Enter time in minutes',
                    valid: (value) {
                      RegExp regex = RegExp(
                          r"^(?:(?:0?[0-9]|[1-9][0-9]):(?:0?[0-9]|[1-5][0-9])|0?:?[1-9]|[1-9][0-9])$");

                      if (value!.isEmpty) {
                        return ("Preparation time is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Preparation time must be in hh:mm format");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Cook Name :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Cook Name",
                    controller: cookNameController,
                    hint: 'Enter cook name',
                    valid: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z'-. ]+$");

                      if (value!.isEmpty) {
                        return ("Cook Name is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Cook Name can't have numbers");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Recipe Reviews :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Recipe Review",
                    controller: recipeReviewController,
                    hint: 'Enter recipe review',
                    valid: (value) {
                      RegExp regex = RegExp(r"^[a-zA-Z][a-zA-Z0-9_ -]{2,}$");

                      if (value!.isEmpty) {
                        return ("Recipe Review is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Enter Valid Recipe Review");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(" Recipe Rating :",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextField(
                    name: "Recipe Rating",
                    controller: recipeRatingController,
                    hint: 'Enter recipe rating',
                    valid: (value) {
                      RegExp regex = RegExp(r"^(?:[1-5](?:\.[0-9])?|5)$");

                      if (value!.isEmpty) {
                        return ("Recipe Rating is required");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please Enter Rating between 1 to 5");
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Center(
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //         primary: AppColors.darkOcean,
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 50, vertical: 20),
                  //         textStyle:
                  //             const TextStyle(fontWeight: FontWeight.bold)),
                  //     onPressed: () {
                  //       if (_formKey.currentState!.validate()) {
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           const SnackBar(content: Text('Processing Data')),
                  //         );
                  //         showDialog(
                  //           context: context,
                  //           builder: (context) {
                  //             return AlertDialog(
                  //               // Retrieve the text the that user has entered by using the
                  //               // TextEditingController.
                  //               content: Text(
                  //                   "recipeName: " + recipeNameController.text),
                  //             );
                  //           },
                  //         );
                  //       }
                  //     },
                  //     child: const Text('Proceed to Ingredients List'),
                  //   ),
                  // ),
                  AppBtn(
                      name: "Proceed To Ingredients",
                      fun: () {
                        if (basicFormKey.currentState?.validate() ?? false) {
                          //firebase code goes here

                          setState(() {
                            modal.recipeName = recipeNameController.text;
                            modal.recipeImage = _image;
                            modal.recipeType = recipeTypeController.text;
                            modal.recipeTime = recipeTimeController.text;
                            modal.authorName = cookNameController.text;
                            modal.recipeReviews = recipeReviewController.text;
                            modal.recipeRating = recipeRatingController.text;
                          });
                          print(modal);
                          modal.changeStep(1);
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
