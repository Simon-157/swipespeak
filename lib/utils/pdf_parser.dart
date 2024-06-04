import 'dart:io';
import 'package:read_pdf_text/read_pdf_text.dart';

Future<String> parsePdf(File file) async {
  final pdfText = await ReadPdfText.getPDFtext(file.path);
  return pdfText;
}
