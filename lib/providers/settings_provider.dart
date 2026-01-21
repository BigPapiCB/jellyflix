import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jellyflix/providers/database_provider.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  final Ref ref;

  SettingsNotifier(this.ref) : super(SettingsState()) {
    _loadSettings();
  }

  void _loadSettings() {
    final db = ref.read(databaseProvider('settings'));
    final maxBitrate = db.get('maxStreamingBitrate') as int?;

    state = state.copyWith(
      maxStreamingBitrate: maxBitrate ?? 1000000000, // Default: 1 Gbps
    );
  }

  Future<void> setMaxStreamingBitrate(int bitrate) async {
    final db = ref.read(databaseProvider('settings'));
    await db.put('maxStreamingBitrate', bitrate);
    state = state.copyWith(maxStreamingBitrate: bitrate);
  }
}

class SettingsState {
  final int maxStreamingBitrate;

  SettingsState({
    this.maxStreamingBitrate = 1000000000, // Default: 1 Gbps
  });

  SettingsState copyWith({
    int? maxStreamingBitrate,
  }) {
    return SettingsState(
      maxStreamingBitrate: maxStreamingBitrate ?? this.maxStreamingBitrate,
    );
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(ref);
});
