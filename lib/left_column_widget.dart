import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const descTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  fontSize: 15,
);
var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: [
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    const Icon(Icons.star, color: Colors.black),
    const Icon(Icons.star, color: Colors.black),
  ],
);

final instructDetails = Container(
  width: 300,
  padding: paddingCont,
  decoration: BoxDecoration(
      border: Border.all(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(2)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Column(
        children: [
          Icon(Icons.kitchen, color: Colors.green[500]),
          const Text('PREP:'),
          const Text('25 min'),
        ],
      ),Column(
        children: [
          Icon(Icons.timer, color: Colors.green[500]),
          const Text('COOK:'),
          const Text('1 hr'),
        ],
      ),Column(
        children: [
          Icon(Icons.restaurant, color: Colors.green[500]),
          const Text('FEEDS:'),
          const Text('4-6'),
        ],
      ),
    ],
  ),
);

final ratings = Container(
  width: 300,
  padding: paddingCont,
  decoration: BoxDecoration(
      border: Border.all(color: Colors.red, width: 1),
      borderRadius: BorderRadius.circular(2)),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      stars,
      const Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 15,
        ),
      ),
    ],
  ),
);
const paddingCont = EdgeInsets.all(5);

class LeftColumn extends StatelessWidget {
  const LeftColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: 300,
            padding: paddingCont,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey),
            child: Text(
              'Strawbery pavolova',
              textAlign: TextAlign.center,
              style: descTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: paddingCont,
            width: 300,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(2),
                color: Colors.grey),
            child: Text(
              'The layout framework allows \n you to nest rows and columns inside of rows and columns',
              textAlign: TextAlign.center,
              style: descTextStyle,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ratings,
          SizedBox(
            height: 10,
          ),
          instructDetails
        ],
      ),
    );
  }
}
