import 'package:flutter/material.dart';

circularProggress() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 12.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
    ),
  );
}

linearProggress() {
  return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 12.0),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.white),
      ));
}
