// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use

import 'dart:convert';
import 'dart:html' as html;

import 'export_delivery.dart';

Future<ExportDeliveryResult> deliverExport(String jsonPayload) async {
  final ts = DateTime.now().millisecondsSinceEpoch;
  final bytes = utf8.encode(jsonPayload);
  final blob = html.Blob([bytes], 'application/json');
  final url = html.Url.createObjectUrlFromBlob(blob);

  final anchor = html.AnchorElement(href: url)
    ..download = 'gutcheck_export_$ts.json'
    ..style.display = 'none';

  html.document.body?.append(anchor);
  anchor.click();
  anchor.remove();
  html.Url.revokeObjectUrl(url);

  return const ExportDeliveryResult(showMessage: false, message: '');
}
