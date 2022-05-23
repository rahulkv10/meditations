import 'package:flutter/material.dart';
import 'package:meditation/utils/app_colors.dart';

// ignore: must_be_immutable
class NavBar extends StatelessWidget {
   String ?title;
  NavBar({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 90,
      alignment: Alignment.bottomCenter,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarItem(icon: Icons.arrow_back_ios,press: (){
            Navigator.pop(context);
          },),
          SizedBox(width: MediaQuery.of(context).size.width*.2,),
          Text(title.toString(),style:TextStyle(color: AppColors.primaryColors,fontSize: 20,fontWeight: FontWeight.w500)),
          //NavBarItem(icon: Icons.list,)
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
final IconData? icon;
final Function()? press;

  const NavBarItem({Key? key, this.icon, this.press}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        height: 40,width: 40,
        decoration:BoxDecoration(
          boxShadow:[
            BoxShadow(
              color: AppColors.primaryColors.withOpacity(0.5),
              offset: const Offset(5, 10),
              spreadRadius: 3,
              blurRadius: 10
            ),
            const  BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -3),
              spreadRadius: -2,
              blurRadius: 20
            ),
          ],
          
          borderRadius: BorderRadius.circular(10),
          color: AppColors.lightpink
        ),
        child: Icon(icon,color: AppColors.primaryColors,),
      ),
    );
  }
}