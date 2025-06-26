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
              // Time Filter Chips
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

              // Income vs Expense Graph
              Text('Income vs Expense',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 200,
                child: LineChart(LineChartData(
                  titlesData: FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
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
                      barWidth: 3,
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
                      barWidth: 3,
                    ),
                  ],
                )),
              ),
              SizedBox(height: 20),

              // Pie Chart - Expense Breakdown
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

              // Savings Rate
              Text('Savings Rate',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              LinearProgressIndicator(
                value: 0.65, // 65% savings rate
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              SizedBox(height: 5),
              Text('65% of your income saved this month',
                  style: TextStyle(fontSize: 12)),

              SizedBox(height: 20),

              // Top Categories
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
