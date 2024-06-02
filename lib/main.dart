  import 'package:flutter/material.dart';
  import 'package:math_expressions/math_expressions.dart';
  import 'database.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.blue,
        ),
        home: MainPage(),
      );
    }
  }

  class MainPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hello! It's B-Calc"),
          centerTitle: true,
        ),
        backgroundColor: Colors.blue.shade100, 
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => StandardPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  "Standard",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TemperaturePage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  "Temperature",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TimePage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: Text(
                  "Time",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  class StandardPage extends StatefulWidget {
    @override
    _StandardPageState createState() => _StandardPageState();
  }

  class _StandardPageState extends State<StandardPage> {
    TextEditingController _controller = TextEditingController();
    String _output = '';
    
    void _calculate() async {
      try {
        Parser p = Parser();
        Expression exp = p.parse(_controller.text);
        ContextModel cm = ContextModel();
        double result = exp.evaluate(EvaluationType.REAL, cm);
        
        await DatabaseHelper.createItem(_controller.text, result.toString());

        setState(() {
          _output = 'Hasil : $result';
        });
      } catch (e) {
        setState(() {
          _output = 'Error';
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("B-Calc ~ Standard"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                _output,
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _controller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'Input angka ...',
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '1';
                      });
                    },
                    child: Text('1'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '2';
                      });
                    },
                    child: Text('2'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '3';
                      });
                    },
                    child: Text('3'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '+';
                      });
                    },
                    child: Text('+'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '4';
                      });
                    },
                    child: Text('4'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '5';
                      });
                    },
                    child: Text('5'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '6';
                      });
                    },
                    child: Text('6'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '-';
                      });
                    },
                    child: Text('-'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '7';
                      });
                    },
                    child: Text('7'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '8';
                      });
                    },
                    child: Text('8'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '9';
                      });
                    },
                    child: Text('9'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '*';
                      });
                    },
                    child: Text('*'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '0';
                      });
                    },
                    child: Text('0'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '.';
                      });
                    },
                    child: Text('.'),
                  ),
                  ElevatedButton(
                    onPressed: _calculate,
                    child: Text('='),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _controller.text = _controller.text + '/';
                      });
                    },
                    child: Text('/'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _controller.text = '';
                          _output = '';
                        });
                      },
                      child: Text('C', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  class TemperaturePage extends StatefulWidget {
    @override
    _TemperaturePageState createState() => _TemperaturePageState();
  }

  class _TemperaturePageState extends State<TemperaturePage> {
    String inputTemperature = '';
    String selectedFromUnit = 'Celsius';
    String selectedToUnit = 'Fahrenheit';
    String result = '';

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("B-Calc ~ Temperature"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDropdownButton('From', selectedFromUnit, _fromUnits),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                readOnly: true,
                controller: TextEditingController(text: inputTemperature),
                decoration: InputDecoration(
                  labelText: 'Enter Temperature',
                ),
              ),
              SizedBox(height: 20),
              _buildDropdownButton('To', selectedToUnit, _toUnits),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(fontSize: 20),
              ),
              _buildKeypad(),
            ],
          ),
        ),
      );
    }

    Widget _buildDropdownButton(
        String label, String selectedValue, List<String> items) {
      return DropdownButton<String>(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            if (label == 'From') {
              selectedFromUnit = value!;
            } else {
              selectedToUnit = value!;
            }
          });
        },
        items: items.map<DropdownMenuItem<String>>((String unit) {
          return DropdownMenuItem<String>(
            value: unit,
            child: Text(unit),
          );
        }).toList(),
        hint: Text(label),
      );
    }

    Widget _buildKeypad() {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('7'),
                _buildKeypadButton('8'),
                _buildKeypadButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('4'),
                _buildKeypadButton('5'),
                _buildKeypadButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('1'),
                _buildKeypadButton('2'),
                _buildKeypadButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('0'),
                _buildKeypadButton('-'),
                _buildKeypadButton('.'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 1,
                  child: _buildKeypadButton('C'),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = _convertTemperature();
                      });
                    },
                    child: Text('Convert'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildKeypadButton(String value) {
      return ElevatedButton(
        onPressed: () {
          _onKeypadButtonPressed(value);
        },
        child: Text(value),
      );
    }

    void _onKeypadButtonPressed(String value) {
      setState(() {
        if (value == 'C') {
          inputTemperature = '';
        } else if (value == '=') {
          result = _convertTemperature();

        DatabaseHelper.createItem(inputTemperature, result);
      
        } else {
          inputTemperature += value;
        }
      });
    }

    String _convertTemperature() {
      try {
        double inputTemp = double.parse(inputTemperature);

        if (selectedFromUnit == selectedToUnit) {
          return inputTemp.toStringAsFixed(2);
        }

        double resultTemp = 0.0;

        if (selectedFromUnit == 'Celsius' && selectedToUnit == 'Fahrenheit') {
          resultTemp = (inputTemp * 9 / 5) + 32;
        } else if (selectedFromUnit == 'Celsius' && selectedToUnit == 'Kelvin') {
          resultTemp = inputTemp + 273.15;
        } else if (selectedFromUnit == 'Fahrenheit' && selectedToUnit == 'Celsius') {
          resultTemp = (inputTemp - 32) * 5 / 9;
        } else if (selectedFromUnit == 'Fahrenheit' && selectedToUnit == 'Kelvin') {
          resultTemp = (inputTemp - 32) * 5 / 9 + 273.15;
        } else if (selectedFromUnit == 'Kelvin' && selectedToUnit == 'Celsius') {
          resultTemp = inputTemp - 273.15;
        } else if (selectedFromUnit == 'Kelvin' && selectedToUnit == 'Fahrenheit') {
          resultTemp = (inputTemp - 273.15) * 9 / 5 + 32;
        }

        return resultTemp.toStringAsFixed(2);
      } catch (e) {
        return 'Invalid Input';
      }
    }

    List<String> _fromUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
    List<String> _toUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];
  }

  class TimePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("B-Calc ~ Time"),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: TimeConverter(),
        ),
      );
    }
  }

  class TimeConverter extends StatefulWidget {
    @override
    _TimeConverterState createState() => _TimeConverterState();
  }

  class _TimeConverterState extends State<TimeConverter> {
    String inputTime = '';
    String selectedFromUnit = 'Seconds';
    String selectedToUnit = 'Minutes';
    String result = '';

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDropdownButton('From', selectedFromUnit, _fromUnits),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              readOnly: true,
              controller: TextEditingController(text: inputTime),
              decoration: InputDecoration(
                labelText: 'Input angka ...',
              ),
            ),
            SizedBox(height: 20),
            _buildDropdownButton('To', selectedToUnit, _toUnits),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 20),
            ),
            _buildKeypad(),
          ],
        ),
      );
    }

    Widget _buildDropdownButton(
        String label, String selectedValue, List<String> items) {
      return DropdownButton<String>(
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            if (label == 'From') {
              selectedFromUnit = value!;
            } else {
              selectedToUnit = value!;
            }
          });
        },
        items: items.map<DropdownMenuItem<String>>((String unit) {
          return DropdownMenuItem<String>(
            value: unit,
            child: Text(unit),
          );
        }).toList(),
        hint: Text(label),
      );
    }

    Widget _buildKeypad() {
      return Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('7'),
                _buildKeypadButton('8'),
                _buildKeypadButton('9'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('4'),
                _buildKeypadButton('5'),
                _buildKeypadButton('6'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('1'),
                _buildKeypadButton('2'),
                _buildKeypadButton('3'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildKeypadButton('0'),
                _buildKeypadButton('.'),
                _buildKeypadButton('C'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = _convertTime();
                      });
                    },
                    child: Text('Convert'),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildKeypadButton(String value) {
      return ElevatedButton(
        onPressed: () {
          _onKeypadButtonPressed(value);
        },
        child: Text(value),
      );
    }

    void _onKeypadButtonPressed(String value) {
      setState(() {
        if (value == 'C') {
          inputTime = '';
        } else if (value == '=') {
          result = _convertTime();
        } else {
          inputTime += value;
        }
      });
    }

    String _convertTime() {
      try {
        double inputTimeValue = double.parse(inputTime);

        if (selectedFromUnit == selectedToUnit) {
          return inputTimeValue.toStringAsFixed(2);
        }

        double resultTime = 0.0;

        if (selectedFromUnit == 'Seconds' && selectedToUnit == 'Minutes') {
          resultTime = inputTimeValue / 60;
        } else if (selectedFromUnit == 'Seconds' && selectedToUnit == 'Hours') {
          resultTime = inputTimeValue / 3600;
        } else if (selectedFromUnit == 'Seconds' && selectedToUnit == 'Days') {
          resultTime = inputTimeValue / (3600 * 24);
        } else if (selectedFromUnit == 'Seconds' && selectedToUnit == 'Months') {
          resultTime = inputTimeValue / (3600 * 24 * 30);
        } else if (selectedFromUnit == 'Seconds' && selectedToUnit == 'Years') {
          resultTime = inputTimeValue / (3600 * 24 * 365);
        } else if (selectedFromUnit == 'Minutes' && selectedToUnit == 'Seconds') {
          resultTime = inputTimeValue * 60;
        } else if (selectedFromUnit == 'Minutes' && selectedToUnit == 'Hours') {
          resultTime = inputTimeValue / 60;
        } else if (selectedFromUnit == 'Minutes' && selectedToUnit == 'Days') {
          resultTime = inputTimeValue / 1440; // 24 hours in a day
        } else if (selectedFromUnit == 'Minutes' && selectedToUnit == 'Months') {
          resultTime = inputTimeValue / (1440 * 30);
        } else if (selectedFromUnit == 'Minutes' && selectedToUnit == 'Years') {
          resultTime = inputTimeValue / (1440 * 365);
        } else if (selectedFromUnit == 'Hours' && selectedToUnit == 'Seconds') {
          resultTime = inputTimeValue * 3600;
        } else if (selectedFromUnit == 'Hours' && selectedToUnit == 'Minutes') {
          resultTime = inputTimeValue * 60;
        } else if (selectedFromUnit == 'Hours' && selectedToUnit == 'Days') {
          resultTime = inputTimeValue / 24;
        } else if (selectedFromUnit == 'Hours' && selectedToUnit == 'Months') {
          resultTime = inputTimeValue / (24 * 30);
        } else if (selectedFromUnit == 'Hours' && selectedToUnit == 'Years') {
          resultTime = inputTimeValue / (24 * 365);
        } else if (selectedFromUnit == 'Days' && selectedToUnit == 'Seconds') {
          resultTime = inputTimeValue * (3600 * 24);
        } else if (selectedFromUnit == 'Days' && selectedToUnit == 'Minutes') {
          resultTime = inputTimeValue * 1440; // 24 hours in a day
        } else if (selectedFromUnit == 'Days' && selectedToUnit == 'Hours') {
          resultTime = inputTimeValue * 24;
        } else if (selectedFromUnit == 'Days' && selectedToUnit == 'Months') {
          resultTime = inputTimeValue / 30;
        } else if (selectedFromUnit == 'Days' && selectedToUnit == 'Years') {
          resultTime = inputTimeValue / 365;
        } else if (selectedFromUnit == 'Months' && selectedToUnit == 'Seconds') {
          resultTime = inputTimeValue * (3600 * 24 * 30);
        } else if (selectedFromUnit == 'Months' && selectedToUnit == 'Minutes') {
          resultTime = inputTimeValue * (1440 * 30);
        } else if (selectedFromUnit == 'Months' && selectedToUnit == 'Hours') {
          resultTime = inputTimeValue * (24 * 30);
        } else if (selectedFromUnit == 'Months' && selectedToUnit == 'Days') {
          resultTime = inputTimeValue * 30;
        } else if (selectedFromUnit == 'Months' && selectedToUnit == 'Years') {
          resultTime = inputTimeValue / 12;
        } else if (selectedFromUnit == 'Years' && selectedToUnit == 'Seconds') {
          resultTime = inputTimeValue * (3600 * 24 * 365);
        } else if (selectedFromUnit == 'Years' && selectedToUnit == 'Minutes') {
          resultTime = inputTimeValue * (1440 * 365);
        } else if (selectedFromUnit == 'Years' && selectedToUnit == 'Hours') {
          resultTime = inputTimeValue * (24 * 365);
        } else if (selectedFromUnit == 'Years' && selectedToUnit == 'Days') {
          resultTime = inputTimeValue * 365;
        } else if (selectedFromUnit == 'Years' && selectedToUnit == 'Months') {
          resultTime = inputTimeValue * 12;
        }

        return resultTime.toStringAsFixed(2);
      } catch (e) {
        return 'Invalid Input';
      }
    }

    List<String> _fromUnits = ['Seconds', 'Minutes', 'Hours', 'Days', 'Months', 'Years'];
    List<String> _toUnits = ['Seconds', 'Minutes', 'Hours', 'Days', 'Months', 'Years'];
  }

  class HistoryPage extends StatefulWidget {
    @override
    _HistoryPageState createState() => _HistoryPageState();
  }
  class _HistoryPageState extends State<HistoryPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("History"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: DatabaseHelper.getItems(),
          builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              List<Map<String, dynamic>> items = snapshot.data ?? [];
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['title'] ?? ''),
                    subtitle: Text(items[index]['description'] ?? ''),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        DatabaseHelper.deleteItem(items[index]['id']);
                        // Refresh the list after deletion
                        setState(() {});
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      );
    }
  }