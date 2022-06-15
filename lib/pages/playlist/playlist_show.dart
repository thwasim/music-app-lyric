import 'package:Music_player/db_functions/databaseplaylist.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:Music_player/pages/playlist/playboutton.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class Screen_playlist extends StatefulWidget {
  Screen_playlist({Key? key, required this.modelindex}) : super(key: key);

  int modelindex;

  @override
  State<Screen_playlist> createState() => _Screen_playlistState();
}

class _Screen_playlistState extends State<Screen_playlist> {
  @override
  Widget build(BuildContext context) {
    playlistsongCheck.showselectsong(widget.modelindex);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Center(
              child: Text(
            'SELECT THE SONGS ',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/aass.webp'
                  ),
                  fit: BoxFit.cover)),
          child: ListView.builder(
              itemCount: MyHomePage.songs.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'assets/aass.webp',
                          ),
                          fit: BoxFit.cover)),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30, left: 12, right: 16),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Color.fromARGB(255, 54, 216, 234),
                          ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      title: Text(
                        MyHomePage.songs[index].title,
                        maxLines: 2,
                      ),
                      trailing: PlaylistButton(
                        index: index,
                        songindex: MyHomePage.songs[index].id,
                        folderindex: widget.modelindex,
                      ),
                      leading: QueryArtworkWidget(
                        id: MyHomePage.songs[index].id,
                        type: ArtworkType.AUDIO,
                      ),
                    ),
                  ),
                );
              }
            ),
          )
      );
  }
}