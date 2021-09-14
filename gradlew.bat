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
