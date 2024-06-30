import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentiment/auth/login_screen.dart';
import '../controller/auth_controller.dart';
import 'Home/home_srceen.dart';
import 'Home/sentiment_score.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final AuthController authController = Get.find<AuthController>();

  // bool isDataFetched=false;
  @override
  Widget build(BuildContext context) {
    SideBarController sideBarController = Get.put(SideBarController());
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: Color(0xffC3ECFE),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      Image.asset(
                        'assets/images/sentiment.png',
                        height: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildListItem(
                        title: "Dashboard",
                        icon: Icons.home,
                        onTap: () {
                          sideBarController.index.value = 0;
                        },
                        selected: sideBarController.index.value == 0,
                        showItem: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildListItem(
                        title: "Search",
                        icon: Icons.search,
                        onTap: () {
                          sideBarController.index.value = 1;
                        },
                        selected: sideBarController.index.value == 1,
                        showItem: true,
                      ),
                      _buildListItem(
                        title: "Sentiment Score",
                        icon: Icons.score,
                        onTap: () {
                          sideBarController.index.value = 2;
                        },
                        selected: sideBarController.index.value == 2,
                        showItem: true,
                      ),
                      _buildListItem(
                        title: "Vissulaizations",
                        icon: Icons.view_sidebar,
                        onTap: () {
                          sideBarController.index.value = 3;
                        },
                        selected: sideBarController.index.value == 3,
                        showItem: true,
                      ),
                      _buildListItem(
                        title: "Feed Back",
                        icon: Icons.feed_outlined,
                        onTap: () {
                          sideBarController.index.value = 4;
                        },
                        selected: sideBarController.index.value == 4,
                        showItem: true,
                      ),
                      _buildListItem(
                        title: "Contact Us",
                        icon: Icons.contact_emergency,
                        onTap: () {
                          sideBarController.index.value = 5;
                        },
                        selected: sideBarController.index.value == 5,
                        showItem: true,
                      ),
                      _buildListItem(
                        title: "Logout",
                        icon: Icons.logout,
                        onTap: () {
                          FirebaseAuth _auth = FirebaseAuth.instance;
                          _auth
                              .signOut()
                              .then((value) => Get.to(LoginScreen()));
                        },
                        selected: sideBarController.index.value == 6,
                        showItem: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Obx(
              () => sideBarController.pages[sideBarController.index.value],
            ),
          ),
        ],
      ),
    );
  }
}

class SideBarController extends GetxController {
  RxInt index = 0.obs;

  var pages = [
    SentimentAnalysisPage(),
    SentimentAnalysisPage(),
    SentimentAnalysisPage(),
    SentimentScore(),
    SentimentScore(),
    SentimentScore(),
  ];
}

Widget _buildListItem({
  required String title,
  required IconData icon,
  required Function onTap,
  required bool selected,
  required bool showItem,
}) {
  if (!showItem) {
    return const SizedBox(); // Return an empty SizedBox if the item should not be shown
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: selected ? Colors.blue[200] : Colors.transparent,
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
            color: selected ? Colors.white : Colors.black, fontSize: 14),
      ),
      leading: Icon(
        icon,
        size: 16,
        color: selected ? Colors.white : Colors.black,
      ),
      onTap: () => onTap(),
      selected: selected,
    ),
  );
}

Widget _buildListbutton({
  required String title,
  required IconData icon,
  required Function onTap,
  required bool selected,
}) {
  return Container(
    height: 20,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0xffC3ECFE),
    ),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.blue[200],
        ),
      ),
      leading: Icon(
        icon,
        color: selected ? Colors.white : Colors.blue[200],
      ),
      onTap: () => onTap(),
      selected: selected,
    ),
  );
}
