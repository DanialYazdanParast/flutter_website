import 'package:datiego/confing/theme/app_theme.dart';
import 'package:datiego/core/widgets/custom_box_decoration.dart';
import 'package:datiego/features/blog/presentation/widgets/blog_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'text_titel_about.dart';

class Experience extends StatelessWidget {
  const Experience({super.key});

  // Constants for spacing to ensure consistency and easy maintenance.
  static const _kVerticalSpacerL = SizedBox(height: 24.0);
  static const _kVerticalSpacerM = SizedBox(height: 16.0);
  static const _kVerticalSpacerS = SizedBox(height: 8.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: customBoxDecoration(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextTitelAbout(text: "Experience"),
          _kVerticalSpacerL,
          SizedBox(
            height: 40,
            child: ButtonWidget(
              color: MyAppThemeConfig.of(context)
                  .green,
              text: "Tibobit Exchange",
              isIcon: true,
              onTap: () => launchUrl(Uri.parse('https://tibobit.com')),
            ),
          ),
          _kVerticalSpacerM,
          Text(
            'Flutter Developer  • 03/2025 - 11/2025',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          _kVerticalSpacerM,
          _buildBulletPoint(
            context,
            [
              const TextSegment('Engineered a production-ready '),
              const TextSegment('Flutter', isBold: true),
              const TextSegment(' crypto trading app for Android/iOS, featuring '),
              const TextSegment('real-time charts, spot trading, secure wallet, and referral system', isBold: true),
              const TextSegment('.'),
            ],
          ),
          _kVerticalSpacerS,
          _buildBulletPoint(
            context,
            [
              const TextSegment('Collaborated on '),
              const TextSegment('pixel-perfect UI', isBold: true),
              const TextSegment(' with smooth animations using '),
              const TextSegment('Figma', isBold: true),
              const TextSegment('; implemented robust security with '),
              const TextSegment('biometrics, 2FA, and anti-phishing measures', isBold: true),
              const TextSegment('.'),
            ],
          ),
          _kVerticalSpacerS,
          _buildBulletPoint(
            context,
            [
              const TextSegment('Boosted performance via '),
              const TextSegment('MVVM + GetX', isBold: true),
              const TextSegment(' architecture, '),
              const TextSegment('Freezed', isBold: true),
              const TextSegment(' for type-safety, and backend-driven push notifications.'),
            ],
          ),
          _kVerticalSpacerS,
          _buildBulletPoint(
            context,
            [
              const TextSegment('Launched on '),
              const TextSegment('Cafe Bazaar', url: 'https://cafebazaar.ir/app/com.tibobit.app'),
              const TextSegment(', '),
              const TextSegment('Myket', url: 'https://myket.ir/app/com.tibobit.app'),
              const TextSegment(' and '),
              const TextSegment('Sibche', url: 'https://sibche.com/applications/tibobit'),
              const TextSegment(' | '),
              const TextSegment('Agile/Scrum', isBold: true),
              const TextSegment(' workflow with '),
              const TextSegment('Jira',isBold: true),
              const TextSegment(' & '),
              const TextSegment('Gitflow', isBold: true),
            ],
          ),
        ],
      ),
    );
  }

  /// Builds a bullet point using a list of [TextSegment]s.
  Widget _buildBulletPoint(BuildContext context, List<TextSegment> segments) {
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return RichText(
      text: TextSpan(
        style: textStyle,
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Text('•', style: TextStyle(fontSize: 16)),
            ),
          ),
          ...segments.map((segment) {
            final isLink = segment.url != null;
            if (isLink) {
              // For links, use a WidgetSpan containing our custom clickable widget.
              return WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _ClickableText(
                  text: segment.text,
                  url: segment.url!,
                  style: textStyle?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blue,
                  ),
                ),
              );
            } else {
              // For normal or bold text, use TextSpan.
              return TextSpan(
                text: segment.text,
                style: TextStyle(
                  fontWeight: segment.isBold ? FontWeight.bold : FontWeight.normal,
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}

/// A helper widget that creates a clickable text with a pointer cursor on hover.
class _ClickableText extends StatelessWidget {
  const _ClickableText({
    required this.text,
    required this.url,
    this.style,
  });

  final String text;
  final String url;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor to a hand/pointer
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Text(text, style: style),
      ),
    );
  }
}

// Data model for text segments.
class TextSegment {
  final String text;
  final bool isBold;
  final String? url;

  const TextSegment(this.text, {this.isBold = false, this.url});
}