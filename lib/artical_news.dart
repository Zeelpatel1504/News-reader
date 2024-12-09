import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticalNews extends StatefulWidget {
  const ArticalNews({super.key, required this.newsUrl});
  final String newsUrl;  // This will be the URL of the API endpoint

  @override
  _ArticalNewsState createState() => _ArticalNewsState();
}

class _ArticalNewsState extends State<ArticalNews> {
  late Future<List<Article>> _articles;

  // Function to fetch articles from the provided newsUrl
  Future<List<Article>> fetchArticles() async {
    final response = await http.get(Uri.parse(widget.newsUrl));

    if (response.statusCode == 200) {
      // Decode the response body and extract the 'articles' list
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      
      // Cast the 'articles' field from JSON as List<dynamic>
      List<dynamic> articlesJson = jsonResponse['articles'] as List<dynamic>;

      // Return the list of Article objects
      return articlesJson.map((data) => Article.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  @override
  void initState() {
    super.initState();
    _articles = fetchArticles();  // Initialize fetching articles when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('News'),
      ),
      body: FutureBuilder<List<Article>>(
        future: _articles,  // The Future we're awaiting
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());  // Show a loading spinner while waiting for the data
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));  // Show error message if fetching fails
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Data Found'));  // Show a message if no data is returned
          } else {
            // Data is available, so display the list of articles
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(articles[index].title),  // Article title
                  subtitle: Text(articles[index].description),  // Article description
                  onTap: () {
                    // You can add functionality to navigate to a detailed article page, or open the article in a browser
                    // For example, using a WebView or launching the URL in a browser
                    // You can pass the URL of the article here (articles[index].url)
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

// Define an Article model to represent the article structure from the API response
class Article {
  final String title;
  final String description;
  final String url;  // You can also add other fields as necessary, such as imageUrl, content, etc.

  Article({required this.title, required this.description, required this.url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? 'No Title',  // Provide a default value if null
      description: json['description'] ?? 'No Description',  // Provide a default value if null
      url: json['url'] ?? '',  // Provide a default value if null
    );
  }
}
