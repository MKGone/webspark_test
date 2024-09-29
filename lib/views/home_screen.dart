import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/url/url_block.dart';
import '../blocs/url/url_event.dart';
import '../blocs/url/url_state.dart';
import '../generated/l10n.dart';
import 'process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UrlBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).home_screen_appbar),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(S.of(context).home_screen_title),
                Row(
                  children: [
                    const Icon(Icons.compare_arrows_outlined),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: BlocBuilder<UrlBloc, UrlState>(
                        builder: (context, state) {
                          return TextFormField(
                            controller: _urlController,
                            onChanged: (value) {
                              context.read<UrlBloc>().add(UrlChanged(value));
                            },
                            decoration: InputDecoration(
                              hintText: S.of(context).hint_text,
                              errorText: state is UrlInvalid
                                  ? state.errorMessage
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: BlocConsumer<UrlBloc, UrlState>(
                      listener: (context, state) {
                        if (state is UrlFetchSuccess) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProcessScreen(jsonResponse: state.data),
                            ),
                          );
                        } else if (state is UrlFetchFailure) {
                          state.error;
                        }
                      },
                      builder: (context, state) {
                        if (state is UrlLoading) {
                          return const CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            context
                                .read<UrlBloc>()
                                .add(ValidateUrl(_urlController.text));
                          },
                          child: Text(S.of(context).start_counting),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
