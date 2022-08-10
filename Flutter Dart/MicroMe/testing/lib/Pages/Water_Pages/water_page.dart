
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;   // in pubspec.yaml dependencies  pie_chart: "5.1.0" //
import 'package:flutter/services.dart';
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/water_model.dart';
import 'package:testing/Models/water_goal_model.dart';
import 'package:intl/intl.dart';

// ****************** Structure *************************
// 
//                                COLUMN
// Container   |------------------------------------------------|  
//             |  WATER PAGE                                    |
//             |------------------------------------------------|
//             |                Title                           |
//             |             PIE-CHART                           |  @https://www.youtube.com/watch?v=NvTQAzGCh5U
//             | Change Goal option
//             | History: 
//             |     (trash) List Tile 1                        |  @https://www.youtube.com/watch?v=XBeYlgjZbms
//             |             List Tile 2 
//             |                 ...
//             __________________________________________________


dynamic totalWater;
dynamic goalWater;

//******************* Water Class *******************

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);
  

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  // Controllers for goal and added amounts //
  late TextEditingController controller;
  String amount = '0';                        // amount user has drank
  String goal = '100';                        // user's set goal
  TimeOfDay time = TimeOfDay.now();           // Time user has added new water entry

  // Pie chart set to UI displaying amount drank //
  Map<String, double> dataMap = {
    "left to drink " : 100,
    "drank "         : 0,
  };

  // Color list to control color of our pie chart //
  List<Color> pieChartColorList = [
    const Color.fromARGB(60, 104, 104, 176),
    const Color.fromARGB(255, 91, 121, 192),
  ];

  // initiate controller to access submit entries for new water and new goal settings //
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    setGoal().then((value) {goalWater = value; });
    updateTotal().then((value) { totalWater = value; });
    updatePieChart();
  }
  
  // clean up the controller after updating entries //
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView (
        child: Column(
          children:<Widget> [
            Container(
              margin: const EdgeInsets.all(30),
              child: const Text('Daily Water Intake',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35),
                      ),
            ),
            // Goal Setting Container, Allows user to change their goal //
            ElevatedButton(
              child: const Text('Change Goal', style: TextStyle(fontSize: 15.0),),
              onPressed: () async {
                final goal = await openDialog();
                if ( goal == null || goal.isEmpty ) return; 
                setState(
                  () => this.goal = goal
                );
                createWaterGoal(int.parse(goal));
                setGoal().then((value) {goalWater = value; });
                updatePieChart();
              } // on pressed for goal amounts
            ),
            // Pie Chart UI Container //
            Container(
              margin: const EdgeInsets.all(30),
              alignment: Alignment.center,
              child: pie_chart.PieChart(
                    dataMap: dataMap,
                    colorList: pieChartColorList,
                    chartRadius: MediaQuery.of(context).size.width / 2,
                    chartType: pie_chart.ChartType.ring,
                    ringStrokeWidth: 24,
                    animationDuration: const Duration(seconds: 2),
                    centerText: totalWater.toString() + " / " + goalWater.toString() + " oz",
                    chartValuesOptions: const pie_chart.ChartValuesOptions( showChartValues: false ),
                    legendOptions: const pie_chart.LegendOptions( showLegends: false,),
                  ), 
            ),
            // Past Entry List View, Allows User to delete mistake entries and view history log for water //
            
          ]
        ),
      ), 
      // Allows user to add new water //
      floatingActionButton: buildNavigateButton(),
    );
  }

  //Button to control adding more water
  //Expected: opens a text entry where user submits a new value that changes the pi chart
  Widget buildNavigateButton() => FloatingActionButton(
    child: const Icon(Icons.add),
    // When pressed updates the (dataMap) map for pie chart to allow values to change // 
    onPressed: () async {
      final amount = await openDialog();
      if ( amount == null || amount.isEmpty ) return;        // Toss out invalid values
      setState(
        () => this.amount = amount,
      );

      final water = Water(
          amount : int.parse(amount),
          createdTime: DateFormat('yyyy-MM-dd').format(DateTime.now())
      );

      await MicromeDatabase.instance.createWater(water);

      updateTotal();
      updatePieChart();
    }
  );


  /* Function - openDialog
    Updates Controller by allowing floating button to add water.
      Returns a string that is amount of water inputted by user
      https://www.youtube.com/watch?v=D6icsXS8NeA */
  Future<String?> openDialog() => showDialog<String>(
  context: context, builder: (context) => AlertDialog(
      title: const Text('Enter Amount: '),
      content: TextField(
        autofocus: true,                                              // keeps the keyboard open
        decoration: const InputDecoration(hintText: '32 oz'),
        controller: controller,
        keyboardType: TextInputType.number, // Set keyboard to number keypad
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))], // Only integers allowed
      ), // Text Pop Up
      actions: [
        TextButton(
          child: const Text('SUBMIT'),
          onPressed: submit,
        ),
      ]
    ) // AlertDialog
  );

  // Closes the input pop up and passes controller.text back to body //
  void submit () {
    Navigator.of(context).pop(controller.text);
  }

  double findPercentDrank(total) {
    if (total == null) {
      return 0;
    }
    else {
      return (total/goalWater);
    }
  }


  /*
   * Helper to update total and grab value from database
   */
  Future updateTotal() async {
    return await MicromeDatabase.instance.returnTodaySumWater();
  }

  /*
   * Helper to update goal and grab value from database
   */
  Future setGoal() async {
    dynamic goal = await MicromeDatabase.instance.getWaterGoal();
    if (goal.toString() == "null") {
      return 100;
    }
    return goal;
  }

  /*
   * Helper to update pieChart UI
   */
  void updatePieChart() {
    double percentageDrank = findPercentDrank(totalWater);
    // Update values for pie chart so it changes
    dataMap.update( "left to drink ", (value) => (100 - (percentageDrank)*100));
    dataMap.update( "drank ", (value) => (percentageDrank*100));
  }

  Future createWaterGoal(goalVal) async {
    dynamic waterGoal = WaterGoal(
        goal : goalVal,
        createdTime: DateFormat('yyyy-MM-dd').format(DateTime.now())
    );
    await MicromeDatabase.instance.createWaterGoal(waterGoal);
    return waterGoal;
  }

} // water

