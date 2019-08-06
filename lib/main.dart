import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final title = "Dismissible Demo";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = List<String>.generate(6, (i) => "item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('$item removed'),
                    action: SnackBarAction(
                      label: 'UNDO',
                      textColor: Colors.orange,
                      onPressed: () => setState(() {
                        items.insert(index, item);
                      }),
                    ),
                  ));
                });
              },
              background: Container(
                color: Colors.red,
                alignment: AlignmentDirectional.centerStart,
                padding: EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: AlignmentDirectional.centerEnd,
                padding: EdgeInsets.only(right: 16),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: Container(
                height: 84,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black12)),
                ),
                child: ListTile(
                  title: Text(item),
                  trailing: Text(item),
                ),
              ),
            );
          },
        ));
  }
}
