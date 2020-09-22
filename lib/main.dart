import 'package:ecommerce/Widget.dart';
import 'package:ecommerce/cart.dart';
import 'package:ecommerce/discribtion.dart';
import 'package:ecommerce/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:carousel_pro/carousel_pro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "E-Commerce",
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: LoginPage(),
    );
  }
}

class HomePage extends StatefulWidget {
  final String documentId;

  const HomePage({Key key, this.documentId}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    final Size hsize = MediaQuery.of(context).size;
    return Scaffold(
        drawer: DrawerList(),
        appBar: AppBar(
          backgroundColor: c,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "FashionDunia",
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: textColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: hsize.height * 0.30,
                  width: hsize.width,
                  child: Carousel(
                    borderRadius: false,
                    animationDuration: Duration(microseconds: 10),
                    dotIncreasedColor: c,
                    dotBgColor: Colors.white.withOpacity(0.3),
                    indicatorBgPadding: 1.4,
                    overlayShadowColors: Colors.white.withOpacity(0.3),
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    images: [
                      new AssetImage('assets/backgroung/canva2.png'),
                      new AssetImage('assets/backgroung/canva1.png'),
                      new AssetImage('assets/backgroung/canva3.png'),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 5),
                child: Text(
                  "Today Sales",
                  style: TextStyle(
                      fontSize: 20,
                      color: textColor,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                  height: hsize.height * 0.60,
                  child: FutureBuilder<QuerySnapshot>(
                      future: _reference.get(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: GridView.count(
                              padding: EdgeInsets.all(5),
                              childAspectRatio: .80,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              crossAxisCount: 2,
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Discribtion(
                                                  documentId: document.id,
                                                  image: document
                                                      .data()['images'][0],
                                                  prize:
                                                      document.data()['prize'],
                                                  title:
                                                      document.data()['name'],
                                                  cartdocumentId: document.id,
                                                )));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: GridTile(
                                        footer: Container(
                                          color: Colors.white.withOpacity(0.6),
                                          height: hsize.height * .12,
                                          child: ListTile(
                                            title: Text(
                                              document.data()['name'],
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              "By ${document.data()['shop']}",
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            trailing: Text(
                                              "\$" + document.data()['prize'],
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                        child: Image.network(
                                          document.data()['images'][0],
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }))
            ],
          ),
        ));
  }
}
