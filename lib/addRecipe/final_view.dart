import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:foodboard_admin_application/widgets/app_btn.dart';
import 'package:foodboard_admin_application/widgets/big_text.dart';
import 'package:im_stepper/stepper.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class FinalView extends StatefulWidget {
  const FinalView({Key? key}) : super(key: key);

  @override
  State<FinalView> createState() => _FinalViewState();
}

class _FinalViewState extends State<FinalView> {
  String data = "";
  String recipeImageUrl = "";

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
                        BigText(
                          text: "Final View",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: SizedBox(
                            width: 350,
                            height: 550,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      child: Container(
                                        color: Colors.blue,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 22, 32, 0),
                                          child: Text(
                                            'RECIPE DETAILS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 247, 247, 247),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 1,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          "Recipe Name: ${modal.recipeName}",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: "\nImage Url: ",
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          width: 200,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          height: 150,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(modal
                                                                .recipeImage!),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\nRecipe Type: ${modal.recipeType}",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                      text:
                                                          "\nPreparation Time: ${modal.recipeTime}",
                                                    ),
                                                    const WidgetSpan(
                                                        child: SizedBox(
                                                      height: 35,
                                                    )),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Colors.black,
                                                      ),
                                                      text:
                                                          "\nAuthor Name: ${modal.authorName}",
                                                    ),
                                                    const WidgetSpan(
                                                        child: SizedBox(
                                                      height: 35,
                                                    )),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Colors.black,
                                                      ),
                                                      text:
                                                          "\nRecipe Review: ${modal.recipeReviews}",
                                                    ),
                                                    const WidgetSpan(
                                                        child: SizedBox(
                                                      height: 35,
                                                    )),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Colors.black,
                                                      ),
                                                      text:
                                                          "\nRecipe Rating: ${modal.recipeRating}",
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: SizedBox(
                            width: 350,
                            height: 525,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      child: Container(
                                        color: Colors.blue,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 22, 32, 0),
                                          child: Text(
                                            'INGREDIENTS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: modal.ingredients?.entries
                                            .toList()
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          String key = modal.ingredients?.keys
                                              .elementAt(index);

                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  "STEP $key",
                                                  style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 16,
                                                    height: 2.2,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 32, 132, 147),
                                                    letterSpacing: 2,
                                                  ),
                                                ),
                                                subtitle: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          "Ingredients Name: ${modal.ingredients?[key]["ingredientName"]}",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\nQuantity: ${modal.ingredients?[key]["ingredientCount"]} ",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text:
                                                          "\nIngredients Url: \n",
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          width: 200,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          height: 150,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                '${modal.ingredients?[key]["ingredientUrl"]}'),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const Divider(
                                                height: 15.0,
                                                thickness: 1,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: SizedBox(
                            width: 350,
                            height: 530,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      child: Container(
                                        color: Colors.blue,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              30, 22, 32, 0),
                                          child: Text(
                                            'DIRECTIONS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: modal.directions?.entries
                                            .toList()
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          String key = modal.directions?.keys
                                              .elementAt(index);

                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  "STEP $key",
                                                  style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 16,
                                                    height: 2.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 32, 132, 147),
                                                    letterSpacing: 2,
                                                  ),
                                                ),
                                                subtitle: RichText(
                                                  textAlign: TextAlign.justify,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          "${modal.directions?["${key}"]}",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.2,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const Divider(
                                                height: 15.0,
                                                thickness: 1,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: SizedBox(
                            width: 350,
                            height: 530,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      child: Container(
                                        color: Colors.blue,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 22, 32, 0),
                                          child: Text(
                                            'HOTELS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 16,
                                              color: Color.fromARGB(
                                                  255, 247, 247, 247),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: modal.hotels?.entries
                                            .toList()
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          String key = modal.hotels?.keys
                                              .elementAt(index);

                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: Text(
                                                  "HOTEL $key",
                                                  style: const TextStyle(
                                                    fontFamily: 'OpenSans',
                                                    fontSize: 16,
                                                    height: 2.5,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color.fromARGB(
                                                        255, 32, 132, 147),
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                subtitle: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                      text:
                                                          "Hotel Name: ${modal.hotels?[key]["hotelName"]}",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          "\nHotel Type: ${modal.hotels?[key]["hotelType"]} ",
                                                      style: const TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Color.fromARGB(
                                                            255, 0, 0, 0),
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text: "\nLogo Url: \n",
                                                      style: TextStyle(
                                                        fontFamily: 'OpenSans',
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Colors.black,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                    WidgetSpan(
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child: Container(
                                                          width: 200,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          height: 130,
                                                          child: Image(
                                                            fit: BoxFit.cover,
                                                            image: NetworkImage(
                                                                "${modal.hotels?[key]["hotelUrl"]}"),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 2.5,
                                                          color: Colors.black),
                                                      text:
                                                          "\nHotel Review: ${modal.hotels?[key]["hotelReviews"]}",
                                                    ),
                                                    TextSpan(
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 2.5,
                                                        color: Colors.black,
                                                      ),
                                                      text:
                                                          "\nHotel Rating: ${modal.hotels?[key]["hotelRating"]}",
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                              const Divider(
                                                height: 15.0,
                                                thickness: 1,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Card(
                          color: Colors.white,
                          elevation: 2,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: SizedBox(
                            width: 350,
                            height: 270,
                            child: InkWell(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(16)),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16)),
                                      child: Container(
                                        color: Colors.blue,
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 22, 32, 0),
                                          child: Text(
                                            'FILTERS',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontFamily: 'OpenSans',
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: modal.filters?.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          String key = modal.filters?.keys
                                              .elementAt(index);

                                          return Column(
                                            children: <Widget>[
                                              ListTile(
                                                title: RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    text:
                                                        "${key} : ${modal.filters?["${key}"]}",
                                                    style: const TextStyle(
                                                      fontFamily: 'OpenSans',
                                                      fontSize: 16,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      letterSpacing: 1,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        AppBtn(
                            name: "Proceed To Final View",
                            fun: () async {
                              //firebase code here

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0))),
                                      contentPadding: const EdgeInsets.all(0.0),
                                      content: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Lottie.asset(
                                              'assets/data-transfer.json',
                                              repeat: true,
                                              reverse: true,
                                              animate: true,
                                            ),
                                            // CircularProgressIndicator(
                                            //     color: Colors.blue),
                                            const SizedBox(height: 16),
                                            const Text(
                                              "Please wait....",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });

                              final referenceRoot =
                                  FirebaseStorage.instance.ref();
                              final referenceDirImages =
                                  referenceRoot.child('images');

                              //Create a reference for the image to be stored
                              Reference referenceImageToUpload =
                                  referenceDirImages.child(
                                      '${modal.recipeName} - ${modal.authorName} ');

                              //Handle errors/success
                              try {
                                //Store the file
                                await referenceImageToUpload
                                    .putFile(modal.recipeImage!);
                                //Success: get the download URL
                                recipeImageUrl = await referenceImageToUpload
                                    .getDownloadURL();
                              } catch (error) {
                                //Some error occurred
                              }
                              final addDataindb = FirebaseFirestore.instance
                                  .collection('recipeDetails')
                                  .doc();

                              Map? ingredientsList = modal.ingredients;

                              Map? directionList = modal.directions;

                              Map? hotelList = modal.hotels;
                              Map? filterList = modal.filters;
                              await addDataindb.set({
                                'recipeName': modal.recipeName,
                                'recipeImage': recipeImageUrl,
                                'recipeType': modal.recipeType,
                                'recipeTime': modal.recipeTime,
                                'authorName': modal.authorName,
                                'restuarantList': hotelList,
                                'recipeReviews': modal.recipeReviews,
                                'recipeRating': modal.recipeRating,
                                'ingredientList': ingredientsList,
                                'directionList': directionList,
                                'Filters': filterList,
                              });

                              Navigator.of(context).pop();

                              if (addDataindb is String) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Text(
                                              "Failed To Store The Data ",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blueGrey),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 12, 80, 249),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 16, 8),
                                                  child: const Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                16, 16, 16, 16),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomLeft:
                                                    Radius.circular(50))),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      child: AlertDialog(
                                        backgroundColor: Colors.white,
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            const Text(
                                              "Successfully Data Executed",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blueGrey),
                                            ),
                                            const SizedBox(
                                              height: 16,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          16, 8, 16, 8),
                                                  child: const Text(
                                                    "Ok",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                16, 16, 16, 16),
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(50),
                                                bottomLeft:
                                                    Radius.circular(50))),
                                      ),
                                    );
                                  },
                                );
                              }

                              // setState(() {
                              //   data = modal.toString();
                              // });
                            }),
                      ]))));
    });
  }
}
