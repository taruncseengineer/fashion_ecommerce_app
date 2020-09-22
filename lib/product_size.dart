import 'package:ecommerce/Widget.dart';
import 'package:flutter/material.dart';

class ProductSize extends StatefulWidget {
  final List productSize;
  final Function(String) onselectid;

  const ProductSize({Key key, this.productSize, this.onselectid})
      : super(key: key);
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      child: Row(
        children: [
          for (var i = 0; i < widget.productSize.length; i++)
            GestureDetector(
              onTap: () {
                widget.onselectid("${widget.productSize[i]}");
                setState(() {
                  selected = i;
                });
              },
              child: Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                    color: selected == i ? c : Colors.brown[100],
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  "${widget.productSize[i]}",
                  style: TextStyle(
                      fontSize: selected == i ? 20 : 16,
                      fontWeight:
                          selected == i ? FontWeight.bold : FontWeight.w600,
                      color: selected == i ? Colors.red : Colors.black),
                ),
              ),
            )
        ],
      ),
    );
  }
}
