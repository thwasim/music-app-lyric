import 'package:Music_player/db_functions/databasefavourite.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FavFunction extends StatefulWidget {
  FavFunction({Key? key, this.index}) : super(key: key);
  dynamic index;

  @override
  State<FavFunction> createState() => _FavFunctionState();
}

class _FavFunctionState extends State<FavFunction> {
  @override
  Widget build(BuildContext context) {
    final finalIndex = dbfunctions.favsongids
        .indexWhere((element) => element == MyHomePage.songs[widget.index!].id);
    final indexCheck = dbfunctions.favouritesongs.value.contains(widget.index);
    if (indexCheck == true) {
      return IconButton(
          onPressed: () async {
            await dbfunctions.deletefav(finalIndex);
            dbfunctions.getAllsongs;
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Color.fromARGB(255, 94, 90, 90),
              duration: Duration(milliseconds: 190),
              content: Text('Removed from Liked Songs'),
              margin: EdgeInsets.all(20),
              behavior: SnackBarBehavior.floating,
            ));
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 30,
          ));
    }
    return IconButton(
      onPressed: () async {
        await dbfunctions.addsong(MyHomePage.songs[widget.index!].id);
        await dbfunctions.getAllsongs();
        setState(() {});
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(milliseconds: 190),
          backgroundColor: Color.fromARGB(255, 94, 90, 90),
          content: Text(
            'added to Liked Songs',
            style: TextStyle(color: Colors.white),
          ),
          margin: EdgeInsets.all(20),
          behavior: SnackBarBehavior.floating,
        ));
      },
      icon: const Icon(
        Icons.favorite_border,
        color: Color.fromARGB(255, 236, 131, 131),
        size: 35,
      ),
    );
  }
}