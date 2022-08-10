
// import 'package:fl_chart/fl_chart.dart';      // fl_chart: "0.50.5"

// import 'package:flutter/material.dart';
// import 'package:testing/Pages/charts/water_data.dart';
// import 'package:testing/Pages/charts/data.dart';

// // Chart Structure @ https://github.com/JohannesMilke/fl_bar_chart_example/blob/master/lib/widget/bar_chart_widget.dart
// // Chart Dynamic @ https://stackoverflow.com/questions/70637093/how-to-update-a-chart-in-flutter-fl-chart

// class BarChartWidget extends StatelessWidget {
//   final double barWidth = 20;

//   BarChartWidget({Key? key}) : super(key: key);

//   // BarChartGroupData generateGroupData(
//   //     int x, double pilates) {
//   //   return BarChartGroupData(
//   //     x: x,
//   //     groupVertically: true,
//   //     barRods: [
//   //       BarChartRodData(
//   //         fromY: 0,
//   //         toY: pilates,
//   //         color: pilateColor,
//   //         width: 5,
//   //       ),
//   //     ],
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) => BarChart(
//         BarChartData(
//           alignment: BarChartAlignment.spaceAround,
//           maxY: 100,
//           minY: 0,
//           groupsSpace: MediaQuery.of(context).size.width * 0.05,
//           barTouchData: BarTouchData(enabled: true),
//           gridData: FlGridData(show: false),
//           borderData: FlBorderData(show: false),
//           barGroups: BarData.barData.map(
//             (data) => BarChartGroupData(
//               x: data.id,
//               barRods: [
//                 BarChartRodData(
//                   toY: data.y,
//                   width: barWidth,
//                   color: data.color,
//                   borderRadius: const BorderRadius.only(
//                       topLeft: Radius.circular(6),
//                       topRight: Radius.circular(6),
//                     ),
//                 ),
//               ],
//             ),
//           ).toList(),
//         ),
//       );

//     // String text;
//     // switch (value.toInt()) {
//     //   case 0:
//     //     text = 'Mn';
//     //     break;
//     //   case 1:
//     //     text = 'Te';
//     //     break;
//     //   case 2:
//     //     text = 'Wd';
//     //     break;
//     //   case 3:
//     //     text = 'Tu';
//     //     break;
//     //   case 4:
//     //     text = 'Fr';
//     //     break;
//     //   case 5:
//     //     text = 'St';
//     //     break;
//     //   case 6:
//     //     text = 'Sn';
//     //     break;
//     //   default:
//     //     text = '';
//     //     break;
//     // }
// }
