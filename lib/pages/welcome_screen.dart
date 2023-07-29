import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tracker_moche/controllers/auth_controller.dart';
import 'package:tracker_moche/pages/list_screen.dart';
import 'package:tracker_moche/pages/map_screen.dart';
import 'package:tracker_moche/pages/multas_screen.dart';
import 'package:tracker_moche/pages/profile_screen.dart';

class WelcomeScreen extends StatefulWidget {
  final String userName;
  final bool isConductor;
  const WelcomeScreen(
      {super.key, required this.userName, required this.isConductor});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  String titulo = 'Mapa';
  late Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _currentScreen = MapScreen(isConductor: widget.isConductor);
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      openScale: 0.95,
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: HexColor('#fec200'),
          // gradient: LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [HexColor('#4181FF'), HexColor('#0c5fcf')],
          // ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 250),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: true,
      childDecoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      drawer: SafeArea(
          child: ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 130.0,
                    height: 130.0,
                    margin: const EdgeInsets.only(
                      top: 24.0,
                      bottom: 10.0,
                    ),
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: HexColor('#8db8f7'),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 130,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    child: Text(
                      widget.userName,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _currentScreen = const PerfilScreen(
                            //esDrawer: true,
                            );
                        titulo = 'Perfil';
                      });
                      _advancedDrawerController.hideDrawer();
                    },
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _currentScreen =
                            MapScreen(isConductor: widget.isConductor);
                        titulo = 'Mapa';
                      });
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: const Icon(Icons.map),
                    title: Text(
                      'Mapa',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _currentScreen = const ListaScreen();
                        titulo = 'Lista de conductores';
                      });
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: const Icon(Icons.list),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Lista de conductores',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      setState(() {
                        _currentScreen = const MultasScreen();
                        titulo = 'Multas';
                      });
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: const Icon(Icons.article),
                    titleAlignment: ListTileTitleAlignment.center,
                    title: Text(
                      'Multas',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      AuthController.instace.cerrarSesion();
                    },
                    leading: const Icon(Icons.logout),
                    title: Text(
                      'Cerrar sesión',
                      style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor('#fec200'),
          title: Text(
            titulo,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
        ),
        body: _currentScreen,
      ),
    );
  }

  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }
}
