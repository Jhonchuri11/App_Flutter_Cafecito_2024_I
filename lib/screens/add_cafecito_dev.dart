import 'package:cafecitodev/model/song_model.dart';
import 'package:cafecitodev/services/api_service_cafecito.dart';
import 'package:cafecitodev/widget/card_widget.dart';
import 'package:cafecitodev/widget/my_box_widget.dart';
import 'package:cafecitodev/widget/text_button_widget.dart';
import 'package:flutter/material.dart';

class AddCafecitoPage extends StatefulWidget {
  const AddCafecitoPage({super.key});

  @override
  State<AddCafecitoPage> createState() => _AddCafecitoPageState();
}

class _AddCafecitoPageState extends State<AddCafecitoPage> {
  final _formKey = GlobalKey<FormState>();

  bool isApiCallProcess = false;

  bool isEditMode = false;

  final ApiServiceCafecito apiServiceCafecito = ApiServiceCafecito();

  TextEditingController titleSongController = TextEditingController();
  TextEditingController descriptionSongController = TextEditingController();
  TextEditingController imageSongController = TextEditingController();
  TextEditingController tipeRecordSongController = TextEditingController();
  TextEditingController authorSongController = TextEditingController();

  // Para crear nueva cancion
  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final title = titleSongController.text;
      final description = descriptionSongController.text;
      final image = imageSongController.text;
      final author = authorSongController.text;

      final newSong = SongModel(
          id: 0,
          title: title,
          description: description,
          image: image,
          author: author);

      try {
        await apiServiceCafecito.createSong(newSong);
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error creating song")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add cafecito store"),
      ),
      body: SingleChildScrollView(
        child: CardWidget(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: titleSongController,
                        decoration: InputDecoration(labelText: 'Titulo'),
                      ),
                    ),
                    MyBoxWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: descriptionSongController,
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                    ),
                    MyBoxWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: imageSongController,
                        decoration:
                            InputDecoration(labelText: 'Url de la imagen'),
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an author';
                          }
                          return null;
                        },
                      ),
                    ),
                    MyBoxWidget(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: authorSongController,
                        decoration: InputDecoration(labelText: 'Author'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an author';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              MyBoxWidget(
                height: 30,
              ),
              TextBtnWidget(
                name: 'Save cafecito',
                onTap: _submit, // Llama al método _submit al presionar el botón
              ),
            ],
          ),
        ),
      ),
    );
  }
}
