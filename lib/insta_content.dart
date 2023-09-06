import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';

class InstaContent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InstaContentState();
}

class _InstaContentState extends State<InstaContent> {
  List<String>? instaUrls;
  var isLoading = false;

  @override
  void initState() {
    getInstaPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var gridSize = screenWidth < 401 ? 1 : 3;
    var nonNullInstaUrls = instaUrls ?? List.empty();
    return isLoading
        ? loadingView()
        : GridView.count(
            crossAxisCount: gridSize,
            children: [
              for (var post in nonNullInstaUrls)
                Container(
                    decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                      image: NetworkImage(
                        post,
                      ),
                      fit: BoxFit.fitHeight),
                  border: Border.all(
                    width: 8,
                  ),
                ))
            ],
          );
  }

  void getInstaPosts() async {
    setState(() {
      isLoading = true;
    });
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData("spiderwaterband");
    setState(() {
      instaUrls = flutterInsta.feedImagesUrl;
      isLoading = false;
    });
  }

  Widget loadingView() {
    return Center(
      child: Image.asset(
        'assets/img/damn-attempt.gif',
      ),
    );
  }
}
