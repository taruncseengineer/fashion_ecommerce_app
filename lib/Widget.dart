import 'package:flutter/material.dart';

Color bgcolor = const Color(0xfff2bcb8);
Color imcolor = const Color(0xfffcf7bd);
Color c = const Color(0xffedbe9a);
Color textColor = const Color(0xff095059);

class Catagroiesname extends StatelessWidget {
  final String imaCat;
  final String nameCat;
  final Function catPress;
  const Catagroiesname({
    Key key,
    this.imaCat,
    this.nameCat,
    this.catPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: catPress,
      child: Container(
        margin: EdgeInsets.fromLTRB(5, 5, 0, 5),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(imaCat),
              radius: 35,
            ),
            Text(nameCat)
          ],
        ),
      ),
    );
  }
}

class CatagroiesPage extends StatelessWidget {
  final Function pressfornav;
  final String imageCatPage1;
  final String imageCatPage2;
  final String imageCatPage3;
  final String imageCatPage4;
  const CatagroiesPage({
    Key key,
    @required this.hsize,
    this.pressfornav,
    this.imageCatPage1,
    this.imageCatPage2,
    this.imageCatPage3,
    this.imageCatPage4,
  }) : super(key: key);

  final Size hsize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressfornav,
      child: Container(
          padding: EdgeInsets.all(10),
          height: hsize.height * .35,
          width: hsize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 180,
                    child: Image.asset(imageCatPage1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 180,
                    child: Image.asset(imageCatPage2),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 180,
                    child: Image.asset(imageCatPage3),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    width: 180,
                    child: Image.asset(imageCatPage4),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class DrawerList extends StatelessWidget {
  const DrawerList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: 300,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: c,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50,
                        child: Text(
                          "T",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    "taruncseengineer@gmail.com",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.shopping_basket,
                color: textColor,
              ),
              title: Text(
                "Order By",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
          Divider(
            height: 4,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.event_available,
                color: textColor,
              ),
              title: Text(
                "Today Deals",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
          Divider(
            height: 4,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.favorite,
                color: textColor,
              ),
              title: Text(
                "Favorites",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
          Divider(
            height: 4,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.lock_open,
                color: textColor,
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
          Divider(
            height: 4,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.contacts,
                color: textColor,
              ),
              title: Text(
                "Contect Us",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
          Divider(
            height: 4,
            color: Colors.brown,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 4),
            child: ListTile(
              leading: Icon(
                Icons.perm_identity,
                color: textColor,
              ),
              title: Text(
                "About Us",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: textColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
