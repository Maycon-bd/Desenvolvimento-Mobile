import 'package:flutter/material.dart';



class MicroFormData {
  String nomeCompleto;
  DateTime? dataNascimento;
  String sexo;

  MicroFormData({
    this.nomeCompleto = '',
    this.dataNascimento,
    this.sexo = 'Homem',
  });
}
class CarrosselMicroFormularioApp extends StatelessWidget {
  const CarrosselMicroFormularioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrossel de Micro-Formulários',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Carrossel de Micro-Formulários'),
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
  List<MicroFormData> forms = List.generate(5, (_) => MicroFormData());
  final PageController _pageController = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            const Text(
              'Carrossel de Micro-Formulários',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 280,
              child: PageView.builder(
                controller: _pageController,
                itemCount: forms.length,
                itemBuilder: (context, index) {
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = ((_pageController.page ?? _pageController.initialPage).toDouble()) - index;
                        value = (1 - (value.abs() * 0.2)).clamp(0.8, 1.0);
                      }
                      return Center(
                        child: Transform.scale(
                          scale: value,
                          child: MicroFormCard(
                            data: forms[index],
                            onChanged: (newData) {
                              setState(() {
                                forms[index] = newData;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MicroFormCard extends StatefulWidget {
  final MicroFormData data;
  final ValueChanged<MicroFormData> onChanged;

  const MicroFormCard({super.key, required this.data, required this.onChanged});

  @override
  State<MicroFormCard> createState() => _MicroFormCardState();
}

class _MicroFormCardState extends State<MicroFormCard> {
  late TextEditingController _nomeController;
  late DateTime? _dataNascimento;
  late String _sexo;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.data.nomeCompleto);
    _dataNascimento = widget.data.dataNascimento;
    _sexo = widget.data.sexo;
  }

  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  void _updateForm() {
    widget.onChanged(MicroFormData(
      nomeCompleto: _nomeController.text,
      dataNascimento: _dataNascimento,
      sexo: _sexo,
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final agora = DateTime.now();
    final dataInicial = _dataNascimento ?? DateTime(agora.year - 18, agora.month, agora.day);
    final selecionada = await showDatePicker(
      context: context,
      initialDate: dataInicial,
      firstDate: DateTime(1900),
      lastDate: agora,
    );
    if (selecionada != null) {
      setState(() {
        _dataNascimento = selecionada;
        _updateForm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Micro-Formulário', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome Completo'),
              onChanged: (_) => _updateForm(),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    hintText: 'Selecione a data',
                  ),
                  controller: TextEditingController(
                    text: _dataNascimento == null
                        ? ''
                        : '${_dataNascimento!.day.toString().padLeft(2, '0')}/${_dataNascimento!.month.toString().padLeft(2, '0')}/${_dataNascimento!.year}',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _sexo,
              decoration: const InputDecoration(labelText: 'Sexo'),
              items: const [
                DropdownMenuItem(value: 'Homem', child: Text('Homem')),
                DropdownMenuItem(value: 'Mulher', child: Text('Mulher')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _sexo = value;
                    _updateForm();
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
