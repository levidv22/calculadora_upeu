import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Check',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
  useMaterial3: true,

  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF023052),
  ).copyWith(
    primary: const Color(0xFF023052),
    surface: Colors.white,
  ),

  scaffoldBackgroundColor: const Color(0xFFF4F6F8),

        cardTheme: const CardThemeData(
  elevation: 0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(16),
    ),
    side: BorderSide(
      color: Color(0xFFE2E8F0),
      width: 1,
    ),
  ),
  margin: EdgeInsets.only(bottom: 12),
),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFCBD5E1)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            borderSide: BorderSide(color: Color(0xFF023052), width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// --- SPLASH SCREEN ---
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const PromedioPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF023052),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                size: 80,
                color: Color(0xFF023052),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Welcome Academic Check",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Gestión de Notas Eficiente",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 14,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 48),
            const SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- PROMEDIO PAGE ---
class PromedioPage extends StatefulWidget {
  const PromedioPage({super.key});

  @override
  State<PromedioPage> createState() => _PromedioPageState();
}

class _PromedioPageState extends State<PromedioPage> {
  bool _pesosExpandidos = false;

  final _u1Es = TextEditingController();
  final _u1Ep = TextEditingController();
  final _u2Es = TextEditingController();
  final _u2Ep = TextEditingController();
  final _u3Es = TextEditingController();
  final _u3Ep = TextEditingController();
  final _ecg = TextEditingController();

  final _wU1Es = TextEditingController(text: "5");
  final _wU1Ep = TextEditingController(text: "15");
  final _wU2Es = TextEditingController(text: "5");
  final _wU2Ep = TextEditingController(text: "30");
  final _wU3Es = TextEditingController(text: "10");
  final _wU3Ep = TextEditingController(text: "25");
  
  final _wTotalEs = TextEditingController(text: "20");
  final _wTotalEp = TextEditingController(text: "70");
  final _wTotalEcg = TextEditingController(text: "10");

  double? _notaFinal;
  String _mensaje = "";

  void _calcular() {
    setState(() {
      double nU1es = double.tryParse(_u1Es.text) ?? 0;
      double nU1ep = double.tryParse(_u1Ep.text) ?? 0;
      double nU2es = double.tryParse(_u2Es.text) ?? 0;
      double nU2ep = double.tryParse(_u2Ep.text) ?? 0;
      double nU3es = double.tryParse(_u3Es.text) ?? 0;
      double nU3ep = double.tryParse(_u3Ep.text) ?? 0;
      double nEcg = double.tryParse(_ecg.text) ?? 0;

      double wU1es = double.tryParse(_wU1Es.text) ?? 0;
      double wU1ep = double.tryParse(_wU1Ep.text) ?? 0;
      double wU2es = double.tryParse(_wU2Es.text) ?? 0;
      double wU2ep = double.tryParse(_wU2Ep.text) ?? 0;
      double wU3es = double.tryParse(_wU3Es.text) ?? 0;
      double wU3ep = double.tryParse(_wU3Ep.text) ?? 0;
      
      double wT_Es = (double.tryParse(_wTotalEs.text) ?? 0) / 100;
      double wT_Ep = (double.tryParse(_wTotalEp.text) ?? 0) / 100;
      double wT_Ecg = (double.tryParse(_wTotalEcg.text) ?? 0) / 100;

      double sumaPesosEs = wU1es + wU2es + wU3es;
      double sumaPesosEp = wU1ep + wU2ep + wU3ep;

      double promedioES = sumaPesosEs > 0 ? (nU1es * wU1es + nU2es * wU2es + nU3es * wU3es) / sumaPesosEs : 0;
      double promedioEP = sumaPesosEp > 0 ? (nU1ep * wU1ep + nU2ep * wU2ep + nU3ep * wU3ep) / sumaPesosEp : 0;

      if (promedioEP < 12.50) {
        _notaFinal = promedioEP;
        _mensaje = "Desaprobado: EP < 12.5";
      } else {
        _notaFinal = (promedioES * wT_Es) + (promedioEP * wT_Ep) + (nEcg * wT_Ecg);
        _mensaje = _notaFinal! >= 10.5 ? "¡Aprobado!" : "Desaprobado";
      }
    });
  }

  void _reset() {
    setState(() {
      for (var c in [_u1Es, _u1Ep, _u2Es, _u2Ep, _u3Es, _u3Ep, _ecg]) {
        c.clear();
      }
      _notaFinal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF023052),
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 22),
            SizedBox(width: 8),
            Text(
              "Academic Check", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 0.5),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    onTap: () => setState(() => _pesosExpandidos = !_pesosExpandidos),
                    leading: const Icon(Icons.tune_rounded, color: Color(0xFF023052)),
                    title: const Text(
                      "CONFIGURACIÓN DE PESOS (%)", 
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF023052), letterSpacing: 0.5),
                    ),
                    trailing: Icon(
                      _pesosExpandidos ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: const Color(0xFF023052),
                    ),
                    dense: true,
                  ),
                  if (_pesosExpandidos)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          const Divider(height: 1, color: Color(0xFFF1F5F9)),
                          const SizedBox(height: 12),
                          _buildWeightRow("U1", _wU1Es, _wU1Ep),
                          _buildWeightRow("U2", _wU2Es, _wU2Ep),
                          _buildWeightRow("U3", _wU3Es, _wU3Ep),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildSmallInput(_wTotalEs, "T. ES %")),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallInput(_wTotalEp, "T. EP %")),
                              const SizedBox(width: 8),
                              Expanded(child: _buildSmallInput(_wTotalEcg, "T. ECG %")),
                            ],
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(height: 4),

            _buildUnidadCard("UNIDAD 1", _u1Es, "Nota ES", _u1Ep, "Nota EP"),
            _buildUnidadCard("UNIDAD 2", _u2Es, "Nota ES", _u2Ep, "Nota EP"),
            _buildUnidadCard("UNIDAD 3", _u3Es, "Nota ES", _u3Ep, "Nota EP"),
            
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _ecg,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: "Nota ECG (Competencia Genérica)",
                    prefixIcon: Icon(Icons.star_rounded, color: Color(0xFF023052)),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calcular,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF023052),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text("CALCULAR", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: _reset,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF023052),
                      side: const BorderSide(color: Color(0xFF023052), width: 1.5),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                    child: const Text("RESET", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1)),
                  ),
                ),
              ],
            ),

            if (_notaFinal != null) ...[
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border(
  top: BorderSide(
    color: _notaFinal! >= 10.5
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444),
    width: 2,
  ),
  bottom: BorderSide(
    color: _notaFinal! >= 10.5
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444),
    width: 2,
  ),
  left: BorderSide(
    color: _notaFinal! >= 10.5
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444),
    width: 2,
  ),
  right: BorderSide(
    color: _notaFinal! >= 10.5
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444),
    width: 2,
  ),
),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "PROMEDIO FINAL", 
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                        fontSize: 13, 
                        color: Colors.grey[600],
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _notaFinal!.toStringAsFixed(2), 
                      style: const TextStyle(fontSize: 54, fontWeight: FontWeight.bold, color: Color(0xFF023052)),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                      decoration: BoxDecoration(
                        color: _notaFinal! >= 10.5 ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _mensaje, 
                        style: TextStyle(
                          fontSize: 15, 
                          fontWeight: FontWeight.bold, 
                          color: _notaFinal! >= 10.5 ? const Color(0xFF047857) : const Color(0xFFB91C1C),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildWeightRow(String label, TextEditingController c1, TextEditingController c2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 36, 
            child: Text(
              label, 
              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF023052), fontSize: 14),
            ),
          ),
          Expanded(child: _buildSmallInput(c1, "ES %")),
          const SizedBox(width: 8),
          Expanded(child: _buildSmallInput(c2, "EP %")),
        ],
      ),
    );
  }

  Widget _buildSmallInput(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        labelText: label,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      ),
    );
  }

  Widget _buildUnidadCard(String titulo, TextEditingController c1, String l1, TextEditingController c2, String l2) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.bookmark_rounded, color: Color(0xFF023052), size: 18),
                const SizedBox(width: 6),
                Text(
                  titulo, 
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF023052), fontSize: 13, letterSpacing: 0.5),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c1, 
                    decoration: InputDecoration(labelText: l1), 
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: c2, 
                    decoration: InputDecoration(labelText: l2), 
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}