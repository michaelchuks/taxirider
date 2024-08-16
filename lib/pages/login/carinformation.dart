import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/managevehicles.dart';
import 'package:flutter_driver/pages/login/landingpage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../login/login.dart';
import '../noInternet/nointernet.dart';
import 'requiredinformation.dart';

// ignore: must_be_immutable
class CarInformation extends StatefulWidget {
  int? frompage;
  CarInformation({this.frompage, Key? key}) : super(key: key);

  @override
  State<CarInformation> createState() => _CarInformationState();
}

bool isowner = false;
dynamic myVehicalType;
dynamic myVehicleIconFor = '';
List vehicletypelist = [];
dynamic vehicleColor;
dynamic myServiceLocation;
dynamic myServiceId;
String vehicleModelId = '';
dynamic vehicleModelName;
dynamic modelYear;
String vehicleMakeId = '';
dynamic vehicleNumber;
dynamic vehicleMakeName;
String myVehicleId = '';
String mycustommake = '';
String mycustommodel = '';
List choosevehicletypelist = [];
List choosevehicletypelistlocal = [];

class _CarInformationState extends State<CarInformation> {
  bool loaded = false;
  bool chooseWorkArea = false;
  bool _isLoading = false;
  String _error = '';
  bool chooseVehicleMake = false;
  bool chooseVehicleModel = false;
  bool chooseVehicleType = false;
  String dateError = '';
  bool vehicleAdded = false;
  String uploadError = '';
  bool iscustommake = false;
  dynamic tempServiceLocationId;
  dynamic tempVehicleMakeId;
  dynamic tempVehicleModelId;
  TextEditingController modelcontroller = TextEditingController();
  TextEditingController colorcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController referralcontroller = TextEditingController();
  TextEditingController custommakecontroller = TextEditingController();
  TextEditingController custommodelcontroller = TextEditingController();
  double isbottom = -1000;

  //navigate
  navigate() {
    Navigator.pop(context, true);
    serviceLocations.clear();
    vehicleMake.clear();
    vehicleModel.clear();
    vehicleType.clear();
  }

  navigateref() {
    Navigator.pop(context, true);
  }

  navigateLogout() {
    if (ownermodule == '1') {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
            (route) => false);
      });
    } else {
      ischeckownerordriver = 'driver';
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
      });
    }
  }

  @override
  void initState() {
    getServiceLoc();
    super.initState();
  }

//get service loc data
  getServiceLoc() async {
    choosevehicletypelist.clear();
    vehicletypelist.clear();
    myServiceId = '';
    myServiceLocation = '';
    vehicleMakeId = '';
    vehicleModelId = '';
    myVehicleId = '';
    // ignore: unused_local_variable, prefer_typing_uninitialized_variables
    var result;
    if (widget.frompage == 2 || isowner == true) {
      myVehicleId = '';
      result = await getvehicleType();
    } else {
      vehicletypelist = [];
      result = await getServiceLocation();
    }

    if (mounted) {
      setState(() {
        loaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        child: Directionality(
          textDirection: (languageDirection == 'rtl')
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Scaffold(
            body: Stack(
              children: [
                Container(
                  height: media.height * 1,
                  width: media.width * 1,
                  color: page,
                  child: Column(
                    children: [
                      // SizedBox(height: MediaQuery.of(context).padding.top),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            media.width * 0.05,
                            media.width * 0.03,
                            media.width * 0.05,
                            media.width * 0.04),
                        decoration: BoxDecoration(color: page, boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 1),
                              blurRadius: 8)
                        ]),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: textColor,
                                  size: 20,
                                )),
                            Expanded(
                              child: MyText(
                                textAlign: TextAlign.center,
                                text: languages[choosenLanguage]
                                    ['text_car_info'],
                                size: media.width * sixteen,
                                maxLines: 1,
                                fontweight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),

                      Expanded(
                          child: Container(
                        padding: EdgeInsets.fromLTRB(
                            media.width * 0.05,
                            media.width * 0.05,
                            media.width * 0.05,
                            media.width * 0.05),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (enabledModule == 'both' &&
                                  widget.frompage == 1)
                                Column(
                                  children: [
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    SizedBox(
                                        width: media.width * 0.9,
                                        child: MyText(
                                          text: languages[choosenLanguage]
                                              ['text_register_for'],
                                          size: media.width * fourteen,
                                          fontweight: FontWeight.w600,
                                          maxLines: 1,
                                        )),
                                    SizedBox(
                                      height: media.height * 0.012,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.025,
                                              right: media.width * 0.025),
                                          width: media.width * 0.25,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                transportType = 'taxi';
                                                myVehicleId = '';
                                                vehicleMakeId = '';
                                                vehicleModelId = '';
                                                myServiceId = '';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: media.width * 0.05,
                                                  width: media.width * 0.05,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: textColor,
                                                          width: 1.2)),
                                                  child: (transportType ==
                                                          'taxi')
                                                      ? Center(
                                                          child: Icon(
                                                          Icons.done,
                                                          color: textColor,
                                                          size: media.width *
                                                              0.04,
                                                        ))
                                                      : Container(),
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.025,
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.15,
                                                  child: MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_taxi_'],
                                                    size:
                                                        media.width * fourteen,
                                                    fontweight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.025,
                                              right: media.width * 0.025),
                                          width: media.width * 0.3,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                transportType = 'delivery';
                                                myVehicleId = '';
                                                vehicleMakeId = '';
                                                vehicleModelId = '';
                                                myServiceId = '';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: media.width * 0.05,
                                                  width: media.width * 0.05,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: textColor,
                                                          width: 1.2)),
                                                  child: (transportType ==
                                                          'delivery')
                                                      ? Center(
                                                          child: Icon(
                                                          Icons.done,
                                                          color: textColor,
                                                          size: media.width *
                                                              0.04,
                                                        ))
                                                      : Container(),
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.025,
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.18,
                                                  child: MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_delivery'],
                                                    size:
                                                        media.width * fourteen,
                                                    fontweight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: media.width * 0.025,
                                              right: media.width * 0.025),
                                          width: media.width * 0.25,
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                transportType = 'both';
                                                myVehicleId = '';
                                                vehicleMakeId = '';
                                                vehicleModelId = '';
                                                myServiceId = '';
                                              });
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: media.width * 0.05,
                                                  width: media.width * 0.05,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: textColor,
                                                          width: 1.2)),
                                                  child: (transportType ==
                                                          'both')
                                                      ? Center(
                                                          child: Icon(
                                                          Icons.done,
                                                          color: textColor,
                                                          size: media.width *
                                                              0.04,
                                                        ))
                                                      : Container(),
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.025,
                                                ),
                                                SizedBox(
                                                  width: media.width * 0.15,
                                                  child: MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_both'],
                                                    size:
                                                        media.width * fourteen,
                                                    fontweight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    )
                                  ],
                                ),
                              (widget.frompage == 1 && isowner == false)
                                  ? Text(
                                      languages[choosenLanguage]
                                          ['text_service_location'],
                                      style: GoogleFonts.notoSans(
                                          fontSize: media.width * sixteen,
                                          color: textColor,
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Container(),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              (widget.frompage == 1 && isowner == false)
                                  ? InkWell(
                                      onTap: () async {
                                        setState(() {
                                          if (chooseWorkArea == true) {
                                            chooseWorkArea = false;
                                            isbottom = -1000;
                                          } else {
                                            chooseWorkArea = true;
                                            chooseVehicleMake = false;
                                            chooseVehicleModel = false;
                                            chooseVehicleType = false;
                                            isbottom = 0;
                                            tempServiceLocationId = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: media.width * 0.13,
                                        decoration: BoxDecoration(
                                          color: page,
                                          borderRadius: BorderRadius.circular(
                                              media.width * 0.01),
                                          border: Border.all(color: underline),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.05,
                                            right: media.width * 0.05),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: media.width * 0.7,
                                              child: Text(
                                                (widget.frompage == 1 &&
                                                        myServiceId == '')
                                                    ? languages[choosenLanguage]
                                                        ['text_service_loc']
                                                    : (myServiceId != null &&
                                                            myServiceId != '')
                                                        ? serviceLocations
                                                                .isNotEmpty
                                                            ? serviceLocations
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element[
                                                                            'id'] ==
                                                                        myServiceId)[
                                                                    'name']
                                                                .toString()
                                                            : ''
                                                        : userDetails[
                                                            'service_location_name'],
                                                style: GoogleFonts.notoSans(
                                                    fontSize: (myServiceId !=
                                                                null &&
                                                            myServiceId != '')
                                                        ? media.width * sixteen
                                                        : media.width *
                                                            fourteen,
                                                    // fontWeight: FontWeight.w600,
                                                    color: (myServiceId !=
                                                                    null &&
                                                                myServiceId !=
                                                                    '') ||
                                                            widget.frompage == 1
                                                        ? textColor
                                                        : hintColor),
                                              ),
                                            ),
                                            Container(
                                              height: media.width * 0.06,
                                              width: media.width * 0.06,
                                              decoration: BoxDecoration(
                                                  color: topBar,
                                                  shape: BoxShape.circle,
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2.0,
                                                        spreadRadius: 2.0,
                                                        color: Colors.black
                                                            .withOpacity(0.2))
                                                  ]),
                                              child: Icon(
                                                Icons.place,
                                                color: loaderColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: media.width * 0.02,
                              ),

                              SizedBox(
                                width: media.width * 0.9,
                                child: MyText(
                                  text: languages[choosenLanguage]
                                      ['text_vehicle_type'],
                                  size: media.width * fifteen,
                                  fontweight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.03,
                              ),
                              (userDetails['vehicle_type_name'] == null &&
                                      userDetails['role'] != 'owner')
                                  ? InkWell(
                                      onTap: () async {
                                        if (chooseVehicleType == true) {
                                          setState(() {
                                            chooseVehicleType = false;
                                            isbottom = 0;
                                          });
                                        } else {
                                          if ((myServiceId != '') ||
                                              (isowner == true)) {
                                            chooseVehicleType = true;
                                          } else {
                                            chooseVehicleType = false;
                                          }
                                          chooseWorkArea = false;
                                          chooseVehicleMake = false;
                                          chooseVehicleModel = false;
                                          isbottom = 0;
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: media.width * 0.13,
                                        width: media.width * 0.9,
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                media.width * 0.01),
                                            border:
                                                Border.all(color: underline),
                                            color: ((myServiceId == null ||
                                                        myServiceId == '') &&
                                                    widget.frompage == 1 &&
                                                    isowner == false)
                                                ? hintColor
                                                : topBar),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.03,
                                            right: media.width * 0.03),
                                        child: (myVehicleId == '')
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: MyText(
                                                      text: languages[
                                                                  choosenLanguage]
                                                              [
                                                              'text_vehicle_type']
                                                          .toString(),
                                                      size: media.width *
                                                          fourteen,
                                                      color: (chooseWorkArea ==
                                                                  true &&
                                                              serviceLocations
                                                                  .isNotEmpty)
                                                          ? (isDarkTheme)
                                                              ? const Color(
                                                                  0xFFEBEBEB)
                                                              : textColor
                                                          : (isDarkTheme)
                                                              ? const Color(
                                                                  0xFFEBEBEB)
                                                              : hintColor,
                                                    ),
                                                  ),
                                                  if ((myServiceId == null ||
                                                          myServiceId == '') &&
                                                      widget.frompage == 1 &&
                                                      isowner == false)
                                                    Icon(
                                                      Icons
                                                          .lock_outline_rounded,
                                                      size: media.width * 0.05,
                                                      color: textColor,
                                                    )
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  SizedBox(
                                                    width: media.width * 0.83,
                                                    child: (choosevehicletypelist
                                                            .isNotEmpty)
                                                        ? SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              children:
                                                                  choosevehicletypelist
                                                                      .asMap()
                                                                      .map((i,
                                                                          value) {
                                                                        return MapEntry(
                                                                          i,
                                                                          Container(
                                                                            padding: EdgeInsets.fromLTRB(
                                                                                media.width * 0.03,
                                                                                media.width * 0.01,
                                                                                media.width * 0.03,
                                                                                media.width * 0.01),
                                                                            margin:
                                                                                EdgeInsets.all(media.width * 0.01),
                                                                            decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.circular(media.width * 0.06),
                                                                                color: buttonColor.withOpacity(0.2),
                                                                                border: Border.all(color: buttonColor.withOpacity(0.1))),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                MyText(
                                                                                  text: choosevehicletypelist[i]['name'].toString(),
                                                                                  size: media.width * sixteen,
                                                                                  color: (isDarkTheme) ? Colors.black : textColor,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        );
                                                                      })
                                                                      .values
                                                                      .toList(),
                                                            ),
                                                          )
                                                        : MyText(
                                                            text: languages[
                                                                        choosenLanguage]
                                                                    [
                                                                    'text_vehicle_type']
                                                                .toString(),
                                                            size: sixteen,
                                                            color: textColor,
                                                          ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        if (chooseVehicleType == true) {
                                          setState(() {
                                            chooseVehicleType = false;
                                          });
                                        } else {
                                          if (myServiceId != '' ||
                                              isowner == true) {
                                            isbottom = 0.0;
                                            chooseVehicleType = true;
                                          } else {
                                            chooseVehicleType = false;
                                          }
                                          chooseWorkArea = false;
                                          chooseVehicleMake = false;
                                          chooseVehicleModel = false;
                                        }
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: media.width * 0.13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                media.width * 0.01),
                                            border:
                                                Border.all(color: textColor),
                                            color: ((myServiceId == null ||
                                                        myServiceId == '') &&
                                                    widget.frompage == 1 &&
                                                    isowner == false)
                                                ? const Color(0xFFE8EAE9)
                                                : topBar),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.05,
                                            right: media.width * 0.05),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: media.width * 0.7,
                                              child: Text(
                                                (myVehicleId == '')
                                                    ? languages[choosenLanguage]
                                                            [
                                                            'text_vehicle_type']
                                                        .toString()
                                                    : (myVehicleId != '' &&
                                                            myVehicleId != '')
                                                        ? vehicleType.isNotEmpty
                                                            ? vehicleType
                                                                .firstWhere(
                                                                    (element) =>
                                                                        element[
                                                                            'id'] ==
                                                                        myVehicleId)[
                                                                    'name']
                                                                .toString()
                                                            : ''
                                                        : myVehicalType
                                                            .toString(),
                                                style: GoogleFonts.notoSans(
                                                    fontSize: (myVehicleId !=
                                                            '')
                                                        ? media.width * sixteen
                                                        : media.width *
                                                            fourteen,
                                                    // fontWeight: FontWeight.w600,
                                                    color: (widget.frompage ==
                                                                1 &&
                                                            (myVehicleId == ''))
                                                        ? (isDarkTheme)
                                                            ? Colors.black
                                                                .withOpacity(
                                                                    0.5)
                                                            : textColor
                                                        : (isDarkTheme)
                                                            ? Colors.black
                                                            : textColor),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                              SizedBox(
                                height: media.width * 0.02,
                              ),

                              SizedBox(
                                height: media.width * 0.03,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_vehicle_make'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (chooseVehicleMake == true) {
                                      chooseVehicleMake = false;
                                    } else {
                                      if (myVehicleId != '') {
                                        chooseVehicleMake = true;
                                        isbottom = 0;
                                      } else {
                                        chooseVehicleMake = false;
                                      }
                                      chooseWorkArea = false;
                                      chooseVehicleModel = false;
                                      chooseVehicleType = false;
                                    }
                                  });
                                },
                                child: (iscustommake == false)
                                    ? Container(
                                        height: media.width * 0.13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                media.width * 0.01),
                                            border:
                                                Border.all(color: Colors.black),
                                            color: myVehicleId == ''
                                                ? const Color(0xFFE8EAE9)
                                                : topBar),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.05,
                                            right: media.width * 0.05),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: media.width * 0.7,
                                                child: MyText(
                                                  text: (vehicleMakeId == '')
                                                      ? languages[
                                                              choosenLanguage]
                                                          ['text_sel_make']
                                                      : (vehicleMakeId != '')
                                                          ? vehicleMake
                                                                  .isNotEmpty
                                                              ? vehicleMake
                                                                  .firstWhere(
                                                                      (element) =>
                                                                          element['id']
                                                                              .toString() ==
                                                                          vehicleMakeId)[
                                                                      'name']
                                                                  .toString()
                                                              : ''
                                                          : vehicleMakeName ==
                                                                  ''
                                                              ? languages[
                                                                      choosenLanguage]
                                                                  [
                                                                  'text_vehicle_make']
                                                              : vehicleMakeName,
                                                  size: (vehicleMakeId != '')
                                                      ? media.width * sixteen
                                                      : media.width * fourteen,
                                                  color: (widget.frompage ==
                                                              1 &&
                                                          (vehicleMakeId == ''))
                                                      ? Colors.black
                                                          .withOpacity(0.5)
                                                      : (vehicleMakeId != '')
                                                          ? textColor
                                                          : Colors.grey,
                                                )),
                                            if (myVehicleId == '')
                                              Icon(
                                                Icons.lock_outline_rounded,
                                                size: media.width * 0.05,
                                                color: textColor,
                                              )
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: media.width * 0.13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                media.width * 0.01),
                                            border:
                                                Border.all(color: underline),
                                            color: topBar),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.05,
                                            right: media.width * 0.05),
                                        child: InputField(
                                          underline: false,
                                          autofocus: true,
                                          text: languages[choosenLanguage]
                                              ['text_sel_make'],
                                          textController: custommakecontroller,
                                          onTap: (val) {
                                            setState(() {
                                              mycustommake = val;
                                            });
                                          },
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),

                              SizedBox(
                                height: media.width * 0.03,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_vehicle_model'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),
                              (iscustommake)
                                  ? Container(
                                      height: media.width * 0.13,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              media.width * 0.01),
                                          border: Border.all(color: underline),
                                          color: topBar),
                                      padding: EdgeInsets.only(
                                          left: media.width * 0.05,
                                          right: media.width * 0.05),
                                      child: InputField(
                                        underline: false,
                                        autofocus: true,
                                        text: languages[choosenLanguage]
                                            ['text_sel_model'],
                                        textController: custommodelcontroller,
                                        onTap: (val) {
                                          setState(() {
                                            mycustommodel = val;
                                          });
                                        },
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (chooseVehicleModel == true) {
                                            chooseVehicleModel = false;
                                          } else {
                                            if (vehicleMakeId != '') {
                                              chooseVehicleModel = true;
                                              isbottom = 0;
                                            } else {
                                              chooseVehicleModel = false;
                                            }
                                            chooseVehicleMake = false;
                                            chooseWorkArea = false;
                                            chooseVehicleType = false;
                                          }
                                        });
                                      },
                                      child: Container(
                                        height: media.width * 0.13,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                media.width * 0.01),
                                            border:
                                                Border.all(color: Colors.black),
                                            color: vehicleMakeId == ''
                                                ? const Color(0xFFE8EAE9)
                                                : topBar),
                                        padding: EdgeInsets.only(
                                            left: media.width * 0.05,
                                            right: media.width * 0.05),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: media.width * 0.7,
                                                child: MyText(
                                                  text: (vehicleModelId == '')
                                                      ? languages[
                                                              choosenLanguage]
                                                          ['text_sel_model']
                                                      : (vehicleModelId != '' &&
                                                              vehicleModelId !=
                                                                  '' &&
                                                              vehicleModel
                                                                  .isNotEmpty)
                                                          ? vehicleModel
                                                              .firstWhere(
                                                                  (element) =>
                                                                      element['id']
                                                                          .toString() ==
                                                                      vehicleModelId)[
                                                                  'name']
                                                              .toString()
                                                          : vehicleModelName ==
                                                                  ''
                                                              ? languages[
                                                                      choosenLanguage]
                                                                  [
                                                                  'text_vehicle_model']
                                                              : vehicleModelName,
                                                  size: (vehicleModelId != '' &&
                                                          vehicleModelId != '')
                                                      ? media.width * sixteen
                                                      : media.width * fourteen,
                                                  color: (widget.frompage ==
                                                              1 &&
                                                          (vehicleModelId ==
                                                                  '' ||
                                                              vehicleModelId ==
                                                                  ''))
                                                      ? Colors.black
                                                          .withOpacity(0.5)
                                                      : (vehicleModelId != '')
                                                          ? textColor
                                                          : Colors.grey,
                                                )),
                                            if (vehicleMakeId == '')
                                              Icon(
                                                Icons.lock_outline_rounded,
                                                size: media.width * 0.05,
                                                // color: Colors.red,
                                              )
                                          ],
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                height: media.width * 0.02,
                              ),

                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_vehicle_model_year'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.01),
                                    border: Border.all(color: Colors.black),
                                    color: ((iscustommake)
                                            ? mycustommodel == ''
                                            : vehicleModelId == '')
                                        ? const Color(0xFFE8EAE9)
                                        : topBar),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.05,
                                    right: media.width * 0.05),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        readonly: ((iscustommake)
                                                ? mycustommodel == ''
                                                : vehicleModelId == '')
                                            ? true
                                            : false,
                                        underline: false,
                                        text: languages[choosenLanguage]
                                            ['text_enter_vehicle_model_year'],
                                        textController: modelcontroller,
                                        onTap: (val) {
                                          setState(() {
                                            modelYear = modelcontroller.text;
                                          });
                                          if (modelcontroller.text.length ==
                                                  4 &&
                                              int.parse(modelYear) <=
                                                  int.parse(DateTime.now()
                                                      .year
                                                      .toString())) {
                                            setState(() {
                                              dateError = '';
                                            });
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          } else if (modelcontroller
                                                      .text.length ==
                                                  4 &&
                                              int.parse(modelYear) >
                                                  int.parse(DateTime.now()
                                                      .year
                                                      .toString())) {
                                            setState(() {
                                              dateError =
                                                  'Please Enter Valid Date';
                                            });
                                          }
                                        },
                                        color: (dateError == '')
                                            ? (isDarkTheme)
                                                ? Colors.black
                                                : Colors.black
                                            : Colors.red,
                                        inputType: TextInputType.number,
                                        maxLength: 4,
                                      ),
                                    ),
                                    if ((iscustommake)
                                        ? mycustommodel == ''
                                        : vehicleModelId == '')
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        size: media.width * 0.05,
                                        color: textColor,
                                      )
                                  ],
                                ),
                              ),
                              (dateError != '')
                                  ? Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: MyText(
                                        text: dateError,
                                        size: media.width * sixteen,
                                        color: Colors.red,
                                      ))
                                  : Container(),

                              //vehicle number

                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_enter_vehicle'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.01),
                                    border: Border.all(color: Colors.black),
                                    color: ((iscustommake)
                                            ? mycustommodel == ''
                                            : vehicleModelId == '')
                                        ? const Color(0xFFE8EAE9)
                                        : topBar),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.05,
                                    right: media.width * 0.05),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        readonly: ((iscustommake)
                                                ? mycustommodel == ''
                                                : vehicleModelId == '')
                                            ? true
                                            : false,
                                        underline: false,
                                        text: languages[choosenLanguage]
                                            ['text_enter_vehicle'],
                                        textController: numbercontroller,
                                        onTap: (val) {
                                          setState(() {
                                            vehicleNumber =
                                                numbercontroller.text;
                                          });
                                        },
                                        maxLength: 20,
                                      ),
                                    ),
                                    if ((iscustommake)
                                        ? mycustommodel == ''
                                        : vehicleModelId == '')
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        size: media.width * 0.05,
                                        color: textColor,
                                      )
                                  ],
                                ),
                              ),

                              //vehicle color
                              SizedBox(
                                height: media.height * 0.02,
                              ),
                              MyText(
                                text: languages[choosenLanguage]
                                    ['text_vehicle_color'],
                                size: media.width * fifteen,
                                fontweight: FontWeight.w500,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.01),
                                    border: Border.all(color: Colors.black),
                                    color: ((iscustommake)
                                            ? mycustommodel == ''
                                            : vehicleModelId == '')
                                        ? const Color(0xFFE8EAE9)
                                        : topBar),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.05,
                                    right: media.width * 0.05),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: InputField(
                                        readonly: ((iscustommake)
                                                ? mycustommodel == ''
                                                : vehicleModelId == '')
                                            ? true
                                            : false,
                                        underline: false,
                                        text: languages[choosenLanguage]
                                            ['Text_enter_vehicle_color'],
                                        textController: colorcontroller,
                                        onTap: (val) {
                                          setState(() {
                                            vehicleColor = colorcontroller.text;
                                          });
                                        },
                                      ),
                                    ),
                                    if ((iscustommake)
                                        ? mycustommodel == ''
                                        : vehicleModelId == '')
                                      Icon(
                                        Icons.lock_outline_rounded,
                                        size: media.width * 0.05,
                                        color: textColor,
                                      )
                                  ],
                                ),
                              ),
                              if (widget.frompage == 1 && isowner != true)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: media.height * 0.02,
                                    ),
                                    MyText(
                                      text: languages[choosenLanguage]
                                          ['text_referral_optional'],
                                      size: media.width * sixteen,
                                      fontweight: FontWeight.w600,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      height: media.width * 0.13,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              media.width * 0.01),
                                          border: Border.all(color: underline),
                                          color: topBar),
                                      padding: EdgeInsets.only(
                                          left: media.width * 0.05,
                                          right: media.width * 0.05),
                                      child: InputField(
                                        // color: page,
                                        underline: false,
                                        text: languages[choosenLanguage]
                                            ['text_enter_referral'],
                                        textController: referralcontroller,
                                        onTap: (val) {
                                          setState(() {});
                                        },
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      )),
                      if (_error != '')
                        Column(
                          children: [
                            SizedBox(
                                width: media.width * 0.9,
                                child: MyText(
                                  text: _error,
                                  color: Colors.red,
                                  size: media.width * fourteen,
                                  textAlign: TextAlign.center,
                                )),
                            SizedBox(
                              height: media.width * 0.025,
                            )
                          ],
                        ),
                      //navigate to pick service page
                      (numbercontroller.text != '' &&
                                  numbercontroller.text.length < 21) &&
                              (myVehicleId != '' ||
                                  choosevehicletypelist.isNotEmpty) &&
                              ((iscustommake)
                                  ? mycustommake != ''
                                  : vehicleMakeId != '') &&
                              ((iscustommake)
                                  ? mycustommodel != ''
                                  : vehicleModelId != '') &&
                              (modelcontroller.text.length == 4 &&
                                  (int.parse(modelYear) <=
                                      int.parse(
                                          DateTime.now().year.toString()))) &&
                              (colorcontroller.text.isNotEmpty)
                          ? Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              child: Button(
                                  onTap: () async {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                    setState(() {
                                      _error = '';
                                      _isLoading = true;
                                    });
                                    if (widget.frompage == 1 &&
                                        userDetails.isNotEmpty &&
                                        isowner != true) {
                                      if (referralcontroller.text.isNotEmpty) {
                                        var val = await updateReferral(
                                            referralcontroller.text);
                                        if (val == 'true') {
                                          carInformationCompleted = true;
                                          navigateref();
                                        } else {
                                          setState(() {
                                            referralcontroller.clear();
                                            _error = languages[choosenLanguage]
                                                ['text_referral_code'];
                                            _isLoading = false;
                                          });
                                        }
                                      } else {
                                        carInformationCompleted = true;
                                        navigateref();
                                      }
                                    } else if (userDetails.isEmpty) {
                                      vehicletypelist.clear();
                                      for (Map<String, dynamic> json
                                          in choosevehicletypelist) {
                                        // Get the value of the key.
                                        vehicletypelist.add(json['id']);
                                      }

                                      var reg = await registerDriver();

                                      if (reg == 'true') {
                                        if (referralcontroller
                                            .text.isNotEmpty) {
                                          var val = await updateReferral(
                                              referralcontroller.text);
                                          if (val == 'true') {
                                            carInformationCompleted = true;
                                            navigateref();
                                          } else {
                                            setState(() {
                                              referralcontroller.clear();
                                              _error =
                                                  languages[choosenLanguage]
                                                      ['text_referral_code'];
                                              _isLoading = false;
                                            });
                                          }
                                        } else {
                                          carInformationCompleted = true;
                                          navigateref();
                                        }
                                      } else {
                                        setState(() {
                                          uploadError = reg.toString();
                                        });
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } else if (userDetails['role'] == 'owner') {
                                      vehicletypelist
                                          .add(choosevehicletypelist[0]['id']);
                                      var reg = await addDriver();
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (reg == 'true') {
                                        // ignore: use_build_context_synchronously
                                        // setState(() {
                                        //   vehicleAdded = true;
                                        // });
                                        showModalBottomSheet(
                                            // ignore: use_build_context_synchronously
                                            context: context,
                                            isScrollControlled: false,
                                            isDismissible: false,
                                            builder: (context) {
                                              return Container(
                                                padding: EdgeInsets.all(
                                                    media.width * 0.05),
                                                width: media.width * 1,
                                                height: media.width * 0.4,
                                                decoration: BoxDecoration(
                                                    color: page,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            topLeft: Radius
                                                                .circular(media
                                                                        .width *
                                                                    0.05),
                                                            topRight: Radius
                                                                .circular(media
                                                                        .width *
                                                                    0.05))),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                        width:
                                                            media.width * 0.7,
                                                        child: MyText(
                                                          text: languages[
                                                                  choosenLanguage]
                                                              [
                                                              'text_vehicle_added'],
                                                          size: media.width *
                                                              sixteen,
                                                          fontweight:
                                                              FontWeight.bold,
                                                        )),
                                                    SizedBox(
                                                      height: media.width * 0.1,
                                                    ),
                                                    Button(
                                                        onTap: () {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const ManageVehicles()));
                                                        },
                                                        text: languages[
                                                                choosenLanguage]
                                                            ['text_ok'])
                                                  ],
                                                ),
                                              );
                                            });
                                      } else if (reg == 'logout') {
                                        navigateLogout();
                                      } else {
                                        setState(() {
                                          uploadError = reg.toString();
                                        });
                                      }
                                    } else {
                                      vehicletypelist.clear();
                                      for (Map<String, dynamic> json
                                          in choosevehicletypelist) {
                                        // Get the value of the key.
                                        vehicletypelist.add(json['id']);
                                      }

                                      var update = await updateVehicle();
                                      if (update == 'success') {
                                        navigate();
                                      } else if (update == 'logout') {
                                        navigateLogout();
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    }
                                  },
                                  text: widget.frompage == 1 &&
                                          userDetails.isNotEmpty &&
                                          referralcontroller.text.isEmpty &&
                                          isowner != true
                                      ? languages[choosenLanguage]
                                          ['text_skip_referral']
                                      : widget.frompage != 2
                                          ? languages[choosenLanguage]
                                              ['text_confirm']
                                          : languages[choosenLanguage]
                                              ['text_updateVehicle']),
                            )
                          : Container(),
                    ],
                  ),
                ),

                AnimatedPositioned(
                  bottom: isbottom,
                  duration: const Duration(milliseconds: 500),
                  child: InkWell(
                    onTap: () async {
                      if (chooseWorkArea == true &&
                          serviceLocations.isNotEmpty) {
                        setState(() {
                          // chooseWorkArea = false;
                          isbottom = -1000;
                        });
                      } else if (chooseVehicleType == true &&
                          vehicleType.isNotEmpty) {
                        if (choosevehicletypelist.isEmpty) {
                          setState(() {
                            vehicleMake.clear();
                            myVehicleId = '';
                            vehicleModelId = '';
                            vehicleMakeId = '';
                            vehicleModel.clear();
                            iscustommake = false;
                            chooseVehicleMake = false;
                          });
                        }
                        setState(() {
                          chooseVehicleType = false;
                          isbottom = -1000;
                        });
                      } else if (chooseVehicleMake == true &&
                          iscustommake == false) {
                        setState(() {
                          if (chooseVehicleMake == true) {
                            chooseVehicleMake = false;
                          } else {
                            if (myVehicleId != '') {
                              chooseVehicleMake = true;
                              isbottom = 0;
                            } else {
                              chooseVehicleMake = false;
                            }
                            chooseWorkArea = false;
                            chooseVehicleModel = false;
                            chooseVehicleType = false;
                          }
                          chooseVehicleMake = false;
                          isbottom = -1000;
                        });
                      } else if (chooseVehicleModel == true &&
                          vehicleModel.isNotEmpty) {
                        setState(() {
                          if (chooseVehicleModel == true) {
                            chooseVehicleModel = false;
                          } else {
                            if (vehicleMakeId != '') {
                              chooseVehicleModel = true;
                              isbottom = 0;
                            } else {
                              chooseVehicleModel = false;
                            }
                            chooseVehicleMake = false;
                            chooseWorkArea = false;
                            chooseVehicleType = false;
                          }
                          isbottom = -1000;
                        });
                      }
                    },
                    child: Container(
                      height: media.height * 1,
                      width: media.width * 1,
                      // color: Colors.black.withOpacity(0.2),
                      alignment: Alignment.bottomCenter,
                      child:
                          (chooseWorkArea == true &&
                                  serviceLocations.isNotEmpty)
                              ? Container(
                                  width: media.width * 1,
                                  height: media.width * 0.7,
                                  padding: EdgeInsets.all(media.width * 0.03),
                                  decoration: BoxDecoration(
                                      color: page,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(
                                              media.width * 0.04),
                                          topRight: Radius.circular(
                                              media.width * 0.04)),
                                      border: Border.all(color: underline)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      MyText(
                                        text: languages[choosenLanguage]
                                            ['text_service_loc'],
                                        size: media.width * sixteen,
                                        fontweight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        height: media.width * 0.02,
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Column(
                                            children: serviceLocations
                                                .asMap()
                                                .map((i, value) {
                                                  return MapEntry(
                                                      i,
                                                      InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            tempServiceLocationId =
                                                                serviceLocations[
                                                                    i]['id'];
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              width:
                                                                  media.width *
                                                                      0.8,
                                                              padding: EdgeInsets.only(
                                                                  top: media
                                                                          .width *
                                                                      0.025,
                                                                  bottom: media
                                                                          .width *
                                                                      0.025),
                                                              child: Text(
                                                                serviceLocations[
                                                                    i]['name'],
                                                                style: GoogleFonts.notoSans(
                                                                    fontSize: media
                                                                            .width *
                                                                        fourteen,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:
                                                                        textColor),
                                                              ),
                                                            ),
                                                            (tempServiceLocationId ==
                                                                    serviceLocations[
                                                                            i]
                                                                        ['id'])
                                                                ? Icon(
                                                                    Icons.done,
                                                                    color:
                                                                        online,
                                                                  )
                                                                : Container()
                                                          ],
                                                        ),
                                                      ));
                                                })
                                                .values
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                      Button(
                                          onTap: () async {
                                            setState(() {
                                              myVehicleId = '';
                                              vehicleMakeId = '';
                                              vehicleModelId = '';
                                              myServiceId =
                                                  tempServiceLocationId;
                                              chooseWorkArea = false;
                                              _isLoading = true;
                                              isbottom = -1000;
                                              choosevehicletypelistlocal
                                                  .clear();
                                              choosevehicletypelist.clear();
                                            });
                                            modelcontroller.text = '';
                                            colorcontroller.text = '';
                                            numbercontroller.text = '';
                                            var result = await getvehicleType();
                                            if (result == 'success') {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            } else {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }
                                          },
                                          text: languages[choosenLanguage]
                                              ['text_confirm'])
                                    ],
                                  ),
                                )
                              : (chooseVehicleType == true &&
                                      vehicleType.isNotEmpty)
                                  ? Container(
                                      width: media.width * 1,
                                      height: media.width * 0.8,

                                      // height: media.width * 0.5,
                                      padding:
                                          EdgeInsets.all(media.width * 0.03),
                                      decoration: BoxDecoration(
                                          color: page,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  media.width * 0.04),
                                              topRight: Radius.circular(
                                                  media.width * 0.04)),
                                          border: Border.all(color: underline)),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: SingleChildScrollView(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Column(
                                                children: vehicleType
                                                    .asMap()
                                                    .map((i, value) {
                                                      return MapEntry(
                                                          i,
                                                          InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                vehicleMakeId =
                                                                    '';
                                                                vehicleModelId =
                                                                    '';
                                                                vehicleMakeName =
                                                                    '';
                                                                vehicleModelName =
                                                                    '';
                                                                // chooseVehicleType = false;
                                                                iscustommake =
                                                                    false;
                                                              });
                                                              if (widget
                                                                      .frompage ==
                                                                  3) {
                                                                if (choosevehicletypelistlocal
                                                                    .isEmpty) {
                                                                  choosevehicletypelistlocal.add(
                                                                      vehicleType[
                                                                          i]);
                                                                } else {
                                                                  choosevehicletypelistlocal
                                                                      .clear();
                                                                  choosevehicletypelistlocal.add(
                                                                      vehicleType[
                                                                          i]);
                                                                }
                                                              } else {
                                                                if (choosevehicletypelistlocal
                                                                    .where((element) =>
                                                                        element[
                                                                            'name'] ==
                                                                        vehicleType[i]
                                                                            [
                                                                            'name'])
                                                                    .isEmpty) {
                                                                  choosevehicletypelistlocal.add(
                                                                      vehicleType[
                                                                          i]);
                                                                } else {
                                                                  choosevehicletypelistlocal.removeWhere((element) =>
                                                                      element[
                                                                          'name'] ==
                                                                      vehicleType[
                                                                              i]
                                                                          [
                                                                          'name']);
                                                                }
                                                              }
                                                            },
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                    width: media
                                                                            .width *
                                                                        0.8,
                                                                    padding: EdgeInsets.only(
                                                                        top: media.width *
                                                                            0.025,
                                                                        bottom: media.width *
                                                                            0.025),
                                                                    child: Row(
                                                                      children: [
                                                                        Image
                                                                            .network(
                                                                          vehicleType[i]['icon']
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          width:
                                                                              media.width * 0.1,
                                                                          height:
                                                                              media.width * 0.08,
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          vehicleType[i]['name']
                                                                              .toString()
                                                                              .toUpperCase(),
                                                                          style: GoogleFonts.notoSans(
                                                                              fontSize: media.width * fourteen,
                                                                              fontWeight: FontWeight.w600,
                                                                              color: textColor),
                                                                        ),
                                                                      ],
                                                                    )),
                                                                (choosevehicletypelistlocal
                                                                        .where((element) =>
                                                                            element['name'] ==
                                                                            vehicleType[i]['name'])
                                                                        .isNotEmpty)
                                                                    ? Icon(
                                                                        Icons
                                                                            .done,
                                                                        color:
                                                                            online,
                                                                      )
                                                                    : Container(),
                                                              ],
                                                            ),
                                                          ));
                                                    })
                                                    .values
                                                    .toList(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: media.width * 0.03,
                                          ),
                                          Button(
                                              onTap: () async {
                                                // choosevehicletypelist =
                                                //     choosevehicletypelistlocal;
                                                choosevehicletypelist.clear();
                                                for (var i = 0;
                                                    i <
                                                        choosevehicletypelistlocal
                                                            .length;
                                                    i++) {
                                                  choosevehicletypelist.add(
                                                      choosevehicletypelistlocal[
                                                          i]);
                                                }
                                                if (choosevehicletypelistlocal
                                                    .isNotEmpty) {
                                                  await getVehicleMake(
                                                    transportType:
                                                        transportType,
                                                    myVehicleIconFor:
                                                        choosevehicletypelistlocal[
                                                                    0][
                                                                'icon_types_for']
                                                            .toString(),
                                                  );
                                                }

                                                isbottom = -1000;

                                                if (choosevehicletypelist
                                                    .isEmpty) {
                                                  setState(() {
                                                    vehicleMake.clear();
                                                    myVehicleId = '';
                                                    vehicleModelId = '';
                                                    vehicleMakeId = '';
                                                    vehicleModel.clear();
                                                    iscustommake = false;
                                                    chooseVehicleMake = false;
                                                  });
                                                }
                                                chooseVehicleType = false;
                                                if (choosevehicletypelistlocal
                                                    .isNotEmpty) {
                                                  myVehicleId =
                                                      choosevehicletypelistlocal[
                                                          0]['id'];
                                                }
                                                modelcontroller.text = '';
                                                colorcontroller.text = '';
                                                numbercontroller.text = '';
                                                setState(() {});
                                              },
                                              text: languages[choosenLanguage]
                                                  ['text_confirm'])
                                        ],
                                      ),
                                    )
                                  : (chooseVehicleMake == true &&
                                          iscustommake == false)
                                      ? Container(
                                          width: media.width * 1,
                                          height: media.width * 0.8,
                                          padding: EdgeInsets.all(
                                              media.width * 0.03),
                                          decoration: BoxDecoration(
                                              color: page,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(
                                                      media.width * 0.04),
                                                  topRight: Radius.circular(
                                                      media.width * 0.04)),
                                              border:
                                                  Border.all(color: underline)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_vehicle_make'],
                                                size: media.width * sixteen,
                                                fontweight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                height: media.width * 0.02,
                                              ),
                                              Expanded(
                                                child: SingleChildScrollView(
                                                  physics:
                                                      const BouncingScrollPhysics(),
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: media
                                                                        .width *
                                                                    0.05),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              iscustommake =
                                                                  true;
                                                              custommakecontroller
                                                                  .text = '';
                                                              custommodelcontroller
                                                                  .text = '';
                                                              chooseVehicleMake =
                                                                  false;
                                                              isbottom = -1000;
                                                              modelcontroller
                                                                  .text = '';
                                                              colorcontroller
                                                                  .text = '';
                                                              numbercontroller
                                                                  .text = '';
                                                            });
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.only(
                                                                            top: media.width *
                                                                                0.025,
                                                                            bottom: media.width *
                                                                                0.025),
                                                                        child:
                                                                            MyText(
                                                                          text: languages[choosenLanguage]
                                                                              [
                                                                              'text_custom_make'],
                                                                          size: media.width *
                                                                              fourteen,
                                                                          fontweight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              buttonColor,
                                                                        )),
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .edit_note_sharp,
                                                                color:
                                                                    buttonColor,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: vehicleMake
                                                            .asMap()
                                                            .map((i, value) {
                                                              return MapEntry(
                                                                  i,
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        tempVehicleMakeId =
                                                                            vehicleMake[i]['id'].toString();
                                                                      });
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                            width: media.width *
                                                                                0.8,
                                                                            padding:
                                                                                EdgeInsets.only(top: media.width * 0.025, bottom: media.width * 0.025),
                                                                            child: MyText(
                                                                              text: vehicleMake[i]['name'].toString(),
                                                                              size: media.width * fourteen,
                                                                              fontweight: FontWeight.w600,
                                                                              color: textColor,
                                                                            )),
                                                                        (tempVehicleMakeId ==
                                                                                vehicleMake[i]['id'].toString())
                                                                            ? Icon(
                                                                                Icons.done,
                                                                                color: online,
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ));
                                                            })
                                                            .values
                                                            .toList(),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Button(
                                                  onTap: () async {
                                                    setState(() {
                                                      vehicleModelId = '';
                                                      vehicleModelName = '';
                                                      vehicleMakeId =
                                                          tempVehicleMakeId;
                                                      chooseVehicleMake = false;
                                                      isbottom = -1000;
                                                      _isLoading = true;
                                                    });

                                                    var result =
                                                        await getVehicleModel();
                                                    if (result == 'success') {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _isLoading = false;
                                                      });
                                                    }
                                                    modelcontroller.text = '';
                                                    colorcontroller.text = '';
                                                    numbercontroller.text = '';
                                                  },
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_confirm'])
                                            ],
                                          ),
                                        )
                                      : (chooseVehicleModel == true &&
                                              vehicleModel.isNotEmpty)
                                          ? Container(
                                              // margin: EdgeInsets.only(
                                              //     bottom: media.width * 0.03),
                                              width: media.width * 1,
                                              height: media.width * 0.7,
                                              padding: EdgeInsets.all(
                                                  media.width * 0.03),
                                              decoration: BoxDecoration(
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  media.width *
                                                                      0.04),
                                                          topRight:
                                                              Radius.circular(
                                                                  media.width *
                                                                      0.04)),
                                                  border: Border.all(
                                                      color: underline)),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    text: languages[
                                                            choosenLanguage]
                                                        ['text_vehicle_model'],
                                                    size: media.width * fifteen,
                                                    fontweight: FontWeight.w600,
                                                  ),
                                                  SizedBox(
                                                    height: media.width * 0.02,
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      physics:
                                                          const BouncingScrollPhysics(),
                                                      child: Column(
                                                        children: vehicleModel
                                                            .asMap()
                                                            .map((i, value) {
                                                              return MapEntry(
                                                                  i,
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        tempVehicleModelId =
                                                                            vehicleModel[i]['id'];
                                                                      });
                                                                    },
                                                                    child: Row(
                                                                      children: [
                                                                        Container(
                                                                            width: media.width *
                                                                                0.8,
                                                                            padding:
                                                                                EdgeInsets.only(top: media.width * 0.025, bottom: media.width * 0.025),
                                                                            child: MyText(
                                                                              text: vehicleModel[i]['name'].toString(),
                                                                              size: media.width * fourteen,
                                                                              fontweight: FontWeight.w600,
                                                                            )),
                                                                        (tempVehicleModelId ==
                                                                                vehicleModel[i]['id'])
                                                                            ? Icon(
                                                                                Icons.done,
                                                                                color: online,
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ));
                                                            })
                                                            .values
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ),
                                                  Button(
                                                      onTap: () async {
                                                        setState(() {
                                                          vehicleModelId =
                                                              tempVehicleModelId
                                                                  .toString();
                                                          chooseVehicleModel =
                                                              false;
                                                          _isLoading = true;
                                                          isbottom = -1000;
                                                        });

                                                        var result =
                                                            await getVehicleModel();
                                                        if (result ==
                                                            'success') {
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                        } else {
                                                          setState(() {
                                                            _isLoading = false;
                                                          });
                                                        }
                                                        modelcontroller.text =
                                                            '';
                                                        colorcontroller.text =
                                                            '';
                                                        numbercontroller.text =
                                                            '';
                                                      },
                                                      text: languages[
                                                              choosenLanguage]
                                                          ['text_confirm'])
                                                ],
                                              ),
                                            )
                                          : Container(),
                    ),
                  ),
                ),

                if (vehicleAdded == true)
                  Positioned(
                      child: Container(
                    height: media.height * 1,
                    width: media.width * 1,
                    color: Colors.transparent.withOpacity(0.6),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: page,
                            width: media.width * 0.9,
                            padding: EdgeInsets.all(media.width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width: media.width * 0.7,
                                    child: MyText(
                                      text: languages[choosenLanguage]
                                          ['text_vehicle_added'],
                                      size: media.width * sixteen,
                                      fontweight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: media.width * 0.1,
                                ),
                                Button(
                                    width: media.width * 0.2,
                                    height: media.width * 0.1,
                                    onTap: () {
                                      Navigator.pop(context, true);
                                    },
                                    text: languages[choosenLanguage]['text_ok'])
                              ],
                            ),
                          )
                        ]),
                  )),
                //no internet
                (internet == false)
                    ? Positioned(
                        top: 0,
                        child: NoInternet(
                          onTap: () {
                            setState(() {
                              internetTrue();
                            });
                          },
                        ))
                    : Container(),
                //loader
                (_isLoading == true)
                    ? const Positioned(top: 0, child: Loading())
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
