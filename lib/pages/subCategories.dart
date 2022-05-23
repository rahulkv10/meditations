import 'package:flutter/material.dart';
import 'package:meditation/pages/meditationDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meditation/pages/meditationDetailsVideo.dart';
import 'package:meditation/provider/myaudio.dart';
import '../utils/app_colors.dart';
import '../utils/connectivity.dart';
import '../widgets/noConnection.dart';

class MeditationList extends StatefulWidget {
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? id;

  // ignore: use_key_in_widget_constructors
  const MeditationList({this.title, this.description, this.thumbnail, this.id});

  @override
  State<MeditationList> createState() => _MeditationListState();
}

class _MeditationListState extends State<MeditationList> {
  bool noConnection = false;
  Stream<QuerySnapshot>? dataList;
  @override
  void initState() {
    dataList = FirebaseFirestore.instance
        .collection('tb_sub_cat')
        .where('sb_cat_id', isEqualTo: widget.id)
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
    // print(widget.description);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return noConnection == true
        ? NoConnection()
        : Scaffold(
            backgroundColor: AppColors.appColor,
            appBar: AppBar(
              title: Text(
                widget.title.toString().toUpperCase(),
                style: const TextStyle(fontSize: 14),
              ),
              centerTitle: true,
              backgroundColor: AppColors.appbarcolor,
              // leading: IconButton(onPressed: (){
              //   MyAudio.noConnection=false;
              // }, icon: Icon(Icons.arrow_back))
            ),
            // backgroundColor: Color.fromARGB(255, 176, 211, 173),
            body: Stack(
              children: [
                SizedBox(
                  height: height,
                  width: width,
                  // child: Image.asset(AppImages.background1,fit: BoxFit.cover,)
                ),
                const SizedBox(
                  height: 20,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: dataList,
                        builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('something went wrong1'));
                          }
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.green,
                            ));
                          }
                          var data = snapshot.requireData;
                          return ListView.builder(
                              itemCount: data.size,
                              itemBuilder: (ctxx, i) {
                                return InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 105, 138, 102)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      child: ListTile(
                                        leading: Stack(
                                          children: [
                                            Positioned(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  // color: const Color.fromARGB(
                                                  //     255, 92, 145, 116),
                                                  // image: DecorationImage(
                                                  //     fit: BoxFit.cover,
                                                  //     colorFilter:

                                                  //         ColorFilter.mode(
                                                  //             Colors.black
                                                  //                 .withOpacity(
                                                  //                     0.5),
                                                  //             BlendMode
                                                  //                 .srcOver),
                                                  //     // image: NetworkImage(

                                                  //     //   data.docs[i]
                                                  //     //        ['sb_cat_image'],

                                                  //     // ),
                                                  //     ),
                                                ),
                                                // padding:
                                                // const EdgeInsets.all(5),
                                                height: 80,
                                                width: 60,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    data.docs[i]
                                                        ['sb_cat_image'],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Image.asset(
                                                          'assets/images/placeholder.jpg',
                                                          fit: BoxFit.contain,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            data.docs[i]['sb_cat_file_type'] ==
                                                    'video'
                                                ? Positioned(
                                                    left: 10,
                                                    top: 5,
                                                    child: Icon(
                                                        Icons.play_arrow,
                                                        size: 40,
                                                        color: Colors.black
                                                        //.withOpacity(0.8),
                                                        ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                        title: Text(
                                          data.docs[i]['sb_cat_name'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 12, 71, 39)),
                                        ),
                                        subtitle: Text(
                                          data.docs[i]['sb_cat_desc'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                          ),
                                          maxLines: 2,
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return data.docs[i]
                                                      ['sb_cat_file_type'] ==
                                                  'video'
                                              ? VideoDetailPage(
                                                  title: data.docs[i]
                                                      ['sb_cat_name'],
                                                  description: data.docs[i]
                                                      ['sb_cat_desc'],
                                                  thumbnail: data.docs[i]
                                                      ['sb_cat_image'],
                                                  id: data.docs[i]['sb_cat_sid']
                                                      .toString())
                                              : MeditationDetails(
                                                  title: data.docs[i]
                                                      ['sb_cat_name'],
                                                  description: data.docs[i]
                                                      ['sb_cat_desc'],
                                                  thumbnail: data.docs[i]
                                                      ['sb_cat_image'],
                                                  id: data.docs[i]['sb_cat_sid']
                                                      .toString());
                                        }),
                                      );
                                    });
                              });

                          //  ListView.builder(
                          //    itemCount: data.size,
                          //    itemBuilder: (ctxx,i){
                          //      return Column(
                          //        children: [
                          //          Text(data.docs[i]['sb_cat_name']),
                          //          Text(data.docs[i]['sb_cat_desc'])
                          //        ],
                          //      );
                          //    });
                        })),
              ],
            ),
          );
  }
}
