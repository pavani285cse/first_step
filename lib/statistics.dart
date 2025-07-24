import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatefulWidget {
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  String selectedFilter = "Monthly";
  List<String> filters = ["Daily", "Weekly", "Monthly", "Yearly"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics & Insights'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Wrap(
                spacing: 8,
                children: filters.map((filter) {
                  return ChoiceChip(
                    label: Text(filter),
                    selected: selectedFilter == filter,
                    onSelected: (bool selected) {
                      setState(() => selectedFilter = filter);
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 20),

              
              Text('Income vs Expense',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(
              //   height: 200,
              //   child: LineChart(LineChartData(
              //     titlesData: FlTitlesData(show: false),
              //     borderData: FlBorderData(show: false),
              //     gridData: FlGridData(show: false),
              //     lineBarsData: [
              //       LineChartBarData(
              //         spots: [
              //           FlSpot(0, 2000),
              //           FlSpot(1, 3000),
              //           FlSpot(2, 2500),
              //           FlSpot(3, 4000),
              //         ],
              //         isCurved: true,
              //         color: Colors.green,
              //         barWidth: 3,
              //       ),
              //       LineChartBarData(
              //         spots: [
              //           FlSpot(0, 1800),
              //           FlSpot(1, 3500),
              //           FlSpot(2, 2200),
              //           FlSpot(3, 3800),
              //         ],
              //         isCurved: true,
              //         color: Colors.red,
              //         barWidth: 3,
              //       ),
              //     ],
              //   )),
              // ),
              SizedBox(
  height: 250,
  child: LineChart(
    LineChartData(
      minX: 0,
      maxX: 3,
      minY: 1500,
      maxY: 4500,
      titlesData: FlTitlesData(
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: (value, meta) {
              if (value == 1500) return Text('Low');
              if (value == 3000) return Text('Middle');
              if (value == 4500) return Text('High');
              return SizedBox.shrink();
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0:
                  return Text('Week 1');
                case 1:
                  return Text('Week 2');
                case 2:
                  return Text('Week 3');
                case 3:
                  return Text('Week 4');
                default:
                  return Text('');
              }
            },
          ),
        ),
        topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.indigo, width: 2),
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 500,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) => FlLine(
          color: Colors.grey[300]!,
          strokeWidth: 1,
        ),
        getDrawingVerticalLine: (value) => FlLine(
          color: Colors.grey[300]!,
          strokeWidth: 1,
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 2000),
            FlSpot(1, 3000),
            FlSpot(2, 2500),
            FlSpot(3, 4000),
          ],
          isCurved: true,
          color: Colors.green,
          barWidth: 4,
          dotData: FlDotData(show: true),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, 1800),
            FlSpot(1, 3500),
            FlSpot(2, 2200),
            FlSpot(3, 3800),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 4,
          dotData: FlDotData(show: true),
        ),
      ],
    ),
  ),
),
              SizedBox(height: 20),

          
              Text('Expense Breakdown by Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(sections: [
                    PieChartSectionData(
                        value: 40, color: Colors.blue, title: 'Rent'),
                    PieChartSectionData(
                        value: 25, color: Colors.orange, title: 'Food'),
                    PieChartSectionData(
                        value: 20, color: Colors.purple, title: 'Travel'),
                    PieChartSectionData(
                        value: 15, color: Colors.teal, title: 'Shopping'),
                  ]),
                ),
              ),
              SizedBox(height: 20),

            
              Text('Savings Rate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.65, 
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 5),
              Text('65% of your income saved this month',
                  style: TextStyle(fontSize: 12)),

              SizedBox(height: 20),

          
              Text('Top Expense Categories',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _topCategoryTile("Rent", "\$1200"),
              _topCategoryTile("Food", "\$450"),
              _topCategoryTile("Travel", "\$300"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topCategoryTile(String category, String amount) {
    return ListTile(
      leading: Icon(Icons.label, color: Colors.indigo),
      title: Text(category),
      trailing:
          Text(amount, style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }
}
