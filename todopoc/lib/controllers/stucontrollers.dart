import 'package:get/get.dart';
import 'package:todopoc/models/stuClass.dart';
import 'package:todopoc/dBase/dBase.dart';

class StuController extends GetxController {
  final RxList stuList = <StuClass>[].obs;
  
  Future<void> getTask()async{
   final List<Map<String, dynamic>> stu = await DBHelper().queryAllRows();
   stuList.assignAll(stu.map((data) => StuClass.fromMap(data)).toList());
  }

  addToDb(StuClass detail)async{
    await DBHelper().insertTask(detail);
    stuList.add(detail);
    getTask();
  }

  deleteFromDb(int? id)async{
    await DBHelper().delete(id!);
    getTask();
  }

  deleteAll()async{
    await DBHelper().deleteAllTasks();
    getTask();
  }

}
