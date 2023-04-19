import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/utils/recipe_modal.dart';
import 'package:im_stepper/stepper.dart';
import 'package:foodboard_admin_application/addRecipe/add_basic_info.dart';
import 'package:foodboard_admin_application/addRecipe/add_directions.dart';
import 'package:foodboard_admin_application/addRecipe/add_filters.dart';
import 'package:foodboard_admin_application/addRecipe/add_hotels.dart';
import 'package:foodboard_admin_application/addRecipe/add_ingredients.dart';
import 'package:foodboard_admin_application/addRecipe/final_view.dart';
import 'package:foodboard_admin_application/utils/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AddRecipeForm extends StatefulWidget {
  int step;
  AddRecipeForm({
    Key? key,
    this.step = 0,
  }) : super(key: key);

  @override
  State<AddRecipeForm> createState() => _AddRecipeFormState();
}

class _AddRecipeFormState extends State<AddRecipeForm> {
  int activeStep = 0;
  int upperBound = 5; // upperBound MUST BE total number of icons minus 1.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RecipeModal>(
      create: (context) => RecipeModal(),
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.greyShade,
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Consumer<RecipeModal>(
              builder: (context, modal, child) {
                switch (modal.activeStep) {
                  case 0:
                    return const AddBasicInfo();
                  case 1:
                    return const AddIngredients();
                  case 2:
                    return const AddDirections();
                  case 3:
                    return const AddHotels();
                  case 4:
                    return const AddFilters();
                  case 5:
                    return const FinalView();

                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: AppColors.darkOcean,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {},
      child: Text('Proceed to ' + headerText()),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: activeStep == 0 ? Colors.grey : AppColors.darkOcean,
          textStyle: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'Ingredients List';

      case 1:
        return 'Directions List';

      case 2:
        return 'Add Hotels information';

      case 3:
        return 'Add any three Filters';

      case 4:
        return 'Final View';

      default:
        return 'Submit';
    }
  }
}
