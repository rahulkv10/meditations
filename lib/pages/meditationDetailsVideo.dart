import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meditation/utils/app_colors.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../provider/myaudio.dart';
import '../widgets/playerControls.dart';

class VideoDetailPage extends StatefulWidget {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? id;
  VideoDetailPage({this.description, this.id, this.thumbnail, this.title});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  String videoUrl = "";
  String description = "";

  Stream<QuerySnapshot>? dataList;
  @override
  void initState() {
    super.initState();
    dataList = FirebaseFirestore.instance
        .collection('tb_details')
        .where('dt_id', isEqualTo: widget.id)
        .snapshots();
    dataList?.listen(getVideo);

    super.initState();
    //  checkConnection();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        title: Text(
          widget.title.toString().toUpperCase(),
          style: const TextStyle(fontSize: 14),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 105, 138, 102),
      ),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                _controller == null
                    ? Container()
                    : AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 8, right: 8, top: 8),
                          child: VideoPlayer(_controller!),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: VideoProgressIndicator(
                    _controller!,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                        backgroundColor: Colors.red,
                        // bufferedColor: Colors.black,
                        playedColor: Colors.blueAccent),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            fixedSize: MaterialStateProperty.all(Size(70, 70)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)))),
                        onPressed: () {
                          _controller!.seekTo(Duration(
                              seconds:
                                  _controller!.value.position.inSeconds - 5));
                        },
                        child: Icon(Icons.fast_rewind)),
                    const Padding(padding: EdgeInsets.all(6)),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            fixedSize: MaterialStateProperty.all(Size(70, 70)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)))),
                        onPressed: () {
                          _controller!.pause();
                        },
                        child: const Icon(Icons.pause)),
                    const Padding(padding: EdgeInsets.all(6)),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.redAccent),
                            fixedSize:
                                MaterialStateProperty.all<Size>(Size(80, 80)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)))),
                        onPressed: () {
                          _controller!.play();
                        },
                        child: Icon(Icons.play_arrow)),
                    const Padding(padding: EdgeInsets.all(6)),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            fixedSize: MaterialStateProperty.all(Size(70, 70)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)))),
                        onPressed: () {
                          _controller!.seekTo(Duration(
                              seconds:
                                  _controller!.value.position.inSeconds + 5));
                        },
                        child: Icon(Icons.fast_forward))
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: SingleChildScrollView(
                      child: Text(
                        description,
                        style: TextStyle(
                            color: AppColors.primaryColors,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return const Center(child: Text("No video Available"));
          }
        },
      ),
    );
  }

  void getVideo(QuerySnapshot<Object?> event) {
    description = event.docs.isNotEmpty ? event.docs[0]['dt_desc'] : "";
    if (videoUrl.isNotEmpty) {
      return;
    }
    String url = event.docs.isNotEmpty ? event.docs[0]['dt_file'] : "";
    if (url.isNotEmpty) {
      print("URL UR L URL  ${url}");
      _controller = VideoPlayerController.network(url);
      _initializeVideoPlayerFuture = _controller?.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    }
  }
}
