import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix_clone/app/screens/widget/text_widget/normal_text.dart';
import '../../api/api_model/movie_model.dart';
import '../../api/api_service/api_service.dart';
import '../constants/functions/custom_functions.dart';
import '../movie_detail_page/movie_detail_screen.dart';
import '../search_page/movie_search_page.dart';
import '../widget/button_l.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Show>> futureShows;

  @override
  void initState() {
    super.initState();
    futureShows = ApiService().fetchShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: NormalText(
          title: 'NEFTLIX',
          color: Color(0xFFe50912),
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
        /*Image.asset(
          'assets/png/netflix_logo.png',
          height: 80,
        ),*/
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.cast,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.download,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(), // Use the search delegate
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Show>>(
        future: futureShows,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No shows available'));
          } else {
            List<Show> shows = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  // Featured Show
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            shows[0].image!.original,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SizedBox(
                            height: 80,
                            width: 300,
                            child: Column(
                              children: [
                                FittedBox(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      NormalText(
                                        title: shows[0].name,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      NormalText(
                                        title:
                                            CustomFunctions.getYearFromString(
                                                    shows[0].premiered)
                                                .toString(),
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      NormalText(
                                        title: shows[0].language,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                        child: VerticalDivider(
                                          color: Colors.white,
                                        ),
                                      ),
                                      NormalText(
                                        title: shows[0].type,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 130,
                                      height: 40,
                                      child: ButtonL(
                                        title: 'Play',
                                        icon: Icons.play_arrow,
                                        iconColor: Colors.black,
                                        textColor: Colors.black,
                                        btnColor: Colors.white,
                                        onTap: () {},
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: 130,
                                      height: 40,
                                      child: ButtonL(
                                        title: 'My List',
                                        icon: Icons.add,
                                        iconColor: Colors.white,
                                        textColor: Colors.white,
                                        btnColor: Colors.black87,
                                        onTap: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Trending Now Section
                  _buildShowListSection("Trending Now", shows),
                  // Popular Shows Section
                  _buildShowListSection("Popular", shows),
                  // Top Rated Section
                  _buildShowListSection("Top Rated", shows),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildShowListSection(String sectionTitle, List<Show> shows) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              sectionTitle,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: shows.length,
              itemBuilder: (context, index) {
                final show = shows[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsScreen(
                            show: show,
                            listShows: shows,
                          ),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          fontWeight: FontWeight.w500,
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
