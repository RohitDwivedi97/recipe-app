import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-details';
  final Function _toggleFavourite;
  final Function _isFavourite;

  MealDetailScreen(this._toggleFavourite, this._isFavourite);

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
        height: 180,
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(15),
        ),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('$selectedMeal.title'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              padding: const EdgeInsets.all(6),
              child: Image.network(
                selectedMeal.imageUrl,
                height: 200,
                width: double.infinity,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        child: Text('${selectedMeal.ingredients[index]}'),
                        padding: const EdgeInsets.all(8.0),
                      ),
                    );
                  },
                  itemCount: selectedMeal.ingredients.length),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Column(
                      children: [
                        ListTile(
                            leading: CircleAvatar(
                              child: Text('#${index + 1}'),
                            ),
                            title: Text(selectedMeal.steps[index])),
                        const Divider(
                          thickness: 2,
                        )
                      ],
                    );
                  },
                  itemCount: selectedMeal.steps.length),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          _isFavourite(mealId) ? Icons.star : Icons.star_border 
        ),
        onPressed: () => _toggleFavourite(mealId),
      ),
    );
  }
}
