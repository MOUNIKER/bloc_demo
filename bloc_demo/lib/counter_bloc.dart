import 'dart:async';


enum CounterAction { increment, decrement, reset }

class CounterBloc {
  int counter = 0;
  final _stateStreamController = StreamController<int>();
  StreamSink<int> get _counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  CounterBloc() {

    _eventStream.listen((event) {
      if (event == CounterAction.increment){
                counter++;
      }
      else if (event == CounterAction.decrement){
                counter--;
      }    
      else if (event == CounterAction.reset) {
        counter = 0;
      }
      _counterSink.add(counter);
    });
  }
   void dispose() {
     _stateStreamController.close();
     _eventStreamController.close();
  }
}
