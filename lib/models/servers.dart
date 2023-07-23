import 'dart:io';
import 'package:args/args.dart';

class Server {
  late String name;
  late String inviteCode;

  Server(this.name, this.inviteCode);
}

class Servers {
  List<Server> _servers = [];

  void createServer(String name, String inviteCode) {
    _servers.add(Server(name, inviteCode));
    print('Server "$name" created with invite code "$inviteCode".');
  }

  void listServers() {
    print('Available Servers:');
    for (var server in _servers) {
      print('${server.name} - Invite Code: ${server.inviteCode}');
    }
  }

  Future<void> joinServer(String inviteCode) async {
    final server = _servers.firstWhere(
      (s) => s.inviteCode == inviteCode,
      orElse: () => Server('', ''),
    );

    if (server.name.isEmpty) {
      print('Server with invite code "$inviteCode" not found.');
    } else {
      print('Pretending to join the server: ${server.name}');
      await Future.delayed(Duration(seconds: 2));
      print('Joined the server: ${server.name}');
    }
  }
}

// Future<void> main(List<String> arguments) async {
//   final parser = ArgParser();
//   parser.addCommand('create');
//   parser.addCommand('join');
//   parser.addCommand('list');

//   final results = parser.parse(arguments);

//   final servers = Servers();

//   final createResults = results.command?.name == 'create' ? results.command : null;
//   final joinResults = results.command?.name == 'join' ? results.command : null;
//   final listResults = results.command?.name == 'list' ? results.command : null;

//   if (createResults != null) {
//     final name = createResults['name'];
//     final inviteCode = createResults['inviteCode'];
//     if (name == null || inviteCode == null) {
//       print('Usage: dart your_script_name.dart create --name <name> --inviteCode <invite_code>');
//       return;
//     }
//     servers.createServer(name, inviteCode);
//   } else if (joinResults != null) {
//     final inviteCode = joinResults['inviteCode'];
//     if (inviteCode == null) {
//       print('Usage: dart your_script_name.dart join --inviteCode <invite_code>');
//       return;
//     }
//     await servers.joinServer(inviteCode);
//   } else if (listResults != null) {
//     servers.listServers();
//   } else {
//     print('Usage: dart your_script_name.dart <command>');
//     print(parser.usage);
//   }
// }
