import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smart_law_enforcement_system/login_signup/values/values.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {


  Map<String,List<int>> ViolatorsStatusCheck=new Map<String,List<int>>();
  bool showLoading=true;

  @override
  void initState() {
    super.initState();

    CheckVerificationStatus();
  }

  void CheckVerificationStatus()
  {
    FirebaseFirestore.instance
        .collection('Violators')
        // .orderBy('Road')
        .get()
        .then((QuerySnapshot snapshot)
    {
      snapshot.docs.map((element)
      {
        if (!ViolatorsStatusCheck.containsKey(element.data()["Road"]))
        {
          if((element.data()["Verified"].toString() == "Yes") && (element.data()["Seen"].toString() == "Yes"))
          {
            setState(()
            {
              // ViolatorsStatusCheck[element.data()['Road']]!.toList()[0] = 1;
              ViolatorsStatusCheck[element.data()['Road']]=[1,0];
            });

          }
          else if((element.data()["Verified"].toString() == "No") && (element.data()["Seen"].toString() == "No"))
          {
            setState(()
            {
              // ViolatorsStatusCheck[element.data()['Road']]!.toList()[1] = 1;
              ViolatorsStatusCheck[element.data()['Road']]=[0,1];
            });
          }
        }
        else
        {
          if((element.data()["Verified"].toString() == "Yes") && (element.data()["Seen"].toString() == "Yes"))
          {
            setState(()
            {
              // ViolatorsStatusCheck[element.data()['Road']]!.toList()[0] = ViolatorsStatusCheck[element.data()['Road']]!.toList()[0]! + 1;
              List<int> Temp=ViolatorsStatusCheck[element.data()['Road']]!.toList();
              Temp[0]=Temp[0]+1;
              ViolatorsStatusCheck[element.data()['Road']]=Temp;
            });
          }
          else if((element.data()["Verified"].toString() == "No") && (element.data()["Seen"].toString() == "No"))
          {
            setState(()
            {
              // ViolatorsStatusCheck[element.data()['Road']]!.toList()[1] = ViolatorsStatusCheck[element.data()['Road']]!.toList()[1]! + 1;
              List<int> Temp=ViolatorsStatusCheck[element.data()['Road']]!.toList();
              Temp[1]=Temp[1]+1;
              ViolatorsStatusCheck[element.data()['Road']]=Temp;
            });
          }
        }
      }).toList();
    })
    .catchError((onError)=>
    {
      print("Couldn't Fetch Records : $onError")
    })
    .whenComplete(() =>
    {
      setState(()
      {
        showLoading=false;
      })
      // print("Completed")
      // print("\n\n"+ViolatorsStatusCheck.toString()+"\n\n")
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return showLoading ?
      Center(
        child: CircularProgressIndicator(),
      )
      :
      ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: ViolatorsStatusCheck.length,
      padding: EdgeInsets.all(10),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext, index) {
        return Card(
          elevation: 8,
          margin: EdgeInsets.all(10),
          color: AppColors.whiteShade2,
          shadowColor: AppColors.blackShade1,
          child: ListTile(
            // contentPadding: EdgeInsets.all(5),
            title: Container(
              child: Row(
                children: [
                  SizedBox(
                    width:120,
                    child: Text(
                      '${ViolatorsStatusCheck.keys.toList()[index]}',
                      style: TextStyle(
                          color: AppColors.blackShade1,
                      ),
                    ),
                  ),
                  SizedBox(width: 30,),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                              "Verified",
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(width: 20,),
                          Text(
                              "Pending",
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text(
                              '${ViolatorsStatusCheck.values.toList()[index][0]}',
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 22,
                              ),
                          ),
                          SizedBox(width: 50,),
                          Text(
                            '${ViolatorsStatusCheck.values.toList()[index][1]}',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
