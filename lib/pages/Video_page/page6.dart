import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

import '../../utils/app_colors.dart';

class Page6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FlutterStatusbarcolor.setStatusBarColor(AppColors.lightBlueShadow);
    return Scaffold(
      appBar: AppBar(
        title: Text('MEDIA PLAYER',
            style: TextStyle(color: Color(0XFF6f7e96),//stylecolor
            )
        ),
        backgroundColor: Color(0XFFe5eefc),//maincolor
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.appColor,

        child: ListView(
          children: [

            Column(
              children: <Widget>[
                ChewieListItem(
                  videoPlayerController: VideoPlayerController.asset('assets/Video/Captain_Jack.mp4',
                  ),

                  looping: true,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  ChewieListItem({
    required this.videoPlayerController,
    required this.looping,
   // Key key,
  });

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  late ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
