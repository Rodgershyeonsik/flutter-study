import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class PersonalCard extends StatelessWidget {
  PersonalCard({Key? key}) : super(key: key);
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.lightBlue
              ),
              child: Center(
                child: GetX<Controller>(builder: (_) => Text(
                  'Name: ${controller.person().name}',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                  ),
                ),)
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue
              ),
              child: Center(
                  child: Obx(()=> Text(
                    'Age: ${controller.person().age}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ))
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              width: double.maxFinite,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.lightBlue
              ),
              child: Center(
                  child: GetX(
                    init: Controller(), // init으로 자체 Controller initialize
                    builder: (_) =>Text(
                    'Name: ${Get.find<Controller>().person().name}',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                  ),)
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateInfo();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

/*
* Obx:
*   Observable(obs)의 변화를 listen함.
*   Controller 인스턴스가 미리 다른 곳에 initialize 되어있어야 함.
* GetX:
*   Observable(obs)의 변화를 listen함.
*   자체적으로 Controller 인스턴스를 intialize 할 수도 있음.
*   Obx보다 다양한 기능을 내장하고 있어 좀 더 무거움.
* */
