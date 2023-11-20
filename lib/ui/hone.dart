import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);
  @override
  State<TipCalculator> createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  late int _tipPercentage = 0;
  late int _personCounter = 1;
  late double _billAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
        alignment: Alignment.center,
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(20.5),
          children: [
            Container(
              height: 150,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12.0)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Total Per Person",
                      style: TextStyle(fontSize: 15,
                      color: Colors.red),),
                    Text("\$ ${calculateperperson(_billAmount, _personCounter, _tipPercentage)}", style: const TextStyle(fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(
                    color: Colors.blueGrey, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      prefixText: "Bill Amount",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                    onChanged: (String value) {
                      try {
                        _billAmount = double.parse(value);
                      } catch (exception) {
                        _billAmount = 0.0;
                      }
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("split",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold,
                          )),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (_personCounter > 1) {
                                  _personCounter--;
                                }
                              });
                            },
                            child: Container(
                              height: 40.0,
                              width: 40.0,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7.0),
                                color: Colors.grey,
                              ),
                              child: const Center(
                                child: Text("-",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0)),
                              ),
                            ),
                          ),
                          Text(
                            "$_personCounter",
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 17,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _personCounter++;
                                  });
                                },
                                child: Container(
                                  height: 40.0,
                                  width: 40.0,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(7.0)),
                                  child: const Center(
                                    child: Text(
                                      "+",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      const Text(
                        "tip",
                        style: TextStyle(color: Colors.red),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child:  Text(
                          "\$ ${(calculatetotaltip(_billAmount, _personCounter, _tipPercentage)).toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "$_tipPercentage%",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.red),
                      ),
                      Slider(
                        min: 0,
                          max: 100,
                          activeColor: Colors.red,
                          inactiveColor: Colors.grey,
                          divisions: 10,
                          value: _tipPercentage.toDouble(), onChanged: (double value){
                          setState(() {
                            _tipPercentage = value.round();
                          });
                      })
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  calculateperperson(  double billAmount, int splitby, int tipPercentage){
    var totalperperson = (calculatetotaltip(billAmount, splitby, tipPercentage) + billAmount) / splitby;
    return totalperperson.toStringAsFixed(2);

  }
  calculatetotaltip(double billAmount, int splitby, int tipPercentage ){
    double billTip = 0.0;
    if(billAmount < 0 || billAmount.toString().isEmpty || billAmount == null ){

    }else{
      billTip = (billAmount * tipPercentage ) / 100;
    }
    return billTip;
  }
}
