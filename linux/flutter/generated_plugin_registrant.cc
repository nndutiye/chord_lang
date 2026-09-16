//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_notemus/flutter_notemus_plugin.h>
#include <printing/printing_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) flutter_notemus_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterNotemusPlugin");
  flutter_notemus_plugin_register_with_registrar(flutter_notemus_registrar);
  g_autoptr(FlPluginRegistrar) printing_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "PrintingPlugin");
  printing_plugin_register_with_registrar(printing_registrar);
}
