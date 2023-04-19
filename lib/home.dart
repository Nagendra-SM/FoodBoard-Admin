import 'package:flutter/material.dart';
import 'package:foodboard_admin_application/addRecipe/add_recipe_detail.dart';
import 'package:foodboard_admin_application/addRecipe/admin_register.dart';
import 'package:foodboard_admin_application/drawer.dart';
import 'package:foodboard_admin_application/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyShade,
      appBar: AppBar(
        iconTheme: const IconThemeData(size: 25, color: Colors.white),
        elevation: 0.0,
        backgroundColor: AppColors.darkOcean,
        title: const Text(
          "FoodBoard Admin",
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: MyDrawer(
        selectedIndex: navIndex,
        setIndex: (int index) {
          setState(() {
            navIndex = index;
          });
        },
      ),
      body: Builder(
        builder: (context) {
          switch (navIndex) {
            case 0:
              return const Center(child: Text('HomePage'));
            case 1:
              return AddRecipeForm();
            case 2:
              return const Center(child: Text('None'));
            case 3:
              return const Center(child: Text('None'));
            case 4:
              return const Admin_Register();

            default:
              return Container();
          }
        },
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Ingredients List"),
      ),
    );
  }
}
