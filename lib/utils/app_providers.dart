import 'package:babylid/screens/Milestones/provider.dart';
import 'package:babylid/screens/account_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<MilestoneProvider>(
    create: (context) => MilestoneProvider(),
  ),
  ChangeNotifierProvider<UserProvider>(
    create: (context) => UserProvider(),
  ),
];
