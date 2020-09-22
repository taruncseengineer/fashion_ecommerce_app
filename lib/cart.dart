import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  final String cartId;

  const Cart({Key key, this.cartId}) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CollectionReference _userref =
      FirebaseFirestore.instance.collection('cartdetail');

  User _user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 70, right: 70, bottom: 8),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Text(
            "BUY",
            style: TextStyle(
                letterSpacing: 2,
                fontSize: 30,
                color: textColor,
                fontWeight: FontWeight.bold),
          ),
          decoration:
              BoxDecoration(color: c, borderRadius: BorderRadius.circular(18)),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: c,
        title: Text(
          "Your Cart List",
          style: TextStyle(
              letterSpacing: 1,
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
          future: _userref
              .doc(_user != null ? _user.uid : null)
              .collection("Cart")
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Image.network(document.data()['image']),
                  ),
                  title: Text(
                    document.data()['title'],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: textColor),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "size: " + document.data()['size'],
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w500,
                            color: textColor),
                      ),
                      Text(
                        "\$" + document.data()['prize'],
                        style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700,
                            color: Colors.red),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                );
              }).toList());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
