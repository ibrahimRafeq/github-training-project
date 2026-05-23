import 'package:flutter/material.dart';

void main() {
  runApp(const MunicipalityApp());
}

class MunicipalityApp extends StatelessWidget {
  const MunicipalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'تطبيق البلدية',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        fontFamily: 'Arial', // يمكنك تغيير الخط حسب المتوفر
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const Center(child: Text('صفحة الخدمات', style: TextStyle(fontSize: 24))),
    const Center(child: Text('صفحة الحساب', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'تطبيق البلدية',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1A5276),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        selectedItemColor: const Color(0xFF1A5276),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'الخدمات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "الخدمات الإلكترونية",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
          ),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth > 600
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ServiceCard(
                    service: services[index],
                    index: index,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final ServiceItem service;
  final int index;
  const ServiceCard({super.key, required this.service, required this.index});

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + (widget.index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // زوايا أكثر نعومة Material 3
            boxShadow: [
              BoxShadow(
                color: isHovered
                    ? const Color(0xFF1A5276).withOpacity(0.15)
                    : Colors.black.withOpacity(0.05),
                blurRadius: isHovered ? 20 : 10,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: isHovered ? const Color(0xFF1A5276) : Colors.grey.shade100,
              width: 1.5,
            ),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A5276).withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      widget.service.icon,
                      size: 40,
                      color: const Color(0xFF1A5276),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    widget.service.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.service.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServiceItem {
  final String title;
  final String description;
  final IconData icon;

  ServiceItem(this.title, this.description, this.icon);
}

final List<ServiceItem> services = [
  ServiceItem('دفع الفواتير', 'خدمة سداد فواتير المياه والكهرباء', Icons.receipt_long),
  ServiceItem('طلب وثائق', 'استخراج شهادات الميلاد والرخص', Icons.description),
  ServiceItem('الشكاوى', 'تقديم ومتابعة الشكاوى والمقترحات', Icons.report_problem),
  ServiceItem('رخص البناء', 'تقديم طلبات تراخيص البناء والترميم', Icons.home_work),
  ServiceItem('دليل المرافق', 'البحث عن أقرب المرافق العامة', Icons.map),
  ServiceItem('التواصل', 'اتصل بنا مباشرة عبر الأرقام المخصصة', Icons.contact_phone),
];
