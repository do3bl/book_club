// import 'package:book_club/states/currentGroup.dart';
// import 'package:book_club/widgets/ourContainer.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../states/currentUser.dart';

// class OurReivew extends StatefulWidget {
//   const OurReivew({Key? key}) : super(key: key);

//   @override
//   State<OurReivew> createState() => _OurReivewState();
// }

// class _OurReivewState extends State<OurReivew> {
//   int _dropDownValue = 1;
//   TextEditingController _reviewController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     CurrentGroup _currentGroup =
//         Provider.of<CurrentGroup>(context, listen: false);
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Row(
//                 children: [BackButton()],
//               ),
//             ),
//             SizedBox(
//               height: MediaQuery.of(context).size.height / 3,
//             ),
//             Padding(
//               padding: EdgeInsets.all(20.0),
//               child: OurContainer(
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Text("rate book 1 -10 "),
//                         DropdownButton<int>(
//                           value: _dropDownValue,
//                           icon: Icon(Icons.arrow_downward),
//                           iconSize: 24,
//                           elevation: 12,
//                           style: TextStyle(color: Colors.deepPurple),
//                           underline: Container(
//                             height: 2,
//                             color: Colors.deepPurple,
//                           ),
//                           onChanged: (newValue) {
//                             setState(() {
//                               _dropDownValue = int.parse(newValue.toString());
//                             });
//                           },
//                           items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
//                               .map<DropdownMenuItem<int>>((int value) =>
//                                   DropdownMenuItem(
//                                       value: value,
//                                       child: Text(value.toString())))
//                               .toList(),
//                         ),
//                       ],
//                     ),
//                     TextFormField(
//                       controller: _reviewController,
//                       maxLength: 6,
//                       decoration: InputDecoration(
//                         prefixIcon: Icon(Icons.group),
//                         hintText: " Add A Review",
//                       ),
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     RaisedButton(
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 100),
//                         child: Text(
//                           "Add Review",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.0),
//                         ),
//                       ),
//                       onPressed: () async {
//                         String userId =
//                             Provider.of<CurrentState>(context, listen: false)
//                                 .getCurrentUser
//                                 .uid!;
//                         CurrentGroup _currentGroup =
//                             Provider.of<CurrentGroup>(context, listen: false);
//                         _currentGroup.finisheBook(
//                             userId, _dropDownValue, _reviewController.text);
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
