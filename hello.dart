import 'package:flutter/material.dart';

class CustomIndicator extends StatefulWidget {
  CustomIndicator({Key key}) : super(key: key);

  _CustomIndicatorState createState() => _CustomIndicatorState();
}

class _CustomIndicatorState extends State<CustomIndicator> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActinButton: FloatingActionButton(onPressed: () {
          setState({
            currentIndex++;
          });
        }),
        body: ListView.builder(
          itemCount: 3,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return CustomIndicator(isSelected: index == currentIndex);
          },
        ));
  }
}
