import 'package:flutter/material.dart';

void main() => runApp(const PlantPalApp());



class Plant {
  final String name;
  final String subtitle;
  final String statusNote;
  final String waterSchedule;
  final String light;
  final String notes;
  final String? imageAsset;
  final IconData? icon;
  final _Status status;

  const Plant({
    required this.name,
    required this.subtitle,
    required this.statusNote,
    required this.waterSchedule,
    required this.light,
    required this.notes,
    this.imageAsset,
    this.icon,
    required this.status,
  });
}

enum _Status { water, mist, sunlight, none }

IconData _statusIcon(_Status s) {
  switch (s) {
    case _Status.water:
      return Icons.water_drop_rounded;
    case _Status.mist:
      return Icons.ac_unit_rounded;
    case _Status.sunlight:
      return Icons.wb_sunny_rounded;
    case _Status.none:
      return Icons.north_east_rounded;
  }
}

const plants = <Plant>[
  Plant(
    name: 'Add a New Plant',
    subtitle: '',
    statusNote: '',
    waterSchedule: '',
    light: '',
    notes: '',
    icon: Icons.add_rounded,
    imageAsset: null,
    status: _Status.none,
  ),
  Plant(
    name: 'Peace Lily',
    subtitle: 'Thrives in shade, loves humidity.',
    statusNote: 'Water in 5 days',
    waterSchedule: 'Every 3 days',
    light: 'Indirect sunlight',
    notes: 'Mist leaves occasionally',
    imageAsset: 'assets/images/Peace.png',
    status: _Status.water,
  ),
  Plant(
    name: 'Basil',
    subtitle: 'Aromatic herb',
    statusNote: 'Mist tomorrow',
    waterSchedule: 'Every 2 days',
    light: 'Direct sunlight',
    notes: 'Trim weekly',
    imageAsset: 'assets/images/Basil.png',
    status: _Status.mist,
  ),
  Plant(
    name: 'Snake Plant',
    subtitle: 'Very hardy',
    statusNote: 'Needs sunlight',
    waterSchedule: 'Every 7 days',
    light: 'Bright, indirect',
    notes: 'Low water',
    imageAsset: 'assets/images/Snake.png',
    status: _Status.sunlight,
  ),
  Plant(
    name: 'Barrel Cactus',
    subtitle: 'Desert native',
    statusNote: 'Water in 9 days',
    waterSchedule: 'Every 14 days',
    light: 'Full sun',
    notes: 'Well-drained soil',
    imageAsset: 'assets/images/Barrel.png',
    status: _Status.water,
  ),
  Plant(
    name: 'Aloe Vera',
    subtitle: 'Succulent healer',
    statusNote: 'Water in 6 days',
    waterSchedule: 'Every 10 days',
    light: 'Bright light',
    notes: 'Do not overwater',
    imageAsset: 'assets/images/Aloe.png',
    status: _Status.water,
  ),
];



const Color kLightCard = Color(0xFFF4F5F6);

const Color kStatusBlue = Color(0xFF4CAFFF);

const double kGridTileHeight = 256.0;


class AppDark {
  static const bg   = Color(0xFF183A23);
  static const card = Color(0xFF2A5034);
  static const chip = Color(0xFF355F40);
  static const pill = Color(0xFFEAF2E8);
}

final _lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2F7D4E)),
  scaffoldBackgroundColor: Colors.white,
);

final _darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF7DD38C),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: AppDark.bg,
);


class PlantPalApp extends StatefulWidget {
  const PlantPalApp({super.key});
  @override
  State<PlantPalApp> createState() => _PlantPalAppState();
}

class _PlantPalAppState extends State<PlantPalApp> {
  ThemeMode _mode = ThemeMode.light;
  void _toggle() =>
      setState(() => _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlantPal',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: _mode,
      home: PlantListScreen(onToggleTheme: _toggle, themeMode: _mode),
      routes: {PlantDetailScreen.route: (_) => const PlantDetailScreen()},
    );
  }
}


class PlantListScreen extends StatelessWidget {
  const PlantListScreen({super.key, required this.onToggleTheme, required this.themeMode});
  final VoidCallback onToggleTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Your Green Buddies 🌿'),
        actions: [
          IconButton(
            tooltip: themeMode == ThemeMode.light ? 'Dark mode' : 'Light mode',
            onPressed: onToggleTheme,
            icon: Icon(
              themeMode == ThemeMode.light
                  ? Icons.dark_mode_outlined
                  : Icons.light_mode_outlined,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Track watering schedules and give your\nplants the love they deserve.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text(
                  'My Plants',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right_rounded, size: 18),
                  label: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: GridView.builder(
                itemCount: plants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  mainAxisExtent: kGridTileHeight,
                ),
                itemBuilder: (_, i) => _PlantCard(p: plants[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DottedCircle extends StatelessWidget {
  const DottedCircle({super.key, this.size = 56, this.color = const Color(0xFFCCD0D6)});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.square(size), painter: _DottedCirclePainter(color));
  }
}

class _DottedCirclePainter extends CustomPainter {
  _DottedCirclePainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    final Path path = Path()..addOval(Rect.fromCircle(center: Offset(r, r), radius: r - 1));
    final metric = path.computeMetrics().first;

    const double dash = 4.0, gap = 4.0;
    double dist = 0.0;
    final Path dashed = Path();
    while (dist < metric.length) {
      dashed.addPath(metric.extractPath(dist, dist + dash), Offset.zero);
      dist += dash + gap;
    }
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(dashed, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PlantCard extends StatelessWidget {
  const _PlantCard({required this.p});
  final Plant p;

  @override
  Widget build(BuildContext context) {
    final isAdd  = p.imageAsset == null;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color filledCard = isDark ? AppDark.card : kLightCard;

    if (isAdd) {
      final Color surface    = isDark ? filledCard : Colors.white;
      final BoxBorder? bord  = isDark ? null : Border.all(color: const Color(0xFFE6E7EA));
      final Color dotColor   = isDark ? Colors.white60 : const Color(0xFFCCD0D6);
      final Color plusColor  = isDark ? Colors.white70 : const Color(0xFF6C6F75);
      final Color textColor  = isDark ? Colors.white : Colors.black87;

      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Container(
          height: kGridTileHeight,
          decoration: BoxDecoration(
            color: surface.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
            border: bord,
          ),
          padding: const EdgeInsets.all(18),
          child: Stack(
            alignment: Alignment.center,
            children: [

              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    DottedCircle(size: 56, color: dotColor),
                    Icon(Icons.add_rounded, size: 28, color: plusColor),
                  ],
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Add\na New Plant',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600, color: textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }



    final Color cardColor = isDark ? AppDark.card : kLightCard;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.of(context).pushNamed(PlantDetailScreen.route, arguments: p),
      child: Container(
        height: kGridTileHeight,
        decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.north_east_rounded,
                size: 16,
                color: isDark ? Colors.white.withOpacity(.45) : Colors.black.withOpacity(.35),
              ),
            ),

            Column(
              children: [

                Expanded(
                  child: Center(
                    child: Image.asset(
                      p.imageAsset!,
                      width: 100,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  p.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _statusIcon(p.status),
                      size: 16,
                      color: p.status == _Status.water
                          ? kStatusBlue
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        p.statusNote,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class PlantDetailScreen extends StatelessWidget {
  static const route = '/plant';
  const PlantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Plant p = (ModalRoute.of(context)?.settings.arguments as Plant?) ?? plants[1];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final infoFill = isDark ? AppDark.card : kLightCard;
    final chipFill = isDark ? AppDark.chip : const Color(0xFFF0F1F3);

    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _TopCircle(
                    icon: Icons.chevron_left_rounded,
                    onTap: () => Navigator.pop(context),
                    fill: chipFill,
                  ),
                  _TopCircle(
                    icon: Icons.mode_edit_outline_outlined,
                    onTap: () {},
                    fill: chipFill,
                  ),
                ],
              ),
              const SizedBox(height: 8),


              Center(
                child: Image.asset(
                  p.imageAsset ?? '',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 8),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    p.name,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('🌸', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Thrives in shade, loves humidity.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark ? Colors.white70 : Colors.black.withOpacity(.60),
                ),
              ),
              const SizedBox(height: 32),


              Row(
                children: [
                  Expanded(
                    child: _InfoTile(
                      fill: infoFill,
                      chipFill: chipFill,
                      icon: Icons.water_drop_rounded,
                      title: p.waterSchedule,
                      caption: 'Water',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _InfoTile(
                      fill: infoFill,
                      chipFill: chipFill,
                      icon: Icons.wb_sunny_rounded,
                      title: p.light,
                      caption: 'Light',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _NotesTile(
                fill: infoFill,
                chipFill: chipFill,
                icon: Icons.cloudy_snowing,
                title: p.notes,
                caption: 'Notes',
              ),

              const Spacer(),


              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.alarm_add_rounded),
                        label: const Text('Set a Reminder'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? AppDark.pill : Colors.black,
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          elevation: isDark ? 0 : 10,
                          shadowColor: isDark ? Colors.transparent : Colors.black26,
                          shape: const StadiumBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  _CircleActionButton(
                    onPressed: () {},
                    icon: Icons.delete_outline_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopCircle extends StatelessWidget {
  const _TopCircle({required this.icon, required this.onTap, required this.fill});
  final IconData icon;
  final VoidCallback onTap;
  final Color fill;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkResponse(
      onTap: onTap,
      radius: 28,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
        child: Icon(
          icon,
          color: isDark ? Colors.white70 : const Color(0xFF45474C), size: 20,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.fill,
    required this.chipFill,
    required this.icon,
    required this.title,
    required this.caption,
  });

  final Color fill;
  final Color chipFill;
  final IconData icon;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 150,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: fill, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: chipFill, shape: BoxShape.circle),
                child: Icon(icon, color: isDark ? const Color(0xFF7DD38C) : Colors.black54, size: 20,),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            caption,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDark ? Colors.white70 : const Color(0x803A3D42),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({
    required this.onPressed,
    required this.icon,
    this.size = 56,
    this.background = const Color(0xFFE53935),
    this.iconColor = Colors.white,
    super.key,
  });

  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: background,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Center(
            child: Icon(icon, color: iconColor),
          ),
        ),
      ),
    );
  }
}

class _NotesTile extends StatelessWidget {
  const _NotesTile({
    required this.fill,
    required this.chipFill,
    required this.icon,
    required this.title,
    required this.caption,
    super.key,
  });

  final Color fill;
  final Color chipFill;
  final IconData icon;
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: 100,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: chipFill, shape: BoxShape.circle),
            child: Icon(
              icon,
              size: 20,
              color: isDark ? const Color(0xFF7DD38C) : Colors.black54,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  caption,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white70 : const Color(0x803A3D42),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
