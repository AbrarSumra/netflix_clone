import 'package:flutter/material.dart';
import 'package:netflix_clone/app/screens/widget/text_widget/normal_text.dart';
import '../../api/api_model/movie_model.dart';
import '../../api/api_service/api_service.dart';
import '../movie_detail_page/movie_detail_screen.dart';

class MovieSearchDelegate extends SearchDelegate {
  final ApiService apiService = ApiService();

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context,
            null); // Close the search and return to the previous screen
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        toolbarTextStyle: TextStyle(color: Colors.white),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(
          color: Colors.white, // Color of the entered text
          fontSize: 18, // Font size of the entered text
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<Show>>(
        future: apiService.searchShows(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: NormalText(
                title: 'No results found',
                color: Colors.white,
              ),
            );
          } else {
            List<Show> shows = snapshot.data!;
            return searchResult(shows: shows);
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<Show>>(
        future: apiService.searchShows(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: NormalText(
                title: 'No suggestions available',
                color: Colors.white,
              ),
            );
          } else {
            List<Show> shows = snapshot.data!;
            return searchResult(shows: shows);
          }
        },
      ),
    );
  }

  Widget searchResult({required List<Show> shows}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: shows.length,
        itemBuilder: (context, index) {
          final show = shows[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(
                      show: show,
                      listShows: shows,
                    ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  show.image != null
                      ? Image.network(
                          show.image!.medium,
                          height: 100,
                        )
                      : Image.asset(
                          'assets/img/netflix_img.jpeg',
                          height: 120,
                        ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 250,
                        child: NormalText(
                          title: show.name,
                          color: Colors.white,
                          textOverflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          const NormalText(
                            title: 'Language : ',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          NormalText(
                            title: show.language,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NormalText(
                            title: 'Description : ',
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          SizedBox(
                            width: 180,
                            child: NormalText(
                              title: show.summary,
                              color: Colors.white,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
