import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation/dummyData/categoriesData.dart';
import 'package:meditation/utils/app_colors.dart';
import 'package:meditation/utils/app_image.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/myaudio.dart';
import '../../utils/connectivity.dart';
import '../../widgets/category_card.dart';
import '../../widgets/noConnection.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool noConnection = false;
  final Stream<QuerySnapshot> categories =
      FirebaseFirestore.instance.collection("tb_category").snapshots();
  Future<void> startFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    var connection = await Connection.checkNetworkConnection();
    if (connection == null) {
      setState(() {
        noConnection = true;
      });
      return;
    } else {}
  }

  void gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token2", "1");
  }

  @override
  void initState() {
    super.initState();
    startFirebase();
    gettoken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<MyAudio>(context, listen: false).stopAudio();
        MyAudio.position = null;

        return true;
      },
      child: noConnection == true
          ? NoConnection(
              noBack: true,
            )
          : Scaffold(
              appBar: AppBar(
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  title: const Text(
                    'Yellow',
                    style: TextStyle(fontSize: 16),
                  ),
                  centerTitle: true,
                  backgroundColor: AppColors.appbarcolor),
              backgroundColor: AppColors.appColor,
              body: Stack(
                children: <Widget>[
                  Container(
                    height: size.height * .40,
                    decoration: BoxDecoration(
                      color: AppColors.appColor,
                      image: DecorationImage(
                        alignment: Alignment.centerLeft,
                        image: AssetImage(AppImages.meditation),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              alignment: Alignment.center,
                              height: 52,
                              width: 52,
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Text(
                            "Meditation",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColors),
                          ),
                          Container(
                            margin:const  EdgeInsets.only(top: 30),
                            child: Text(
                              "Find a suitable music for yourself to stay\nfocused more easily",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColors),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.15,
                          ),
                          Text(
                            "Categories",
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColors),
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                                stream: categories,
                                builder: (ctx,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('something went wrong1'));
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  final data = snapshot.requireData;
                                  //  dynamic data1= jsonEncode(data);
                                  //print('.....................$data');
                                  return GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 200,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20),
                                      itemCount: data.size,
                                      itemBuilder: (ctx, i) {
                                        return CategoryCard(
                                          title: data.docs[i]['cat_name'],
                                          svgSrc: data.docs[i]['cat_image'],
                                          id: data.docs[i]['cat_id']
                                              .toString(),
                                          des: categoryDummy[i]
                                              .description
                                              .toString(),
                                          press: () {},
                                        );
                                      });
                                }),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
