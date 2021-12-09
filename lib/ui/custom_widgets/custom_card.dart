import 'package:aflore_flutter/constants/app_constant.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:aflore_flutter/utils/utils_app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(this.movie, this.onTap, {Key? key}) : super(key: key);

  final ModelMovie movie;

  final Function(ModelMovie) onTap;

  @override
  Widget build(BuildContext context) {
    final releaseDate = movie.releaseDate ?? '${DateTime.now()}}';

    final rating = (movie.voteAverage?.toDouble() ?? 0.0) / 2;

    return GestureDetector(
      onTap: () {
        onTap(movie);
      },
      child: Card(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(2.w),
          child: Row(
            children: [
              Hero(
                tag: '${movie.id}',
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 20.h,
                      width: 20.w,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator(),),
                      imageUrl: '${AppConstant.urlImage}${movie.posterPath}',
                    )),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Container(
                  color: Colors.white10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Text(
                          '${movie.title}',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14.sp),
                        ),
                      ),
                      Text('(${UtilsApp.getYear(releaseDate)})'),
                      SizedBox(height: 2.h),
                      RatingBarIndicator(
                        rating: rating,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20.0,
                        direction: Axis.horizontal,
                      ),
                      Text('Calificación $rating'),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
