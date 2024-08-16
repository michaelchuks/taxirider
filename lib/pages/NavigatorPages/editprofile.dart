import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/carinfopage.dart';
import 'package:flutter_driver/pages/login/landingpage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../login/login.dart';
import '../login/uploaddocument.dart';
import '../noInternet/nointernet.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

dynamic profileImageFile;

class _EditProfileState extends State<EditProfile> {
  ImagePicker picker = ImagePicker();
  bool _isLoading = false;
  String _error = '';
  bool _pickImage = false;
  String _permission = '';
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobilenum = TextEditingController();

//get gallery permission
  getGalleryPermission() async {
    dynamic status;
    if (platform == TargetPlatform.android) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        status = await Permission.storage.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.storage.request();
        }

        /// use [Permissions.storage.status]
      } else {
        status = await Permission.photos.status;
        if (status != PermissionStatus.granted) {
          status = await Permission.photos.request();
        }
      }
    } else {
      status = await Permission.photos.status;
      if (status != PermissionStatus.granted) {
        status = await Permission.photos.request();
      }
    }
    return status;
  }

  bool isEdit = false;

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

//get camera permission
  getCameraPermission() async {
    var status = await Permission.camera.status;
    if (status != PermissionStatus.granted) {
      status = await Permission.camera.request();
    }
    return status;
  }

//pick image from gallery
  pickImageFromGallery() async {
    var permission = await getGalleryPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        profileImageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noPhotos';
      });
    }
  }

//pick image from camera
  pickImageFromCamera() async {
    var permission = await getCameraPermission();
    if (permission == PermissionStatus.granted) {
      final pickedFile =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      setState(() {
        profileImageFile = pickedFile?.path;
        _pickImage = false;
      });
    } else {
      setState(() {
        _permission = 'noCamera';
      });
    }
  }

  @override
  void initState() {
    _error = '';
    profileImageFile = null;
    isEdit = false;
    name.text = userDetails['name'].toString().split(' ')[0];
    lastname.text = (userDetails['name'].toString().split(' ').length > 1)
        ? userDetails['name'].toString().split(' ')[1]
        : '';
    mobilenum.text = userDetails['mobile'];
    email.text = userDetails['email'];
    setState(() {});
    super.initState();
  }

  pop() {
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        child: Scaffold(
          backgroundColor: page,
          body: Directionality(
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
                              text: (!isEdit)
                                  ? languages[choosenLanguage]
                                      ['text_personal_info']
                                  : languages[choosenLanguage]
                                      ['text_editprofile'],
                              size: media.width * sixteen,
                              maxLines: 1,
                              fontweight: FontWeight.w600,
                            ),
                          ),
                          (isEdit)
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      isEdit = true;
                                    });
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
                        ],
                      ),
                    ),
                    SizedBox(
                      height: media.width * 0.02,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(media.width * 0.05),
                        width: media.width * 1,
                        color: page,
                        child: Column(
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(height: media.width * 0.05),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          _pickImage = true;
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          ShowUp(
                                            delay: 100,
                                            child: Container(
                                              height: media.width * 0.25,
                                              width: media.width * 0.25,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: page,
                                                  image: (profileImageFile ==
                                                          null)
                                                      ? DecorationImage(
                                                          image: NetworkImage(
                                                            userDetails[
                                                                'profile_picture'],
                                                          ),
                                                          fit: BoxFit.cover)
                                                      : DecorationImage(
                                                          image: FileImage(File(
                                                              profileImageFile)),
                                                          fit: BoxFit.cover)),
                                            ),
                                          ),
                                          if (isEdit)
                                            Positioned(
                                                right: media.width * 0.02,
                                                bottom: media.width * 0.02,
                                                child: Container(
                                                  height: media.width * 0.05,
                                                  width: media.width * 0.05,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Color(
                                                              0xff898989)),
                                                  child: Icon(
                                                    Icons.edit,
                                                    color: topBar,
                                                    size: media.width * 0.04,
                                                  ),
                                                ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.04,
                                    ),
                                    Row(
                                      children: [
                                        ProfileDetails(
                                          heading: languages[choosenLanguage]
                                              ['text_name'],
                                          controller: name,
                                          width: media.width * 0.4,
                                          readyonly: (isEdit) ? false : true,
                                        ),
                                        SizedBox(
                                          width: media.height * 0.04,
                                        ),
                                        ProfileDetails(
                                            heading: '',
                                            controller: lastname,
                                            width: media.width * 0.4,
                                            readyonly: (isEdit) ? false : true),
                                      ],
                                    ),
                                    SizedBox(
                                      height: media.height * 0.02,
                                    ),
                                    if (isEdit == false)
                                      ProfileDetails(
                                        heading: languages[choosenLanguage]
                                            ['text_mob_num'],
                                        controller: mobilenum,
                                        readyonly: true,
                                      ),
                                    SizedBox(
                                      height: media.height * 0.02,
                                    ),
                                    ProfileDetails(
                                      heading: languages[choosenLanguage]
                                          ['text_email'],
                                      controller: email,
                                      readyonly: (isEdit) ? false : true,
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    (userDetails['role'] != 'owner')
                                        ? InkWell(
                                            onTap: () async {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const CarInfoPage()));
                                            },
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: media.width * 0.05),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  media.width *
                                                                      0.6,
                                                              child: ShowUp(
                                                                delay: 200,
                                                                child: MyText(
                                                                  text: languages[
                                                                              choosenLanguage]
                                                                          [
                                                                          'text_car_info']
                                                                      .toString(),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  size: media
                                                                          .width *
                                                                      sixteen,
                                                                  fontweight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color:
                                                                      textColor,
                                                                ),
                                                              ),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios_rounded,
                                                              size:
                                                                  media.width *
                                                                      0.04,
                                                              color: textColor,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    padding: EdgeInsets.only(
                                                      top: media.width * 0.05,
                                                    ),
                                                    child: Container(
                                                      color: textColor
                                                          .withOpacity(0.1),
                                                      height: 1,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        var nav = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadDocument()));
                                        if (nav != null) {
                                          if (nav) {
                                            setState(() {});
                                          }
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            top: media.width * 0.05),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width:
                                                            media.width * 0.6,
                                                        child: ShowUp(
                                                          delay: 200,
                                                          child: MyText(
                                                            text: languages[
                                                                        choosenLanguage]
                                                                    [
                                                                    'text_docs']
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            size: media.width *
                                                                sixteen,
                                                            fontweight:
                                                                FontWeight.w500,
                                                            color: textColor,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons
                                                            .arrow_forward_ios_rounded,
                                                        size:
                                                            media.width * 0.04,
                                                        color: textColor,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            Container(
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.only(
                                                top: media.width * 0.05,
                                              ),
                                              child: Container(
                                                color:
                                                    textColor.withOpacity(0.1),
                                                height: 1,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_error != '')
                              Container(
                                padding:
                                    EdgeInsets.only(top: media.width * 0.02),
                                child: MyText(
                                  text: _error,
                                  size: media.width * twelve,
                                  color: Colors.red,
                                ),
                              ),
                            if (isEdit)
                              Button(
                                  onTap: () async {
                                    setState(() {
                                      _error = '';
                                    });
                                    String pattern =
                                        r"^[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[A-Za-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?\.)+[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])*$";
                                    var remail = email.text.replaceAll(' ', '');
                                    RegExp regex = RegExp(pattern);
                                    if (regex.hasMatch(remail)) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      // ignore: prefer_typing_uninitialized_variables
                                      var nav;
                                      if (userDetails['email'] == remail) {
                                        // print('started');
                                        nav = await updateProfile(
                                          '${name.text} ${lastname.text}',
                                          remail,
                                        );
                                        if (nav != 'success') {
                                          _error = nav.toString();
                                        } else {}
                                      } else {
                                        var result =
                                            await validateEmail(remail);
                                        if (result == 'success') {
                                          nav = await updateProfile(
                                            '${name.text} ${lastname.text}',
                                            remail,
                                            // userDetails['mobile']
                                          );
                                          if (nav != 'success') {
                                            _error = nav.toString();
                                          } else {
                                            // ignore: use_build_context_synchronously
                                            // Navigator.pop(context, true);
                                          }
                                        } else {
                                          setState(() {
                                            _error = result;
                                          });
                                        }
                                      }
                                      setState(() {
                                        _isLoading = false;
                                      });
                                    } else {
                                      setState(() {
                                        _error = languages[choosenLanguage]
                                            ['text_email_validation'];
                                      });
                                    }
                                  },
                                  text: languages[choosenLanguage]
                                      ['text_confirm']),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                //pick image popup
                (_pickImage == true)
                    ? Positioned(
                        bottom: 0,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _pickImage = false;
                            });
                          },
                          child: Container(
                            height: media.height * 1,
                            width: media.width * 1,
                            color: Colors.transparent.withOpacity(0.6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(media.width * 0.05),
                                  width: media.width * 1,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25)),
                                      border: Border.all(
                                        color: borderLines,
                                        width: 1.2,
                                      ),
                                      color: page),
                                  child: Column(
                                    children: [
                                      Container(
                                        height: media.width * 0.02,
                                        width: media.width * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              media.width * 0.01),
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  pickImageFromCamera();
                                                },
                                                child: Container(
                                                    height: media.width * 0.171,
                                                    width: media.width * 0.171,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Icon(
                                                      Icons.camera_alt_outlined,
                                                      size: media.width * 0.064,
                                                      color: textColor,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.02,
                                              ),
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_camera'],
                                                size: media.width * ten,
                                                color:
                                                    textColor.withOpacity(0.4),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  pickImageFromGallery();
                                                },
                                                child: Container(
                                                    height: media.width * 0.171,
                                                    width: media.width * 0.171,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: Icon(
                                                      Icons.image_outlined,
                                                      size: media.width * 0.064,
                                                      color: textColor,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.02,
                                              ),
                                              MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_gallery'],
                                                size: media.width * ten,
                                                color:
                                                    textColor.withOpacity(0.4),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    : Container(),

                //permission denied popup
                (_permission != '')
                    ? Positioned(
                        child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: media.width * 0.9,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _permission = '';
                                        _pickImage = false;
                                      });
                                    },
                                    child: Container(
                                      height: media.width * 0.1,
                                      width: media.width * 0.1,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: page),
                                      child: Icon(Icons.cancel_outlined,
                                          color: textColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: media.width * 0.05,
                            ),
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: page,
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2.0,
                                        spreadRadius: 2.0,
                                        color: Colors.black.withOpacity(0.2))
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                      width: media.width * 0.8,
                                      child: MyText(
                                        text: (_permission == 'noPhotos')
                                            ? languages[choosenLanguage]
                                                ['text_open_photos_setting']
                                            : languages[choosenLanguage]
                                                ['text_open_camera_setting'],
                                        size: media.width * sixteen,
                                        fontweight: FontWeight.w600,
                                      )),
                                  SizedBox(height: media.width * 0.05),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                          onTap: () async {
                                            await openAppSettings();
                                          },
                                          child: MyText(
                                            text: languages[choosenLanguage]
                                                ['text_open_settings'],
                                            size: media.width * sixteen,
                                            fontweight: FontWeight.w600,
                                            color: buttonColor,
                                          )),
                                      InkWell(
                                          onTap: () async {
                                            (_permission == 'noCamera')
                                                ? pickImageFromCamera()
                                                : pickImageFromGallery();
                                            setState(() {
                                              _permission = '';
                                            });
                                          },
                                          child: MyText(
                                            text: languages[choosenLanguage]
                                                ['text_done'],
                                            size: media.width * sixteen,
                                            fontweight: FontWeight.w600,
                                            color: buttonColor,
                                          ))
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                    : Container(),
                //loader
                (_isLoading == true)
                    ? const Positioned(top: 0, child: Loading())
                    : Container(),

                //error
                (_error != '')
                    ? Positioned(
                        child: Container(
                        height: media.height * 1,
                        width: media.width * 1,
                        color: Colors.transparent.withOpacity(0.6),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(media.width * 0.05),
                              width: media.width * 0.9,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: page),
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: media.width * 0.8,
                                    child: MyText(
                                      text: _error.toString(),
                                      textAlign: TextAlign.center,
                                      size: media.width * sixteen,
                                      fontweight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Button(
                                      onTap: () async {
                                        setState(() {
                                          _error = '';
                                        });
                                      },
                                      text: languages[choosenLanguage]
                                          ['text_ok'])
                                ],
                              ),
                            )
                          ],
                        ),
                      ))
                    : Container(),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
