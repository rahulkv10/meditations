import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meditation/pages/home/homePage.dart';
import 'package:meditation/pages/splashScreen.dart';
import 'package:meditation/pages/subCategories.dart';
import 'package:meditation/pages/welcome/welcome_page.dart';
import 'package:meditation/provider/myaudio.dart';
import 'package:meditation/utils/routes.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
    ChangeNotifierProvider(create: (_)=>MyAudio(),
      // TestScreen(),
      child:
     MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:
      SplashScreen(),
      routes: {
        MyRoutes.welcome: (BuildContext context) => WelcomePage(),
        MyRoutes.homeRoute: (BuildContext context) => HomePage(),
        MyRoutes.subCategory: (BuildContext context) => MeditationList(),
      }
      )
    );
  }
}

class TestScreen extends StatelessWidget {
final Stream<QuerySnapshot> categories = FirebaseFirestore.instance.collection("tb_category").snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold
    (
      body: 
Container(child: 
      StreamBuilder<QuerySnapshot>(
        stream: categories,
        builder: (ctx,AsyncSnapshot<QuerySnapshot>snapshot){
           if(snapshot.hasError){
             return Center(child: Text('something went wrong1'));
           }
            if(snapshot.connectionState==ConnectionState.waiting){
             return Center(child: Text('Loading'));
           }
           final data =snapshot.requireData;
           return ListView.builder(
             itemCount: data.size,
             itemBuilder: (ctxx,i){
               return Column(
                 children: [
                   Text(data.docs[i]['cat_name']),
                   Text(data.docs[i]['cat_desc'])
                 ],
               );
             });

        })
      ,),
      
    );
  }
}