import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

// "ca-app-pub-3940256099942544/8135179316";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Native Ads Guide',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _list = List<ImageClass>();

  // _adunitID id TEST ID
  static const _adUnitID = "ca-app-pub-3940256099942544/8135179316";

  final _nativeAdController = NativeAdmobController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Widget images(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: _list[index].images,
        placeholder: (context, string) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        },
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  List<String> imageList = [
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4',
    'https://images.unsplash.com/photo-1521577352947-9bb58764b69a',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2',
    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea',
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4',
    'https://images.unsplash.com/photo-1521577352947-9bb58764b69a',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2',
    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea',
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4',
    'https://images.unsplash.com/photo-1521577352947-9bb58764b69a',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2',
    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea',
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4',
    'https://images.unsplash.com/photo-1521577352947-9bb58764b69a',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2',
    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea',
    'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f',
    'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e',
    'https://images.unsplash.com/photo-1513956589380-bad6acb9b9d4',
    'https://images.unsplash.com/photo-1521577352947-9bb58764b69a',
    'https://images.unsplash.com/photo-1488161628813-04466f872be2',
    'https://images.unsplash.com/photo-1501196354995-cbb51c65aaea',
  ];

  void _getData() {
    for (int i = 0; i < imageList.length; i++) {
      var image = ImageClass();

      if (i != 0) {
        if (i % 5 == 0) {
          //Below image.type = "GoogleAds" is Going to the show Ads
          image.type = "GoogleAd";
        } else {
          //Below image.type is Goign to SHow Images
          image.type = "";
          image.images = imageList[i];
        }
        _list.add(image);
      } else {
        image.type = "";
        image.images = imageList[i];
        _list.add(image);
      }
    }
  }

  Widget adsContainer() {
    return Container(
      //You Can Set Container Height
      height: 250,
      child: NativeAdmob(
        // Your ad unit id
        adUnitID: _adUnitID,
        controller: _nativeAdController,
        type: NativeAdmobType.full,
        error: CupertinoActivityIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(12),
          child: StaggeredGridView.countBuilder(
            crossAxisSpacing: 3.0,
            mainAxisSpacing: 3.0,
            // controller: scrollController,
            itemCount: _list.length,
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              if (_list[index].type != "GoogleAd")
                return images(index);
              else
                return adsContainer();
            },
            crossAxisCount: 2,
            staggeredTileBuilder: (int index) {
              if (_list[index].type != "GoogleAd")
                return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
              else
                return StaggeredTile.count(2, 1);
            },
          )),
    );
  }
}

class ImageClass {
  String images;
  String type;
}
