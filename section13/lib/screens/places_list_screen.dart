import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:section13/providers/great_places.dart';

import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: Consumer<GreatPlaces>(
        child: Center(
          child: Text('Places yet, start adding some!'),
        ),
        builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
            ? ch!
            : ListView.builder(
                itemCount: greatPlaces.items.length,
                itemBuilder: (ctx, i) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(greatPlaces.items[i].image),
                  ),
                  title: Text(greatPlaces.items[i].title),
                  onTap: () {
                    // Todo go to detail place
                  },
                ),
              ),
      ),
    );
  }
}
