import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Stepper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentStep = 0;
  StepperType _stepperType = StepperType.vertical;

  SwitchStepType() {
    setState(() {
      if (_stepperType == StepperType.vertical) {
        _stepperType = StepperType.horizontal;
      } else {
        _stepperType = StepperType.vertical;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              steps: _stepper(),
              physics: ClampingScrollPhysics(),
              currentStep: this._currentStep,
              type: _stepperType,
              onStepTapped: (step) {
                setState(() {
                  this._currentStep = step;
                });
              },
              onStepContinue: () {
                setState(() {
                  if (this._currentStep < this._stepper().length - 1) {
                    this._currentStep = this._currentStep + 1;
                  } else {
                    print("complete Sir");
                  }
                });
              },
              onStepCancel: () {
                setState(() {
                  if (this._currentStep > 0) {
                    this._currentStep = this._currentStep - 1;
                  } else {
                    this._currentStep = 0;
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: SwitchStepType,
      backgroundColor: Colors.blue,
      child: Icon(Icons.swap_horizontal_circle,color:Colors.white),),
    );
  }

  List<Step> _stepper() {
    List<Step> _steps = [
      Step(
        title: Text('Name'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
          ],
        ),
        isActive: _currentStep >= 0,
        state: StepState.complete,
      ),
      Step(
        title: Text('Email'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Recovery Email'),
            ),
          ],
        ),
        isActive: _currentStep >= 1,
        state: StepState.disabled,
      ),
      Step(
        title: Text('Mobile No'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Mobile No'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Alternative Mobile No'),
            ),
          ],
        ),
        isActive: _currentStep >= 2,
        state: StepState.editing,
      ),
      Step(
        title: Text('Address'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Address 1'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Address 2'),
            ),
          ],
        ),
        isActive: _currentStep >= 3,
        state: StepState.error,
      ),
      Step(
        title: Text('Password'),
        content: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Password'),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Confirm Password'),
            ),
          ],
        ),
        isActive: _currentStep >= 4,
        state: StepState.indexed,
      )
    ];
    return _steps;
  }
}
