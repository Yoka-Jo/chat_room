part of 'ChatImports.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  IO.Socket? socket;
  TextEditingController nameController = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    initTheSocket();
  }

  initTheSocket() {
    socket = IO.io("http://192.168.1.20/3000/", {
      "transports": ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();

    socket!.onConnect((_) {
      print("Connected with the server");
    });

    socket!.on("res", (data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("Chat Room"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          BuildChatMessages(
            messages: messages,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200.0,
                child: TextField(
                  controller: nameController,
                  decoration:
                      InputDecoration(hintText: "Enter your message here..."),
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              InkWell(
                  onTap: () {
                    socket!.emit("msg", {"name": nameController.text});
                    nameController.clear();
                  },
                  child: CircleAvatar(radius: 25.0, child: Icon(Icons.send)))
            ],
          ),
        ],
      ),
    );
  }
}
