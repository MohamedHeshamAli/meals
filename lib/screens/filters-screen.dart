import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "filters";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegan = false;
  bool _vegetarian = false;
  bool _lactoseFree = false;
  Widget _buildSwitchListTile(
      bool currentValue, String title, String subtitle, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
            ),
          ],
          title: Text("Your Filters"),
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildSwitchListTile(_glutenFree, "gluten-Free",
                      "only include gluten free meals.", (val) {
                    setState(() {
                      _glutenFree = val;
                    });
                  }),
                  _buildSwitchListTile(_lactoseFree, "lactose-Free",
                      "only include lactose free meals.", (val) {
                    setState(() {
                      _lactoseFree = val;
                    });
                  }),
                  _buildSwitchListTile(
                      _vegan, "vegan", "only include vegan meals.", (val) {
                    setState(() {
                      _vegan = val;
                    });
                  }),
                  _buildSwitchListTile(_vegetarian, "vegetarian",
                      "only include vegetarian meals.", (val) {
                    setState(() {
                      _vegetarian = val;
                    });
                  }),
                ],
              ),
            )
          ],
        ));
  }
}
