import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/app/screens/constants/functions/custom_functions.dart';
import 'package:netflix_clone/app/screens/home_page/home_page.dart';
import 'package:netflix_clone/app/screens/widget/button_l.dart';
import 'package:netflix_clone/app/screens/widget/text_widget/normal_text.dart';
import '../../api/api_model/movie_model.dart'; // Your model

class MovieDetailsScreen extends StatelessWidget {
  final Show show; // Movie data passed from the HomePage
  final List<Show> listShows;

  const MovieDetailsScreen(
      {super.key, required this.show, required this.listShows});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Column(
                  children: [
                    show.image?.original != null
                        ? CachedNetworkImage(
                            imageUrl: show.image?.original ??
                                'https://via.placeholder.com/500',
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.fill,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )
                        : Image.asset(
                            'assets/img/netflix_lanscape.jpg',
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black87,
                      ),
                      icon: const Icon(
                        Icons.cast,
                        size: 20,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.black87,
                      ),
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.66,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NormalText(
                            title: show.name,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          Row(
                            children: [
                              NormalText(
                                title: CustomFunctions.getYearFromString(
                                        show.premiered)
                                    .toString(),
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 20,
                                child: VerticalDivider(),
                              ),
                              NormalText(
                                title: show.language,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 20,
                                child: VerticalDivider(),
                              ),
                              NormalText(
                                title: show.type,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ButtonL(
                            title: 'Play',
                            icon: Icons.play_arrow,
                            iconColor: Colors.black,
                            textColor: Colors.black,
                            btnColor: Colors.white,
                            onTap: () {},
                          ),
                          const SizedBox(height: 10),
                          ButtonL(
                            title: 'Download',
                            icon: Icons.download,
                            iconColor: Colors.white,
                            textColor: Colors.white,
                            btnColor: Colors.white24,
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),
                          Text(
                            show.summary,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    GridView.builder(
                      itemCount: listShows.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 4 / 8,
                      ),
                      itemBuilder: (context, index) {
                        var show = listShows[index];

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      show: show,
                                      listShows: listShows,
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: show.image?.medium != null
                                      ? CachedNetworkImage(
                                          height: 200,
                                          imageUrl: show.image?.medium ??
                                              'default_image_url', // Fallback if null
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/img/netflix_img.jpeg',
                                          height: 200,
                                        ),
                                ),
                                const SizedBox(height: 10),
                                NormalText(
                                  title: show.name,
                                  fontSize: 16,
                                  color: Colors.white,
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
