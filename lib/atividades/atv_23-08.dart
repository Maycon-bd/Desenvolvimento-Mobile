import 'package:flutter/material.dart';

class BottomNavComTabsApp extends StatelessWidget {
	const BottomNavComTabsApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'BottomNav + Tabs',
			theme: ThemeData(
				colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
			),
			home: const BottomNavComTabsPage(),
		);
	}
}

class BottomNavComTabsPage extends StatefulWidget {
	const BottomNavComTabsPage({super.key});

	@override
	State<BottomNavComTabsPage> createState() => _BottomNavComTabsPageState();
}

class _BottomNavComTabsPageState extends State<BottomNavComTabsPage> {
	int _selectedIndex = 0;

	final List<Widget> _pages = [
		const Center(child: Text('Página 1', style: TextStyle(fontSize: 24))),
		const TabsModule(),
		const Center(child: Text('Página 3', style: TextStyle(fontSize: 24))),
	];

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: const Text('BottomNavigation + Tabs')),
			body: _pages[_selectedIndex],
			bottomNavigationBar: BottomNavigationBar(
				currentIndex: _selectedIndex,
				onTap: (index) {
					setState(() {
						_selectedIndex = index;
					});
				},
				items: const [
					BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Módulo 1'),
					BottomNavigationBarItem(icon: Icon(Icons.tab), label: 'Módulo 2'),
					BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Módulo 3'),
				],
			),
		);
	}
}

class TabsModule extends StatelessWidget {
	const TabsModule({super.key});

	@override
	Widget build(BuildContext context) {
		return DefaultTabController(
			length: 3,
			child: Scaffold(
				appBar: AppBar(
					automaticallyImplyLeading: false,
					backgroundColor: Theme.of(context).colorScheme.inversePrimary,
					title: const Text('Módulo 2'),
					bottom: const TabBar(
						tabs: [
							Tab(text: 'Tab 1'),
							Tab(text: 'Tab 2'),
							Tab(text: 'Tab 3'),
						],
					),
				),
				body: const TabBarView(
					children: [
						Center(child: Text('Conteúdo da Tab 1', style: TextStyle(fontSize: 20))),
						Center(child: Text('Conteúdo da Tab 2', style: TextStyle(fontSize: 20))),
						Center(child: Text('Conteúdo da Tab 3', style: TextStyle(fontSize: 20))),
					],
				),
			),
		);
	}
}
