import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference _Student =
      FirebaseFirestore.instance.collection('Student');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _Student.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount:  streamSnapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['dept'].toString()),
                      ),
                    );
                  });
            }
          }),
    );
  }
}
/*body: Center(
child: FutureBuilder<List<Grocery>>(
future: DatabaseHelper.instance.getGroceries(),
builder:
(BuildContext context, AsyncSnapshot<List<Grocery>> snapshot) {
if (!snapshot.hasData) {
return const Center(child: Text('Loading...'));
}
return snapshot.data!.isEmpty
? const Center(child: Text('No Grocery in List.'))
    : ListView(
children: snapshot.data!.map((grocery) {
return Center(
child: Card(
color: selectedId == grocery.id
? Colors.white70
    : Colors.white,
child: ListTile(
title: Text(grocery.name),
onTap: () {
setState(() {
if (selectedId == null) {
textController.text = grocery.name;
selectedId = grocery.id;
} else {
textController.text = '';
selectedId = null;
}
});
},
onLongPress: () {
setState(() {
var deleted = DatabaseHelper.instance.remove(grocery.id);
print (deleted);
});
},
),
),
);*/