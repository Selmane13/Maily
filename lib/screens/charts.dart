import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../Dimensions.dart';

class BarChartSample extends StatefulWidget {
  late String intervalle;
  late double? max;
  late List<String> lesX;
  late List<double> lesvaleurs;
  late double width;
  BarChartSample(
      {super.key,
      required this.width,
      required this.lesX,
      required this.lesvaleurs,
      required this.max,
      required this.intervalle});

  @override
  State<StatefulWidget> createState() => BarChartSampleState();
}

class BarChartSampleState extends State<BarChartSample> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> items = [];
    for (int i = 0; i < widget.width; i++) {
      items.add(makeGroupData(i, widget.lesvaleurs[i]));
    }

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
    return Container(
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: EdgeInsets.all(Dimensions.height17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  makeTransactionsIcon(),
                  SizedBox(
                    width: Dimensions.height30,
                  ),
                  const Text(
                    'Mail received',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  SizedBox(
                    width: Dimensions.height15,
                  ),
                  Text(
                    widget.intervalle,
                    style: TextStyle(color: Color(0xff77839a), fontSize: 16),
                  ),
                ],
              ),
              SizedBox(
                height: Dimensions.height38,
              ),
              Expanded(
                child: BarChart(
                  BarChartData(
                    maxY: widget.max,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.grey,
                        getTooltipItem: (a, b, c, d) => null,
                      ),
                      touchCallback: (FlTouchEvent event, response) {
                        /*
                        if (response == null || response.spot == null) {
                          setState(() {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                          });
                          return;
                        }
   
                        touchedGroupIndex = response.spot!.touchedBarGroupIndex;
   
                        setState(() {
                          if (!event.isInterestedForInteractions) {
                            touchedGroupIndex = -1;
                            showingBarGroups = List.of(rawBarGroups);
                            return;
                          }
                          showingBarGroups = List.of(rawBarGroups);
                          if (touchedGroupIndex != -1) {
                            var sum = 0.0;
                            for (final rod
                                in showingBarGroups[touchedGroupIndex].barRods) {
                              sum += rod.toY;
                            }
                            final avg = sum /
                                showingBarGroups[touchedGroupIndex]
                                    .barRods
                                    .length;
   
                            showingBarGroups[touchedGroupIndex] =
                                showingBarGroups[touchedGroupIndex].copyWith(
                              barRods: showingBarGroups[touchedGroupIndex]
                                  .barRods
                                  .map((rod) {
                                return rod.copyWith(
                                    toY: avg, color: Colors.black);
                              }).toList(),
                            );
                          }
                        });
                      */
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 50,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: Dimensions.height50,
                          interval: 1,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      border: Border(bottom: BorderSide(), left: BorderSide()),
                      show: true,
                    ),
                    barGroups: showingBarGroups,
                    gridData: FlGridData(show: true, drawVerticalLine: false),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: Dimensions.height14,
    );
    String text;
    if (value % (widget.max! / 4) == 0) {
      text = value.toString();
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = widget.lesX;

    final Widget text = Text(
      titles[value.toInt()],
      style: TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: Dimensions.height14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: Dimensions.height14, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: Color(0xffE26127),
          width: widget.width,
        ),
      ],
    );
  }

  ///cbn
  Widget makeTransactionsIcon() {
    final width = 4.5;
    final space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: Dimensions.height10,
          color: Colors.black.withOpacity(0.4),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: Dimensions.height28,
          color: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: Dimensions.height42,
          color: Colors.black.withOpacity(1),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: Dimensions.height28,
          color: Colors.black.withOpacity(0.8),
        ),
        SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: Dimensions.height10,
          color: Colors.black.withOpacity(0.4),
        ),
      ],
    );
  }
}
