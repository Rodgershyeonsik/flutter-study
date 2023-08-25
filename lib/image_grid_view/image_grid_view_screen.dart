import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:study/image_grid_view/tour_image_model.dart';

import 'dart:io';

import 'detail_screen.dart';

class ImageGridViewScreen extends StatefulWidget {
  const ImageGridViewScreen({Key? key}) : super(key: key);

  @override
  State<ImageGridViewScreen> createState() => _ImageGridViewScreenState();
}

class _ImageGridViewScreenState extends State<ImageGridViewScreen> {
  int _pageNo = 1;
  int? _totalCount;
  final _numOfRows = 10;
  List<TourImgModel> _items = [];
  final _scrollController = ScrollController();

  Future<void> requestGalList1(int pageNo) async {
    final Uri uri = Uri.parse(
        'https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryList1');
    final queryParam = {
      'numOfRows': '$_numOfRows',
      'pageNo': pageNo.toString(),
      'MobileOS': Platform.isAndroid ? 'AND' : 'IOS',
      'MobileApp': 'assignments',
      '_type': 'json',
      'serviceKey':
      '서비스키'
    };
    print("queryParam: $queryParam");

    final uriWithQuery = uri.replace(queryParameters: queryParam);
    final response = await http.get(uriWithQuery);
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));

      _totalCount = jsonRes['response']['body']['totalCount'] as int;
      var newItems = jsonRes['response']['body']['items']['item'] as List;

      setState(() {
        _items.addAll((newItems.map((e) => TourImgModel.fromJson(e))));
      });
    } else {
      print('통신 에러: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    requestGalList1(_pageNo);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_items.length < _totalCount!) {
          requestGalList1(++_pageNo);
        } else {
          print("끝");
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("image grid demo"),
      ),
      body: _totalCount == null
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 0.8),
          controller: _scrollController,
          itemCount: _items.length + 2,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            if (index < _items.length) {
              return makeImgCard(context, _items[index]);
            } else {
              if (_items.isNotEmpty && _items.length == _totalCount) {
                return Container();
              }
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget makeImgCard(context, TourImgModel model) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textScale = MediaQuery.of(context).textScaleFactor;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailScreen(
                    title: model.galTitle, mainImgUri: model.galWebImageUrl)));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.3,
                blurRadius: 1,
                offset: Offset(1, 1),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Image.network(
                model.galWebImageUrl,
                fit: BoxFit.fill,
                height: screenHeight * 0.15,
                width: screenWidth * 0.4,
              ),
            ),
            Text(
              model.galTitle,
              style: TextStyle(
                  fontSize: textScale * 13, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              '장소: ${model.galPhotographyLocation}',
              style: TextStyle(fontSize: textScale * 12),
            ),
            Text(
              "\n#${model.galSearchKeyword.replaceAll(", ", " #")}",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: textScale * 8),
            )
          ],
        ),
      ),
    );
  }
}
