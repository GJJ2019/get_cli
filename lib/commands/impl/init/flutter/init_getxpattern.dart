import 'dart:io';

import '../../../../common/utils/logger/LogUtils.dart';
import '../../../../common/utils/pubspec/pubspec_utils.dart';
import '../../../../common/utils/shell/shel.utils.dart';
import '../../../../core/internationalization.dart';
import '../../../../core/locales.g.dart';
import '../../../../core/structure.dart';
import '../../../../functions/create/create_list_directory.dart';
import '../../../../functions/create/create_main.dart';
import '../../../../samples/impl/getx_pattern/get_main.dart';
import '../../commads_export.dart';
import '../../install/install_get.dart';

Future<void> createInitGetxPattern() async {
  bool canContinue = await createMain();
  if (!canContinue) return;

  bool isServerProject = PubspecUtils.isServerProject;
  if (!isServerProject) {
    await installGet();
  }
  List<Directory> initialDirs = [
    Directory(Structure.replaceAsExpected(path: 'lib/app/data/')),
  ];
  GetXMainSample(isServer: isServerProject).create();
  await Future.wait([
    CreatePageCommand().execute(),
  ]);
  createListDirectory(initialDirs);
  if (!isServerProject) {
    await ShellUtils.pubGet();
  }
  LogService.success(Translation(LocaleKeys.sucess_getx_pattern_generated));
}
