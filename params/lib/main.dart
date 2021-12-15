import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Ressources Relationnelles'),
            actions: [
              ContextualMenuExample(),
            ],
          ),
          body: Container(
          ),
        ),
      ),
    );
  }
}

class ContextualMenuExample extends StatefulWidget {
  const ContextualMenuExample({Key? key}) : super(key: key);

  @override
  _ContextualMenuExampleState createState() => _ContextualMenuExampleState();
}

class _ContextualMenuExampleState extends State<ContextualMenuExample> {
  bool _showMenu = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ModalEntry(
        visible: _showMenu,
        onClose: () => setState(() => _showMenu = false),
        childAnchor: Alignment.topLeft,
        menuAnchor: Alignment.topRight,
        menu: const Menu(
          children: [
            PopupMenuItem<void>(
              height: 42,
              child: Text('Paramètres'),
            ),
            PopupMenuItem<void>(
              height: 42,
              child: Text('Aide'),
            ),
          ],
        ),
        child: IconButton(
          onPressed: () => setState(() => _showMenu = true), 
        icon: Icon(Icons.more_vert))
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
    required this.children,
  }) : super(key: key);

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Card(
        elevation: 8,
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    );
  }
}

class ModalEntry extends StatelessWidget {
  const ModalEntry({
    Key? key,
    required this.onClose,
    required this.menu,
    required this.visible,
    required this.menuAnchor,
    required this.childAnchor,
    required this.child,
  }) : super(key: key);

  final VoidCallback onClose;
  final Widget menu;
  final bool visible;
  final Widget child;
  final Alignment menuAnchor;
  final Alignment childAnchor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: visible ? onClose : null,
      child: PortalEntry(
        visible: visible,
        portal: menu,
        portalAnchor: menuAnchor,
        childAnchor: childAnchor,
        child: IgnorePointer(
          ignoring: visible,
          child: child,
        ),
      ),
    );
  }
}

