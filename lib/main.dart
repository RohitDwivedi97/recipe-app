import 'package:flutter/material.dart';
import 'package:recipe_app/screens/meal_detail_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> selectedMeals = DUMMY_MEALS;
  List<Meal> favouritedMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      filters = filterData;

      selectedMeals = DUMMY_MEALS.where((meal) {
        if (filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavourite(String mealId) {
    setState(() {
      var existingIndex =
          favouritedMeals.indexWhere((meal) => meal.id == mealId);
      if (existingIndex >= 0) {
        favouritedMeals.remove(favouritedMeals[existingIndex]);
      } else {
        favouritedMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      }
    });
  }

  bool _isFavourite(String id) {
    return favouritedMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          accentColor: Colors.amber,
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: const TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline1: const TextStyle(
                    fontSize: 24,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold),
              )),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(favouritedMeals),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(selectedMeals),
        MealDetailScreen.routeName: (context) => MealDetailScreen(_toggleFavourite, _isFavourite),
        FiltersScreen.routeName: (context) =>
            FiltersScreen(_setFilters, filters),
      },
    );
  }
}
