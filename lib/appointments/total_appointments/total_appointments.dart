import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_checkque_pool/appointments/appointments.dart';
import 'package:flutter_app_checkque_pool/appointments/patient_details/patient_details.dart';
import 'package:flutter_app_checkque_pool/appointments/pending_appointments/pending_appointmentController.dart';
import 'package:flutter_app_checkque_pool/appointments/total_appointments/total_appointmnet_controller.dart';
import 'package:flutter_app_checkque_pool/constants/controllers.dart';
import 'package:flutter_app_checkque_pool/hero_tag/hero_tag.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pending_appointments_model.dart' as prefix;
import 'package:flutter/cupertino.dart';

import '../pending_appointments_model.dart';




class TotalAppointment extends StatefulWidget {
  const TotalAppointment({Key key}) : super(key: key);

  @override
  _TotalAppointmentState createState() => _TotalAppointmentState();
}

class _TotalAppointmentState extends State<TotalAppointment> {
  final  TotalAppointments totalController = Get.put(TotalAppointments());
  Future<PendingModel> _appointModel;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('username'+loginController.userName.toString());
    print('username'+loginController.userpassword.toString());
    _appointModel = API().Appoint();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder<PendingModel>(
          future: _appointModel,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Container(
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(

                    gradient: LinearGradient(

                      begin: Alignment.topLeft,
                      end: Alignment(3.0,
                          2.0), // 10% of the width, so there are ten blinds.
                      colors: <Color>[
                        Color(0xff80D0C9),
                        Color(0xff0093E9)
                      ], // red to yellow
                      tileMode: TileMode
                          .repeated, // repeats the gradient over the canvas
                    ),
                    boxShadow:[ BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                    ),]
                ),
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: PhotoHero(
                          photo:  "assets/cp-logo.png",
                          width: size.width * 0.3,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text("Total Appointments",
                        style: TextStyle(
                          fontSize: size.width * 0.07,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),

                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.resultData.length,
                        itemBuilder: (context, index) {
                          var Plist = snapshot.data.resultData[index];

                          return
                            Padding(
                              padding: const EdgeInsets.only(left: 50,right: 17),
                              child: InkWell(
                                onTap: () {
                                 setState(() async{
                                    PendingAppointments.email=Plist.pname;
                                    PendingAppointments.email1=Plist.docn.toString();
                                    PendingAppointments.age=Plist.pAge;
                                    PendingAppointments.ph=Plist.pmob;
                                    PendingAppointments.suffer=Plist.remarks;
                                    //PendingAppointments.appdate=Plist.date.isNumericOnly as int;
                                    PendingAppointments.amt=Plist.amut;
                                    PendingAppointments.city=Plist.pcity;
                                    //Get.to(PatientDetails());
                                  });



                                },
                                child: Card(
                                  child: ListTile(
                                    leading: Icon(Icons.perm_contact_cal_rounded),
                                    title: Text(Plist.pname,style:  TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.normal,
                                      fontSize: size.width * 0.04,
                                    ),),
                                    subtitle: Text(Plist.pcity,style:  TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontSize: size.width * 0.03,
                                    ),),
                                  ),
                                ),
                              ),);
                        },
                      )
                    ],
                  ),
                ),
              );}
            else{
              return Center(child: CircularProgressIndicator());

            }



          }),
    );
  }

 /* ref() async {
    var appointModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apdetail';
    var data = {
      'id': loginController.userName.toString(),

      // 'password': loginController.userpassword.toString()
    };
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      print(response.body);


      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      appointModel = PendingModel.fromJson(jsonMap);
      return appointModel;


    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }


  }*/
}



class API{
  Future<PendingModel> Appoint() async {
    print('loginController.userName.toString(), ${loginController.userName.toString()}');
    dynamic Id=loginController.userName.toString();
    var appointModel;
    var url = 'https://www.docllpdemo.com/checkpool/api/dapi/apdetail';
    var data = {
      'id': Id,


      // 'password': loginController.userpassword.toString()
    };
    var response = await http.post(Uri.parse(url),
        body: json.encode(data)
    );
    if (response.statusCode == 200) {
      print(response.body);


      var jsonString = response.body;
      var jsonMap = json.decode(jsonString);

      appointModel = PendingModel.fromJson(jsonMap);
      return appointModel;


    }
    else
    {
      print('response.statusCode ${response.statusCode}');
    }




  }
}