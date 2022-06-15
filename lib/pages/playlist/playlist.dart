import 'package:Music_player/db_functions/data_model.dart';
import 'package:Music_player/db_functions/databaseplaylist.dart';
import 'package:Music_player/pages/playlist/playlist_showsongs.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PlayList extends StatelessWidget {
  PlayList({Key? key, this.addplaylist}) : super(key: key);
  final namecontroller = TextEditingController();
  String? name;
  int? addplaylist;
  @override
  Widget build(BuildContext context) {
    PlaylistFunctions.getplayList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text('Playlist')),
      ),
      backgroundColor: Colors.black,
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/aass.webp',
                ),
                fit: BoxFit.cover),
          ),
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ValueListenableBuilder(
                    valueListenable: PlaylistFunctions.playlistsong,
                    builder: (BuildContext ctx, List<dynamic> playlist,
                        Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              mainAxisExtent: 140,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                            ),
                            itemCount: playlist.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (ctx) => PlaylistFolder(
                                                  newindex: index,
                                                )));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              'Delete Folder ${PlaylistFunctions.playlistsong.value[index].name} ',
                                              style: const TextStyle(
                                                  color: Colors.black),
                                            ),
                                            actions: [
                                              IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel_outlined,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0),
                                                  )),
                                              IconButton(
                                                  onPressed: () {
                                                    PlaylistFunctions
                                                        .deleteplaylist(index);
                                                    Navigator.pop(context);
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Color.fromARGB(
                                                        255, 255, 17, 0),
                                                  )),
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Color.fromARGB(255, 54, 216, 234),
                                            ]),
                                      ),
                                      child: Center(
                                          child: Text(
                                        playlist[index].name.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18),
                                      ))));
                            }),
                      );
                    }),
              )
            ],
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(14.0),
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    backgroundColor: Colors.black87,
                    content: TextField(
                      controller: namecontroller,
                      decoration: InputDecoration(
                        hintText: 'Create Folder',
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 120),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel')),
                          ),
                          TextButton(
                              onPressed: () {
                                if (namecontroller.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                      'Enter Folder Name',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    behavior: SnackBarBehavior.fixed,
                                    backgroundColor:
                                        Color.fromARGB(255, 255, 17, 0),
                                  ));
                                  Navigator.pop(context);
                                }
                                if (namecontroller.text.isNotEmpty) {
                                  final name = namecontroller.text;
                                  final model = Playlistmodels(
                                      name: name, songlistdb: []);
                                  PlaylistFunctions.addplaylist(model: model);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Create')),
                        ],
                      )
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
}
