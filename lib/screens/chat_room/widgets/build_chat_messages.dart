part of 'chat_room_w_imports.dart';


class BuildChatMessages extends StatelessWidget {
  final List<String> messages;
  const BuildChatMessages({Key? key, required this.messages}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
              itemBuilder: (context, i) {
                return Card(
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(messages[i]),
                    ));
              },
              itemCount: messages.length,
              separatorBuilder: (context, i) {
                return const SizedBox(
                  height: 25.0,
                );
              },
            ),
      ),
    );
  }
}
