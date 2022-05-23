import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/myaudio.dart';
import '../utils/app_colors.dart';

class PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
        builder: (_, myAudioModel, child) => Container(
              padding: const EdgeInsets.only(right: 20),
              child: MyAudio.noConnection == true
                  ? Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        MyAudio.audioState != "Playing"
                            ? const Text(
                                "No Internet Connectivity Please Comeback later")
                            : Column(
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                    const Text(
                                        "No Internet Connectivity Please Comeback later"),
                                    const Stop(
                                      icon: Icons.stop,
                                    ),
                                  ]),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyAudio.audioState != "Playing"
                            ? const Repeat(
                                icon: Icons.repeat,
                              )
                            : audioLoop(myAudioModel.newDuration),
                        // Container(
                        //     color: Colors.yellow,
                        //     height: 20,
                        //     width: 20,
                        //     child: Text("${myAudioModel.newDuration}")),
                        // Controls(icon: Icons.skip_previous,),
                        const PlayControls(),
                        const Stop(
                          icon: Icons.stop,
                        ),
                        // Controls(icon:Icons.add),
                      ],
                    ),
            ));
  }

  Widget audioLoop(int data) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: AppColors.appColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryColors.withOpacity(0.5),
                offset: const Offset(5, 10),
                spreadRadius: 3,
                blurRadius: 10),
            const BoxShadow(
                color: Colors.white,
                offset: const Offset(-2, -3),
                spreadRadius: -2,
                blurRadius: 20),
          ]),
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.primaryColors.withOpacity(0.5),
                        offset: const Offset(5, 10),
                        spreadRadius: 3,
                        blurRadius: 10),
                    const BoxShadow(
                        color: Colors.white,
                        offset: const Offset(-2, -3),
                        spreadRadius: -2,
                        blurRadius: 20),
                  ]),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: AppColors.appColor, shape: BoxShape.circle),
              child: Center(
                child: Text("$data"),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PlayControls extends StatelessWidget {
  const PlayControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
        builder: (_, myAudioModel, child) => GestureDetector(
              onTap: () {
                MyAudio.audioState == "Playing"
                    ? myAudioModel.pauseAudio()
                    : myAudioModel.playAudio();
              },
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primaryColors.withOpacity(0.5),
                          offset: const Offset(5, 10),
                          spreadRadius: 3,
                          blurRadius: 10),
                      const BoxShadow(
                          color: Colors.white,
                          offset: const Offset(-2, -3),
                          spreadRadius: -2,
                          blurRadius: 20),
                    ]),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 105, 138, 102),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors.primaryColors.withOpacity(0.5),
                                  offset: const Offset(5, 10),
                                  spreadRadius: 3,
                                  blurRadius: 10),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-2, -3),
                                  spreadRadius: -2,
                                  blurRadius: 20),
                            ]),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            color: AppColors.appColor, shape: BoxShape.circle),
                        child: Center(
                            child: Icon(
                          MyAudio.audioState == "Playing"
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 50,
                          color: const Color.fromARGB(255, 105, 138, 102),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

class Repeat extends StatefulWidget {
  final IconData? icon;

  const Repeat({Key? key, this.icon}) : super(key: key);

  @override
  State<Repeat> createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  int repeatCount = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
        builder: (_, myAudioModel, child) => GestureDetector(
              onTap: () {
                // myAudioModel.repeatAudio(repeatCount);
              },
              child: Container(
                height: 50,
                // width: 100,
                decoration: BoxDecoration(
                    color: AppColors.borderColor,
                    // shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primaryColors.withOpacity(0.5),
                          offset: const Offset(5, 10),
                          spreadRadius: 3,
                          blurRadius: 10),
                      const BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, -3),
                          spreadRadius: -2,
                          blurRadius: 20),
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                            // shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppColors.primaryColors.withOpacity(0.5),
                                  offset: const Offset(5, 10),
                                  spreadRadius: 3,
                                  blurRadius: 10),
                              const BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(-2, -3),
                                  spreadRadius: -2,
                                  blurRadius: 20),
                            ]),
                      ),
                    ),
                    Center(
                      child: Container(
                        margin: const EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(20)
                            // shape: BoxShape.circle
                            ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (repeatCount > 0) {
                                    setState(() {
                                      repeatCount--;
                                    });
                                  }
                                  myAudioModel.updateCounter(repeatCount);
                                },
                                child: const Icon(
                                  Icons.arrow_drop_down,
                                  size: 35,
                                  color:
                                      const Color.fromARGB(255, 105, 138, 102),
                                ),
                              ),
                              Text(repeatCount.toString()),
                              Consumer<MyAudio>(
                                  builder: (_, myAudioModel, child) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            repeatCount = repeatCount + 1;
                                            print(repeatCount);
                                          });
                                          myAudioModel
                                              .updateCounter(repeatCount);
                                          //             Provider.of<MyAudio>(context).repeatAudio(
                                          // MyAudio.totalDuration, data.docs[0]['dt_file']);
                                        },
                                        child: const Icon(
                                          Icons.arrow_drop_up,
                                          size: 35,
                                          color: Color.fromARGB(
                                              255, 105, 138, 102),
                                        ),
                                      ))
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

class Stop extends StatelessWidget {
  final IconData? icon;

  const Stop({Key? key, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<MyAudio>(
      builder: (_, myAudioModel, child) => GestureDetector(
        onTap: () {
          myAudioModel.stopAudio();
          MyAudio.position = null;
          myAudioModel.newDuration = 0;
          MyAudio.audioState != "Playing";
        },
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              color: AppColors.appColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: AppColors.primaryColors.withOpacity(0.5),
                    offset: const Offset(5, 10),
                    spreadRadius: 3,
                    blurRadius: 10),
                const BoxShadow(
                    color: Colors.white,
                    offset: const Offset(-2, -3),
                    spreadRadius: -2,
                    blurRadius: 20),
              ]),
          child: Stack(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.primaryColors.withOpacity(0.5),
                            offset: const Offset(5, 10),
                            spreadRadius: 3,
                            blurRadius: 10),
                        const BoxShadow(
                            color: Colors.white,
                            offset: const Offset(-2, -3),
                            spreadRadius: -2,
                            blurRadius: 20),
                      ]),
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                      color: AppColors.appColor, shape: BoxShape.circle),
                  child: Center(
                      child: Icon(
                    icon,
                    size: 25,
                    color: const Color.fromARGB(255, 105, 138, 102),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}