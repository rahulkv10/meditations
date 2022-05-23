import 'package:flutter/material.dart';
import 'package:meditation/pages/welcome/welcome_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_image.dart';
import '../home/homePage.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<WelcomeModel> _onBoardingList = [
    WelcomeModel(
        title: "Stay Focused",
        description:
            "Find a suitable music for yourself to stay focused more easily",
        image: AppImages.onboarding1),
    WelcomeModel(
        title: "Take a deep breath",
        description:
            "Start your mindfulness journey with our meditation program",
        image: AppImages.onboarding2),
  ];
  final controller = PageController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return 
      
     AnimatedContainer(
        duration:const Duration(seconds: 1),
        color: selectedIndex == 0 ? AppColors.appColor : AppColors.appColor,
        child: SafeArea(
          bottom: false,
          child: Scaffold(
           backgroundColor:selectedIndex == 0
                              ? AppColors.appColor
                              : AppColors.appColor,
            body: Column(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    duration:const Duration(seconds: 1),
                    decoration: BoxDecoration(
                        color: selectedIndex == 0
                            ? AppColors.appColor
                            : AppColors.appColor,
                        borderRadius:const BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: _containerPaginationWidget(),
                  ),
                ),
                _indicatorWidget(),
                _buttonWidget(),
               const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      );
    
  }

  Widget _containerPaginationWidget() {
    return PageView.builder(
        controller: controller,
        itemCount: _onBoardingList.length,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        itemBuilder: (context, index) {
          return  Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(_onBoardingList[index].image),
             const SizedBox(
                height: 40,
              ),
              Text(
                _onBoardingList[index].title,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primaryColors,
                  fontWeight: FontWeight.bold
                ),
              ),
             const SizedBox(
                height: 10,
              ),
              Container(
                margin:const EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  _onBoardingList[index].description,
                  textAlign: TextAlign.center,
                  style:const TextStyle(
                      color:Color.fromARGB(255, 130, 131, 134),
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                      ),
                ),
              ),
            ],
          );
        });
  }

  Widget _indicatorWidget() {
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SmoothPageIndicator(
        controller: controller,
        count: _onBoardingList.length,
        effect: ExpandingDotsEffect(
          spacing: 10,
          dotHeight: 10,
          dotWidth: 10,
          activeDotColor: AppColors.primaryColors,
          dotColor: Colors.grey,
        ),
      ),
    );
  }

  Widget _buttonWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: SizedBox(
        width: double.infinity,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppColors.primaryColors,
          onPressed: () {
            if (selectedIndex == 0) {
              controller.animateToPage(1,
                  duration:const Duration(seconds: 1), curve: Curves.easeIn);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>const HomePage()),
              );
            }
          },
          child: Text(
            selectedIndex == 0 ? "Continue" : "Let's go",
            style: const TextStyle( 
              color: Colors.white,
              fontSize: 18,
             // fontFamily: AppString.boldFontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
