import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:future/constants.dart';

import 'account_page/account_page.dart';
import 'message_page/message_page.dart';
import 'home_page/home_page.dart';

class BottomNavigationHome extends StatefulWidget {
  const BottomNavigationHome({Key? key}) : super(key: key);

  static String id = 'bottom_navigation_home';

  @override
  State<BottomNavigationHome> createState() => _BottomNavigationHomeState();
}

class _BottomNavigationHomeState extends State<BottomNavigationHome> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

//MessagePage(),
  Widget getBody() {
    List<Widget> pages = [
      HomePage(),
      AccountPage(),
    ];
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }
  //"icons/bottom_navigation/messaging.svg",

  Widget getFooter() {
    var size = MediaQuery.of(context).size;
    List bottomItems = [
      "icons/bottom_navigation/home.svg",
      "icons/bottom_navigation/person.svg",
    ];
    return Container(
      width: size.width,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 30.0,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 100, right: 100, bottom: 0, top: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(bottomItems.length, (index) {
              return InkWell(
                  onTap: () {
                    selectedTab(index);
                  },
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        bottomItems[index],
                        height: 40.0,
                        color: pageIndex == index
                            ? kPrimaryColor
                            : kSecondaryColor,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      (pageIndex == index)
                          ? AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn,
                              child: Container(
                                height: 8.0,
                                width: 20.0,
                                decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius: BorderRadius.circular(100)),
                              ),
                            )
                          : Container(
                              height: 8.0,
                              width: 20.0,
                            ),
                    ],
                  ));
            }),
          ),
        ),
      ),
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
