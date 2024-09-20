import 'package:flutter/material.dart';

extension MySize on int {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
  Divider get div => Divider(thickness: toDouble());
}

extension MyText on String {
  Text ts({TextStyle? style}) => Text(this, style: style);
}

extension MyPadding on Widget {
  Widget pAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget get center => Center(child: this);
}
