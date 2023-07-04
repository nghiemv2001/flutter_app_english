import 'dart:math';
import 'package:english_directory_flutter/Widgets/app_Button.dart';
import 'package:english_directory_flutter/packages/quote/qoute_model.dart';
import 'package:english_directory_flutter/pages/all_words_page.dart';
import 'package:english_directory_flutter/pages/control_page.dart';
import 'package:english_directory_flutter/values/Share_key.dart';
import 'package:english_directory_flutter/values/app_assets.dart';
import 'package:english_directory_flutter/values/app_colors.dart';
import 'package:english_directory_flutter/values/app_styles.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:english_directory_flutter/models/english_today.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/quote/quote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();
  List<EnglishToday> words = [];
  String quote = Quotes().getRandom().content!;
  List<int> fixedListRamdom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

  getEnglishToday() async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    int len = pref.getInt(ShareKeys.counter, ) ?? 5 ;
    List<String> newList = [];
    List<int> rans = fixedListRamdom(len: len, max: nouns.length);
    rans.forEach((index) {
      newList.add(nouns[index]);
    });
    setState(() {
      words = newList.map((e) => getQoute(e)).toList();
    });
  }

  EnglishToday getQoute(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(
      noun: noun,
      quote: quote?.content,
      id: quote?.id,
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.9);
    getEnglishToday();
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldkey,
      backgroundColor: App_colors.secondColor,
      appBar: AppBar(
        backgroundColor: App_colors.secondColor,
        elevation: 0,
        title: Text(
          'English Today',
          style:
              AppStyles.h3.copyWith(color: App_colors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            _scaffoldkey.currentState?.openDrawer();
          },
          child: Image.asset(App_Assets.menu),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              alignment: Alignment.centerLeft,
              child: Text(
                  '"$quote"',
                  style: AppStyles.h5.copyWith(
                      fontFamily: "Time New Roman",
                      color: App_colors.textColor,
                      fontSize: 14)),
            ),
            Container(
              height: size.height * 3 / 5,
              child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: words.length,
                  itemBuilder: (context, index) {
                    String firstLetter =
                        words[index].noun != null ? words[index].noun! : "";
                    firstLetter = firstLetter.substring(0, 1);
                    String leftLetter =
                        words[index].noun != null ? words[index].noun! : "";
                    leftLetter = leftLetter.substring(1, leftLetter.length);
                    String quoteDefault = "Think of all the beauty still left around you and be happy ";
                    String quote = words[index].quote != null ? words[index].quote! : quoteDefault;
                    return Container(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: App_colors.primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(3, 8),
                                  blurRadius: 6)
                            ],
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.asset(App_Assets.heart),
                              alignment: Alignment.centerRight,
                            ),
                            RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                    text: firstLetter,
                                    style: TextStyle(
                                        fontFamily: FontFamily.sen,
                                        fontSize: 89,
                                        fontWeight: FontWeight.bold,
                                        shadows: [
                                          BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 6)
                                        ]),
                                    children: [
                                      TextSpan(
                                          text: leftLetter,
                                          style: TextStyle(
                                              fontFamily: FontFamily.sen,
                                              fontSize: 66,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                    color: Colors.black38,
                                                    offset: Offset(3, 6),
                                                    blurRadius: 6)
                                              ]))
                                    ])),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Text(
                                '"$quote"',
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.h4.copyWith(
                                    letterSpacing: 1,
                                    color: App_colors.textColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),

            //Indicator
            _currentIndex >= 5 ? buildShowMore()
            :
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 12,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return buildIndicator(index == _currentIndex, size);
                    }),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: App_colors.primaryColor,
        onPressed: () {
          setState(() {
            getEnglishToday();
          });
        },
        child: Image.asset(App_Assets.exchange),
      ),
      drawer: Drawer(
        child: Container(
          color: App_colors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top : 24 , left: 16),
                child: Text("Your mind",
                style: AppStyles.h3.copyWith(
                  color: App_colors.textColor
                )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: App_Button(label: "Favorite", onTap: (){
                  print("favorite");
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: App_Button(label: "Your control",
                    onTap: (){
                    Navigator.push(context, 
                    MaterialPageRoute(builder: (_)=> Control_Page()));
                }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: Duration(milliseconds:300),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? App_colors.lighBlue : App_colors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore(){
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      alignment: Alignment.centerLeft,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(24)),
        elevation: 4,
        color: App_colors.primaryColor,
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) => AllWordsPage(words :this.words)));
          },
          splashColor: Colors.black38,
          borderRadius: BorderRadius.all(Radius.circular(24)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Text("Show more", style: AppStyles.h5,),
          ),
        ),
      ),
    );
  }
}
