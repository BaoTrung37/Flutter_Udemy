import 'package:flutter/material.dart';

class MealDetaiScreen extends StatelessWidget {
  static const routeName = '/meal-detail';
  const MealDetaiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(mealId),
      ),
      body: Center(
        child: Text('The meal - $mealId!'),
      ),
    );
  }
}
