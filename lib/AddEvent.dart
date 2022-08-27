import 'package:flutter/material.dart';
import 'main.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {


  // Textfield controllers

  TextEditingController title = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("StudyHelper"),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              DrawerHeader(child: Center(child: makeDarkText("Overview")),),
              ListTile(
                title: const Text("Home"),
                onTap: () => Navigator.pushNamed(context, "/"),
              ),
            ],
          ),

        ),
        body: Container(
          decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/wallpaper.jpg"))),
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Card(
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Text(
                      "Add an Event",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32
                      ),
                    ),
                    //Divider(color: Colors.grey[300],thickness: 2,),
                    SizedBox(height: 20,),
                    makeTextFieldAndText("Title", title),
                    const SizedBox(height: 10),
                    makeTextFieldAndText("Date", date),
                    const SizedBox(height: 10),
                    makeTextFieldAndText("Starting at", startTime),
                    const SizedBox(height: 10),
                    makeTextFieldAndText("Ending at", endTime),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: ()async{
                        var lol = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2022), lastDate: DateTime(2023));
                        print(lol);
                      },
                      child: const Text("Save")
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }

  Row makeTextFieldAndText(String hint, TextEditingController controller){
    return Row(
      children: [
        Text(
          hint,
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(5))
              )
            ),
            controller: controller,
          ),
        ),
      ],
    );
  }
}