import 'package:flutter/material.dart';

var scrheight = 813.0;
var scrwidth = 375.0;

double eight = 0.0213;
double ten = 0.0267;
double twelve = 0.032;
double thirty = 0.08;
double fourteen = 0.0373;
double fifteen = 0.04;
double sixteen = 0.042666;
double eighteen = 0.048;
double twenty = 0.053;
double twentysix = 0.0693;
double twentyeight = 0.07466;
double twentyfour = 0.064;
double thirtysix = 0.096;
double fourty = 0.10667;
Color backgroundColor = const Color(0xffe5e5e5);
Color textColor = const Color(0xff12121D);
Color backIcon = const Color(0xff12121D);
Color underline = const Color(0xff12121D).withOpacity(0.3);
Color hintColor = const Color(0xff12121D).withOpacity(0.3);
Color inputUnderline = const Color(0xff12121D).withOpacity(0.3);
Color inputfocusedUnderline = const Color(0xff12121D);
Color topBar = const Color(0xffF8F8F8);
Color page = const Color(0xffF8F8F8);
Color buttonColor = const Color(0xff4003FF);
Color theme = const Color(0xff4003FF);
Color buttonText = const Color(0xffFFFFFF);
Color inputFieldSeparator = const Color(0xff1DA1F2);
Color termsCheckBox = const Color(0xff4003FF);
Color loaderColor = const Color(0xff4003FF);
Color notUploadedColor = Colors.orange;
Color verifyPendingBck = const Color(0xffFEF2F2);
Color verifyPending = const Color(0xffFFB800);
Color verifyDeclined = const Color(0xffE70000);
Color offline = const Color(0xff898989);
Color online = const Color(0xff309700);
Color onlineOfflineText = const Color(0xffFFFFFF);
Color borderLines = const Color(0xffE5E5E5);
Color starColor = const Color(0xffFac500);
Color darkHintColor = Colors.white.withOpacity(0.3);
bool isDarkTheme = false;
Color loaderBg = const Color(0xffFBFBFB);

class SlidingGradientTransform extends GradientTransform {
  const SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

dynamic shimmer;
List<Color> shaderColor = [
  const Color(0xFFEBEBF4).withOpacity(0.2),
  page,
  const Color(0xFFEBEBF4).withOpacity(0.2),
];

List<double> shaderStops = [
  0.1,
  0.3,
  0.4,
];

Alignment shaderBegin = const Alignment(-1.0, -0.3);
Alignment shaderEnd = const Alignment(1.0, 0.3);
