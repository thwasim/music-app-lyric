import 'package:Music_player/pages/home/screenplay.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:Music_player/pages/home/homepage.dart';

ValueNotifier<List<SongModel>> temp = ValueNotifier([]);

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final searchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
            backgroundColor: Colors.black,
            shadowColor: Colors.white,
            elevation: 15,
            title: Center(
              child: Container(
                height: 60,
                child: Center(
                    child: TextField(
                  onChanged: (String? value) {
                    if (value == null || value.isEmpty) {
                      temp.value.addAll(MyHomePage.songs);
                      temp.notifyListeners();
                    } else {
                      temp.value.clear();
                      for (SongModel a in MyHomePage.songs) {
                        if (a.title.toLowerCase()
                            .contains(value.toLowerCase())) {
                          temp.value.add(a);
                        }
                        temp.notifyListeners();
                      }
                    }
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search Songs",
                      hintStyle: TextStyle(color: Colors.black)),
                )),
              ),
            )),
      ),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/aass.webp',
                  ),
                  fit: BoxFit.cover),
            ),
            
            child: Container(
              
              child: ValueListenableBuilder(
                  valueListenable: temp,
                  builder: (BuildContext ctx, List<SongModel> searchdata,
                      Widget? child) {
                    return ListView.separated(
                      itemBuilder: (ctx, index) {
                        final data = searchdata[index];
                        return Container(
                          margin: EdgeInsets.only(left: 12, right: 16, top: 29),
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
                            leading: QueryArtworkWidget(
                                id: searchdata[index].id,
                                type: ArtworkType.AUDIO),
                            title: Text(data.title),
                            onTap: () async {
                              await MyHomePage.player.setAudioSource(
                                  createPlaylist(searchdata),
                                  initialIndex: index);
                              await MyHomePage.player.play();
                              Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => Screenplay(songlist: MyHomePage.songs,)));
                            },
                          ),
                        );
                      },
                      separatorBuilder: (ctx, index) {
                        return Divider();
                      },
                      itemCount: searchdata.length,
                    );
                  }),
            )),
      ),
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(song.uri!),
          tag: MediaItem(
        id: song.id.toString(), 
        title: song.title
        )
      ));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}