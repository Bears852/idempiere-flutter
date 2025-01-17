// ignore_for_file: unused_element

library dashboard;

//import 'dart:convert';
import 'dart:convert';
import 'dart:developer';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idempiere_app/Screens/app/constans/app_constants.dart';
import 'package:idempiere_app/Screens/app/features/Portal_Mp_Anomaly/models/lit_nc_json.dart';
import 'package:idempiere_app/Screens/app/shared_components/chatting_card.dart';
import 'package:idempiere_app/Screens/app/shared_components/list_profil_image.dart';
import 'package:idempiere_app/Screens/app/shared_components/progress_card.dart';
import 'package:idempiere_app/Screens/app/shared_components/progress_report_card.dart';
import 'package:idempiere_app/Screens/app/shared_components/project_card.dart';
import 'package:idempiere_app/Screens/app/shared_components/responsive_builder.dart';
import 'package:idempiere_app/Screens/app/shared_components/search_field.dart';
import 'package:idempiere_app/Screens/app/shared_components/selection_button.dart';
import 'package:idempiere_app/Screens/app/shared_components/task_card.dart';
import 'package:idempiere_app/Screens/app/shared_components/today_text.dart';
import 'package:idempiere_app/Screens/app/utils/helpers/app_helpers.dart';
//import 'package:idempiere_app/Screens/app/constans/app_constants.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kDebugMode, kIsWeb;

//model for sales_order_controller
import 'package:idempiere_app/Screens/app/features/Calendar/models/type_json.dart';

// binding
part '../../bindings/portal_mp_anomaly_binding.dart';

// controller
part '../../controllers/portal_mp_anomaly_controller.dart';

// models
part '../../models/profile.dart';

// component
//part '../components/active_project_card.dart';
part '../components/header.dart';
//part '../components/overview_header.dart';
part '../components/profile_tile.dart';
part '../components/recent_messages.dart';
part '../components/sidebar.dart';
part '../components/team_member.dart';

class PortalMpAnomalyScreen extends GetView<PortalMpAnomalyController> {
  const PortalMpAnomalyScreen({Key? key}) : super(key: key);

  completeOrder(int index) async {
    Get.back();
    final ip = GetStorage().read('ip');
    String authorization = 'Bearer ${GetStorage().read('token')}';
    final msg = jsonEncode({
      "record-id": controller.trx.records![index].id,
    });
    final protocol = GetStorage().read('protocol');
    var url = Uri.parse('$protocol://$ip/api/v1/processes/c-order-process');

    var response = await http.post(
      url,
      body: msg,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': authorization,
      },
    );
    if (response.statusCode == 200) {
      controller.getAnomalies();
      //print("done!");

      Get.snackbar(
        "Done!".tr,
        "Record has been completed".tr,
        icon: const Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
    } else {
      //print(response.body);
      Get.snackbar(
        "Error!".tr,
        "Record not completed".tr,
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.offNamed('/Dashboard');
        return false;
      },
      child: Scaffold(
        //key: controller.scaffoldKey,
        drawer: /* (ResponsiveBuilder.isDesktop(context))
            ? null
            : */
            Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: kSpacing),
            child: _Sidebar(data: controller.getSelectedProject()),
          ),
        ),
        body: SingleChildScrollView(
          child: ResponsiveBuilder(
            mobileBuilder: (context, constraints) {
              return Column(children: [
                const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                _buildHeader(
                    onPressedMenu: () => Scaffold.of(context).openDrawer()),
                const SizedBox(height: kSpacing / 2),
                const Divider(),
                _buildProfile(data: controller.getProfil()),
                const SizedBox(height: kSpacing),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Obx(() => controller.dataAvailable
                          ? Text("ANOMALIES: ".tr +
                              controller.trx.rowcount.toString())
                          : Text("ANOMALIES: ".tr)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () {
                          controller.getAnomalies();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => TextButton(
                          onPressed: () {
                            controller.changeFilter();
                            //print("hello");
                          },
                          child: Text(controller.value.value),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.all(10),
                      //width: 20,
                      /* decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      child: Obx(
                        () => DropdownButton(
                          icon: const Icon(Icons.filter_alt_sharp),
                          value: controller.dropdownValue.value,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            controller.dropdownValue.value = newValue!;

                            //print(dropdownValue);
                          },
                          items: controller.dropDownList.map((list) {
                            return DropdownMenuItem<String>(
                              value: list.id,
                              child: Text(
                                list.name.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: controller.searchFieldController,
                          onSubmitted: (String? value) {
                            controller.searchFilterValue.value =
                                controller.searchFieldController.text;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_outlined),
                            border: const OutlineInputBorder(),
                            //labelText: 'Product Value',
                            hintText: 'Search'.tr,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing),
                Obx(
                  () => controller.dataAvailable
                      ? ListView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.trx.rowcount,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => Visibility(
                                  visible: controller.searchFilterValue.value ==
                                          ""
                                      ? true
                                      : controller.dropdownValue.value == "1"
                                          ? controller
                                              .trx.records![index].ncDescription
                                              .toString()
                                              .toLowerCase()
                                              .contains(controller
                                                  .searchFilterValue.value
                                                  .toLowerCase())
                                          : controller.dropdownValue.value ==
                                                  "2"
                                              ? (controller.trx.records![index]
                                                          .name ??
                                                      "")
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(controller
                                                      .searchFilterValue.value
                                                      .toLowerCase())
                                              : true,
                                  child: Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(64, 75, 96, .9)),
                                      child: ExpansionTile(
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.article,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            /* Get.toNamed('/SalesOrderLine',
                                            arguments: {
                                              "id": controller
                                                  .trx.records![index].id,
                                              "bPartner": controller
                                                  .trx
                                                  .records![index]
                                                  .cBPartnerID
                                                  ?.identifier,
                                              "docNo": controller
                                                  .trx.records![index].documentNo,
                                              "priceListId": controller
                                                  .trx
                                                  .records![index]
                                                  .mPriceListID
                                                  ?.id,
                                              "dateOrdered": controller.trx
                                                  .records![index].dateOrdered,
                                            }); */
                                          },
                                        ),
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                            ),
                                            tooltip: 'Edit Anomaly'.tr,
                                            onPressed: () {
                                              //log("info button pressed");
                                              /* Get.to(const CRMEditSalesOrder(), arguments: {
                                            "id": controller
                                                .trx.records![index].id,
                                            "docNo": controller
                                                  .trx.records![index].documentNo,
                                            "docTypeTargetId": controller.trx.records![index].cDocTypeTargetID!.id,
                                            "BPartnerLocationId": controller.trx.records![index].cBPartnerLocationID!.id,
                                            "bPartnerId": controller
                                                  .trx
                                                  .records![index]
                                                  .cBPartnerID
                                                  ?.id,
                                          }); */
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          controller.trx.records![index]
                                              .ncDescription!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: <Widget>[
                                            const Icon(Icons.handshake,
                                                color: Colors.yellowAccent),
                                            Expanded(
                                              child: Text(
                                                controller.trx.records![index]
                                                        .name ??
                                                    "",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),

                                        childrenPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controller
                                                            .trx
                                                            .records![index]
                                                            .dateDoc ??
                                                        "",
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ]);
            },
            tabletBuilder: (context, constraints) {
              return Column(children: [
                const SizedBox(height: kSpacing * (kIsWeb ? 1 : 2)),
                _buildHeader(
                    onPressedMenu: () => Scaffold.of(context).openDrawer()),
                const SizedBox(height: kSpacing / 2),
                const Divider(),
                _buildProfile(data: controller.getProfil()),
                const SizedBox(height: kSpacing),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Obx(() => controller.dataAvailable
                          ? Text("ANOMALIES: ".tr +
                              controller.trx.rowcount.toString())
                          : Text("ANOMALIES: ".tr)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: IconButton(
                        onPressed: () {
                          controller.getAnomalies();
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Obx(
                        () => TextButton(
                          onPressed: () {
                            controller.changeFilter();
                            //print("hello");
                          },
                          child: Text(controller.value.value),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      //padding: const EdgeInsets.all(10),
                      //width: 20,
                      /* decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ), */
                      child: Obx(
                        () => DropdownButton(
                          icon: const Icon(Icons.filter_alt_sharp),
                          value: controller.dropdownValue.value,
                          elevation: 16,
                          onChanged: (String? newValue) {
                            controller.dropdownValue.value = newValue!;

                            //print(dropdownValue);
                          },
                          items: controller.dropDownList.map((list) {
                            return DropdownMenuItem<String>(
                              value: list.id,
                              child: Text(
                                list.name.toString(),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: TextField(
                          controller: controller.searchFieldController,
                          onSubmitted: (String? value) {
                            controller.searchFilterValue.value =
                                controller.searchFieldController.text;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.search_outlined),
                            border: const OutlineInputBorder(),
                            //labelText: 'Product Value',
                            hintText: 'Search'.tr,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing),
                Obx(
                  () => controller.dataAvailable
                      ? ListView.builder(
                          primary: false,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.trx.rowcount,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() => Visibility(
                                  visible: controller.searchFilterValue.value ==
                                          ""
                                      ? true
                                      : controller.dropdownValue.value == "1"
                                          ? controller
                                              .trx.records![index].ncDescription
                                              .toString()
                                              .toLowerCase()
                                              .contains(controller
                                                  .searchFilterValue.value
                                                  .toLowerCase())
                                          : controller.dropdownValue.value ==
                                                  "2"
                                              ? (controller.trx.records![index]
                                                          .name ??
                                                      "")
                                                  .toString()
                                                  .toLowerCase()
                                                  .contains(controller
                                                      .searchFilterValue.value
                                                      .toLowerCase())
                                              : true,
                                  child: Card(
                                    elevation: 8.0,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 6.0),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(64, 75, 96, .9)),
                                      child: ExpansionTile(
                                        trailing: IconButton(
                                          icon: const Icon(
                                            Icons.article,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            /* Get.toNamed('/SalesOrderLine',
                                            arguments: {
                                              "id": controller
                                                  .trx.records![index].id,
                                              "bPartner": controller
                                                  .trx
                                                  .records![index]
                                                  .cBPartnerID
                                                  ?.identifier,
                                              "docNo": controller
                                                  .trx.records![index].documentNo,
                                              "priceListId": controller
                                                  .trx
                                                  .records![index]
                                                  .mPriceListID
                                                  ?.id,
                                              "dateOrdered": controller.trx
                                                  .records![index].dateOrdered,
                                            }); */
                                          },
                                        ),
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 10.0),
                                        leading: Container(
                                          padding: const EdgeInsets.only(
                                              right: 12.0),
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  right: BorderSide(
                                                      width: 1.0,
                                                      color: Colors.white24))),
                                          child: IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                            ),
                                            tooltip: 'Edit Anomaly'.tr,
                                            onPressed: () {
                                              //log("info button pressed");
                                              /* Get.to(const CRMEditSalesOrder(), arguments: {
                                            "id": controller
                                                .trx.records![index].id,
                                            "docNo": controller
                                                  .trx.records![index].documentNo,
                                            "docTypeTargetId": controller.trx.records![index].cDocTypeTargetID!.id,
                                            "BPartnerLocationId": controller.trx.records![index].cBPartnerLocationID!.id,
                                            "bPartnerId": controller
                                                  .trx
                                                  .records![index]
                                                  .cBPartnerID
                                                  ?.id,
                                          }); */
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          controller.trx.records![index]
                                              .ncDescription!,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                        subtitle: Row(
                                          children: <Widget>[
                                            const Icon(Icons.handshake,
                                                color: Colors.yellowAccent),
                                            Expanded(
                                              child: Text(
                                                controller.trx.records![index]
                                                        .name ??
                                                    "",
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),

                                        childrenPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 10.0),
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    controller
                                                            .trx
                                                            .records![index]
                                                            .dateDoc ??
                                                        "",
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                          },
                        )
                      : const Center(child: CircularProgressIndicator()),
                ),
              ]);
            },
            desktopBuilder: (context, constraints) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: (constraints.maxWidth < 1360) ? 4 : 3,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(kBorderRadius),
                          bottomRight: Radius.circular(kBorderRadius),
                        ),
                        child: _Sidebar(data: controller.getSelectedProject())),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(children: [
                      _buildProfile(data: controller.getProfil()),
                      /* Row(
                  children: [
                    Flexible(flex: 3, child: _buildHeader(onPressedMenu: () => Scaffold.of(context).openDrawer())),
                    Flexible(flex: 5, child: _buildProfile(data: controller.getProfil())),
                  ],
                ), */
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 15),
                            child: Obx(() => controller.dataAvailable
                                ? Text("ANOMALIES: ".tr +
                                    controller.trx.rowcount.toString())
                                : Text("ANOMALIES: ".tr)),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: IconButton(
                              onPressed: () {
                                controller.getAnomalies();
                              },
                              icon: const Icon(
                                Icons.refresh,
                                color: Colors.yellow,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Obx(
                              () => TextButton(
                                onPressed: () {
                                  controller.changeFilter();
                                  //print("hello");
                                },
                                child: Text(controller.value.value),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            //padding: const EdgeInsets.all(10),
                            //width: 20,
                            /* decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ), */
                            child: Obx(
                              () => DropdownButton(
                                icon: const Icon(Icons.filter_alt_sharp),
                                value: controller.dropdownValue.value,
                                elevation: 16,
                                onChanged: (String? newValue) {
                                  controller.dropdownValue.value = newValue!;

                                  //print(dropdownValue);
                                },
                                items: controller.dropDownList.map((list) {
                                  return DropdownMenuItem<String>(
                                    value: list.id,
                                    child: Text(
                                      list.name.toString(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                controller: controller.searchFieldController,
                                onSubmitted: (String? value) {
                                  controller.searchFilterValue.value =
                                      controller.searchFieldController.text;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.search_outlined),
                                  border: const OutlineInputBorder(),
                                  //labelText: 'Product Value',
                                  hintText: 'Search'.tr,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: kSpacing),
                      Obx(
                        () => controller.dataAvailable
                            ? Scrollbar(
                                child: ListView.builder(
                                  primary: false,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: controller.trx.rowcount,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(() => Visibility(
                                        visible: controller.searchFilterValue.value ==
                                                ""
                                            ? true
                                            : controller.dropdownValue.value ==
                                                    "1"
                                                ? controller.trx.records![index].ncDescription
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(controller
                                                        .searchFilterValue.value
                                                        .toLowerCase())
                                                : controller.dropdownValue.value ==
                                                        "2"
                                                    ? (controller.trx.records![index].name ?? "")
                                                        .toString()
                                                        .toLowerCase()
                                                        .contains(controller
                                                            .searchFilterValue
                                                            .value
                                                            .toLowerCase())
                                                    : controller.dropdownValue.value ==
                                                            "3"
                                                        ? (controller.trx.records![index].dateDoc ?? "")
                                                            .toString()
                                                            .toLowerCase()
                                                            .contains(controller.searchFilterValue.value.toLowerCase())
                                                        : true,
                                        child: Card(
                                          elevation: 8.0,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 6.0),
                                          child: Obx(
                                            () => controller.selectedCard ==
                                                    index
                                                ? _buildCard(
                                                    Theme.of(context).cardColor,
                                                    context,
                                                    index)
                                                : _buildCard(
                                                    const Color.fromRGBO(
                                                        64, 75, 96, .9),
                                                    context,
                                                    index),
                                          ),
                                        )));
                                  },
                                ),
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ),
                    ]),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        const SizedBox(height: kSpacing),
                        _buildHeader(),
                        const SizedBox(height: kSpacing * 6.5),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  //width: 100,
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: Obx(() => controller.dataAvailable
                                      ? Container(
                                          //margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                          margin: const EdgeInsets.only(
                                              right: 10.0,
                                              left: 10.0,
                                              /* top: kSpacing * 7.7 */ bottom:
                                                  6.0),
                                          color: const Color.fromRGBO(
                                              64, 75, 96, .9),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintStyle: const TextStyle(
                                                                    color:
                                                                        Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                labelText:
                                                                    'Client'.tr,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .always,
                                                                hintText: controller
                                                                        .trx
                                                                        .records![
                                                                            controller.selectedCard]
                                                                        .aDClientID
                                                                        ?.identifier ??
                                                                    '',
                                                                enabled: false),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintStyle: const TextStyle(
                                                                    color: Color.fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                labelText:
                                                                    'Organization'
                                                                        .tr,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .always,
                                                                hintText: controller
                                                                        .trx
                                                                        .records![
                                                                            controller.selectedCard]
                                                                        .aDOrgID
                                                                        ?.identifier ??
                                                                    '',
                                                                enabled: false),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintStyle: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      labelText:
                                                          'Maintenance Resource'
                                                              .tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      hintText: controller
                                                              .trx
                                                              .records![controller
                                                                  .selectedCard]
                                                              .mPMaintainResourceID
                                                              ?.identifier ??
                                                          '',
                                                      enabled: false),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintStyle:
                                                          const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      labelText:
                                                          'Maintenance Task'.tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      hintText: controller
                                                              .trx
                                                              .records![controller
                                                                  .selectedCard]
                                                              .mPMaintainTaskID
                                                              ?.identifier ??
                                                          '',
                                                      enabled: false),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintStyle: const TextStyle(
                                                                    color: Color.fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                labelText:
                                                                    'Fault Type'
                                                                        .tr,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .always,
                                                                hintText: controller
                                                                        .trx
                                                                        .records![
                                                                            controller.selectedCard]
                                                                        .lITNCFaultTypeID
                                                                        ?.identifier ??
                                                                    '',
                                                                enabled: false),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                hintStyle: const TextStyle(
                                                                    color: Color.fromARGB(
                                                                        255,
                                                                        255,
                                                                        255,
                                                                        255)),
                                                                labelStyle:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                                border:
                                                                    const OutlineInputBorder(),
                                                                labelText:
                                                                    'Document Date'
                                                                        .tr,
                                                                floatingLabelBehavior:
                                                                    FloatingLabelBehavior
                                                                        .always,
                                                                hintText: controller
                                                                        .trx
                                                                        .records![
                                                                            controller.selectedCard]
                                                                        .dateDoc ??
                                                                    '',
                                                                enabled: false),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintStyle:
                                                          const TextStyle(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255)),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      labelText:
                                                          'User/Contact'.tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      hintText: controller
                                                              .trx
                                                              .records![controller
                                                                  .selectedCard]
                                                              .aDUserID
                                                              ?.identifier ??
                                                          '',
                                                      enabled: false),
                                                ),
                                              ),
                                              //const SizedBox(width: kSpacing * 2,),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintStyle: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      labelText: 'Name'.tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      hintText: controller
                                                              .trx
                                                              .records![controller
                                                                  .selectedCard]
                                                              .name ??
                                                          '',
                                                      enabled: false),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.all(10),
                                                child: TextField(
                                                  decoration: InputDecoration(
                                                      hintStyle: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(),
                                                      labelText:
                                                          'Description'.tr,
                                                      floatingLabelBehavior:
                                                          FloatingLabelBehavior
                                                              .always,
                                                      hintText: controller
                                                              .trx
                                                              .records![controller
                                                                  .selectedCard]
                                                              .ncDescription ??
                                                          '',
                                                      enabled: false),
                                                ),
                                              ),
                                            ]),
                                          ))
                                      : const Center(
                                          child: CircularProgressIndicator()))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Column(
                      children: [
                        const SizedBox(height: kSpacing * 10),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                  //width: 100,
                                  height:
                                      MediaQuery.of(context).size.height / 1.3,
                                  child: Obx(() => controller.showDetails
                                      ? SingleChildScrollView(
                                          child: Container(
                                              //margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                              margin: const EdgeInsets.only(
                                                  right: 10.0,
                                                  left: 10.0,
                                                  /* top: kSpacing * 7.7 */ bottom:
                                                      6.0),
                                              color: const Color.fromRGBO(
                                                  64, 75, 96, .9),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(children: [
                                                  Text(
                                                    'Maintenance Resource'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Product'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .mProductID
                                                                      ?.identifier ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Location'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .maintainLocation ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Code/Position'
                                                                      .tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .maintainValue ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'SerNo'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .maintainSerNo ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Check Date'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl1DateFrom ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                      //const SizedBox(width: kSpacing * 2,),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Next Check'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl1DateNext ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Revision Date'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl2DateFrom ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                      //const SizedBox(width: kSpacing * 2,),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Next Revision'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl2DateNext ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Testing Date'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl3DateFrom ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                      //const SizedBox(width: kSpacing * 2,),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .all(10),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                                    hintStyle: const TextStyle(
                                                                        color: Color.fromARGB(
                                                                            255,
                                                                            255,
                                                                            255,
                                                                            255)),
                                                                    labelStyle:
                                                                        const TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                    border:
                                                                        const OutlineInputBorder(),
                                                                    labelText:
                                                                        'Next Testing'
                                                                            .tr,
                                                                    floatingLabelBehavior:
                                                                        FloatingLabelBehavior
                                                                            .always,
                                                                    hintText: controller
                                                                            .trx
                                                                            .records![controller
                                                                                .selectedCard]
                                                                            .litControl3DateNext ??
                                                                        '',
                                                                    enabled:
                                                                        false),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Divider(
                                                    height: 20,
                                                    thickness: 1,
                                                    indent: 10,
                                                    endIndent: 10,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    'Maintenance Task'.tr,
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'LineNo'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: (controller
                                                                          .trx
                                                                          .records![controller
                                                                              .selectedCard]
                                                                          .taskLine !=
                                                                      null
                                                                  ? controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .taskLine
                                                                      .toString()
                                                                  : ''),
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Name'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .taskName ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Description'
                                                                      .tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .taskDescription ??
                                                                  '',
                                                              enabled: false),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: TextField(
                                                      decoration:
                                                          InputDecoration(
                                                              hintStyle: const TextStyle(
                                                                  color:
                                                                      Color.fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255)),
                                                              labelStyle:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  const OutlineInputBorder(),
                                                              labelText:
                                                                  'Quantity'.tr,
                                                              floatingLabelBehavior:
                                                                  FloatingLabelBehavior
                                                                      .always,
                                                              hintText: (controller
                                                                          .trx
                                                                          .records![controller
                                                                              .selectedCard]
                                                                          .taskQuantity !=
                                                                      null
                                                                  ? controller
                                                                      .trx
                                                                      .records![
                                                                          controller
                                                                              .selectedCard]
                                                                      .taskQuantity
                                                                      .toString()
                                                                  : ''),
                                                              enabled: false),
                                                    ),
                                                  ),
                                                ]),
                                              )),
                                        )
                                      : Center(
                                          child:
                                              Text('No Anomaly Selected'.tr)))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Color selectionColor, context, index) {
    return Container(
      decoration: BoxDecoration(color: selectionColor),
      child: ExpansionTile(
        trailing: IconButton(
          icon: const Icon(
            Icons.article,
            color: Colors.green,
          ),
          onPressed: () {
            //controller.getAnomalies();
            controller.selectedCard = index;
            controller.showDetails = true;
          },
        ),
        tilePadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        /* leading: Container(
                padding: const EdgeInsets.only(right: 12.0),
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(
                            width: 1.0,
                            color: Colors.white24))),
                child: IconButton(
                  icon: const Icon(
                    Icons.edit,
                  ),
                  tooltip: 'Edit Anomaly'.tr,
                  onPressed: () {
                  },
                ),
              ), */
        title: Text(
          controller.trx.records![index].ncDescription!,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: <Widget>[
            const Icon(Icons.report_problem, color: Colors.yellowAccent),
            Expanded(
              child: Text(
                controller.trx.records![index].name ?? "",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: [
          Column(
            children: [
              Row(
                children: [
                  Text('${'Document Date'.tr}: '),
                  Text(
                    controller.trx.records![index].dateDoc ?? "",
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Row(
        children: [
          if (onPressedMenu != null)
            Padding(
              padding: const EdgeInsets.only(right: kSpacing),
              child: IconButton(
                onPressed: onPressedMenu,
                icon: const Icon(EvaIcons.menu),
                tooltip: "menu",
              ),
            ),
          const Expanded(child: _Header()),
        ],
      ),
    );
  }

  Widget _buildProgress({Axis axis = Axis.horizontal}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: (axis == Axis.horizontal)
          ? Row(
              children: [
                Flexible(
                  flex: 5,
                  child: ProgressCard(
                    data: const ProgressCardData(
                      totalUndone: 10,
                      totalTaskInProress: 2,
                    ),
                    onPressedCheck: () {},
                  ),
                ),
                const SizedBox(width: kSpacing / 2),
                Flexible(
                  flex: 4,
                  child: ProgressReportCard(
                    data: ProgressReportCardData(
                      title: "1st Sprint",
                      doneTask: 5,
                      percent: .3,
                      task: 3,
                      undoneTask: 2,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                ProgressCard(
                  data: const ProgressCardData(
                    totalUndone: 10,
                    totalTaskInProress: 2,
                  ),
                  onPressedCheck: () {},
                ),
                const SizedBox(height: kSpacing / 2),
                ProgressReportCard(
                  data: ProgressReportCardData(
                    title: "1st Sprint",
                    doneTask: 5,
                    percent: .3,
                    task: 3,
                    undoneTask: 2,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProfile({required _Profile data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ProfilTile(
        data: data,
        onPressedNotification: () {},
      ),
    );
  }

  Widget _buildTeamMember({required List<ImageProvider> data}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TeamMember(
            totalMember: data.length,
            onPressedAdd: () {},
          ),
          const SizedBox(height: kSpacing / 2),
          ListProfilImage(maxImages: 6, images: data),
        ],
      ),
    );
  }

  Widget _buildRecentMessages({required List<ChattingCardData> data}) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: kSpacing),
        child: _RecentMessages(onPressedMore: () {}),
      ),
      const SizedBox(height: kSpacing / 2),
      ...data
          .map(
            (e) => ChattingCard(data: e, onPressed: () {}),
          )
          .toList(),
    ]);
  }
}
