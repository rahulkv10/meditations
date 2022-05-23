import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meditation/pages/subCategories.dart';
import 'package:meditation/utils/app_colors.dart';
import 'package:meditation/utils/connectivity.dart';
import 'package:meditation/utils/routes.dart';
import 'package:meditation/widgets/noConnection.dart';
import 'package:provider/provider.dart';

import '../provider/myaudio.dart';
import '../widgets/playerControls.dart';

class MeditationDetails extends StatefulWidget {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? id;
  // ignore: use_key_in_widget_constructors
  const MeditationDetails(
      {required this.title,
      required this.description,
      required this.thumbnail,
      this.id});

  @override
  State<MeditationDetails> createState() => _MeditationDetailsState();
}

class _MeditationDetailsState extends State<MeditationDetails> {
  double sliderValue = 2;
  bool noConnection = false;

  int numberOftimesToPlay = 0;
// playThreeTimes() async {
//   _audioPlayer = AudioPlayer();
//         int res = await _audioPlayer.play("");
//         //await _audioPlayer.play("http://192.168.1.5/00001.mp3");
//         if (res == 1 & numberOftimesToPlay>4) {
//           numberOftimesToPlay ++;
//           playThreeTimes();
//           print("ok");
//         } else {
//           print("done");
//         }}
// final Stream<QuerySnapshot> categories = FirebaseFirestore.instance.collection("tb_details").snapshots();
  Stream<QuerySnapshot>? dataList;
  @override
  void initState() {
    dataList = FirebaseFirestore.instance
        .collection('tb_details')
        .where('dt_id', isEqualTo: widget.id)
        .snapshots();

    super.initState();
    checkConnection();
  }

  checkConnection() async {
    var connection = await Connection.checkNetworkConnection();
    if (connection == null) {
      setState(() {
        noConnection = true;
      });
      return;
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // print('datalist===>$dataList[1]');
    // print(widget.id);
    // print(widget.description);

    showSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Internet not availble'),
      ));
    }

    return WillPopScope(
      onWillPop: () async {

        // Provider.of<MyAudio>(context, listen: false).removeUrl();
        // MyAudio.position = null;
            checkConnection();
        MyAudio.noConnection=false;
//         if(noConnection==true){
//          // print('nnnnnnnnnn');
//          //NoConnection();
//          Navigator.push(context, MaterialPageRoute(builder: (context){
//             return NoConnection();
//          }));
//          }
//          else {
//            //print('1111111111');
//  Navigator.pop(context);   
//          }
       Navigator.pop(context);
        return true;
      },
      child: 
      // noConnection == true
      //     ? NoConnection()
      //     : 
          Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.title.toString().toUpperCase(),
                  style: const TextStyle(fontSize: 14),
                ),
                centerTitle: true,
                backgroundColor: const Color.fromARGB(255, 105, 138, 102),
              //   leading: IconButton(icon: Icon(Icons.arrow_back),onPressed: (){
              //        Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) {
              //     return MeditationList(
              //       title: widget.title,
              //       description: widget.description,
              //       thumbnail: widget.thumbnail,
              //       id: widget.id,
              //     );
              //   }),
              // );
              //   }
              //     ),
              ),
              backgroundColor: AppColors.appColor,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //NavBar(title: widget.title!.toUpperCase()),
                  SizedBox(
                    height: height / 2.5,
                    child: Container(
                      height: 260,
                      width: 260,
                      margin:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          widget.thumbnail.toString(),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  'assets/images/placeholder.jpg',
                                  fit: BoxFit.contain,
                                ));
                          },
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: AppColors.borderColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: AppColors.primaryColors,
                                offset: const Offset(12, 5),
                                spreadRadius: 3,
                                blurRadius: 25),
                            const BoxShadow(
                                color: Color.fromARGB(255, 245, 247, 245),
                                offset: Offset(-2, -3),
                                spreadRadius: -2,
                                blurRadius: 20),
                          ]),
                    ),
                  ),
                 PlayerControls(),
                  const SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   widget.title.toString(),
                  //   style: TextStyle(
                  //       color: AppColors.primaryColors,
                  //       fontSize: 20,
                  //       fontWeight: FontWeight.bold),
                  // ),
                  SliderTheme(
                      data: const SliderThemeData(
                          trackHeight: 4,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 8)),
                      child: Consumer<MyAudio>(
                        builder: (_, muaudio, child) => Slider(
                          activeColor: const Color.fromARGB(255, 87, 117, 84),
                          inactiveColor:
                              AppColors.primaryColors.withOpacity(0.3),
                          value: MyAudio.position == null
                              ? 0
                              : MyAudio.position!.inMilliseconds.toDouble(),
                          onChanged: (val) {
                            muaudio.seekAudio(
                                Duration(milliseconds: val.toInt()));
                          },
                          min: 0,
                          max: MyAudio.totalDuration == null
                              ? 20
                              : MyAudio.totalDuration!.inMilliseconds
                                  .toDouble(),
                        ),
                      )),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Text(
                  //     widget.description.toString(),
                  //     style: TextStyle(
                  //         color: AppColors.primaryColors,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w400),
                  //   ),
                  // ),

                  const SizedBox(
                    height: 20,
                  ),

                  StreamBuilder<QuerySnapshot>(
                      stream: dataList,
                    // initialData: ,
                      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: Text('something went wrong'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final data = snapshot.requireData;
                        if (data.docs.isEmpty){
                            return Consumer<MyAudio>(
                            builder: (_, muaudio, child) {
                          return const Text('No song available');
                        });
                        }
                        Provider.of<MyAudio>(context)
                            .updateUrl(data.docs[0]['dt_file']);
                        // Provider.of<MyAudio>(context).autoPlay();
                        Provider.of<MyAudio>(context).repeatAudio(
                            MyAudio.totalDuration, data.docs[0]['dt_file']);
                        Provider.of<MyAudio>(context)
                            .updateUID(data.docs[0].id);
                            Provider.of<MyAudio>(context)
                            .checkConnection();
                        return Consumer<MyAudio>(
                            builder: (_, muaudio, child) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Text(data.docs[0]['dt_desc'],style: TextStyle(
                                color: AppColors.primaryColors,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),),
                              ),
                            ),
                          );
                        });
                       // Text(data.docs[0]['dt_file']));
                        //Text(data.docs[i]['dt_file'])) 
                      })

                  //SizedBox(height: 80,)
                ],
              ),
              floatingActionButton: FloatingActionButton(
                elevation: 10,
                onPressed: () {
                
              },
              child:const Icon(Icons.download),
              backgroundColor: const Color.fromARGB(255, 105, 138, 102),
              
              ),
            ),
    );
  }
}
