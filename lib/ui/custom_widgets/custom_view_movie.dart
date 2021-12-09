import 'package:aflore_flutter/constants/app_constant.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomViewMovie extends StatelessWidget {
  const CustomViewMovie({Key? key, required this.movie}) : super(key: key);

  final ModelMovie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      alignment: Alignment.center,
      child: Material(
          color: Colors.white.withOpacity(0.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: '${movie.id}',
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:CachedNetworkImage(
                          height: 80.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          imageUrl: '${AppConstant.urlImage}${movie.posterPath}',
                        )
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
                      child: Text(
                        '${movie.overview}',
                        style: const TextStyle(color: Colors.white),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 3.h, right: 5.w),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Aceptar'),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
