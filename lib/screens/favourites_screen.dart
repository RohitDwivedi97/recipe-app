import 'package:flutter/widgets.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouritedMeals;

  FavouritesScreen(this.favouritedMeals);

  @override
  Widget build(BuildContext context) {
    if(favouritedMeals.isEmpty) {
      return Center(
        child: Text("You don't have favourites yet."),
      );
    }
    return ListView.builder(
            itemBuilder: (ctx, i) {
              final meal = favouritedMeals[i];
              return MealItem(
                id: meal.id,
                title: meal.title,
                imageUrl: meal.imageUrl,
                duration: meal.duration,
                complexity: meal.complexity,
                affordability: meal.affordability,
              );
            },
            itemCount: favouritedMeals.length);
      
  } 
}