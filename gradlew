//FdBondPlacement

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:idirectalpha/AccountOpening_Flow/AccountOpeningWebView.dart';
import 'package:idirectalpha/AccountOpening_Flow/AccountOpening_Widgets/AccountOpening_TextStyle.dart';
import 'package:idirectalpha/AccountOpening_Flow/AccountOpening_Widgets/BottomSheet_DecorationBox.dart';
import 'package:idirectalpha/FD_BONDS/model/SchemeModel.dart';
import 'package:idirectalpha/FD_BONDS/repository/FdBondPortfolioRepository.dart';
import 'package:idirectalpha/MutualFund/mfAppBar.dart';
import 'package:idirectalpha/Portfolio/Widgets/portfolioProductDetail.dart';
import 'package:idirectalpha/Watchlist/Widgets/watchlistCheckBox.dart';
import 'package:idirectalpha/allocate_funds/allocatefund_mfscreen.dart';
import 'package:idirectalpha/login/model/common_datamodel_forlogin.dart';
import 'package:idirectalpha/order_book/screens/orderbook_n_tradebook_screen.dart';
import 'package:idirectalpha/stock_search/model/FdBondSearchModel.dart' as selectedFdData;
import 'package:idirectalpha/utils/Utils.dart';
import 'package:idirectalpha/utils/assets.dart';
import 'package:idirectalpha/utils/color_utils.dart';
import 'package:idirectalpha/utils/date_utils.dart';
import 'package:idirectalpha/utils/textStyleFile.dart';
import 'package:idirectalpha/widgets/custom_item_segment.dart';
import 'package:idirectalpha/widgets/dashline_Seprator.dart';
import 'package:idirectalpha/widgets/date_picker_text_field.dart';
import 'package:idirectalpha/widgets/hollow_button.dart';
import 'package:idirectalpha/widgets/input_text_field.dart';
import 'package:idirectalpha/widgets/solid_button.dart';
import 'package:idirectalpha/widgets/swipe_to_buy_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:idirectalpha/allocate_funds/AllocateFundForAllProduct.dart';

import 'FdOrderConfirmationPage.dart';
import 'JointHolderWidget.dart';
import 'PlacementSchemeWidget.dart';
import 'bloc/FdBondPortfolioBloc.dart';
import 'bloc/FdBondPortfolioEvent.dart';
import 'bloc/FdBondPortfolioState.dart';
import 'fdValidationMsg.dart';
import 'package:idirectalpha/login/model/clientdetail_matchid_model.dart';


class FdBondPlacement extends StatefulWidget {
  FdBondPlacement(this.fdDetail);
  selectedFdData.Success fdDetail;

  @override
  State<StatefulWidget> createState() => FdBondPlacementState1();

}


class FdBondPlacementState1 extends State<FdBondPlacement> {
  bool checkBox = false;
  bool shareHolder = false;
  bool dpIdEnabled = true;
  bool tnc = false;

  TextEditingController  investmentCtrl ;

  String nomineeFlag="N",tdsExemption="N",seniorCitizen="N", shareHolderType = "NSDL";
  String url;

  var dpId, dpAccount;

  final loginModel = CommonLoginDataModel.loginModel;

  PlacementSchemeWidget schemeObj  ;
  BuildContext contextt;


  //TextEditingController firstNameCtrl,midNameCtrl,lastName,dobCtrl,relationshipCtrl,addressLineCtrl1,addressLineCtrl2,addressLineCtrl3,cityCtrl,pinCtrl;

  String limit;
  bool nomineeSubmitted = false;

  TextEditingController dpIdController = TextEditingController();
  TextEditingController dpAccountController = TextEditingController();
  TextEditingController firstNameCtrl = TextEditingController();
  TextEditingController midNameCtrl = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dobCtrl = TextEditingController();
  TextEditingController relationshipCtrl = TextEditingController();
  TextEditingController addressLineCtrl1 = TextEditingController();
  TextEditingController addressLineCtrl2 = TextEditingController();
  TextEditingController addressLineCtrl3 = TextEditingController();
  TextEditingController cityCtrl = TextEditingController();
  TextEditingController pinCtrl = TextEditingController();

  String allocatedMultipleOfFunds="",allocatedMaxLimit="";

  bool showHolders=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    investmentCtrl = new TextEditingController();

    schemeObj = PlacementSchemeWidget(widget.fdDetail);

    contextt=context;
    url="http://103.87.40.246/apiuser/frmtncfd?FML_STTLMNT_NO=${widget.fdDetail.sTTLMNTNO}&FML_NHL_HD_LNS=${widget.fdDetail.nHLHDLNS}&FML_USR_ADDRSS_LN1=${widget.fdDetail.uSRANSWR1}&FML_NN_CORP_ACT_IND=${widget.fdDetail.nNCORPACTIND}&FML_XCHNGSEC_GRP=${widget.fdDetail.xCHNGSECGRP}&FML_CAPITAL_VAL=${widget.fdDetail.cAPITALVAL}&FML_INDINFO_VAL=${widget.fdDetail.iNDINFOVAL}&"
        "FML_O_BRK_CD=${widget.fdDetail.oBRKCD}&FML_BARRA_VAL=${widget.fdDetail.bARRAVAL}&FML_SYS_MSG=${widget.fdDetail.sYSMSG}&strFML_O_CLN_ID=${widget.fdDetail.oCLNID}&FML_MDC_MAINCODE=${widget.fdDetail.mDCMAINCODE}&FML_IDD_TM=${widget.fdDetail.iDDTM}&FML_USR_ANSWR2=${widget.fdDetail.uSRANSWR2}&FML_USR_ANSWR1=${widget.fdDetail.uSRANSWR1}&FML_USR_QSTN2=${widget.fdDetail.uSRQSTN2}&FML_USR_QSTN1=${widget.fdDetail.uSRQST