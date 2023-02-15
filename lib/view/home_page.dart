import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviemandu/view/search_page.dart';
import 'package:moviemandu/view/widgets/connection_widget.dart';
import 'package:moviemandu/view/widgets/tabbar_widget.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

enum CategoryType { popular, top_rated, upcoming }

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    FlutterNativeSplash.remove();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(physics: NeverScrollableScrollPhysics(), tabs: [
              Tab(
                text: 'Popular',
              ),
              Tab(
                text: 'UpComing',
              ),
              Tab(
                text: 'Top Rated',
              ),
            ]),
            toolbarHeight: 70,
            flexibleSpace: Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              height: 100,
              child: Column(
                children: [
                  Spacer(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Moviemandu',
                        style: TextStyle(fontSize: 30),
                      ),
                      IconButton(
                          onPressed: () {
                            Get.to(() => SearchPage());
                          },
                          icon: Icon(
                            Icons.search,
                            size: 30,
                          ))
                    ],
                  ),
                ],
              ),
            )),
        body: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
          ConnectionWidget(widget: TabBarWidget(CategoryType.popular, '1')),
          ConnectionWidget(widget: TabBarWidget(CategoryType.upcoming, '2')),
          ConnectionWidget(widget: TabBarWidget(CategoryType.top_rated, '3')),
        ]),
      ),
    );
  }
}
