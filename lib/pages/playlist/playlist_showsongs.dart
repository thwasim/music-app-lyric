import 'package:Music_player/db_functions/databaseplaylist.dart';
import 'package:Music_player/pages/home/homepage.dart';
import 'package:Music_player/pages/home/screenplay.dart';
import 'package:Music_player/pages/playlist/playlist_show.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';

// ignore: must_be_immutable
class PlaylistFolder extends StatefulWidget {
  PlaylistFolder({
    Key? key,
    this.newindex,
  }) : super(key: key);

  int? newindex;
  @override
  State<PlaylistFolder> createState() => _PlaylistFolderState();
}

class _PlaylistFolderState extends State<PlaylistFolder> {
  @override
  Widget build(BuildContext context) {
    playlistsongCheck.showselectsong(widget.newindex);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Center(
            child: Text(
          PlaylistFunctions.playlistsong.value[widget.newindex!].name
              .toString()
              .toUpperCase(),
          style: const TextStyle(
              color: Color.fromARGB(255, 245, 242, 242),
              fontWeight: FontWeight.bold),
        )),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                  return Screen_playlist(modelindex: widget.newindex!);
                })).whenComplete(() {
                  setState(() {});
                });
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.add_box_outlined,
                  color: Color.fromARGB(255, 255, 17, 0),
                ),
              ))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/Motivational Wallpaper.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: [
            PlaylistFunctions
                    .playlistsong.value[widget.newindex!].songlistdb.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Center(
                        child: Text(
                          'NO SONGS',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: ValueListenableBuilder(
                        valueListenable: PlaylistFunctions.playlistsong,
                        builder: (BuildContext ctx, List<dynamic> selectedsongs,
                            Widget? child) {
                          return ListView.builder(
                              itemCount: PlaylistFunctions.playlistsong
                                  .value[widget.newindex!].songlistdb.length,
                              itemBuilder: (ctx, index) {
                                return Container(
                                    child: Container(
                                  margin: EdgeInsets.only(
                                      bottom: 30, left: 12, right: 16),
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      MyHomePage.player.setAudioSource(
                                        createPlaylist(playlistsongCheck
                                            .playlistmodel.value),
                                        initialIndex: index,
                                      );
                                      MyHomePage.player.play();
                                      Get.to(()=>Screenplay(
                                          songlist: playlistsongCheck
                                              .playlistmodel.value,
                                        ),);
                                    },
                                    leading: CircleAvatar(
                                      child: QueryArtworkWidget(
                                        id: MyHomePage
                                            .songs[playlistsongCheck
                                                .selectplaysong.value[index]]
                                            .id,
                                        type: ArtworkType.AUDIO,
                                        artworkBorder: BorderRadius.circular(0),
                                      ),
                                    ),
                                    title: Text(
                                      MyHomePage
                                          .songs[playlistsongCheck
                                              .selectplaysong.value[index]]
                                          .title,
                                      style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: Color.fromARGB(255, 255, 255, 255)),
                                    ),
                                  ),
                                ));
                              });
                        }),
                  ),
          ],
        ),
      ),
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!),
          tag: MediaItem(id: song.id.toString(), title: song.title)));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}
