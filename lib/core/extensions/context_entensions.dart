import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  //PADDING VALUES
  double get lowPaddingValue => 0.1;
  double get mediumPaddingValue => 0.2;
  double get highPaddingValue => 0.3;

//PADDING - EDGE INSETS
  EdgeInsets symetricPadding(double horizontal, double vertical) =>
      EdgeInsets.symmetric(
          vertical: dynamicHeight(vertical),
          horizontal: dynamicWidth(horizontal));

  EdgeInsets get lowPadding => EdgeInsets.symmetric(
      vertical: dynamicHeight(lowPaddingValue),
      horizontal: dynamicWidth(lowPaddingValue));
  EdgeInsets get mediumPadding => EdgeInsets.symmetric(
      vertical: dynamicHeight(mediumPaddingValue),
      horizontal: dynamicWidth(mediumPaddingValue));
  EdgeInsets get highPadding => EdgeInsets.symmetric(
      vertical: dynamicHeight(highPaddingValue),
      horizontal: dynamicWidth(highPaddingValue));

  ThemeData get theme => Theme.of(this);

  MediaQueryData get media => MediaQuery.of(this);

  EdgeInsets get lowHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(lowPaddingValue));
  EdgeInsets get mediumHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(mediumPaddingValue));
  EdgeInsets get highHorizontalPadding =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(highPaddingValue));

  EdgeInsets get lowVerticalPadding =>
      EdgeInsets.symmetric(vertical: dynamicWidth(lowPaddingValue));
  EdgeInsets get mediumVerticalPadding =>
      EdgeInsets.symmetric(vertical: dynamicWidth(mediumPaddingValue));
  EdgeInsets get highVerticalPadding =>
      EdgeInsets.symmetric(vertical: dynamicWidth(highPaddingValue));

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double dynamicHeight(double value) => MediaQuery.of(this).size.height * value;
  double dynamicWidth(double value) => MediaQuery.of(this).size.width * value;
}
