import 'package:flutter/material.dart';
import 'package:flutter_driver/pages/NavigatorPages/paymentgateways.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../functions/functions.dart';
import '../../styles/styles.dart';
import '../../translation/translation.dart';
import '../../widgets/widgets.dart';
import '../loadingPage/loading.dart';
import '../login/landingpage.dart';
import '../login/login.dart';
import '../noInternet/nointernet.dart';
import 'withdraw.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

dynamic addMoney;
TextEditingController phonenumber = TextEditingController();
TextEditingController amount = TextEditingController();
bool isLoading = true;
bool showtoast = false;

class _WalletPageState extends State<WalletPage> {
  TextEditingController addMoneyController = TextEditingController();

  bool _addPayment = false;
  bool _completed = false;
  int ischeckmoneytransfer = 0;

  @override
  void initState() {
    getWallet();
    super.initState();
  }

  getWallet() async {
    var val = await getWalletHistory();
    if (val == 'logout') {
      navigateLogout();
    }
    if (mounted) {
      if (val == 'success') {
        isLoading = false;
        _completed = true;
        valueNotifierHome.incrementNotifier();
      }
    }
  }

  showToast() {
    setState(() {
      showtoast = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showtoast = false;
      });
    });
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

  bool error = false;
  String errortext = '';
  bool ispop = false;

  //show toast for copy

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Material(
      child: ValueListenableBuilder(
          valueListenable: valueNotifierHome.value,
          builder: (context, value, child) {
            return Directionality(
              textDirection: (languageDirection == 'rtl')
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(media.width * 0.05,
                          media.width * 0.05, media.width * 0.05, 0),
                      height: media.height * 1,
                      width: media.width * 1,
                      color: page,
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).padding.top),
                          Stack(
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: media.width * 0.05),
                                width: media.width * 1,
                                alignment: Alignment.center,
                                child: MyText(
                                  text: languages[choosenLanguage]
                                      ['text_enable_wallet'],
                                  size: media.width * twenty,
                                  fontweight: FontWeight.w600,
                                ),
                              ),
                              Positioned(
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Icon(Icons.arrow_back_ios,
                                          color: textColor)))
                            ],
                          ),
                          SizedBox(
                            height: media.width * 0.05,
                          ),
                          (walletBalance.isNotEmpty)
                              ? Column(
                                  children: [
                                    Row(
                                      children: [
                                        MyText(
                                          text: languages[choosenLanguage]
                                                  ['text_availablebalance']
                                              .toString()
                                              .toUpperCase(),
                                          size: media.width * fourteen,
                                          fontweight: FontWeight.w800,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: media.width * 0.03,
                                    ),
                                    Container(
                                      height: media.width * 0.1,
                                      width: media.width * 0.9,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: MyText(
                                        text: walletBalance['currency_symbol'] +
                                            ' ' +
                                            walletBalance['wallet_balance']
                                                .toString(),
                                        size: media.width * twenty,
                                        fontweight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: media.width * 0.05,
                                    ),
                                    SizedBox(
                                        width: media.width * 0.9,
                                        child: MyText(
                                            text: languages[choosenLanguage]
                                                    ['text_latest_transitions']
                                                .toString()
                                                .toUpperCase(),
                                            size: media.width * fourteen,
                                            fontweight: FontWeight.w800)),
                                  ],
                                )
                              : Container(),
                          Expanded(
                              child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                (walletHistory.isNotEmpty)
                                    ? Column(
                                        children: walletHistory
                                            .asMap()
                                            .map((i, value) {
                                              return MapEntry(
                                                  i,
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: media.width * 0.02,
                                                        bottom:
                                                            media.width * 0.02),
                                                    width: media.width * 0.9,
                                                    padding: EdgeInsets.all(
                                                        media.width * 0.025),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: borderLines,
                                                            width: 1.2),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.grey
                                                            .withOpacity(0.1)),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height: media.width *
                                                              0.1067,
                                                          width: media.width *
                                                              0.1067,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: topBar),
                                                          alignment:
                                                              Alignment.center,
                                                          child: MyText(
                                                            text: (walletHistory[
                                                                            i][
                                                                        'is_credit'] ==
                                                                    1)
                                                                ? '+'
                                                                : '-',
                                                            size: media.width *
                                                                twentyfour,
                                                            color:
                                                                (isDarkTheme ==
                                                                        true)
                                                                    ? Colors
                                                                        .black
                                                                    : textColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: media.width *
                                                              0.025,
                                                        ),
                                                        Expanded(
                                                          flex: 5,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              MyText(
                                                                text: walletHistory[
                                                                            i][
                                                                        'remarks']
                                                                    .toString(),
                                                                size: media
                                                                        .width *
                                                                    fourteen,
                                                                maxLines: 1,
                                                                fontweight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                              SizedBox(
                                                                height: media
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              MyText(
                                                                text: walletHistory[
                                                                        i][
                                                                    'created_at'],
                                                                size: media
                                                                        .width *
                                                                    ten,
                                                                color: textColor
                                                                    .withOpacity(
                                                                        0.4),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                MyText(
                                                                  // ignore: prefer_interpolation_to_compose_strings
                                                                  text: walletBalance[
                                                                          'currency_symbol'] +
                                                                      ' ' +
                                                                      walletHistory[i]
                                                                              [
                                                                              'amount']
                                                                          .toString(),
                                                                  size: media
                                                                          .width *
                                                                      twelve,
                                                                  color: (walletHistory[i]
                                                                              [
                                                                              'is_credit'] ==
                                                                          1)
                                                                      ? online
                                                                      : verifyDeclined,
                                                                  maxLines: 1,
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    ),
                                                  ));
                                            })
                                            .values
                                            .toList(),
                                      )
                                    : (_completed == true)
                                        ? Container(
                                            height: media.width * 0.1,
                                            width: media.width * 0.9,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                            ),
                                            child: MyText(
                                              text:
                                                  '${userDetails['currency_symbol']} 0',
                                              size: media.width * twenty,
                                              fontweight: FontWeight.w600,
                                            ),
                                          )
                                        : Container(),

                                //load more button
                                (walletPages.isNotEmpty)
                                    ? (walletPages['current_page'] <
                                            walletPages['total_pages'])
                                        ? InkWell(
                                            onTap: () async {
                                              setState(() {
                                                isLoading = true;
                                              });

                                              var val = await getWalletHistoryPage(
                                                  (walletPages['current_page'] +
                                                          1)
                                                      .toString());
                                              if (val == 'logout') {
                                                navigateLogout();
                                              }

                                              setState(() {
                                                isLoading = false;
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  media.width * 0.025),
                                              margin: EdgeInsets.only(
                                                  bottom: media.width * 0.05),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: page,
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2)),
                                              child: MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_loadmore'],
                                                size: media.width * sixteen,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container()
                              ],
                            ),
                          )),
                          SizedBox(
                            height: media.width * 0.2,
                            width: media.width * 0.9,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: media.width * 0.01,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                          ['text_recharge_bal']
                                      .toString()
                                      .toUpperCase(),
                                  size: media.width * fourteen,
                                  fontweight: FontWeight.w800,
                                ),
                                SizedBox(
                                  height: media.width * 0.03,
                                ),
                                MyText(
                                  text: languages[choosenLanguage]
                                      ['text_rechage_text'],
                                  size: media.width * twelve,
                                  fontweight: FontWeight.w600,
                                  color: textColor.withOpacity(0.5),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height: media.width * 0.15,
                                width: media.width * 0.9,
                                alignment: Alignment.center,
                                color: Colors.grey.withOpacity(0.3),
                                padding: EdgeInsets.only(
                                    left: media.width * 0.02,
                                    right: media.width * 0.02),
                                // color: textColor,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const Withdraw()));
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.money,
                                                  size: media.width * 0.1,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              3)
                                                          ? buttonColor
                                                          : textColor),
                                              MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_withdraw'],
                                                  size: media.width * sixteen,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              3)
                                                          ? buttonColor
                                                          : textColor)
                                            ],
                                          ),
                                        ),
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        SizedBox(
                                          width: media.width * 0.02,
                                        ),
                                      if (userDetails[
                                              'show_bank_info_feature_on_mobile_app'] ==
                                          '1')
                                        Container(
                                          height: media.width * 0.1,
                                          width: 1,
                                          color: textColor.withOpacity(0.3),
                                        ),
                                      SizedBox(
                                        width: media.width * 0.02,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          addMoneyController.clear();
                                          addMoney = null;
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return Container(
                                                  padding:
                                                      MediaQuery.of(context)
                                                          .viewInsets,
                                                  decoration: BoxDecoration(
                                                      color: page,
                                                      borderRadius: BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  media.width *
                                                                      0.05),
                                                          topRight:
                                                              Radius.circular(
                                                                  media.width *
                                                                      0.05))),
                                                  // padding:
                                                  //     EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom),
                                                  child: Container(
                                                    padding: EdgeInsets.all(
                                                        media.width * 0.05),
                                                    child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .stretch,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: MyText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              text: (languages[
                                                                      choosenLanguage]
                                                                  [
                                                                  'text_addmoney']),
                                                              size:
                                                                  media.width *
                                                                      sixteen,
                                                              fontweight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: textColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.06,
                                                          ),
                                                          Container(
                                                            height:
                                                                media.width *
                                                                    0.128,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                              border: Border.all(
                                                                  color:
                                                                      borderLines,
                                                                  width: 1.2),
                                                            ),
                                                            child: Row(
                                                                children: [
                                                                  Container(
                                                                      width: media
                                                                              .width *
                                                                          0.1,
                                                                      height: media
                                                                              .width *
                                                                          0.128,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                              borderRadius: BorderRadius
                                                                                  .only(
                                                                                topLeft: Radius.circular(12),
                                                                                bottomLeft: Radius.circular(12),
                                                                              ),
                                                                              color: Color(
                                                                                  0xffF0F0F0)),
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      child:
                                                                          MyText(
                                                                        text: walletBalance[
                                                                            'currency_symbol'],
                                                                        size: media.width *
                                                                            twelve,
                                                                        fontweight:
                                                                            FontWeight.w600,
                                                                        color: (isDarkTheme ==
                                                                                true)
                                                                            ? Colors.black
                                                                            : textColor,
                                                                      )),
                                                                  SizedBox(
                                                                    width: media
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Container(
                                                                    height: media
                                                                            .width *
                                                                        0.128,
                                                                    width: media
                                                                            .width *
                                                                        0.6,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        TextField(
                                                                      controller:
                                                                          addMoneyController,
                                                                      onChanged:
                                                                          (val) {
                                                                        setState(
                                                                            () {
                                                                          addMoney =
                                                                              int.parse(val);
                                                                        });
                                                                      },
                                                                      keyboardType:
                                                                          TextInputType
                                                                              .number,
                                                                      decoration:
                                                                          InputDecoration(
                                                                        border:
                                                                            InputBorder.none,
                                                                        hintText:
                                                                            languages[choosenLanguage]['text_enteramount'],
                                                                        hintStyle:
                                                                            GoogleFonts.notoSans(
                                                                          fontSize:
                                                                              media.width * fourteen,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          color:
                                                                              textColor.withOpacity(0.4),
                                                                        ),
                                                                      ),
                                                                      style: GoogleFonts.notoSans(
                                                                          fontSize: media.width *
                                                                              fourteen,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              textColor),
                                                                      maxLines:
                                                                          1,
                                                                    ),
                                                                  ),
                                                                ]),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.05,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    addMoneyController
                                                                            .text =
                                                                        '100';
                                                                    addMoney =
                                                                        100;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: media
                                                                          .width *
                                                                      0.11,
                                                                  width: media
                                                                          .width *
                                                                      0.17,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              borderLines,
                                                                          width:
                                                                              1.2),
                                                                      color:
                                                                          page,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: MyText(
                                                                    text: walletBalance[
                                                                            'currency_symbol'] +
                                                                        '100',
                                                                    size: media
                                                                            .width *
                                                                        twelve,
                                                                    fontweight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    addMoneyController
                                                                            .text =
                                                                        '500';
                                                                    addMoney =
                                                                        500;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: media
                                                                          .width *
                                                                      0.11,
                                                                  width: media
                                                                          .width *
                                                                      0.17,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              borderLines,
                                                                          width:
                                                                              1.2),
                                                                      color:
                                                                          page,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: MyText(
                                                                    text: walletBalance[
                                                                            'currency_symbol'] +
                                                                        '500',
                                                                    size: media
                                                                            .width *
                                                                        twelve,
                                                                    fontweight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: media
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    addMoneyController
                                                                            .text =
                                                                        '1000';
                                                                    addMoney =
                                                                        1000;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                  height: media
                                                                          .width *
                                                                      0.11,
                                                                  width: media
                                                                          .width *
                                                                      0.17,
                                                                  decoration: BoxDecoration(
                                                                      border: Border.all(
                                                                          color:
                                                                              borderLines,
                                                                          width:
                                                                              1.2),
                                                                      color:
                                                                          page,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6)),
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: MyText(
                                                                    text: walletBalance[
                                                                            'currency_symbol'] +
                                                                        '1000',
                                                                    size: media
                                                                            .width *
                                                                        twelve,
                                                                    fontweight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.1,
                                                          ),
                                                          Button(
                                                            onTap: () async {
                                                              // print(addMoney);
                                                              FocusManager
                                                                  .instance
                                                                  .primaryFocus
                                                                  ?.unfocus();
                                                              if (addMoney !=
                                                                      0 &&
                                                                  addMoney !=
                                                                      null) {
                                                                Navigator.pop(
                                                                    context);
                                                                showModalBottomSheet(
                                                                    context:
                                                                        context,
                                                                    isScrollControlled:
                                                                        true,
                                                                    builder:
                                                                        (context) {
                                                                      return Container(
                                                                        padding:
                                                                            EdgeInsets.all(media.width *
                                                                                0.05),
                                                                        height:
                                                                            media.width *
                                                                                1,
                                                                        width:
                                                                            media.width *
                                                                                1,
                                                                        child:
                                                                            SingleChildScrollView(
                                                                          child:
                                                                              Column(
                                                                            children: paymentGateways
                                                                                .map((i, value) {
                                                                                  return MapEntry(
                                                                                      i,
                                                                                      (paymentGateways[i]['enabled'] == true)
                                                                                          ? InkWell(
                                                                                              onTap: () async {
                                                                                                Navigator.pop(context);
                                                                                                var val = await Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentGateWaysPage(url: paymentGateways[i]['url'])));
                                                                                                if (val != null) {
                                                                                                  if (val) {
                                                                                                    setState(() {
                                                                                                      isLoading = true;

                                                                                                      addMoney = null;
                                                                                                    });
                                                                                                    await getWallet();
                                                                                                  }
                                                                                                }
                                                                                              },
                                                                                              child: Container(
                                                                                                height: media.width * 0.15,
                                                                                                width: media.width * 0.6,
                                                                                                margin: EdgeInsets.only(bottom: media.width * 0.02),
                                                                                                decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(paymentGateways[i]['image']))),
                                                                                              ),
                                                                                            )
                                                                                          : Container());
                                                                                })
                                                                                .values
                                                                                .toList(),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                              }
                                                            },
                                                            text: languages[
                                                                    choosenLanguage]
                                                                [
                                                                'text_addmoney'],
                                                            width: media.width *
                                                                0.4,
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                media.width *
                                                                    0.02,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                addMoney = null;
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                                addMoneyController
                                                                    .clear();
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .all(media
                                                                          .width *
                                                                      0.02),
                                                              child: MyText(
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                text: languages[
                                                                        choosenLanguage]
                                                                    [
                                                                    'text_cancel'],
                                                                size: media
                                                                        .width *
                                                                    sixteen,
                                                                color:
                                                                    verifyDeclined,
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
                                                  ),
                                                );
                                              });
                                          // setState(() {
                                          //   _addPayment = true;
                                          // });
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.credit_card,
                                              size: media.width * 0.1,
                                              color: (ischeckmoneytransfer == 1)
                                                  ? buttonColor
                                                  : textColor,
                                            ),
                                            MyText(
                                                text: languages[choosenLanguage]
                                                    ['text_addmoney'],
                                                size: media.width * sixteen,
                                                color:
                                                    (ischeckmoneytransfer == 1)
                                                        ? buttonColor
                                                        : textColor)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: media.width * 0.02,
                                      ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        Container(
                                          height: media.width * 0.1,
                                          width: 1,
                                          color: textColor.withOpacity(0.3),
                                        ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        SizedBox(
                                          width: media.width * 0.02,
                                        ),
                                      if (userDetails[
                                              'shoW_wallet_money_transfer_feature_on_mobile_app'] ==
                                          '1')
                                        InkWell(
                                          onTap: () {
                                            // setState(() {
                                            //   ispop = true;
                                            // });
                                            amount.clear();
                                            phonenumber.clear();
                                            errortext = '';
                                            error = false;
                                            showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                backgroundColor: page,
                                                builder: (context) {
                                                  return const MonetTransferBottomSheet();
                                                });
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.swap_horiz_outlined,
                                                  size: media.width * 0.1,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              2)
                                                          ? buttonColor
                                                          : textColor),
                                              MyText(
                                                  text:
                                                      languages[choosenLanguage]
                                                          ['text_credit_trans'],
                                                  size: media.width * sixteen,
                                                  color:
                                                      (ischeckmoneytransfer ==
                                                              2)
                                                          ? buttonColor
                                                          : textColor)
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: media.width * 0.05,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    //add payment
                    (_addPayment == true)
                        ? Positioned(
                            bottom: 0,
                            child: Container(
                              height: media.height * 1,
                              width: media.width * 1,
                              color: Colors.transparent.withOpacity(0.6),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        bottom: media.width * 0.05),
                                    width: media.width * 0.9,
                                    padding:
                                        EdgeInsets.all(media.width * 0.025),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            color: borderLines, width: 1.2),
                                        color: page),
                                    child: Column(children: [
                                      Container(
                                        height: media.width * 0.128,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: borderLines, width: 1.2),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                width: media.width * 0.1,
                                                height: media.width * 0.128,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(12),
                                                      bottomLeft:
                                                          Radius.circular(12),
                                                    ),
                                                    color: Color(0xffF0F0F0)),
                                                alignment: Alignment.center,
                                                child: MyText(
                                                  text: walletBalance[
                                                      'currency_symbol'],
                                                  size: media.width * twelve,
                                                  fontweight: FontWeight.w600,
                                                  color: (isDarkTheme == true)
                                                      ? Colors.black
                                                      : textColor,
                                                )),
                                            SizedBox(
                                              width: media.width * 0.05,
                                            ),
                                            Container(
                                                height: media.width * 0.128,
                                                width: media.width * 0.6,
                                                alignment: Alignment.center,
                                                child: MyTextField(
                                                  textController:
                                                      addMoneyController,
                                                  hinttext:
                                                      languages[choosenLanguage]
                                                          ['text_enteramount'],
                                                  onTap: (val) {
                                                    setState(() {
                                                      addMoney = int.parse(val);
                                                    });
                                                  },
                                                  maxline: 1,
                                                ))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: media.width * 0.05,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '100';
                                                addMoney = 100;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '100',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text = '500';
                                                addMoney = 500;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '500',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: media.width * 0.05,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                addMoneyController.text =
                                                    '1000';
                                                addMoney = 1000;
                                              });
                                            },
                                            child: Container(
                                              height: media.width * 0.11,
                                              width: media.width * 0.17,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: borderLines,
                                                      width: 1.2),
                                                  color: page,
                                                  borderRadius:
                                                      BorderRadius.circular(6)),
                                              alignment: Alignment.center,
                                              child: MyText(
                                                text: walletBalance[
                                                        'currency_symbol'] +
                                                    '1000',
                                                size: media.width * twelve,
                                                fontweight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: media.width * 0.1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Button(
                                            onTap: () async {
                                              setState(() {
                                                _addPayment = false;
                                                addMoney = null;
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                addMoneyController.clear();
                                              });
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_cancel'],
                                            width: media.width * 0.4,
                                          ),
                                          Button(
                                            onTap: () async {
                                              // print(addMoney);
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                              if (addMoney != 0 &&
                                                  addMoney != null) {
                                                setState(() {
                                                  _addPayment = false;
                                                });
                                              }
                                            },
                                            text: languages[choosenLanguage]
                                                ['text_addmoney'],
                                            width: media.width * 0.4,
                                          ),
                                        ],
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ))
                        : Container(),

                    //loader
                    (isLoading)
                        ? const Positioned(top: 0, child: Loading())
                        : Container(),
                    (showtoast == true)
                        ? PaymentSuccess(
                            onTap: () async {
                              setState(() {
                                showtoast = false;
                                // Navigator.pop(context, true);
                              });
                            },
                            transfer: true,
                          )
                        : Container(),
                    (internet == false)
                        ? Positioned(
                            top: 0,
                            child: NoInternet(
                              onTap: () {
                                setState(() {
                                  internetTrue();
                                  // _complete = false;
                                  isLoading = true;
                                  getWallet();
                                });
                              },
                            ))
                        : Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class MonetTransferBottomSheet extends StatefulWidget {
  const MonetTransferBottomSheet({super.key});

  @override
  State<MonetTransferBottomSheet> createState() =>
      _MonetTransferBottomSheetState();
}

class _MonetTransferBottomSheetState extends State<MonetTransferBottomSheet> {
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(value: "user", child: Text("User")),
      DropdownMenuItem(value: "driver", child: Text("Driver")),
    ];
    return menuItems;
  }

  String dropdownValue = 'user';
  bool error = false;
  String errortext = '';

  @override
  void initState() {
    setState(() {
      amount.text = '';
      phonenumber.text = '';
      dropdownValue = 'user';
    });
    super.initState();
  }

  getWallet() async {
    var val = await getWalletHistory();
    await getCountryCode();
    if (val == 'success') {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(media.width * 0.05),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(mainAxisSize: MainAxisSize.min, children: [
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    filled: false,
                    fillColor: page,
                  ),
                  dropdownColor: page,
                  value: dropdownValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: dropdownItems,
                  style: GoogleFonts.notoSans(
                    fontSize: media.width * sixteen,
                    color: textColor,
                  ),
                ),
                TextFormField(
                  controller: amount,
                  style: GoogleFonts.notoSans(
                    fontSize: media.width * sixteen,
                    color: textColor,
                    letterSpacing: 1,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: languages[choosenLanguage]['text_enteramount'],
                    counterText: '',
                    hintStyle: GoogleFonts.notoSans(
                      fontSize: media.width * sixteen,
                      color: textColor.withOpacity(0.7),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.2)
                          : inputfocusedUnderline,
                      width: 1.2,
                      style: BorderStyle.solid,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.1)
                          : inputUnderline,
                      width: 1.2,
                      style: BorderStyle.solid,
                    )),
                  ),
                ),
                TextFormField(
                  controller: phonenumber,
                  onChanged: (val) {},
                  style: GoogleFonts.notoSans(
                    fontSize: media.width * sixteen,
                    color: textColor,
                    letterSpacing: 1,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: languages[choosenLanguage]['text_phone_number'],
                    counterText: '',
                    hintStyle: GoogleFonts.notoSans(
                      fontSize: media.width * sixteen,
                      color: textColor.withOpacity(0.7),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.2)
                          : inputfocusedUnderline,
                      width: 1.2,
                      style: BorderStyle.solid,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: (isDarkTheme == true)
                          ? textColor.withOpacity(0.1)
                          : inputUnderline,
                      width: 1.2,
                      style: BorderStyle.solid,
                    )),
                  ),
                ),
                SizedBox(
                  height: media.width * 0.05,
                ),
                (error == true)
                    ? Text(
                        errortext,
                        style: const TextStyle(color: Colors.red),
                      )
                    : Container(),
                SizedBox(
                  height: media.width * 0.05,
                ),
                (isLoading == false)
                    ? Button(
                        onTap: () async {
                          // Navigator.pop(context);
                          setState(() {
                            isLoading = true;
                          });
                          if (phonenumber.text == '' || amount.text == '') {
                            setState(() {
                              error = true;
                              errortext = languages[choosenLanguage]
                                  ['text_fill_fileds'];
                              isLoading = false;
                            });
                          } else {
                            // Navigator.pop(context);
                            var result = await sharewalletfun(
                                amount: amount.text,
                                mobile: phonenumber.text,
                                role: dropdownValue);
                            if (result == 'success') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              setState(() {
                                dropdownValue = 'user';
                                error = false;
                                errortext = '';

                                getWallet();
                                showtoast = true;
                              });
                            } else {
                              setState(() {
                                error = true;
                                errortext = result.toString();
                                isLoading = false;
                              });
                            }
                          }
                        },
                        text: languages[choosenLanguage]['text_credit_trans'],
                        width: media.width * 0.9,
                      )
                    : Container(
                        height: media.width * 0.12,
                        width: media.width * 0.9,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                                BorderRadius.circular(media.width * 0.02)),
                        child: SizedBox(
                          height: media.width * 0.06,
                          width: media.width * 0.07,
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      ),
                SizedBox(
                  height: media.width * 0.02,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(media.width * 0.02),
                    child: MyText(
                      textAlign: TextAlign.center,
                      text: languages[choosenLanguage]['text_cancel'],
                      size: media.width * sixteen,
                      color: verifyDeclined,
                    ),
                  ),
                ),
              ]),
            ]),
      ),
    );
  }
}
