import 'package:bloc_rest_api/features/posts/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostsPage> {
  final PostBloc postsBloc = PostBloc();

  @override
  void initState() {
    postsBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Page'),
        backgroundColor: Colors.teal,
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: () {
        postsBloc.add(PostAddEvent());
      }),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingSuccessfulState:
              final successState = state as PostFetchingSuccessfulState;
              return Container(
                child: ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade200,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(successState.posts[index].title),
                          Text(successState.posts[index].body)
                        ],
                      ),
                    );
                  },
                ),
              );
            case PostFetchingLoadingState:
              return Center(child: CircularProgressIndicator());
            case PostFetchingErrorState:
              return Text('Error');
            default:
              return SizedBox();
          }
        },
      ),
    );
  }
}
