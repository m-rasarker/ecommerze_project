import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrencyToUSD extends StatefulWidget {
  @override
  _CurrencyToUSDState createState() => _CurrencyToUSDState();
}

class _CurrencyToUSDState extends State<CurrencyToUSD> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedCurrency = 'INR';
  double _convertedAmount = 0.0;

  // Example static exchange rates to USD
  final Map<String, double> _exchangeRates = {
    'INR': 0.012, // 1 INR = 0.012 USD
    'EUR': 1.07,  // 1 EUR = 1.07 USD
    'GBP': 1.25,  // 1 GBP = 1.25 USD
    'JPY': 0.0068, // 1 JPY = 0.0068 USD
    'BDT': 0.0082 // 1 BDT = 0.0082 USD
  };

  void _convertCurrency() {
    final double? amount = double.tryParse(_amountController.text);
    if (amount != null) {
      final rate = _exchangeRates[_selectedCurrency]!;
      setState(() {
        _convertedAmount = amount * rate;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid amount")),
      );
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Currency to USD')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: 'Enter Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCurrency,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCurrency = newValue!;
                });
              },
              items: _exchangeRates.keys.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(

              onPressed: _convertCurrency,
              child: Text('Convert to USD'),
            ),
            SizedBox(height: 20),
            Text(
              'USD: \$${_convertedAmount.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}