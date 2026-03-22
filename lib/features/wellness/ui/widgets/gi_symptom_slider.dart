import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class GiSymptomSlider extends StatelessWidget {
  final String label;
  final String minLabel;
  final String maxLabel;
  final int value;
  final bool inverted; // true = high value is bad (bloating, cramping)
  final ValueChanged<int> onChanged;

  const GiSymptomSlider({
    super.key,
    required this.label,
    required this.minLabel,
    required this.maxLabel,
    required this.value,
    required this.onChanged,
    this.inverted = false,
  });

  Color get _thumbColor {
    // For inverted (bloating/cramping): low = good (green), high = bad (red)
    // For non-inverted (gutPeace): high = good (green), low = bad (red)
    final score = inverted ? (10 - value + 1) : value;
    return AppColors.wellnessScoreInterpolated(score * 10.0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: theme.textTheme.titleSmall),
              const Spacer(),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: _thumbColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$value',
                  style: theme.textTheme.titleMedium
                      ?.copyWith(color: _thumbColor),
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: _thumbColor,
              thumbColor: _thumbColor,
              inactiveTrackColor: _thumbColor.withOpacity(0.2),
              overlayColor: _thumbColor.withOpacity(0.1),
              trackHeight: 6,
            ),
            child: Slider(
              value: value.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (v) => onChanged(v.round()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(minLabel,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey)),
                Text(maxLabel,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
