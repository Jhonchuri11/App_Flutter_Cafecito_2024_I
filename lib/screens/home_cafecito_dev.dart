import 'package:cafecitodev/screens/add_cafecito_dev.dart';
import 'package:cafecitodev/screens/song_item.dart';
import 'package:cafecitodev/services/api_service_cafecito.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:cafecitodev/model/song_model.dart';

class MyHomeCafecito extends StatefulWidget {
  const MyHomeCafecito({super.key});

  @override
  State<MyHomeCafecito> createState() => _MyHomeCafecitoState();
}

class _MyHomeCafecitoState extends State<MyHomeCafecito>
    with TickerProviderStateMixin {
  final TextEditingController searchController = TextEditingController();

  bool isApiCallProcess = false;

  final ApiServiceCafecito apiServiceCafecito = ApiServiceCafecito();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: TextField(
          controller: searchController,
          textInputAction: TextInputAction.search,
          onChanged: (v) {},
          decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  if (searchController.text.isEmpty) {}
                },
                child: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
              hintText: 'Search Cafecito',
              contentPadding: const EdgeInsets.all(10),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black))),
        ),
      ),
      body: ProgressHUD(
        child: loadSongs(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/add-song');
          },
          label: Icon(Icons.add)),
    );
  }

  Widget loadSongs() {
    return FutureBuilder(
      future: ApiServiceCafecito.getSongs(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SongModel>?> model,
      ) {
        if (model.hasData) {
          return songList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget songList(songs) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(10),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return SongItem(
          model: songs[index],
          onDelete: (SongModel model) {
            setState(() {
              isApiCallProcess = true;
            });

            ApiServiceCafecito.deleteSong(model.id).then((response) {
              setState(() {
                isApiCallProcess = false;
              });
            });
          },
        );
      },
    );
  }
}
