//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_midi_command_windows/flutter_midi_command_windows_plugin.h>
#include <flutter_notemus/flutter_notemus_plugin_c_api.h>
#include <printing/printing_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterMidiCommandWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterMidiCommandWindowsPlugin"));
  FlutterNotemusPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterNotemusPluginCApi"));
  PrintingPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("PrintingPlugin"));
}
