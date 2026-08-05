import 'package:dio/dio.dart';
import 'package:lesson5/data/models/todo_model.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class TodoRepository {
  TodoRepository() {
    dio.interceptors.add(TalkerDioLogger());
  }

  final Dio dio = Dio();

  Future<List<TodoModel>> getTodos() async {
    final Response response = await dio.get(
      'https://dummyjson.com/todos',
    );

    List<TodoModel> list = [];
    response.data['todos'].forEach((json) {
      list.add(TodoModel.fromJson(json));
    });
    return list;
  }
}
