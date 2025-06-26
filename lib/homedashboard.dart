import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeDashboard extends StatefulWidget {
  @override
  _HomeDashboardState createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  bool _balanceVisible = true;

  final List<String> categories = ['Food', 'Rent', 'Shopping', 'Travel'];
  final List<double> budget = [500, 1200, 300, 400];
  final List<double> actual = [450, 1300, 250, 500];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome back, Pavani!'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(
                _balanceVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () =>
                setState(() => _balanceVisible = !_balanceVisible),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Budget vs Actual',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 250,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              index >= 0 && index < categories.length
                                  ? categories[index]
                                  : '',
                              style: TextStyle(fontSize: 12),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  barGroups: List.generate(categories.length, (index) {
                    return BarChartGroupData(x: index, barRods: [
                      BarChartRodData(
                        toY: budget[index],
                        width: 8,
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      BarChartRodData(
                        toY: actual[index],
                        width: 8,
                        color: actual[index] > budget[index]
                            ? Colors.red
                            : Colors.greenAccent,
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ]);
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Easy Operations
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['Transfer', 'Receipt', 'Add Expense', 'Add Income']
                  .map((label) => Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.indigo[100],
                            child: Icon(Icons.add, color: Colors.indigo),
                          ),
                          SizedBox(height: 5),
                          Text(label, style: TextStyle(fontSize: 12)),
                        ],
                      ))
                  .toList(),
            ),
            SizedBox(height: 20),

            // Summary Highlights
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _summaryCard("Income", "\$10,320", Colors.green),
                _summaryCard("Expense", "\$7,450", Colors.red),
                _summaryCard("Savings", "\$2,870", Colors.blue),
              ],
            ),
            SizedBox(height: 20),

            // Recent Transactions
            Text('Recent Transactions',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Divider(),
            _transactionTile(
                "Rental Income", "+\$6,500.00", "12 July 2021", Colors.green),
            _transactionTile("Grocery Shopping", "-\$300.49", "22 July 2021",
                Colors.red),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Stats'),
          BottomNavigationBarItem(
              icon: Icon(Icons.list), label: 'Transactions'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }

  Widget _summaryCard(String title, String value, Color color) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(value, style: TextStyle(color: color, fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _transactionTile(
      String title, String amount, String date, Color color) {
    return ListTile(
      leading: Icon(Icons.account_balance_wallet, color: color),
      title: Text(title),
      subtitle: Text(date),
      trailing: Text(amount,
          style: TextStyle(color: color, fontWeight: FontWeight.bold)),
    );
  }
}
