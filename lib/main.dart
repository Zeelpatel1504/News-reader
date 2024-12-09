import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'artical_news.dart';
import 'constants.dart';
import 'list_of_country.dart';

void main() => runApp(const MyApp());

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

void toggleDrawer() {
  if (_scaffoldKey.currentState?.isDrawerOpen ?? false) {
    _scaffoldKey.currentState?.openEndDrawer();
  } else {
    _scaffoldKey.currentState?.openDrawer();
  }
}

class DropDownList extends StatelessWidget {
  const DropDownList({super.key, required this.name, required this.call});
  final String name;
  final VoidCallback call;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(title: Text(name)),
      onTap: call,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic cName;
  dynamic country;
  dynamic category;
  dynamic findNews;
  int pageNum = 1;
  bool isPageLoading = false;
  late ScrollController controller;
  int pageSize = 10;
  bool isSwitched = false;
  List<dynamic> news = [];
  bool notFound = false;
  bool isLoading = false;
  bool noDataFound = false; // Flag to indicate no data for selected filters
  String baseApi = 'https://newsapi.org/v2/top-headlines?';

  final String apiKey = '81a79e41c8af42198f4a64e6cc96bf9f';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: isSwitched
          ? ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              brightness: Brightness.light,
            )
          : ThemeData(
              fontFamily: GoogleFonts.poppins().fontFamily,
              brightness: Brightness.dark,
            ),
      home: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 32),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (country != null) Text('Country = $cName') else Container(),
                  const SizedBox(height: 10),
                  if (category != null) Text('Category = $category') else Container(),
                  const SizedBox(height: 20),
                ],
              ),
              ListTile(
                title: TextFormField(
                  decoration: const InputDecoration(hintText: 'Find Keyword'),
                  scrollPadding: const EdgeInsets.all(5),
                  onChanged: (String val) => setState(() => findNews = val),
                ),
                trailing: IconButton(
                  onPressed: () async => getNews(searchKey: findNews as String),
                  icon: const Icon(Icons.search),
                ),
              ),
              ExpansionTile(
                title: const Text('Country'),
                children: <Widget>[
                  for (int i = 0; i < listOfCountry.length; i++)
                    DropDownList(
                      call: () {
                        country = listOfCountry[i]['code'];
                        cName = listOfCountry[i]['name']!.toUpperCase();
                        getNews();
                      },
                      name: listOfCountry[i]['name']!.toUpperCase(),
                    ),
                ],
              ),
              ExpansionTile(
                title: const Text('Category'),
                children: [
                  for (int i = 0; i < listOfCategory.length; i++)
                    DropDownList(
                      call: () {
                        category = listOfCategory[i]['code'];
                        getNews();
                      },
                      name: listOfCategory[i]['name']!.toUpperCase(),
                    )
                ],
              ),
              ExpansionTile(
                title: const Text('Channel'),
                children: [
                  for (int i = 0; i < listOfNewsChannel.length; i++)
                    DropDownList(
                      call: () =>
                          getNews(channel: listOfNewsChannel[i]['code']),
                      name: listOfNewsChannel[i]['name']!.toUpperCase(),
                    ),
                ],
              ),
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: const Text('News'),
          actions: [
            IconButton(
              onPressed: () {
                country = null;
                category = null;
                findNews = null;
                cName = null;
                getNews(reload: true);
              },
              icon: const Icon(Icons.refresh),
            ),
            Switch(
              value: isSwitched,
              onChanged: (bool value) => setState(() => isSwitched = value),
              activeTrackColor: Colors.white,
              activeColor: Colors.white,
            ),
          ],
        ),
        body: noDataFound
            ? Center(
                child: Text(
                  'No data found for the selected filters!',
                  style: TextStyle(fontSize: 30),
                ),
              )
            : notFound
                ? const Center(
                    child: Text('No Results Found', style: TextStyle(fontSize: 30)),
                  )
                : news.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.yellow,
                        ),
                      )
                    : ListView.builder(
                        controller: controller,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: GestureDetector(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          fullscreenDialog: true,
                                          builder: (BuildContext context) =>
                                              ArticalNews(
                                            newsUrl: news[index]['url'] as String,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 10,
                                        horizontal: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              if (news[index]['urlToImage'] == null)
                                                Container()
                                              else
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    placeholder:
                                                        (BuildContext context, String url) =>
                                                            Container(),
                                                    errorWidget:
                                                        (BuildContext context, String url, error) =>
                                                            const SizedBox(),
                                                    imageUrl: news[index]
                                                        ['urlToImage'] as String,
                                                  ),
                                                ),
                                              Positioned(
                                                bottom: 8,
                                                right: 8,
                                                child: Card(
                                                  elevation: 0,
                                                  color: Theme.of(context)
                                                      .primaryColor
                                                      .withOpacity(0.8),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    child: Text(
                                                      "${news[index]['source']['name']}",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(),
                                          Text(
                                            "${news[index]['title']}",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              if (index == news.length - 1 && isLoading)
                                const Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.yellow,
                                  ),
                                )
                              else
                                const SizedBox(),
                            ],
                          );
                        },
                        itemCount: news.length,
                      ),
      ),
    );
  }

  Future<void> getDataFromApi(String url) async {
    try {
      final http.Response res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final articles = data['articles'] as List<dynamic>;

        if (articles.isEmpty) {
          setState(() {
            noDataFound = true;
            notFound = false;
            isLoading = false;
          });
        } else {
          setState(() {
            noDataFound = false;
            notFound = false;
            news = articles;
            isLoading = false;
          });
        }
      } else {
        setState(() {
          notFound = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Connection failed: $e');
      setState(() {
        notFound = true;
        isLoading = false;
      });
    }
  }

  Future<void> getNews({
    String? channel,
    String? searchKey,
    bool reload = false,
  }) async {
    setState(() => notFound = false);

    if (!reload && !isLoading) {
      toggleDrawer();
    } else {
      country = null;
      category = null;
    }
    if (isLoading) {
      pageNum++;
    } else {
      setState(() => news = []);
      pageNum = 1;
    }

    baseApi = 'https://newsapi.org/v2/top-headlines?pageSize=$pageSize&page=$pageNum&';

    baseApi += country == null ? 'country=in&' : 'country=$country&';
    baseApi += category == null ? '' : 'category=$category&';
    baseApi += 'apiKey=$apiKey';

    if (searchKey != null) {
      baseApi += '&q=$searchKey';  // Add search term if present
    }

    if (channel != null) {
      baseApi =
          'https://newsapi.org/v2/top-headlines?pageSize=$pageSize&page=$pageNum&sources=$channel&apiKey=$apiKey';
    }

    print('API URL: $baseApi');  // Debugging the final URL
    getDataFromApi(baseApi);
  }

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    getNews();
    super.initState();
  }

  void _scrollListener() {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      setState(() => isLoading = true);
      getNews();
    }
  }
}
