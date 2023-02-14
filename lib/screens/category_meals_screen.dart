import 'package:flutter/material.dart';
import 'package:recipe_app/dummy_data.dart';
import '../dummy_data.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  List<Meal> selectedMeals;

  CategoryMealsScreen(this.selectedMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'].toString();
    final categoryId = routeArgs['id'];

    final categoryMeals =
        widget.selectedMeals.where((meal) => meal.categories.contains(categoryId)).toList();
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
            itemBuilder: (ctx, i) {
              final meal = categoryMeals[i];
              return MealItem(
                id: meal.id,
                title: meal.title,
                imageUrl: meal.imageUrl,
                duration: meal.duration,
                complexity: meal.complexity,
                affordability: meal.affordability,
              );
            },
            itemCount: categoryMeals.length));
  }
}
