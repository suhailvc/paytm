import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerScreen extends StatelessWidget {
  const PdfViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text(
          "PDF",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: querySize.height * 0.87,
        child: SfPdfViewer.network(
            "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf"),
      ),
    );
  }
}
