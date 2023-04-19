import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';

class RecipeModal extends ChangeNotifier {
  String? recipeName;
  File? recipeImage;
  String? recipeType;
  String? recipeTime;
  String? authorName;
  String? recipeReviews;
  String? recipeRating;

  Map? ingredients;
  Map? directions;
  Map? hotels;
  Map? filters;

  int activeStep = 0;
  int totalIndex = 6;
  RecipeModal({
    this.recipeName,
    this.recipeImage,
    this.recipeType,
    this.recipeTime,
    this.authorName,
    this.recipeReviews,
    this.recipeRating,
    this.ingredients,
    this.directions,
    this.hotels,
    this.filters,
  });

  changeStep(int index) {
    activeStep = index;
    notifyListeners();
  }

  factory RecipeModal.fromJson(Map<String, dynamic> json) {
    return RecipeModal(
      recipeName: json['recipeName'] as String,
      recipeImage: json['recipeImage'] as File,
      recipeType: json['recipeType'] as String,
      recipeTime: json['recipeTime'] as String,
      recipeReviews: json['recipeReviews'] as String,
      recipeRating: json['recipeRating'] as String,
      ingredients: json['ingredients'] as Map,
      directions: json['directions'] as Map,
      hotels: json['hotels'] as Map,
      filters: json['filters'] as Map,
    );
  }

  Map<String, dynamic> toJson() => {
        'recipeName': recipeName,
        'recipeImage': recipeImage,
        'recipeType': recipeType,
        'recipeTime': recipeTime,
        'authorName': authorName,
        'recipeReviews': recipeReviews,
        'recipeRating': recipeRating,
        'ingredients': ingredients,
        'directions': directions,
        'hotels': hotels,
        'filters': filters
      };
}
