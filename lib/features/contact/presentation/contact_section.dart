import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/features/home/presentation/widgets/creative_top_bar.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  static final Uri _email = Uri.parse('mailto:mahmoudahmed8692@gmail.com');
  static final Uri _github = Uri.parse('https://github.com/MahmoudASoliman');
  static final Uri _linkedin = Uri.parse('https://www.linkedin.com/in/mahmoud-a-soliman/');
  static final Uri _phone = Uri.parse('tel:+201286927788');
  static final Uri _wa = Uri.parse('https://wa.me/201286927788?text=Hi%20Mahmoud%2C%20I%20saw%20your%20portfolio');
  static final Uri _cv = Uri.parse('https://drive.google.com/file/d/1EqP_d66jT4NR2jP3KEYCA03cOL7MIkpb/view?usp=drive_link');

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Contact', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Text('Let’s connect about freelance, internships, or junior roles.', style: t.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 16),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ContactPill(label: 'Whatsapp', icon: FontAwesomeIcons.whatsapp, url: 'https://wa.me/201286927788?text=Hi%20Mahmoud%2C%20I%20saw%20your%20portfolio'),
            ContactPill(label: 'View CV', icon: FontAwesomeIcons.filePdf, url: 'https://drive.google.com/file/d/1EqP_d66jT4NR2jP3KEYCA03cOL7MIkpb/view?usp=drive_link'),
            ContactPill(label: 'Email Me', icon: FontAwesomeIcons.solidEnvelope, url: 'mailto:mahmoudahmed8692@gmail.com'),
            ContactPill(label: 'Call', icon: FontAwesomeIcons.phone, url: 'tel:+201286927788'),
            ContactPill(label: 'GitHub', icon: FontAwesomeIcons.github, url: 'https://github.com/MahmoudASoliman'),
            ContactPill(label: 'LinkedIn', icon: FontAwesomeIcons.linkedin, url: 'https://www.linkedin.com/in/mahmoud-a-soliman/'),
          ],
        ),
      ],
    );
  }
}
