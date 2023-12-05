import 'package:flutter/material.dart';
import 'package:sampleapi3/controller/employee_controller.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  var nameController = TextEditingController();
  var desgController = TextEditingController();
  HomeScreenController homeScreenController = HomeScreenController();
  bool isloading = false;

  @override
  void initState() {
    print("init state");
    fetchData();
    super.initState();
  }

  Future fetchData() async {
    isloading = true;
    setState(() {});
    await homeScreenController.getData();
    isloading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
            itemCount:
                homeScreenController.decodedData["employees"]?.length ?? 0,
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(
                      homeScreenController.modelObj?.employees?[index].employeeName ?? "",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(homeScreenController
                            .modelObj?.employees?[index].designation ??
                        ""),
                    // Text(homeScreenController.modelObj?.employees?[index].id ?? ""),

                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              nameController.text = homeScreenController
                                      .modelObj
                                      ?.employees?[index]
                                      .employeeName ??
                                  "";
                              desgController.text = homeScreenController
                                      .modelObj
                                      ?.employees?[index]
                                      .designation ??
                                  "";
                              showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) => Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Details of Employee",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: TextField(
                                                  controller: nameController,
                                                  decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        gapPadding: 5),
                                                    hintText: "Employee name",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              TextField(
                                                controller: desgController,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        gapPadding: 5),
                                                    hintText: "Designation"),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    MaterialButton(
                                                      onPressed: () async {
                                                        Navigator.pop(context);
                                                        await homeScreenController.updateData(
                                                            name: nameController
                                                                .text,
                                                            designation:
                                                                desgController
                                                                    .text,
                                                            id: homeScreenController
                                                                    .modelObj
                                                                    ?.employees?[
                                                                        index]
                                                                    .id
                                                                    .toString());
                                                        isloading = true;
                                                        setState(() {});
                                                        nameController.clear();
                                                        desgController.clear();
                                                      },
                                                      child: Text(
                                                        'Update',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      color: Colors.blue,
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    MaterialButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        nameController.clear();
                                                        desgController.clear();
                                                      },
                                                      child: Text('Cancel',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      color: Colors.blue,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 30,
                            )),
                        IconButton(
                            onPressed: () async {
                              isloading = true;
                              setState(() {});
                              await homeScreenController.deleteData(
                                  homeScreenController
                                      .modelObj?.employees?[index].id);
                              isloading = true;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                              size: 30,
                            )),
                      ],
                    ),
                  ),
                )),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Details of Employee",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(gapPadding: 5),
                                  labelText: "Employee name",
                                  hintText: "Employee name",
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: desgController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(gapPadding: 5),
                                  labelText: "Designation",
                                  hintText: "Designation"),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      'CANCEL',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.blue,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      isloading = true;
                                      setState(() {});
                                      homeScreenController.addData(
                                          nameController.text,
                                          desgController.text);
                                      isloading = false;
                                      setState(() {});
                                    },
                                    child: Text('SAVE',
                                        style: TextStyle(color: Colors.white)),
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ));
  }
}
