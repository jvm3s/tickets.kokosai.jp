// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tickets_kokosai_jp/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      supportedLocales: [Locale('ja', 'JP')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(fontFamily: 'NotoSansJP'),
      locale: Locale("ja", "JP"),
    );
  }
}

class PerformanceData {
  final String title;
  final String venue;
  final String date;
  final String time;
  final String prText;
  final String classnumber;

  PerformanceData({
    required this.title,
    required this.venue,
    required this.date,
    required this.time,
    required this.prText,
    required this.classnumber,
  });
}

class UrlLauncherUtil {
  static Future<void> launch({
    required String url,
    required BuildContext context,
    LaunchMode mode = LaunchMode.platformDefault,
  }) async {
    final Uri uri = Uri.parse(url);
    if (!await canLaunchUrl(uri)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('URLを開けませんでした。'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }
    await launchUrl(uri, mode: mode);
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> scrollOffsetNotifier = ValueNotifier(0.0);
  bool _shouldAnimateIn = false;
  bool _shouldAnimateIncard = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _shouldAnimateIn = true;
        });
      }
    });
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _shouldAnimateIncard = true;
        });
      }
    });
    _scrollController.addListener(() {
      scrollOffsetNotifier.value = _scrollController.offset;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      setState(() {
        _shouldAnimateIn = false;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _shouldAnimateIn = true;
          });
        }
      });
    }
  }

  Widget animatedTextItem({
    required String text,
    required int duration,
    required bool isVisible,
    required TextStyle? style,
  }) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.0,
      duration: Duration(milliseconds: duration),
      curve: Curves.easeIn,
      child: Text(text, style: style),
    );
  }

  Widget animatedItem({
    required Widget child,
    required int duration,
    required bool isVisible,
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: duration),
      curve: Curves.easeOut,
      top: isVisible ? top : (top != null ? top + 50 : null),
      left: isVisible ? left : (left != null ? left - 50 : null),
      right: isVisible ? right : (right != null ? right - 50 : null),
      bottom: isVisible ? bottom : (bottom != null ? bottom - 50 : null),
      child: AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeIn,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F4FF),
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          // スクロールが終了した時にのみ処理したい場合
          if (notification is ScrollStartNotification) {
            _shouldAnimateIncard = true;
            setState(() {});
          }
          return false;
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    animatedItem(
                      isVisible: _shouldAnimateIn,
                      duration: 1500,
                      top: 40,
                      right: -10,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 127, 183, 248),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    animatedItem(
                      isVisible: _shouldAnimateIn,
                      duration: 1500,
                      top: 100,
                      right: -10,
                      child: Container(
                        width: 170,
                        height: 170,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 240, 244, 249),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    animatedItem(
                      isVisible: _shouldAnimateIn,
                      duration: 1500,
                      bottom: 100,
                      right: 30,
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 178, 222, 246),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    animatedItem(
                      isVisible: _shouldAnimateIn,
                      duration: 1500,
                      bottom: 100,
                      left: -50,
                      child: Container(
                        width: 250,
                        height: 250,
                        decoration: const BoxDecoration(
                          color: Color(0xFF90D490),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    animatedItem(
                      isVisible: _shouldAnimateIn,
                      duration: 1800,
                      top: 250,
                      left: -150,
                      child: Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF6B8FD4),
                            width: 30,
                          ),
                        ),
                        child: const Center(
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Color(0xFF6B8FD4),
                          ),
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 50),
                                    animatedTextItem(
                                      isVisible: _shouldAnimateIn,
                                      text: '鯱光祭\n三年劇チケット\n予約サイト',
                                      duration: 2000,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    animatedTextItem(
                                      isVisible: _shouldAnimateIn,
                                      text:
                                          '77th Kokosai\nAsahigaoka High School',
                                      duration: 2200,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 50),
                              ],
                            ),
                          ),
                          SizedBox(height: 30),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: AnimatedOpacity(
                              opacity: _shouldAnimateIncard ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 1200),
                              curve: Curves.easeIn,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 1800),
                                curve: Curves.easeOut,
                                transform: Matrix4.translationValues(
                                  0,
                                  _shouldAnimateIncard ? 0 : 50,
                                  0,
                                ),
                                margin: const EdgeInsets.symmetric(
                                  vertical: 20,
                                ),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    padding: const EdgeInsets.all(25),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(5, 5),
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.confirmation_number,
                                          size: 30,
                                          color: const Color(0xFF6B8FD4),
                                        ),
                                        Text(
                                          "三年劇チケット予約について",
                                          style: TextStyle(
                                            fontSize: 25,
                                            fontFamily: 'NotoSansJP',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "予約は抽選制です\n募集締め切り＆抽選は9/25です",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: const Color.fromARGB(
                                              255,
                                              255,
                                              0,
                                              0,
                                            ),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "・劇の予約は一人につき3件まで可能です。ただし同じ時間帯の予約は1件しかできません。\n・抽選結果は9/25にメールでお知らせします。\n・メールアドレスは複数使用しないでください。",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black.withOpacity(
                                              0.7,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 20.0,
                                          ),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF6B8FD4,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (context) => TicketPage(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "予約選択へ",
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        TextButton(
                                          onPressed: () {
                                            UrlLauncherUtil.launch(
                                              url:
                                                  'https://tickets.kokosai.jp/faq',
                                              context: context,
                                            );
                                          },
                                          child: Text("その他の予約に関する説明はこちらから"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      UrlLauncherUtil.launch(
                                        url:
                                            'https://tickets.kokosai.jp/privacy',
                                        context: context,
                                      );
                                    },
                                    child: const Text(
                                      'プライバシーポリシー',
                                      style: TextStyle(
                                        color: Color(0xFF6B8FD4),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.0,
                                    ),
                                    child: Text(
                                      '|',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      UrlLauncherUtil.launch(
                                        url:
                                            'https://tickets.kokosai.jp/disclaimer',
                                        context: context,
                                      );
                                    },
                                    child: const Text(
                                      '免責事項',
                                      style: TextStyle(
                                        color: Color(0xFF6B8FD4),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketPage extends StatefulWidget {
  const TicketPage({super.key});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  final Map<String, PerformanceData> _selectedPerformances = {};

  final List<PerformanceData> _allPerformances = [
    PerformanceData(
      classnumber: "301",
      title: '心が叫びたがってるんだ。',
      venue: '武道場',
      date: '9月28日（日）',
      time: '9:30~11:00',
      prText: '伝えたい想いがある。言葉にできない心の叫びが、静かに、けれど確かに響き合う、切なくも温かい青春の物語。',
    ),
    PerformanceData(
      classnumber: "302",
      title: 'オペラ座の怪人',
      venue: '鯱光館',
      date: '9月28日（日）',
      time: '9:30~11:00',
      prText: 'オペラ座に響く、届かぬ恋と運命の物語。仮面に隠した想いが、舞台で動き出す＿\n旭丘史上、最高の劇を見逃すな！',
    ),
    PerformanceData(
      classnumber: "303",
      title: 'RRR-Re:Ramayana×mahabhaRata',
      venue: '鯱光館',
      date: '9月27日（土）',
      time: '13:00~14:30',
      prText: '友情か使命か。全ての次元を越えた出逢いを繋ぐ、インド映画の最高峰。',
    ),
    PerformanceData(
      classnumber: "304",
      title: 'KINGDOM',
      venue: '鯱光館',
      date: '9月27日（土）',
      time: '9:30~11:00',
      prText:
          '時は春秋戦国時代。下僕の少年と若き王の出会いが、中華の未来を動かす__\n命を懸けた戦い、仲間との絆。｢KINGDOM｣ここに開幕！',
    ),
    PerformanceData(
      classnumber: "305",
      title: '今日から俺は‼︎',
      venue: '武道場',
      date: '9月27日（土）',
      time: '9:30~11:00',
      prText: '「今日俺」待望の舞台化。ここ旭丘でもヤンキーたちが大暴れ！！！この夏、最大で最凶の闘いが今始まる！！！',
    ),
    PerformanceData(
      classnumber: "306",
      title: 'アナと雪の女王',
      venue: '小体育館',
      date: '9月27日（土）',
      time: '9:30~11:00',
      prText:
          '秘密の力を持った姉エルサと運命の恋を夢見る妹アナの姉妹が織りなす、アレンデール王国を巡る魔法と感動の物語。\n「少しも寒くない」この夏、小体育館で魔法にかかろう！',
    ),
    PerformanceData(
      classnumber: "307",
      title: 'LA LA LAND',
      venue: '小体育館',
      date: '9月28日（日）',
      time: '9:30~11:00',
      prText: 'ミュージカルの魔法があなたを包む\n極上のエンターテイメント\nようこそLA LA LANDの世界へ！',
    ),
    PerformanceData(
      classnumber: "308",
      title: 'マクベス',
      venue: '小体育館',
      date: '9月27日（土）',
      time: '13:00~14:30',
      prText: '「いずれは王になるお方」魔女の予言が、心を惑わす。野望に憑かれた男の血と裏切りの運命。悲劇『マクベス』開演。',
    ),
    PerformanceData(
      classnumber: "309",
      title: 'デスノート',
      venue: '武道場',
      date: '9月27日（土）',
      time: '13:00~14:30',
      prText: '名前を書かれた人間は死ぬ——。圧倒的な頭脳を持つ二人が繰り広げる、命を懸けた壮絶な心理戦。果たして、本当の“正義”とは何か？',
    ),
  ];

  void _handleSelection(String timeSlot, PerformanceData performance) {
    setState(() {
      if (_selectedPerformances.containsKey(timeSlot)) {
        if (_selectedPerformances[timeSlot]?.classnumber !=
            performance.classnumber) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('同時間帯は1つしか選択できません。'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        } else {
          _selectedPerformances.remove(timeSlot);
        }
      } else {
        _selectedPerformances[timeSlot] = performance;
      }
    });
  }

  // 元のコンテナデザインのパフォーマンスカード
  Widget _buildPerformanceCard({
    required BuildContext context,
    required PerformanceData performance,
  }) {
    final timeSlot = '${performance.date} ${performance.time}';
    final isSelected =
        _selectedPerformances[timeSlot]?.classnumber == performance.classnumber;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: GestureDetector(
        onTap: () {
          _handleSelection(timeSlot, performance);
        },
        child: Container(
          decoration: BoxDecoration(
            color:
                isSelected
                    ? const Color(0xFF6B8FD4).withOpacity(0.2)
                    : Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(5, 5),
                blurRadius: 15,
              ),
            ],
            border: Border.all(
              color: isSelected ? const Color(0xFF6B8FD4) : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(18),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    "lib/assets/img/${performance.classnumber}.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      performance.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'クラス: ${performance.classnumber}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xFF6B8FD4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          "  ${performance.date} ${performance.time}  @${performance.venue}  ",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Text(
                      performance.prText,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isSelected
                                  ? const Color(0xFF90D490)
                                  : const Color(0xFF6B8FD4),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        onPressed: () {
                          _handleSelection(timeSlot, performance);
                        },
                        child: Text(
                          isSelected ? '選択済み' : '選択する',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 大画面向けのパフォーマンス表示ウィジェット
  Widget _buildPerformanceDisplay({
    required BuildContext context,
    required PerformanceData performance,
  }) {
    final timeSlot = '${performance.date} ${performance.time}';
    final isSelected =
        _selectedPerformances[timeSlot]?.classnumber == performance.classnumber;

    return GestureDetector(
      onTap: () {
        _handleSelection(timeSlot, performance);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        color: isSelected ? Colors.blue.shade50.withOpacity(0.5) : Colors.white,
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      "lib/assets/img/${performance.classnumber}.png",
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.5),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          performance.classnumber,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          performance.title,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${performance.date} ${performance.time} @${performance.venue}',
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          performance.prText,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.8),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              _handleSelection(timeSlot, performance);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isSelected
                                      ? Colors.green.shade400
                                      : Colors.blue.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 15,
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              isSelected ? '選択済み' : '選択する',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 1, color: Colors.grey.shade200),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 画面の横幅をチェック
        final bool isLargeScreen = constraints.maxWidth > 800;

        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: const Color(0xFFE0F4FF),
                title: Text(
                  "チケットを選択",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((
                  BuildContext context,
                  int index,
                ) {
                  final performance = _allPerformances[index];
                  if (isLargeScreen) {
                    return _buildPerformanceDisplay(
                      context: context,
                      performance: performance,
                    );
                  } else {
                    return _buildPerformanceCard(
                      context: context,
                      performance: performance,
                    );
                  }
                }, childCount: _allPerformances.length),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: ElevatedButton(
              onPressed:
                  _selectedPerformances.isNotEmpty
                      ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => ConfirmationPage(
                                  selectedPerformances:
                                      _selectedPerformances.values.toList(),
                                ),
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6B8FD4),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                elevation: 0,
              ),
              child: const Text(
                '確定',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final List<PerformanceData> selectedPerformances;
  const ConfirmationPage({super.key, required this.selectedPerformances});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約内容の確認', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6B8FD4),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFE0F4FF),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '以下の内容でよろしいですか？',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6B8FD4),
              ),
            ),
            const SizedBox(height: 20),
            ...selectedPerformances.map(
              (data) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: Color(0xFF90D490),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "${data.classnumber} ${data.title}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // 戻るボタンと確定ボタン
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // 予約ページに戻る
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    '戻る',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (context) => EmailInputPage(
                              selectedPerformances: selectedPerformances,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B8FD4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    '予約を確定する',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmailInputPage extends StatelessWidget {
  final List<PerformanceData> selectedPerformances;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numController = TextEditingController();
  EmailInputPage({required this.selectedPerformances, super.key});
  Future<void> addEmailToArray({
    required List<PerformanceData> classNos,
    required String email,
    required String noOfPeople,
  }) async {
    final docRef = FirebaseFirestore.instance.doc("entries/data");
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(docRef);
      final data = snapshot.data() as Map<String, dynamic>;
      int totalOccurrences = 0;
      for (int i = 1; i <= 9; i++) {
        final key = "array$i";
        final List<dynamic> list = (data[key] ?? []) as List<dynamic>;
        totalOccurrences += list.where((e) => e == email).length;
      }
      if (totalOccurrences < 3) {
        for (var i in classNos) {
          final List<dynamic> targetArray = (data[i.classnumber] ?? []);
          if (!targetArray.contains(email)) {
            targetArray.add({'email': email, 'noOfPeople': noOfPeople});
          }
          transaction.update(docRef, {i.classnumber: targetArray});
        }
        var buffer = StringBuffer();
        buffer.writeln(
          '鯱光祭チケットシステムをご利用いただきありがとうございます。\nチケット抽選の受付が完了しました。\n\n----------\n',
        );
        buffer.writeln("人数: $noOfPeople\n");
        for (int i = 0; i < selectedPerformances.length; i++) {
          buffer.writeln(
            '発表名: ${selectedPerformances[i].classnumber} ${selectedPerformances[i].title}\n日時:　 ${selectedPerformances[i].date}${selectedPerformances[i].time} @${selectedPerformances[i].venue}\n',
          );
        }
        buffer.writeln(
          '----------\n\n抽選結果は後日、メールにてお知らせいたします。\n\n第77回鯱光祭「旭斗七星」\n愛知県立旭丘高等学校 三年劇舞台監督審議会\n\nこのメールに見覚えのない方は無視してください。',
        );
        String emailContent = buffer.toString();
        await FirebaseFirestore.instance.collection("ticketsMail").add({
          "to": [email],
          "message": {"subject": "鯱光祭チケット受付", "text": emailContent},
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メールアドレスの入力', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF6B8FD4),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFE0F4FF),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF0D4),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: const Color(0xFFD4B96B),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '⚠︎ ご注意',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFD4B96B),
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '・ご入力いただいたメールアドレスに抽選結果をお知らせします。',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '・迷惑メール設定をされている方は、事前に「@kokosai.jp」からのメールを受信できるように設定してください。',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '・複数のアドレスを使用しての応募は無効となります。',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '予約内容をメールで送信します。',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B8FD4),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _numController,
                decoration: const InputDecoration(
                  labelText: '人数',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  RegExp numRegex = RegExp(r'^[1-3]$');
                  if (!numRegex.hasMatch(value!)) {
                    return '1~3の数字を入力してください。';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text;
                    final nOfP = _numController.text;
                    if (email.isNotEmpty && nOfP.isNotEmpty) {
                      await addEmailToArray(
                        email: email,
                        classNos: selectedPerformances,
                        noOfPeople: nOfP,
                      );
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookingCompletePage(),
                        ),
                        (route) => route.isFirst,
                      );
                    } else {
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('記入された内容を確認してください。'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B8FD4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    '予約を完了する',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingCompletePage extends StatelessWidget {
  const BookingCompletePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F4FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: Color(0xFF90D490),
                size: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                '予約が完了しました！',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6B8FD4),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '抽選結果は、ご入力いただいたメールアドレスに9/25に送信されます。',
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false, // これまでのナビゲーション履歴をすべて破棄
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B8FD4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                child: const Text(
                  'メインページに戻る',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
