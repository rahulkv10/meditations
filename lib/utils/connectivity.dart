//import 'package:connectivity/connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Connection {
  static checkNetworkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return 'Connected to mobile data';
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return 'Connected to Wireless Network';
    } else {
      return null;
    }
  }

  static checkConnectionAgain() async {
    var connection = await Connection.checkNetworkConnection();
    if (connection == null) {
     // print('no connection');
      return false;
    } else {
     // print(connection);
      return true;
    }
  }
}