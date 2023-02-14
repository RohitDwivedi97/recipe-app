import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters-screen';

  final Function saveFilters;
   Map<String,bool> filters; 
  FiltersScreen(this.saveFilters, this.filters);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool? _glutenFree = false;
  bool? _lactoseFree = false;
  bool? _isVegan = false;
  bool? _isVegetarian = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _glutenFree = widget.filters['gluten'] ;
      _lactoseFree = widget.filters['lactose'] ;
      _isVegan = widget.filters['vegan'];
      _isVegetarian = widget.filters['vegetarian'];
    });
  }

  Widget buildSwitchListTile(
      String title, String description, bool? value, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: value as bool,
      onChanged: (changedValue) => updateValue(changedValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: <Widget> [
          IconButton(icon: const Icon(Icons.save),onPressed: () {
            var filterData = {
              'gluten': _glutenFree as bool,
              'lactose': _lactoseFree as bool,
              'vegan': _isVegan as bool,
              'vegetarian': _isVegetarian as bool
            };
            widget.saveFilters(filterData);
          },),
        ]
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            child: const Center(
              child: Text(
                'Adjust your meal selection.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
          buildSwitchListTile(
              'Gluten-free', 'Only include gluten free meals', _glutenFree as bool,
              (value) {
            setState(() {
              _glutenFree = value;
            });
          }),
          buildSwitchListTile(
              'Lactose-free', 'Only include lactose free meals', _lactoseFree as bool,
              (value) {
            setState(() {
              _lactoseFree = value;
            });
          }),
          buildSwitchListTile(
              'Vegetarian', 'Only include vegetarian meals', _isVegetarian as bool,
              (value) {
            setState(() {
              _isVegetarian = value;
            });
          }),
          buildSwitchListTile(
              'Vegan', 'Only include vegan meals', _isVegan as bool,
              (value) {
            setState(() {
              _isVegan = value;
            });
          }),
        ],
      ),
    );
  }
}
