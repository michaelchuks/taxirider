import 'package:flutter/material.dart';
import 'package:flutter_driver/functions/functions.dart';
import 'package:flutter_driver/pages/login/carinformation.dart';
import 'package:flutter_driver/styles/styles.dart';
import 'package:flutter_driver/translation/translation.dart';
import 'package:flutter_driver/widgets/widgets.dart';

class CarInfoPage extends StatefulWidget {
  const CarInfoPage({super.key});

  @override
  State<CarInfoPage> createState() => _CarInfoPageState();
}

class _CarInfoPageState extends State<CarInfoPage> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return SafeArea(
      child: Material(
        color: page,
        child: Directionality(
            textDirection: (languageDirection == 'rtl')
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: Stack(
              children: [
                Column(
                  children: [
                    // SizedBox(height: MediaQuery.of(context).padding.top),
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          media.width * 0.05,
                          media.width * 0.03,
                          media.width * 0.05,
                          media.width * 0.04),
                      // color: page,
                      decoration: BoxDecoration(color: page, boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            offset: const Offset(0, 1),
                            blurRadius: 8)
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          SizedBox(
                            width: media.width * 0.6,
                            child: MyText(
                              textAlign: TextAlign.center,
                              text: languages[choosenLanguage]['text_car_info'],
                              size: media.width * sixteen,
                              maxLines: 1,
                              fontweight: FontWeight.w600,
                            ),
                          ),
                          (userDetails['owner_id'] == null)
                              ? InkWell(
                                  onTap: () async {
                                    myServiceId =
                                        userDetails['service_location_id'];

                                    var nav = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CarInformation(
                                                  frompage: 2,
                                                )));
                                    if (nav != null) {
                                      if (nav) {
                                        setState(() {});
                                      }
                                    }
                                  },
                                  child: SizedBox(
                                    width: media.width * 0.15,
                                    child: MyText(
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                      text: languages[choosenLanguage]
                                          ['text_edit'],
                                      color: buttonColor,
                                      size: media.width * sixteen,
                                      fontweight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    SizedBox(
                      height: media.height * 0.05,
                    ),
                    Expanded(
                        child: Container(
                      width: media.width * 1,
                      padding: EdgeInsets.all(media.width * 0.05),
                      child: Column(
                        children: [
                          (userDetails['owner_id'] != null &&
                                  userDetails['vehicle_type_name'] == null)
                              ? Row(
                                  children: [
                                    MyText(
                                      text: languages[choosenLanguage]
                                          ['text_no_fleet_assigned'],
                                      size: media.width * eighteen,
                                      fontweight: FontWeight.bold,
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    SizedBox(
                                      width: media.width * 0.9,
                                      child: MyText(
                                        text: languages[choosenLanguage]
                                            ['text_type'],
                                        size: media.width * fourteen,
                                        color: hintColor,
                                      ),
                                    ),
                                    Container(
                                      height: media.width * 0.1,
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: (isDarkTheme == true)
                                                      ? textColor
                                                          .withOpacity(0.4)
                                                      : underline)),
                                          color: page),
                                      child: Row(
                                        children: [
                                          if (userDetails['owner_id'] == null)
                                            for (int i = 0;
                                                i <=
                                                    userDetails['driverVehicleType']
                                                                ['data']
                                                            .length -
                                                        1;
                                                i++)
                                              MyText(
                                                text:
                                                    '${userDetails['driverVehicleType']['data'][i]['vehicletype_name']},',
                                                size: media.width * fourteen,
                                                color: textColor,
                                              ),
                                          if (userDetails['owner_id'] != null)
                                            MyText(
                                              text: userDetails[
                                                  'vehicle_type_name'],
                                              size: media.width * sixteen,
                                              color: textColor,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    ProfileDetails(
                                      heading: languages[choosenLanguage]
                                          ['text_make_name'],
                                      readyonly: true,
                                      value: userDetails['car_make_name'],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    ProfileDetails(
                                      heading: languages[choosenLanguage]
                                          ['text_model_name'],
                                      readyonly: true,
                                      value: userDetails['car_model_name'],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    ProfileDetails(
                                      heading: languages[choosenLanguage]
                                          ['text_license'],
                                      readyonly: true,
                                      value: userDetails['car_number'],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    ProfileDetails(
                                      heading: languages[choosenLanguage]
                                          ['text_color'],
                                      readyonly: true,
                                      value: userDetails['car_color'],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                  ],
                                )
                        ],
                      ),
                    )),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
