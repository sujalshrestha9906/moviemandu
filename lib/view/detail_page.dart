import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:moviemandu/providers/video_provider.dart';
import 'package:pod_player/pod_player.dart';

import '../model/movie.dart';

class DetailPage extends ConsumerWidget {
  final Movie movie;
  DetailPage(this.movie);

  @override
  Widget build(BuildContext context, ref) {
    final videoData = ref.watch(videoProvider(movie.id));
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              // height: 300,
              child: videoData.when(
                  data: (data) {
                    return data.isEmpty ? Text('No Movie') : VideoPlay(data[0]);
                  },
                  error: ((err, stack) => Text('$err')),
                  loading: () => Container()),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: 0.3,
                        child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (c, s) => Center(
                                    child: SpinKitSpinningLines(
                                  color: Colors.pinkAccent,
                                )),
                            imageUrl:
                                'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.poster_path}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment,
                          children: [
                            Text(movie.title,
                                style: TextStyle(
                                  fontSize: 28,
                                )),
                            // Text(movie.vote_average),
                            SizedBox(height: 15),
                            Text(
                              'Released Date : ${movie.release_date}',
                              style: TextStyle(fontSize: 15),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              movie.overview,
                              style: TextStyle(
                                fontSize: 20,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class VideoPlay extends StatefulWidget {
  final String keys;
  VideoPlay(this.keys);

  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  late final PodPlayerController controller;

  @override
  void initState() {
    controller = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube('https://youtu.be/${widget.keys}'),
        podPlayerConfig: const PodPlayerConfig(
            autoPlay: true,
            isLooping: false,
            videoQualityPriority: [1080, 720, 480, 360]))
      ..initialise();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(controller: controller);
  }
}
