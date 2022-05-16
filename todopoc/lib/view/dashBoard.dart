import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
import 'package:todopoc/models/stuClass.dart';
import 'package:todopoc/controllers/stucontrollers.dart';
import 'package:get/get.dart';
import 'package:todopoc/view/addDetailsScreen.dart';
import 'package:todopoc/view/detailsScreen.dart';


class DashBoard extends StatefulWidget {
  const DashBoard({ Key? key }) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final StuController _stuController = Get.put(StuController());

  void initState() {
    // TODO: implement initState
    super.initState();
    //  if (SchedulerBinding.instance?.schedulerPhase == SchedulerPhase.persistentCallbacks) {
    //     SchedulerBinding.instance?.addPostFrameCallback((_) {
    //       print("SchedulerBinding");
    //     });
    //  }
    _stuController.getTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DashBoard")),

      body: Container(
        child: _lists(),
      ),

      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () => Get.to(() => AddDetailsScreen(),),
      ),
    );
  }

Widget _lists(){
  return Expanded(
    child: Obx((){
    if (_stuController.stuList.isEmpty) {
        return Container();
    } else {
      return Container(
        child: ListView.builder(
           itemCount: _stuController.stuList.length,
           itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text( _stuController.stuList[index].name),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _stuController.deleteFromDb(_stuController.stuList[index].id);
                    },
                  ),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(
                          _stuController.stuList[index]
                        ),
                      ),
                    );
                  },
                );
              }
         )
      );
    }
  }
  )
  );
}

}