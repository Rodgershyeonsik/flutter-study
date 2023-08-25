import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study/image_grid_view/tour_image_model.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.title, required this.mainImgUri}) : super(key: key);
  final String title;
  final String mainImgUri;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _pageNo = 1;
  final _numOfRows = 10;
  int? _totalCount;
  List<TourImgModel> _items = [];
  final _scrollController = ScrollController();

  Future<void> requestGalDetailList1(int pageNo) async {
    final Uri uri = Uri.parse(
        'https://apis.data.go.kr/B551011/PhotoGalleryService1/galleryDetailList1');
    final queryParam = {
      'numOfRows': '$_numOfRows',
      'pageNo': pageNo.toString(),
      'MobileOS': Platform.isAndroid ? 'AND' : 'IOS',
      'MobileApp': 'assignments',
      '_type': 'json',
      'title': widget.title,
      'serviceKey': 'jkqvpZbVGElLO3oiDkzS2NoOGQ7s2Oqomt1EeMdntvzjQwMFYLiKVT/DQaLcW5vRLp0ySoAzg4Yz5q5vF1CISw=='
    };
    print("queryParam: $queryParam");

    final uriWithQuery = uri.replace(queryParameters: queryParam);
    final response = await http.get(uriWithQuery);
    if (response.statusCode == 200) {
      var jsonRes = jsonDecode(utf8.decode(response.bodyBytes));
      _totalCount = jsonRes['response']['body']['totalCount'] as int;
      setState(() {});
      if(_totalCount! > 0) {
        var newItems = jsonRes['response']['body']['items']['item'] as List;
        setState(() {
          _items.addAll((newItems.map((e) => TourImgModel.fromJson(e))));
        });
      }
    } else {
      print('통신 에러: ${response.statusCode}');
    }
  }
  @override
  void initState() {
    super.initState();
    requestGalDetailList1(_pageNo);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_items.length < _totalCount!) {
          requestGalDetailList1(++_pageNo);
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
        title: Align(
          alignment: Alignment.centerRight,
          child: Text("${widget.title},사진 둘러보기",
            style: TextStyle(
              fontSize: 20,
            ),),
        ),
      ),
      body: _totalCount == null
          ? Center(child: CircularProgressIndicator())
          : _totalCount == 0
          ? Center(child: Text("관련된 사진이 없어요!"))
          : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
              childAspectRatio: 1
          ),
          controller: _scrollController,
          itemCount: _items.length + 2,
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) {
            if (index < _items.length) {
              return Image.network(
                  _items[index].galWebImageUrl,
                  fit: BoxFit.fill);
            } else {
              if(_items.isNotEmpty && _items.length == _totalCount) {
                return Container();
              }
              return Center(child: CircularProgressIndicator());
            }
          }
      ),
    );
  }
}