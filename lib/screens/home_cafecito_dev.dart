import 'package:cafecitodev/screens/add_cafecito_dev.dart';
import 'package:cafecitodev/screens/song_item.dart';
import 'package:cafecitodev/services/api_service_cafecito.dart';
import 'package:cafecitodev/widget/icon_button_widget.dart';
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
        actions: [
          IconButtonWidget(
              color: Theme.of(context).dialogBackgroundColor,
              onTap: () {},
              iconData: Icons.add_sharp)
        ],
      ),
      body: ProgressHUD(
        child: loadSongs(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: navigatetoAddPage, label: Icon(Icons.add)),
    );
  }

  void navigatetoAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddCafecitoPage(),
    );
    Navigator.push(context, route);
  }

  Widget loadSongs() {
    return FutureBuilder<List<SongModel>?>(
      future: ApiServiceCafecito
          .getSongs(), // Llama al método estático directamente a través de la clase
      builder: (
        BuildContext context,
        AsyncSnapshot<List<SongModel>?> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No songs found'),
          );
        }

        return songList(snapshot.data!);
      },
    );
  }

  Widget songList(List<SongModel> songs) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return SongItem(
          model: songs[index],
          onDelete: (SongModel model) {
            setState(() {
              isApiCallProcess = true;
            });
            // Aquí puedes agregar la lógica para eliminar la canción si es necesario
          }, // Pasa la instancia de apiServiceCafecito a SongItem
        );
      },
    );
  }
}
