import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller = TextEditingController();
  var _list = [];

  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: .center,
              children: [
                const Text('You wrote: '),
                Text(
                  _controller.text,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Expanded(
                  child: ReorderableListView.builder(
                    itemCount: _list.length,
                    itemBuilder: (context, index){
                      final item = _list[index];

                      return ListTile(
                        key: ValueKey("$item-$index"),
                        title: Text(item),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: (){
                            setState((){
                              print("This index was removed: ${index}");
                              _list.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                    onReorder: (int oldIndex, int newIndex){
                      setState((){
                        if (oldIndex < newIndex){
                          newIndex -= 1;
                        }
                        final item = _list.removeAt(oldIndex);
                        _list.insert(newIndex, item);
                      });
                    }
                  ),
                ),
              ]
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 2.5, 5),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter a task or idea',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(2.5, 0, 5, 5),
                child: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: (){
                    setState((){
                      _list.add(_controller.text);
                      _controller.clear();
                    });
                  },
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}
