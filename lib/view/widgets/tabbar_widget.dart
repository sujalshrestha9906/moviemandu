import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:moviemandu/view/detail_page.dart';
import '../../providers/movie_provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../home_page.dart';

class TabBarWidget extends ConsumerWidget {
  final CategoryType categorytype;
  final String someKey;
  TabBarWidget(this.categorytype, this.someKey);
  @override
  Widget build(BuildContext context, ref) {
    final movieData = categorytype == CategoryType.popular
        ? ref.watch(popularProvider)
        : categorytype == CategoryType.top_rated
            ? ref.watch(topRatedProvider)
            : ref.watch(upcomingProvider);
    if (movieData.isLoad) {
      return Center(child: CircularProgressIndicator());
    } else if (movieData.isError) {
      return OfflineBuilder(
        connectivityBuilder: (context, connectivity, child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return connected
              ? Center(
                  child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          ref.refresh(popularProvider);
                          ref.refresh(topRatedProvider);
                          ref.refresh(upcomingProvider);
                        },
                        child: Text('Refresh')),
                    Text('Connection is on !!!')
                  ],
                ))
              : Center(child: Text(movieData.errorMessage));
        },
        child: Container(),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: NotificationListener(
          onNotification: (ScrollEndNotification onNotification) {
            final before = onNotification.metrics.extentBefore;
            final max = onNotification.metrics.maxScrollExtent;
            if (before == max) {
              if (categorytype == CategoryType.popular) {
                ref.read(popularProvider.notifier).loadMore();
              } else if (categorytype == CategoryType.top_rated) {
                ref.read(topRatedProvider.notifier).loadMore();
              } else {
                ref.read(upcomingProvider.notifier).loadMore();
              }
            }
            ;
            return true;
          },
          child: GridView.builder(
              key: PageStorageKey<String>(someKey),
              itemCount: movieData.movies.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5),
              itemBuilder: ((context, index) {
                final movie = movieData.movies[index];
                return InkWell(
                  onTap: () {
                    Get.to(DetailPage(movie));
                  },
                  child: CachedNetworkImage(
                      placeholder: (c, s) => Center(
                              child: SpinKitSpinningLines(
                            color: Colors.pinkAccent,
                          )),
                      imageUrl:
                          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/${movie.poster_path}'),
                );
              })),
        ),
      );
    }
  }
}
