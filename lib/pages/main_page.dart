import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:login/pages/dados_cadastrais.dart';
import 'package:login/pages/pagina1.dart';
import 'package:login/pages/pagina2.dart';
import 'package:login/pages/pagina3.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController controller = PageController(initialPage: 0);

  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text("Main Page"),
            backgroundColor: Colors.blueAccent,
            titleTextStyle: TextStyle(color: Colors.white),
          ),
          drawer: Drawer(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Text("Dados Cadastrais")),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DadosCadastraisPage()));
                    },
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Text("Termos de uso e privacidade")),
                    onTap: () {},
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Text("Configurações")),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      posicaoPagina = value;
                    });
                  },
                  children: [Pagina1Page(), Pagina2Page(), Pagina3Page()],
                ),
              ),
              BottomNavigationBar(
                  onTap: (value) {
                    controller.jumpToPage(value);
                  },
                  currentIndex: posicaoPagina,
                  items: [
                    BottomNavigationBarItem(
                        label: "Pag1", icon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        label: "Pag2", icon: Icon(Icons.add)),
                    BottomNavigationBarItem(
                        label: "Pag3", icon: Icon(Icons.person))
                  ])
            ],
          )),
    );
  }
}
