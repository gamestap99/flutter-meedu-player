import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:meedu_player/meedu_player.dart';
import 'package:meedu_player/src/helpers/responsive.dart';
import 'package:meedu_player/src/helpers/utils.dart';
import 'package:meedu_player/src/widgets/fullscreen_button.dart';
import 'package:meedu_player/src/widgets/mute_sound_button.dart';
import 'package:meedu_player/src/widgets/pip_button.dart';
import 'package:meedu_player/src/widgets/player_slider.dart';

class PrimaryBottomControls extends StatelessWidget {
  final Responsive responsive;
  const PrimaryBottomControls({Key key, @required this.responsive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontSize = responsive.ip(2.5);
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: fontSize > 17 ? 17 : fontSize,
    );
    return GetBuilder<MeeduPlayerController>(
      builder: (_) => Positioned(
        left: 5,
        right: 0,
        bottom: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // START VIDEO POSITION
            Obx(
              () => Text(
                _.duration.inMinutes >= 60
                    ? printDurationWithHours(_.position)
                    : printDuration(_.position),
                style: textStyle,
              ),
            ),
            // END VIDEO POSITION
            SizedBox(width: 10),
            Expanded(
              child: PlayerSlider(),
            ),
            SizedBox(width: 10),
            // START VIDEO DURATION
            Obx(
              () => Text(
                _.duration.inMinutes >= 60
                    ? printDurationWithHours(_.duration)
                    : printDuration(_.duration),
                style: textStyle,
              ),
            ),
            // END VIDEO DURATION
            SizedBox(width: 15),
            if (_.bottomRight != null) ...[_.bottomRight, SizedBox(width: 5)],

            PipButton(responsive: responsive),

            MuteSoundButton(responsive: responsive),

            FullscreenButton(
              size: responsive.ip(_.fullscreen ? 5 : 7),
            )
          ],
        ),
      ),
    );
  }
}
