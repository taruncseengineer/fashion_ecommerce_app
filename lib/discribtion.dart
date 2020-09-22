import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Widget.dart';
import 'package:ecommerce/product_size.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Discribtion extends StatefulWidget {
  final String documentId;
  final String title;
  final String prize;
  final String image;

  final String cartdocumentId;

  const Discribtion(
      {Key key,
      this.documentId,
      this.cartdocumentId,
      this.title,
      this.prize,
      this.image})
      : super(key: key);

  @override
  _DiscribtionState createState() => _DiscribtionState();
}

class _DiscribtionState extends State<Discribtion> {
  final CollectionReference _reference =
      FirebaseFirestore.instance.collection('products');

  final CollectionReference _userref =
      FirebaseFirestore.instance.collection('cartdetail');

  User _user = FirebaseAuth.instance.currentUser;

  String _selectedproductsize = "0";
  Future _addtocart() {
    return _userref
        .doc(_user != null ? _user.uid : null)
        .collection("Cart")
        .doc(widget.documentId)
        .set({
      "size": _selectedproductsize,
      "title": widget.title,
      "prize": widget.prize,
      "image": widget.image
    });
  }

  final SnackBar _snackBar =
      SnackBar(content: Text("product is added in card"));
  bool select = false;

  @override
  Widget build(BuildContext context) {
    final Size hsize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: FutureBuilder(
        future: _reference.doc(widget.documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> detailpage = snapshot.data.data();
            List data = detailpage['images'];
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: hsize.height * 0.45,
                  child: PageView(
                    children: [
                      for (var i = 0; i < data.length; i++)
                        Container(
                            alignment: Alignment.bottomLeft,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data[i]),
                                    fit: BoxFit.contain),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: c.withOpacity(0.4)),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                detailpage['name'],
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: textColor),
                              ),
                            ))
                    ],
                  ),
                ),
                Positioned(
                    top: 20,
                    left: 10,
                    child: Container(
                      height: 45,
                      width: 45,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    )),
                Positioned(
                    top: hsize.height * 0.45,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Prize ",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: textColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "\$" + detailpage['prize'].toString(),
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, bottom: 5, top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Old Prize ",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      color: textColor),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "\$" + detailpage['oldprize'].toString(),
                                    style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: textColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "Describtion",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: textColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              detailpage['des'],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              "Size",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: textColor),
                            ),
                          ),
                          ProductSize(
                            onselectid: (size) {
                              _selectedproductsize = size;
                            },
                            productSize: detailpage['size'],
                          ),
                          Container(
                            color: Colors.white.withOpacity(0.3),
                            height: 55,
                            width: hsize.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: GestureDetector(
                                    onTap: () async {
                                      await _addtocart();
                                      Scaffold.of(context)
                                          .showSnackBar(_snackBar);
                                      print("product is added in card");
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                      decoration: BoxDecoration(
                                          color: c,
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(25),
                                              topRight: Radius.circular(25))),
                                      height: hsize.height,
                                      width: 190,
                                      alignment: Alignment.center,
                                      child: ListTile(
                                        leading: Icon(
                                          Icons.add_shopping_cart,
                                          size: 25,
                                          color: Colors.black,
                                        ),
                                        title: Text(
                                          "Add Cart",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                              color: textColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
                                    height: hsize.height,
                                    width: 190,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.check,
                                        size: 25,
                                        color: Colors.black,
                                      ),
                                      title: Text(
                                        "Buy",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: textColor),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: c,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(25),
                                            bottomRight: Radius.circular(25))),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
