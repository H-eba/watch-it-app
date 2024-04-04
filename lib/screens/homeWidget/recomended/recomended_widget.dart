import 'package:flutter/material.dart';
import 'package:movie_app/my_theme_data.dart';
import 'package:movie_app/screens/homeWidget/custome_widget.dart';
import 'package:movie_app/screens/homeWidget/recomended/recomended_widget_view_model.dart';
import 'package:provider/provider.dart';

class RecomendedWidget extends StatefulWidget {
  const RecomendedWidget({super.key});

  @override
  State<RecomendedWidget> createState() => _RecomendedWidgetState();
}

class _RecomendedWidgetState extends State<RecomendedWidget> {
  RecomendedWidgetViewModel viewModel =RecomendedWidgetViewModel();
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    viewModel.getRecomended();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(10),
        height: 300,
        color: Color(0xff514F4F),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Recommended',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 15,
            ),
            ChangeNotifierProvider(
              create: (context) => viewModel,
              child: Consumer<RecomendedWidgetViewModel>(
                  builder:(context, value, child) {
                    if (viewModel.errorMessage != null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              viewModel.errorMessage!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                viewModel.getRecomended();
                                setState(() {});
                              },
                              child: Text(
                                'Tray again',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                      );
                    }else if(viewModel.movies == null) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: MyThemeData.yellowColor,
                        ),
                      );

                    }
                    else{
                      return CustomeWidget(movies: viewModel.movies);
                    }
                  }
              ),
            ),
          ],
        ),
      );
  }
}