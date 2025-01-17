// ignore_for_file: unused_element

library dashboard;

//import 'dart:convert';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bluetooth_thermal_printer/bluetooth_thermal_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idempiere_app/Screens/app/constans/app_constants.dart';
import 'package:idempiere_app/Screens/app/features/CRM_Invoice/models/orginfo_json.dart';
import 'package:idempiere_app/Screens/app/features/Maintenance_Mptask/views/screens/maintenance_mptask_screen.dart';
import 'package:idempiere_app/Screens/app/features/Maintenance_Mptask_taskline/models/workorder_local_json.dart';
import 'package:idempiere_app/Screens/app/features/Maintenance_Mptask_taskline/models/workorder_task_local_json.dart';
import 'package:idempiere_app/Screens/app/features/Maintenance_Mptask_taskline/views/screens/maintenance_create_mptask_taskline_screen.dart';
import 'package:idempiere_app/Screens/app/features/Maintenance_Mptask_taskline/views/screens/maintenance_edit_mptask_taskline_screen.dart';
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idempiere_app/constants.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// binding
part '../../bindings/maintenance_mptask_taskline_binding.dart';

// controller
part '../../controllers/maintenance_mptask_taskline_controller.dart';

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

class MaintenanceMptaskLineScreen
    extends GetView<MaintenanceMptaskLineController> {
  const MaintenanceMptaskLineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text("${Get.arguments["docN"]}"),
            Text("${Get.arguments["bPartner"]}"),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            Get.offNamed('/MaintenanceMptask');
          },
        ),
      ),
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return Column(children: [
              const SizedBox(height: kSpacing),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: "Save".tr,
                    onPressed: () {
                      controller.editManualNote();
                    },
                    icon: const Icon(Icons.save),
                  ),
                  IconButton(
                    tooltip: "Add Task".tr,
                    onPressed: () {
                      Get.to(const CreateMaintenanceMptask(), arguments: {
                        "id": Get.arguments["id"],
                      });
                    },
                    icon: const Icon(EvaIcons.fileAddOutline),
                  ),
                  IconButton(
                    tooltip: "Print".tr,
                    onPressed: () {},
                    icon: const Icon(EvaIcons.printerOutline),
                  ),
                  IconButton(
                    tooltip: "Report".tr,
                    onPressed: () {
                      controller.printWorkOrderTasksTicket();
                    },
                    icon: const Icon(Icons.receipt),
                  ),
                  IconButton(
                    tooltip: "Attach Image".tr,
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_outlined),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Visibility(
                visible: controller.args["isSpecialOrder"],
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 4,
                    controller: controller.requestFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_pin_outlined),
                      border: const OutlineInputBorder(),
                      labelText: 'Request Description'.tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.args["isSpecialOrder"],
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 4,
                    controller: controller.noteFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_pin_outlined),
                      border: const OutlineInputBorder(),
                      labelText: 'Activity To Do'.tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: controller.args["isSpecialOrder"],
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    minLines: 1,
                    maxLines: 4,
                    controller: controller.manualNoteFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_pin_outlined),
                      border: const OutlineInputBorder(),
                      labelText: 'Activity Done'.tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.dataAvailable
                    ? ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.trx.records!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ExpansionTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    int taskindex = 0;
                                    for (var i = 0;
                                        i < controller._trx2.records!.length;
                                        i++) {
                                      if (controller._trx2.records![i].id ==
                                          controller._trx.records![index].id) {
                                        taskindex = i;
                                      }
                                    }
                                    //print(taskindex);
                                    Get.to(const EditMaintenanceMptaskLine(),
                                        arguments: {
                                          "index": taskindex,
                                          "id": controller
                                              ._trx.records![index].id,
                                          "qtyEntered": controller
                                              ._trx.records![index].qtyEntered
                                              .toString(),
                                          "resourceQty": controller
                                              ._trx.records![index].resourceQty
                                              .toString(),
                                          "description": controller
                                              ._trx.records![index].description,
                                          "qty": controller
                                              ._trx.records![index].qty
                                              .toString(),
                                          "offlineid": controller
                                              ._trx.records![index].offlineId,
                                          "prod": controller
                                              ._trx
                                              .records![index]
                                              .mProductID
                                              ?.identifier,
                                          "prodId": controller._trx
                                              .records![index].mProductID?.id,
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Delete Task',
                                    onPressed: () {
                                      controller.deleteTask(
                                          controller._trx.records![index].id!,
                                          index);
                                    },
                                  ),
                                ),
                                title: Text(
                                  controller.trx.records![index].mProductID
                                          ?.identifier ??
                                      "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.event),
                                        Text(
                                          "${"Qty".tr}: ${controller.trx.records![index].qty}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                /* trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                    size: 30.0,
                                  ), */
                                childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                children: const [],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ]);
          },
          tabletBuilder: (context, constraints) {
            return Column(children: [
              const SizedBox(height: kSpacing),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: "Save".tr,
                    onPressed: () {
                      controller.editManualNote();
                    },
                    icon: const Icon(Icons.save),
                  ),
                  IconButton(
                    tooltip: "Add Task".tr,
                    onPressed: () {
                      Get.to(const CreateMaintenanceMptask(), arguments: {
                        "id": Get.arguments["id"],
                      });
                    },
                    icon: const Icon(EvaIcons.fileAddOutline),
                  ),
                  IconButton(
                    tooltip: "Print".tr,
                    onPressed: () {},
                    icon: const Icon(EvaIcons.printerOutline),
                  ),
                  IconButton(
                    tooltip: "Report".tr,
                    onPressed: () {
                      controller.printWorkOrderTasksTicket();
                    },
                    icon: const Icon(Icons.receipt),
                  ),
                  IconButton(
                    tooltip: "Attach Image".tr,
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_outlined),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.requestFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Request Description'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.noteFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Activity To Do'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.manualNoteFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Activity Done'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Obx(
                () => controller.dataAvailable
                    ? ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.trx.records!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ExpansionTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    /* GetStorage().write(
                                        'selectedTaskDocNo',
                                        controller
                                            .trx.records![index].documentNo);
                                    GetStorage().write(
                                        'selectedTaskBP',
                                        controller.trx.records![index]
                                                .cBPartnerID?.identifier ??
                                            "");
                                    GetStorage().write(
                                        'selectedTaskId',
                                        controller.trx.records![index]
                                            .mPMaintainTaskID!.id);
                                    Get.toNamed('/MaintenanceMpResource'); */
                                  },
                                  icon: const Icon(
                                    Icons.view_list,
                                    color: Colors.green,
                                  ),
                                ),
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Delete Task',
                                    onPressed: () {
                                      controller.deleteTask(
                                          controller._trx.records![index].id!,
                                          index);
                                    },
                                  ),
                                ),
                                title: Text(
                                  controller.trx.records![index].mProductID
                                          ?.identifier ??
                                      "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.event),
                                        Text(
                                          "${"Qty".tr}: ${controller.trx.records![index].qty}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                /* trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                    size: 30.0,
                                  ), */
                                childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                children: const [],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ]);
          },
          desktopBuilder: (context, constraints) {
            return Column(children: [
              const SizedBox(height: kSpacing),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: "Save".tr,
                    onPressed: () {
                      controller.editManualNote();
                    },
                    icon: const Icon(Icons.save),
                  ),
                  IconButton(
                    tooltip: "Add Task".tr,
                    onPressed: () {
                      Get.to(const CreateMaintenanceMptask(), arguments: {
                        "id": Get.arguments["id"],
                      });
                    },
                    icon: const Icon(EvaIcons.fileAddOutline),
                  ),
                  IconButton(
                    tooltip: "Print".tr,
                    onPressed: () {},
                    icon: const Icon(EvaIcons.printerOutline),
                  ),
                  IconButton(
                    tooltip: "Report".tr,
                    onPressed: () {
                      controller.printWorkOrderTasksTicket();
                    },
                    icon: const Icon(Icons.receipt),
                  ),
                  IconButton(
                    tooltip: "Attach Image".tr,
                    onPressed: () {},
                    icon: const Icon(Icons.attach_file_outlined),
                  ),
                ],
              ),
              Container(
                color: Colors.grey[600],
                width: screenSize.width,
                height: 0.25,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.requestFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Request Description'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  readOnly: true,
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.noteFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Activity To Do'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
                  controller: controller.manualNoteFieldController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_pin_outlined),
                    border: const OutlineInputBorder(),
                    labelText: 'Activity Done'.tr,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Obx(
                () => controller.dataAvailable
                    ? ListView.builder(
                        primary: false,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.trx.records!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 8.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 6.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(64, 75, 96, .9)),
                              child: ExpansionTile(
                                trailing: IconButton(
                                  onPressed: () {
                                    Get.to(const EditMaintenanceMptaskLine());
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.green,
                                  ),
                                ),
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              width: 1.0,
                                              color: Colors.white24))),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    tooltip: 'Delete Task',
                                    onPressed: () {
                                      controller.deleteTask(
                                          controller._trx.records![index].id!,
                                          index);
                                    },
                                  ),
                                ),
                                title: Text(
                                  controller.trx.records![index].mProductID
                                          ?.identifier ??
                                      "",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        const Icon(Icons.event),
                                        Text(
                                          "${"Qty".tr}: ${controller.trx.records![index].qty}",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                /* trailing: const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                    size: 30.0,
                                  ), */
                                childrenPadding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                children: const [],
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ]);
          },
        ),
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

  /* Widget _buildTaskOverview({
    required List<TaskCardData> data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
    Axis headerAxis = Axis.horizontal,
  }) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: crossAxisCount,
      itemCount: data.length + 1,
      addAutomaticKeepAlives: false,
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return (index == 0)
            ? Padding(
                padding: const EdgeInsets.only(bottom: kSpacing),
                child: _OverviewHeader(
                  axis: headerAxis,
                  onSelected: (task) {},
                ),
              )
            : TaskCard(
                data: data[index - 1],
                onPressedMore: () {},
                onPressedTask: () {},
                onPressedContributors: () {},
                onPressedComments: () {},
              );
      },
      staggeredTileBuilder: (int index) =>
          StaggeredTile.fit((index == 0) ? crossAxisCount : crossAxisCellCount),
    );
  }

  Widget _buildActiveProject({
    required List<ProjectCardData> data,
    int crossAxisCount = 6,
    int crossAxisCellCount = 2,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: _ActiveProjectCard(
        onPressedSeeAll: () {},
        child: StaggeredGridView.countBuilder(
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: crossAxisCount,
          itemCount: data.length,
          addAutomaticKeepAlives: false,
          mainAxisSpacing: kSpacing,
          crossAxisSpacing: kSpacing,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ProjectCard(data: data[index]);
          },
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(crossAxisCellCount),
        ),
      ),
    );
  } */

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
