//import 'package:aurora/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meditation/utils/app_colors.dart';

// ignore: must_be_immutable
class NoConnection extends StatefulWidget {
  
  bool noBack ;
  @override
  _NoConnectionState createState() => _NoConnectionState();
  NoConnection({Key? key, this.noBack=false}
    
  ) : super(key: key);
}

class _NoConnectionState extends State<NoConnection> {
  static int errorCount = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appColor,
      appBar: AppBar(
        backgroundColor: AppColors.appColor,
        elevation: 0,
        leading: Container(),
        title: const Text('No Internet Connection',style: TextStyle(color: Color.fromARGB(255, 105, 102, 102)),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            errorCount >= 3
                ?const Center(
                    child: Icon(
                      Icons.exit_to_app,
                      size: 80,
                    ),
                  )
                :const  Center(
                    child: Icon(
                      Icons.wifi_off,
                      size: 80,
                      color: Colors.green,
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            const Text('There is no internet connection please try again later',style: TextStyle(color: Color.fromARGB(255, 105, 102, 102)),),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
      backgroundColor:  MaterialStateProperty.all(AppColors.darkAppcolor),
    ),
              child:const Text('Retry'),
              onPressed: () {
              widget.noBack?SystemNavigator.pop():  Navigator.pop(context);
                
              },
            )
          ],
        ),
      ),
    );
  }
}