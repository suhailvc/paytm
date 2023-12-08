import 'dart:io';

import 'package:flutter/material.dart';
import 'package:machine_task/presentation/pdf_viewer_screen/pdf_viewer_screen.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:machine_task/presentation/widgets/warning.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var querySize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "PDF Viewerr",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(querySize.height * 0.03),
        child: Column(children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PdfViewerScreen(),
                  ));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(querySize.height * 0.02)),
              height: querySize.height * 0.69,
              width: querySize.height * 0.43,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text("PDF file here")],
              ),
            ),
          ),
          SizedBox(
            height: querySize.height * 0.03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  final response = await http.get(Uri.parse(
                      "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf"));

                  final directory = await getTemporaryDirectory();
                  final file = File('${directory.path}/paytm.pdf');
                  await file.writeAsBytes(response.bodyBytes);

                  final xFile = XFile.fromData(response.bodyBytes,
                      mimeType: 'application/pdf');

                  await Share.shareXFiles([xFile]);
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.share),
                ),
              ),
              GestureDetector(
                onTap: () {
                  FileDownloader.downloadFile(
                    url:
                        "https://paytym.net/storage/pdfs/EMP18_PS_22-09-2023.pdf",
                    onDownloadCompleted: (path) {
                      warning(context, 'download completed');
                    },
                  );
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.download),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
