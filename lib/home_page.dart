import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:resep/bloc/resep/resep_bloc.dart';
import 'package:resep/components/error_state.dart';
import 'package:resep/utils/toast_util.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: Text("Resep"),
      ),
      body: BlocProvider<ResepBloc>(
        create: (context) => ResepBloc()..add(ResepGetListEvent()),
        child: HomeView(),
      ),
    );
  }
}

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  ResepBloc bloc;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(ResepGetListEvent(refresh: true));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    bloc..add(ResepGetListEvent());
    _refreshController.loadComplete();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ResepBloc>(context);
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: Parent(
            style: ParentStyle()..background.color(Colors.grey[50]),
            child: BlocConsumer<ResepBloc, ResepState>(
              listener: (context, state) {
                if (state is ResepStateError) {
                  ToastUtil.error(message: state.errors['message'] ?? '');
                } else if (state is ResepStateSuccess) {
                  ToastUtil.success(message: state.data['message'] ?? '');
                }
              },
              builder: (context, state) {
                if (state is ResepListLoaded) {
                  ResepListLoaded stateData = state;
                  if (stateData.reseps.length > 0) {
                    return SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      enablePullUp: true,
                      header: WaterDropMaterialHeader(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: ListView.builder(
                        itemCount: stateData.reseps.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map<String, dynamic> resep = stateData.reseps[index];
                          return Container(
                            margin: EdgeInsets.all(5),
                            child: ListTile(
                              tileColor: Colors.white,
                              trailing: Icon(Icons.arrow_right),
                              onTap: () {
                                Get.toNamed("/detail", arguments: resep);
                              },
                              title: Text("${resep['resep_nama']}"),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ErrorState(
                      title: "Anda belum menambahkan resep",
                      onTap: () {
                        bloc..add(ResepGetListEvent(refresh: true));
                      },
                    );
                  }
                }
                return ErrorState(
                  onTap: () {
                    bloc..add(ResepGetListEvent(refresh: true));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
