import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_loss_consultant_mobile/constants/app_colors.dart';
import 'package:weight_loss_consultant_mobile/models/account_model.dart';
import 'package:weight_loss_consultant_mobile/models/campaign_model.dart';
import 'package:weight_loss_consultant_mobile/pages/components/generic_app_bar.dart';
import 'package:weight_loss_consultant_mobile/pages/components/toast.dart';
import 'package:weight_loss_consultant_mobile/services/customer_service.dart';

class CustomerUpdateCampaignPage extends StatefulWidget {
  late int? campaignID;
  CustomerUpdateCampaignPage({Key? key, this.campaignID}) : super(key: key);

  @override
  _CustomerUpdateCampaignPageState createState() => _CustomerUpdateCampaignPageState();
}

class _CustomerUpdateCampaignPageState extends State<CustomerUpdateCampaignPage> {

  AccountModel user = AccountModel(email: "", fullname: "");
  late CampaignModel? campaignModel;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _weightTarget = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _currentWeight = TextEditingController();

  String dropdownValue = '1 day';
  int spendTimeForTraining = 1;


  Future<void> initAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJSON = prefs.getString('ACCOUNT');
    if (userJSON is String){
      Map<String, dynamic> userMap = jsonDecode(userJSON);
      user = AccountModel.fromJson(userMap);
    }
  }

  Future<void> saveAccount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("ACCOUNT", jsonEncode(user.toJson()));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_){
      initAccount().then((value){
        CustomerService service = CustomerService();
        service.getCampaignById(widget.campaignID ?? 0, user).then((value) {
          campaignModel = value;
          _description.text = campaignModel!.description ?? "";
          _weightTarget.text = campaignModel!.targetWeight.toString();
          _currentWeight.text = campaignModel!.currentWeight.toString();


          setState(() {});
        });
      });
    });
  }

  Widget _title(String title) {
    return Text(title,
        style: const TextStyle(
            color: Color(0xFF0D3F67),
            fontWeight: FontWeight.w700,
            fontSize: 18));
  }

  Widget _singleInput(
      String label,
      String hint,
      TextEditingController controller,
      TextInputType type,
      IconData icon,
      bool haveSuffixIcon,
      FormFieldValidator<String> validator) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.INPUT_COLOR,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              label,
              style: const TextStyle(
                  color: Color(0xFF0D3F67),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  validator: validator,
                  controller: controller,
                  keyboardType: type,
                  style: const TextStyle(fontSize: 15),
                  decoration: InputDecoration(
                    suffixIcon: haveSuffixIcon
                        ? Icon(
                      icon,
                      color: const Color(0xFF0D3F67),
                      size: 20,
                    )
                        : const SizedBox(),
                    border: InputBorder.none,
                    hintText: hint,
                    hintStyle: const TextStyle(
                        color: Color(0xFFB6C5D1),
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                    errorStyle: const TextStyle(height: 0.1),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _multiInput(
      String label, String hint, TextEditingController controller, int maxCharacter) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.INPUT_COLOR,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 15),
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxCharacter),
            ],
            maxLines: 5,
            decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.always,
                border: InputBorder.none,
                labelText: label,
                labelStyle: TextStyle(
                    fontSize: 15,
                    color: AppColors.PRIMARY_WORD_COLOR,
                    fontWeight: FontWeight.bold),
                hintText: hint,
                hintStyle: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFFB6C5D1),
                    fontWeight: FontWeight.w400)),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'Max. $maxCharacter characters',
              style: const TextStyle(
                  color: Color(0xFFB6C5D1),
                  fontWeight: FontWeight.w400,
                  fontSize: 11),
            ),
          )
        ],
      ),
    );
  }

  Widget _dropdown(){
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.INPUT_COLOR,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child:  Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'How many day per week you can spend for training',
              style: TextStyle(
                  color: Color(0xFF0D3F67),
                  fontSize: 11,
                  fontWeight: FontWeight.bold),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_drop_down_sharp),
            iconSize: 24,
            elevation: 16,
            isExpanded: true,
            style: const TextStyle(color: Color(0xFF0D3F67), fontWeight: FontWeight.w400, fontSize: 15),
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              switch (newValue){
                case "1 day":
                  spendTimeForTraining = 1;
                  break;
                case "2 days":
                  spendTimeForTraining = 2;
                  break;
                case "3 days":
                  spendTimeForTraining = 3;
                  break;
                case "4 days":
                  spendTimeForTraining = 4;
                  break;
                case "5 days":
                  spendTimeForTraining = 5;
                  break;
              }
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>["1 day", '2 days', '3 days', '4 days', '5 days']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GenericAppBar.builder("Campaign"),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        margin: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: _title('Fill the Forms'),
                ),
                _singleInput("Your current weight", "E.g: 70", _currentWeight, TextInputType.number, Icons.add, false, (text){
                  if (text == null || text.isEmpty){
                    return "Current weight cannot be empty";
                  }
                  try{
                    int weight = int.parse(text);
                    if (weight < 0){
                      return "Current weight cannot be negative";
                    }
                    if (weight > 300){
                      return "Current weight cannot be bigger than 300kg";
                    }
                  } catch (e){
                    return "Current weight must be a number";
                  }
                  return null;
                }),
                _singleInput("Your target weight", "E.g: 70", _weightTarget, TextInputType.number, Icons.add, false, (text){
                  int currentWeight = 0;
                  if (_currentWeight.text.isEmpty){
                    return null;
                  }
                  try{
                    currentWeight = int.parse(_currentWeight.text);
                    if (currentWeight < 0 || currentWeight > 300){
                      return null;
                    }
                  } catch (e){
                    return null;
                  }

                  if (text == null || text.isEmpty){
                    return "Target weight cannot be empty";
                  }
                  try{
                    int weight = int.parse(text);
                    if (weight < 0){
                      return "Target weight cannot be negative";
                    }
                    if (weight > 300){
                      return "Target weight cannot be bigger than 300kg";
                    }
                    if (weight > currentWeight){
                      return "Target weight cannot be bigger than current weight";
                    }
                  } catch (e){
                    return "Target weight must be a number";
                  }
                  return null;
                }),
                _dropdown(),
                _multiInput("Your description", "Your description...", _description, 1000),

                const SizedBox(
                  height: 30,
                ),
                FlatButton(
                  height: 64,
                  color: AppColors.PRIMARY_COLOR,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState?.save();
                      campaignModel!.description = _description.text;
                      campaignModel!.targetWeight = int.parse(_weightTarget.text);
                      campaignModel!.currentWeight = int.parse(_currentWeight.text);
                      campaignModel!.spendTimeForTraining = spendTimeForTraining;
                      CustomerService service = CustomerService();
                      bool result = await service.updateCampaign(campaignModel, user);
                      if (result){
                        CustomToast.makeToast("Update successfully");
                      } else {
                        CustomToast.makeToast("Some thing went wrong! Try again");
                      }
                    }
                  },
                  minWidth: 300,
                  child: const Text(
                    'Update campaign',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
