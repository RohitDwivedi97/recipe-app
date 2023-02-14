import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favouritedMeals;

  TabsScreen(this.favouritedMeals);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages = [];
  int _selectedPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      {'page': const CategoriesScreen(), 'title': 'Meals'},
      {'page': FavouritesScreen(widget.favouritedMeals), 'title': 'Favourites'}
    ];
  }

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title'] as String),
      ),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Colors.amber,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 16,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
