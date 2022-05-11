import 'dart:convert';
//import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:idempiere_app/Screens/app/features/Supplychain_Load_Unload/views/screens/supplychain_load_unload_screen.dart';
import 'package:idempiere_app/Screens/app/shared_components/responsive_builder.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CreateSupplychainLoadUnload extends StatefulWidget {
  const CreateSupplychainLoadUnload({Key? key}) : super(key: key);

  @override
  State<CreateSupplychainLoadUnload> createState() =>
      _CreateSupplychainLoadUnloadState();
}

class _CreateSupplychainLoadUnloadState
    extends State<CreateSupplychainLoadUnload> {
  createLoadUnload() async {
    final ip = GetStorage().read('ip');
    String authorization = 'Bearer ' + GetStorage().read('token');
    var formatter = DateFormat('yyyy-MM-dd');
    // ignore: prefer_typing_uninitialized_variables
    var msg;
    if (activityFieldController.text == "") {
      msg = jsonEncode({
        "AD_Org_ID": {"id": GetStorage().read("organizationid")},
        "AD_Client_ID": {"id": GetStorage().read("clientid")},
        "C_DocType_ID": {"id": Get.arguments["idDoc"]},
        "M_Warehouse_ID": {"id": GetStorage().read("warehouseid")},
        "MovementDate": formatter.format(DateTime.now()),
        "Description": descriptionFieldController.text,
        "DocAction": "CO",
      });
    } else {
      msg = jsonEncode({
        "AD_Org_ID": {"id": GetStorage().read("organizationid")},
        "AD_Client_ID": {"id": GetStorage().read("clientid")},
        "C_Activity_ID": {"id": int.parse(activityFieldController.text)},
        "C_DocType_ID": {"id": Get.arguments["idDoc"]},
        "M_Warehouse_ID": {"id": GetStorage().read("warehouseid")},
        "MovementDate": formatter.format(DateTime.now()),
        "Description": descriptionFieldController.text,
        "DocAction": "CO",
      });
    }

    final protocol = GetStorage().read('protocol');
    var url = Uri.parse('$protocol://' + ip + '/api/v1/models/M_Inventory/');
    //print(msg);
    var response = await http.post(
      url,
      body: msg,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': authorization,
      },
    );
    if (response.statusCode == 201) {
      if (kDebugMode) {
        print(response.body);
      }
      var json = jsonDecode(utf8.decode(response.bodyBytes));
      Get.find<SupplychainLoadUnloadController>().getLoadUnloads();
      Get.offNamed('/SupplychainLoadUnloadLine',
          arguments: {"id": json["id"], "docNo": json["DocumentNo"]});
      //print("done!");
      Get.snackbar(
        "Fatto!",
        "Il record è stato creato",
        icon: const Icon(
          Icons.done,
          color: Colors.green,
        ),
      );
    } else {
      if (kDebugMode) {
        print(response.body);
      }
      Get.snackbar(
        "Errore!",
        "Record non creato",
        icon: const Icon(
          Icons.error,
          color: Colors.red,
        ),
      );
    }
  }

  /* void fillFields() {
    nameFieldController.text = args["name"];
    bPartnerFieldController.text = args["bpName"];
    phoneFieldController.text = args["Tel"];
    mailFieldController.text = args["eMail"];
    //dropdownValue = args["leadStatus"];
    salesrepValue = args["salesRep"];
    //salesRepFieldController.text = args["salesRep"];
  } */

  //dynamic args = Get.arguments;
  // ignore: prefer_typing_uninitialized_variables
  var activityFieldController;
  // ignore: prefer_typing_uninitialized_variables
  var descriptionFieldController;

  @override
  void initState() {
    super.initState();
    activityFieldController = TextEditingController();
    descriptionFieldController = TextEditingController();
    //fillFields();
  }

  //static String _displayStringForOption(Records option) => option.name!;
  //late List<Records> salesrepRecord;
  //bool isSalesRepLoading = false;

  @override
  Widget build(BuildContext context) {
    //getSalesRepAutoComplete();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Add Load/Unload'.tr),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
              onPressed: () {
                createLoadUnload();
              },
              icon: const Icon(
                Icons.save,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: activityFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outlined),
                      border: const OutlineInputBorder(),
                      labelText: 'Activity (Barcode)'.tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: TextField(
                    controller: descriptionFieldController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person_outlined),
                      border: const OutlineInputBorder(),
                      labelText: "Description".tr,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                  ),
                ),
              ],
            );
          },
          tabletBuilder: (context, constraints) {
            return const Text("desktop visual WIP");
          },
          desktopBuilder: (context, constraints) {
            return const Text("tablet visual WIP");
          },
        ),
      ),
    );
  }
}
