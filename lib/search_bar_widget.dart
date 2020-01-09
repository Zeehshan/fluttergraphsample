import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const SearchWidget({Key key, this.controller, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double l = MediaQuery.of(context).size.longestSide;
    return Container(
      margin: EdgeInsets.only(left: 18, right: 18),
      width: w,
      height: l*0.06,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            hintText: 'Search by car name',
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.7), fontFamily: 'Montserrat-Medium',fontSize: w*0.03, letterSpacing: 1.5),
            fillColor: Colors.grey.withOpacity(0.2),
            prefixIcon: Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                child: Icon(Icons.search, color: Colors.black)),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(200.0)),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
            borderRadius: BorderRadius.circular(200)
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(200)
          )
        ),
      ),
    )
    ;
  }
}
