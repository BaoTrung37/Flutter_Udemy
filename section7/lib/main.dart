import 'package:flutter/material.dart';
import 'screens/filters_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart' show CategoryMealsScreen;
import 'screens/meal_detail_screen.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/', // default is '/'
      routes: {
        '/': (ctx) => const TabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(),
        MealDetaiScreen.routeName: (ctx) => MealDetaiScreen(),
        FiltersScreen.routerName: (ctx) => FiltersScreen(),
      },
      // tạo ra đường dẫn đến trang khi không tồn tại route chỉ định
      // onGenerateRoute: (settings) {
      // print(settings.arguments);
      // if(settings.name == '/meal-detail'){
      //   return ...;
      // }
      // else if() {

      // }
      // return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      // },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => const CategoriesScreen());
      },
    );
  }
}
