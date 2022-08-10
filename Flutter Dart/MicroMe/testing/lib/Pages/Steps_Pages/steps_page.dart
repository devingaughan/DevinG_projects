// Steps Class
// create each bottom nav bar item as their own navigation route
// when pushing new page we push to new navigator stack in main stack.
/*
                                    MAIN
                                     |
                                     |
                       -----------------------------
                       |             |             |
                       |             |             |
                      Water     ***Steps***      Journal
                       |             |             |
*/
// sources: https://pub.dev/packages/pedometer/example
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Utils/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  _StepsPageState createState() => _StepsPageState();
}
class _StepsPageState extends State<StepsPage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  // This line connects to the package for steps //
  late TextEditingController controller;
  late Stream<StepCount> _stepCountStream;
  // The following five fields are used to calculate, reset, and display steps //
  String _steps = '?';
  String _miles = '?';
  int extSteps = 0;
  int trueStepsGlobal = 0;
  double miles = 0;
  // The following two fields are used to set and display the user's goal //
  int goalInt = 1000; // default: 1000
  String goalVal = '?';
  // The following two fields are used to display the progress towards the user's
  // goal
  String percentString = '?';
  double percentVal = 0;

  @override

  /*
  Function - initState
    Function that initiates the state of the app on first run.
 */
  void initState() {
    super.initState();
    initPlatformState();
    controller = TextEditingController();
  }

/*
Function - storeSPint
 This function uses the shared preferences package to map an int value to a
 string key that is passed in via the steps parameter. From there, the value can
 be accessed via the string key that was passed in and the getInt sharedPref method.
*/

  Future<void> storeSPInt(String key, int val) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setInt(key, val).then((bool success) {
        return val;
      });
    });
  }

  /*
    Function - updateGoal
      This function is called everytime a stepcount event is detected.
      It "queries" the shared preference key-values to see what the
      latest goalVal that was stored was. If there are none, then it defaults
      to 1000.
   */
  void updateGoal() async {
    final SharedPreferences prefs = await _prefs;
    goalInt = prefs.getInt('storedGoal') ?? 1000;
    goalVal = goalInt.toString();
  }

/*
 Function - percentCalculation
   takes in TrueStepsGlobal and the goal and converts it into percentage
   needed to pass into the percent param in the percentageIndicator funct
   Ranges from 0.0 to 1.0. 1.0 x 100 = 100%. Cannot be above 100.
*/
  double percentCalculation(int ts, int goal) {
    double store = ts / goal;
    if(store >= 1.0) {
      return 1.0;
    }
    else {
      return store;
    }
  }

/*
Function - percentToString
 Wrapper function that takes in the double percent
 and converts it into a string. Used for displaying
 percentage on the Steps Page.
*/
  String percentToString(double percent) {
    // This 100 is not a magic number, it's purely for calculations //
    percent *= 100;
    return percent.toStringAsFixed(2);
  }

/*
Function - setDisplay
 Function that takes in trueSteps,
 calculates newSteps on reset then displays as string.
*/
  void setDisplay(int trueSteps) async {
    final SharedPreferences prefs = await _prefs;
    int subSteps = prefs.getInt('subSteps') ?? 0;
    trueSteps = trueSteps - subSteps;
    // This is a special case to ensure that the display number will not go negative
    if(trueSteps < 0) {
      trueSteps = 0;
      storeSPInt('subSteps', 0);
    }
    trueStepsGlobal = trueSteps;
    _steps = trueSteps.toString();
    miles = trueSteps / 2000;
    // This function truncates the double 'miles' to two decimal places
    // while also turning it into a string
    _miles = miles.toStringAsFixed(2);
  }

/*
Function - onStepCount
 Function takes in a event which is triggered by the pedometer.
 Starts to update the step counter and displays newly updated steps.
 Will also update the goal on every step.
*/
  void onStepCount(StepCount event) {
    setState(() {
      extSteps = event.steps;
      int trueSteps = event.steps;
      setDisplay(trueSteps);
      updateGoal();
    });
  }

  /*
Function - onStepCountError
 Function that checks if an event that is passed
 into onStepCount is an invalid type.
*/
  void onStepCountError(error) {
    setState(() {
      _steps = 'Error with Steps';
    });
  }

/*
Function - initPlatformState
 Function that initiates the streams and connects to the
 pedometer package.
*/
  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    controller = TextEditingController();
    if(!mounted) return;
  }
  @override

/*
Function - dispose
 Function that disposes of controllers when no longer needed.
*/
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Steps Taken:',
                style: TextStyle(fontSize: 30),
              ),
              Text(
                _steps,
                style: const TextStyle(fontSize: 30),
              ),
              const Divider(
                height: 45,
                thickness: 0,
                //color: Colors.white,
              ),
              LinearPercentIndicator(
                width: MediaQuery.of(context).size.width,
                animation: true,
                lineHeight: 30.0,
                animationDuration: 1000,
                percent: percentCalculation(trueStepsGlobal, goalInt),
                center: Text(percentToString(percentCalculation(trueStepsGlobal, goalInt)) + '%'),
                barRadius: const Radius.circular(16),
                progressColor: Colors.purple,
              ),
              const Divider(
                height: 45,
                thickness: 0,
                //color: Colors.white,
              ),
              Text(
                'Goal: $goalVal',
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                  child: const Text(
                      'Change Goal',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20)
                  ),
                  onPressed: () async {
                    final goal = await openDialog();
                    if (goal == null || goal.isEmpty) return; // TODO: Toss out invalid values
                    setState(() {
                      goalVal = goal;
                    });
                    goalInt = int.parse(goalVal);
                    storeSPInt('storedGoal', int.parse(goalVal));
                  }
              ),
              const Divider(
                height: 40,
                thickness: 0,
                //color: Colors.white,
              ),
              Text(
                'You walked $_miles miles',
                style: const TextStyle(fontSize: 30),
              ),
              ElevatedButton(
                child: const Text(
                  'Reset Steps',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () async {
                  storeSPInt('subSteps', extSteps);
                },
              )
            ],
          ),
        )
    );
  }


  // This code was adapted from 'Water_page.dart'
  Future<String?> openDialog() => showDialog<String>(
      context: context, builder: (context) => AlertDialog(
      title: const Text('# of steps '),
      content: TextField(
        autofocus: true,                                              // keeps the keyboard open
        decoration: const InputDecoration(hintText: '1000'),
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
}