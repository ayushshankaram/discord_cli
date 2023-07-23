import 'package:discord/discord.dart' as discord;
import 'package:discord/models/user.dart';
import 'package:discord/models/servers.dart';
import 'package:args/args.dart';
import 'dart:io';

// Future<void> main(List<String> arguments) async {
//   final input = stdin.readLineSync().toString();
//   switch (input) {
//     case "register":
//       await Users.Register();
//     case "Login":
//       await Users.Login();
//     case "Logout":
//       await Users.Logout();
//     case "isLogin":
//       final res = await Users.isLoggedin();
//       print(res);
//   }
// }

Future<void> main(List<String> arguments) async {
  final parser = ArgParser();
  parser.addCommand('register');
  parser.addCommand('login');
  parser.addCommand('logout');
  parser.addCommand('isLogin');
   parser.addCommand('create');
  parser.addCommand('join');
  parser.addCommand('list');

  // parser.addOption('username', abbr: 'u'); // Adding the 'username' option.

// Add the options for the create command
  final createParser = ArgParser();
  createParser.addOption('name', abbr: 'n', help: 'Server Name');
  createParser.addOption('inviteCode', abbr: 'i', help: 'Invite Code');
  parser.addCommand('create', createParser);

  // Add the options for the join command
  final joinParser = ArgParser();
  joinParser.addOption('inviteCode', abbr: 'i', help: 'Invite Code');
  parser.addCommand('join', joinParser);

  final results = parser.parse(arguments);

  if (results.command == null) {
    // print("Usage: dart your_script_name.dart <command>");
    print(parser.usage);
    return;
  }

  final command = results.command!.name;

  switch (command) {
    case 'register':
      await Users.Register();
      break;
    case 'login':
      // if (results.rest.isEmpty) {
      //   print("Please provide a username using -u <username>");
      //   return;
      // }
      // final username = results.rest[0]!;
      // final username = results.rest.isEmpty ? null : results.rest[0];

      // final username = results.rest.isNotEmpty ? results.rest[0] : null;
      //
      await Users.Login();
      break;
    case 'logout':
      await Users.Logout();
      break;

    case 'isLogin':
      final res = await Users.isLoggedin();
      print(res);

    default:
      print("Invalid command: $command");
      print(parser.usage);
      break;
  }


   final servers = Servers();

  switch (results.command?.name) {
    case 'create':
      final name = results.command!['name'];
      final inviteCode = results.command!['inviteCode'];
      if (name == null || inviteCode == null) {
        // print('Usage: dart your_script_name.dart create --name <name> --inviteCode <invite_code>');
        return;
      }
      servers.createServer(name, inviteCode);
      break;
    case 'join':
      final inviteCode = results.command!['inviteCode'];
      if (inviteCode == null) {
        // print('Usage: dart your_script_name.dart join --inviteCode <invite_code>');
        return;
      }
      await servers.joinServer(inviteCode);
      break;
    case 'list':
      servers.listServers();
      break;
    default:
      // print('Usage: dart your_script_name.dart <command>');
      print(parser.usage);
      break;
  }
}
