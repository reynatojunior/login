import 'package:flutter/material.dart';
import 'package:login/repositories/nivel_repository.dart';
import 'package:login/shared/widgets/text_label.dart';

class DadosCadastraisPage extends StatefulWidget {
  const DadosCadastraisPage({super.key});

  @override
  State<DadosCadastraisPage> createState() => _DadosCadastraisPageState();
}

class _DadosCadastraisPageState extends State<DadosCadastraisPage> {
  TextEditingController nomeController = TextEditingController(text: "");
  TextEditingController dataNascimentoController =
      TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepository();
  var niveis = [];
  var nivelSelecionado = "";

  @override
  void initState() {
    // TODO: implement initState
    niveis = nivelRepository.retornaNiveis();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlueAccent,
          title: Text("Meus dados"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextLabel(texto: "Nome"),
            TextField(
              controller: nomeController,
            ),
            TextLabel(texto: "Data de Nascimento"),
            TextField(
              controller: dataNascimentoController,
              readOnly: true,
              onTap: () async {
                var data = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900, 1, 1),
                    lastDate: DateTime(2030, 12, 31));
                if (data != null) {
                  dataNascimentoController.text = data.toString();
                  dataNascimento = data;
                }
              },
            ),
            TextLabel(texto: "Nível de experiência"),
            Column(
                children: niveis
                    .map((nivel) => RadioListTile(
                        dense: true,
                        title: Text(nivel.toString()),
                        selected: nivelSelecionado == nivel,
                        value: nivel,
                        groupValue: nivelSelecionado,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            nivelSelecionado = value.toString();
                          });
                        }))
                    .toList()),
            TextButton(
              onPressed: () {
                print(nomeController.text);
              },
              child: Text("Salvar"),
            ),
          ]),
        ),
      ),
    );
  }
}
