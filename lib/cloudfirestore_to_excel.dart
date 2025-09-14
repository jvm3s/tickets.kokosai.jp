import 'package:excel/excel.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


Future<void> createExcelFile() async {
  // 新しいExcelファイルを作成
  var excel = Excel.createExcel();

  // 'Sheet1'という名前のシートを取得
  var sheet = excel['Sheet1'];

  fire
  sheet.cell(CellIndex.indexByString("A1")).value =TextCellValue("aaa")

  // ファイルをバイトデータにエンコード
  var fileBytes = excel.encode();

  // ファイルをローカルに保存
  var file = File('example.xlsx');
  await file.writeAsBytes(fileBytes!);
  print('Excelファイルが作成されました: ${file.path}');
}
class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}