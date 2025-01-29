import 'package:flutter/material.dart';
import 'package:login/repositories/linguages_repository.dart';
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
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var nivelSelecionado = "";
  var linguagens = [];
  var linguagensSelecionadas = [];
  double salarioEscolhido = 0;
  int tempoExperiencia = 2;

  @override
  void initState() {
    // TODO: implement initState
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();

    super.initState();
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(
        DropdownMenuItem(
          child: Text(i.toString()),
          value: i, // Valor 0 corresponde ao valor inicial
        ),
      );
    }

    return itens;
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
          child: ListView(children: [
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
            TextLabel(texto: "Linguagens:"),
            Column(
              children: linguagens
                  .map((linguagem) => CheckboxListTile(
                      dense: true,
                      title: Text(linguagem),
                      value: linguagensSelecionadas.contains(linguagem),
                      onChanged: (bool? value) {
                        if (value!) {
                          setState(() {
                            linguagensSelecionadas.add(linguagem);
                          });
                        } else {
                          setState(() {
                            linguagensSelecionadas.remove(linguagem);
                          });
                        }
                      }))
                  .toList(),
            ),
            TextLabel(texto: "Tempo de experiência:"),
            DropdownButton(
              value: tempoExperiencia,
              isExpanded: true,
              items: returnItens(50),
              // Adicione outros itens conforme necessário
              onChanged: (value) {
                setState(() {
                  tempoExperiencia = value!;
                });
              },
            ),
            TextLabel(
                texto:
                    "Pretenção Salarial. R\$ ${salarioEscolhido.round().toString()}"),
            Slider(
                min: 0,
                max: 10000,
                value: salarioEscolhido,
                onChanged: (double value) {
                  setState(() {
                    salarioEscolhido = value;
                  });
                }),
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
