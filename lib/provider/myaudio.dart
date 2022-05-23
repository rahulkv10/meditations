import 'dart:async';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../utils/connectivity.dart';

class MyAudio extends ChangeNotifier {
  static Duration? totalDuration;
  static Duration? position;
  static String? audioState;
  static String? url;
  String? id;
  static int? timesToRepeat;
  static bool noConnection = false;
  // MyAudio(){
  //   initAudio();
  // }
  MyAudio() {
    initAudio();
  }
  AudioPlayer audioPlayer = AudioPlayer();

  initAudio() {
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.STOPPED) audioState = "Stopped";
      if (playerState == PlayerState.PLAYING) audioState = "Playing";
      if (playerState == PlayerState.PAUSED) audioState = "Paused";
      notifyListeners();
    });
  }

  updateUrl(String urldata) {
    url = urldata;
    //  notifyListeners();
  }

  updateUID(String data) async {
    if (id == null) {
      id = data;
    } else {
      if (id == data) {
        noConnection = false;
        print('same song playing');
      } else {
        await audioPlayer.stop();
        MyAudio.position = null;
        newDuration = 0;
        // isPlayed = false;
        id = data;
      }
    }
    // notifyListeners();
  }

  // bool isPlayed = false;
  // autoPlay() async {
  //   if (isPlayed) {
  //     return;
  //   }
  //   await audioPlayer.play(url!);
  //   isPlayed = true;
  // }
  removeUrl() async {
    await audioPlayer.stop();
    url = null;
    notifyListeners();
  }

  playAudio() {
    log("tim,errrr ${timer?.tick}");
    audioPlayer.play(url!);
    notifyListeners();
  }

  pauseAudio() {
    audioPlayer.pause();
    //  audioPlayer.setLoopMode(...);
    notifyListeners();
  }

  stopAudio() {
    audioPlayer.stop();
    notifyListeners();
  }

  seekAudio(Duration durationToSeek) {
    audioPlayer.seek(durationToSeek);
  }

  repeatAudio1(int count) {
    audioPlayer.onPlayerCompletion.listen((event) {
      // totalDuration = updatedDuration;
      for (int i = 0; i < count; i++) {
        playAudio();
      }
      //stopAudio();
      //notifyListeners();
    });
  }

  int newDuration = 0;
  updateCounter(int count) {
    newDuration = count;
    // notifyListeners();
    print(" 11111111 timesToRepeat $newDuration");
  }

  // int timesPlayed = 0;
  // Duration newDuration = const Duration(minutes: 0);

  bool isTimerStop = false;
  Timer? timer;
  repeatAudio(Duration? duration, urls) {
    print('kkkkkkkkk $newDuration');
    if (newDuration != 0) {
      timer ??= Timer(Duration(minutes: newDuration), () async {
        await audioPlayer.stop();
        // newDuration = 0;
        isTimerStop = true;
        timer = null;
      });
    }

    audioPlayer.onPlayerCompletion.listen((event) async {
      if (timer == null) {
        await audioPlayer.stop();
        return;
      }
      if (isTimerStop) {
      } else {
        await audioPlayer.play(urls);
      }
    });

    // audioPlayer.onPlayerCompletion.listen((event) async {
    // position = duration;
    // timesPlayed++;

    // if (timesPlayed >= timesToRepeat!) {
    //   timesPlayed = 0;
    //   await audioPlayer.stop();
    // } else {
    //   await audioPlayer.play(urls);
    // }
    // });
    //notifyListeners();
  }

  checkConnection() async {
    var connection = await Connection.checkNetworkConnection();
    if (connection == null) {
      noConnection = true;

      return;
    } else {}
  }
}
