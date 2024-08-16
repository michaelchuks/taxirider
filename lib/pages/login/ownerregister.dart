import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/login/login.dart';
import 'package:image_picker/image_picker.dart';

import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../noInternet/nointernet.dart';
import 'carinformation.dart';
import 'requiredinformation.dart';

class OwnersRegister extends StatefulWidget {
  const OwnersRegister({Key? key}) : super(key: key);

  @override
  State<OwnersRegister> createState() => _OwnersRegisterState();
}

String ownerName = ''; //name of user
String ownerEmail = ''; // email of user
String companyName = '';
String companyAddress = '';
String city = '';
String postalCode = '';
String taxNumber = '';
String ownerServiceLocation = '';

class _OwnersRegisterState extends State<OwnersRegister> {
  bool chooseWorkArea = false;

  bool _loading = true;
  // ignore: unused_field, prefer_final_fields
  bool _chooseLocation = false;
  var verifyEmailError = '';
  var error = '';
  ImagePicker picker = ImagePicker();

  TextEditingController emailText =
      TextEditingController(); //email textediting controller
  TextEditingController nameText =
      TextEditingController(); //name textediting controller
  TextEditingController companyText =
      TextEditingController(); //name textediting controller
  TextEditingController addressText =
      TextEditingController(); //name textediting controller
  TextEditingController cityText =
      TextEditingController(); //name textediting controller
  TextEditingController postalText =
      TextEditingController(); //name textediting controller
  TextEditingController taxText =
      TextEditingController(); //name textediting controller

  getLocations() async {
    myServiceId = '';
    var result = await getServiceLocation();
    if (result == 'success') {
      setState(() {
        _loading = false;
      });
    } else {
      setState(() {
        _loading = true;
      });
    }
  }

  @override
  void initState() {
    proImageFile1 = null;
    getLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: Directionality(
        textDirection: (languageDirection == 'rtl')
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: media.width * 0.08,
                    right: media.width * 0.08,
                    top:
                        media.width * 0.05 + MediaQuery.of(context).padding.top,
                    bottom: media.width * 0.05),
                height: media.height * 1,
                width: media.width * 1,
                color: page,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: media.width * 0.05),
                          width: media.width * 1,
                          alignment: Alignment.center,
                          child: MyText(
                              text: languages[choosenLanguage]['text_reqinfo'],
                              size: media.width * sixteen),
                        ),
                        if (userDetails.isEmpty)
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: textColor,
                                    )),
                              ],
                            ),
                          ),
                      ],
                    ),
                    Expanded(
                        child: Scaffold(
                      backgroundColor: page,
                      body: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: media.height * 0.04,
                            ),
                            SizedBox(
                              width: media.width * 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  MyText(
                                    text: languages[choosenLanguage]
                                        ['text_company_info'],
                                    size: media.width * fourteen,
                                    fontweight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            if (enabledModule == 'both')
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
                                                child: (transportType == 'taxi')
                                                    ? Center(
                                                        child: Icon(
                                                        Icons.done,
                                                        color: textColor,
                                                        size:
                                                            media.width * 0.04,
                                                      ))
                                                    : Container(),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.15,
                                                child: MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_taxi_'],
                                                  size: media.width * fourteen,
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
                                        width: media.width * 0.26,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              transportType = 'delivery';
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
                                                        size:
                                                            media.width * 0.04,
                                                      ))
                                                    : Container(),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.18,
                                                child: MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_delivery'],
                                                  size: media.width * fourteen,
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
                                                child: (transportType == 'both')
                                                    ? Center(
                                                        child: Icon(
                                                        Icons.done,
                                                        color: textColor,
                                                        size:
                                                            media.width * 0.04,
                                                      ))
                                                    : Container(),
                                              ),
                                              SizedBox(
                                                width: media.width * 0.025,
                                              ),
                                              SizedBox(
                                                width: media.width * 0.15,
                                                child: MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_both'],
                                                  size: media.width * fourteen,
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
                                    height: media.width * 0.02,
                                  )
                                ],
                              ),
                            SizedBox(
                              height: media.width * 0.04,
                            ),
                            MyText(
                              text: languages[choosenLanguage]
                                  ['text_service_location'],
                              size: media.width * sixteen,
                              fontweight: FontWeight.w600,
                            ),
                            SizedBox(
                              height: media.width * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                if (transportType != '') {
                                  setState(() {
                                    if (chooseWorkArea == true) {
                                      chooseWorkArea = false;
                                    } else {
                                      chooseWorkArea = true;
                                    }
                                  });
                                }

                                await getServiceLocation();
                                setState(() {});
                              },
                              child: Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                  color: (transportType == '')
                                      ? hintColor.withOpacity(0.3)
                                      : page,
                                  borderRadius:
                                      BorderRadius.circular(media.width * 0.02),
                                  border: Border.all(color: textColor),
                                ),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.05,
                                    right: media.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: media.width * 0.66,
                                        child: MyText(
                                          text: (myServiceId != null &&
                                                  myServiceId == '')
                                              ? languages[choosenLanguage]
                                                      ['text_service_loc']
                                                  .toString()
                                              : (myServiceId != null &&
                                                      myServiceId != '')
                                                  ? serviceLocations.isNotEmpty
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
                                          size: (myServiceId != null &&
                                                  myServiceId != '')
                                              ? media.width * sixteen
                                              : media.width * fourteen,
                                        )),
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
                            ),
                            SizedBox(
                              height: media.width * 0.02,
                            ),
                            if (chooseWorkArea == true &&
                                serviceLocations.isNotEmpty)
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: media.width * 0.03),
                                width: media.width * 0.9,
                                // height: media.width * 0.5,
                                padding: EdgeInsets.all(media.width * 0.03),
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(media.width * 0.02),
                                  border: Border.all(color: textColor),
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: Column(
                                    children: serviceLocations
                                        .asMap()
                                        .map((i, value) {
                                          return MapEntry(
                                              i,
                                              InkWell(
                                                onTap: () async {
                                                  setState(() {
                                                    myServiceId =
                                                        serviceLocations[i]
                                                            ['id'];
                                                    chooseWorkArea = false;
                                                  });

                                                  setState(() {});
                                                },
                                                child: Container(
                                                    width: media.width * 0.8,
                                                    padding: EdgeInsets.only(
                                                        top:
                                                            media.width * 0.025,
                                                        bottom: media.width *
                                                            0.025),
                                                    child: MyText(
                                                      text: serviceLocations[i]
                                                          ['name'],
                                                      size: media.width *
                                                          fourteen,
                                                      fontweight:
                                                          FontWeight.w600,
                                                    )),
                                              ));
                                        })
                                        .values
                                        .toList(),
                                  ),
                                ),
                              ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.02),
                                    border: Border.all(color: textColor),
                                    color: page),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: MyTextField(
                                  textController: companyText,
                                  hinttext: languages[choosenLanguage]
                                      ['text_company_name'],
                                  onTap: (val) {
                                    companyName = companyText.text;
                                  },
                                )),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Container(
                              height: media.width * 0.13,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(media.width * 0.02),
                                  border: Border.all(color: textColor),
                                  color: page),
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: MyTextField(
                                textController: addressText,
                                hinttext: languages[choosenLanguage]
                                    ['text_address'],
                                onTap: (val) {
                                  companyAddress = addressText.text;
                                },
                              ),
                            ),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.02),
                                    border: Border.all(color: textColor),
                                    color: page),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: MyTextField(
                                  textController: cityText,
                                  hinttext: languages[choosenLanguage]
                                      ['text_city'],
                                  onTap: (val) {
                                    city = cityText.text;
                                  },
                                )),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.02),
                                    border: Border.all(color: textColor),
                                    color: page),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: MyTextField(
                                  textController: postalText,
                                  hinttext: languages[choosenLanguage]
                                      ['text_postal_code'],
                                  inputType: TextInputType.number,
                                  onTap: (val) {
                                    postalCode = postalText.text;
                                  },
                                )),
                            SizedBox(
                              height: media.height * 0.02,
                            ),
                            Container(
                                height: media.width * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        media.width * 0.02),
                                    border: Border.all(color: textColor),
                                    color: page),
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: MyTextField(
                                  textController: taxText,
                                  hinttext: languages[choosenLanguage]
                                      ['text_tax_number'],
                                  onTap: (val) {
                                    taxNumber = taxText.text;
                                  },
                                )),
                            SizedBox(
                              height: media.height * 0.012,
                            ),
                            SizedBox(
                              height: media.height * 0.065,
                            ),
                          ],
                        ),
                      ),
                    )),
                    (error != '')
                        ? Container(
                            margin: EdgeInsets.only(
                                top: media.height * 0.03,
                                bottom: media.height * 0.03),
                            alignment: Alignment.center,
                            width: media.width * 0.8,
                            child: MyText(
                              text: error,
                              size: media.width * sixteen,
                              color: Colors.red,
                            ),
                          )
                        : Container(),
                    (companyText.text.isNotEmpty &&
                            addressText.text.isNotEmpty &&
                            cityText.text.isNotEmpty &&
                            postalText.text.isNotEmpty &&
                            taxText.text.isNotEmpty &&
                            transportType != '')
                        ? Container(
                            width: media.width * 1,
                            alignment: Alignment.center,
                            child: Button(
                                onTap: () async {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  setState(() {
                                    verifyEmailError = '';
                                    error = '';
                                    _loading = true;
                                  });

                                  var val = await registerOwner();
                                  if (val == 'true') {
                                    carInformationCompleted = true;
                                    // ignore: use_build_context_synchronously
                                    Navigator.pop(context, true);
                                    serviceLocations.clear();
                                  } else {
                                    error = val.toString();
                                  }

                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                text: languages[choosenLanguage]['text_next']))
                        : Container(),
                  ],
                ),
              ),

              //permission denied popup

              //internet not connected
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
              (_loading == true)
                  ? const Positioned(top: 0, child: Loading())
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
