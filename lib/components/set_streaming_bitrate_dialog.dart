import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jellyflix/models/bitrates.dart';
import 'package:jellyflix/l10n/generated/app_localizations.dart';

class SetStreamingBitrateDialog extends HookConsumerWidget {
  const SetStreamingBitrateDialog({
    super.key,
    required int streamingBitrate,
  }) : _streamingBitrate = streamingBitrate;

  final int _streamingBitrate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamingBitrate = useState(_streamingBitrate);

    return AlertDialog(
      title: const Text('Max Streaming Bitrate'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Set the maximum bitrate for streaming playback.'),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            width: 350,
            child: RadioGroup<int>(
              groupValue: streamingBitrate.value,
              onChanged: (value) {
                streamingBitrate.value = value!;
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: BitRates().map.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Radio<int>(
                        value: BitRates().map.keys.toList()[index]),
                    title: Text(BitRates().map.values.toList()[index]),
                    onTap: () {
                      streamingBitrate.value = BitRates().map.keys.toList()[index];
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, null);
          },
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, streamingBitrate.value);
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
      ],
    );
  }
}
