import 'package:game_dashboard/ui/enums/tabs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final tabProvider = StateProvider<String>((ref)=>Tabs.values.first);