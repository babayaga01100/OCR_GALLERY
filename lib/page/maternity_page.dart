import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:last_ocr/page/maternity_list_page.dart';
import '../functions/functions.dart';

late int ocr_seq;
late String sow_no;
late String sow_birth;
late String sow_buy;
late String sow_expectdate;
late String sow_givebirth;
late String sow_totalbaby;
late String sow_feedbaby;
late String sow_babyweight;
late String sow_sevrerdate;
late String sow_sevrerqty;
late String sow_sevrerweight;
late String vaccine1;
late String vaccine2;
late String vaccine3;
late String vaccine4;
late String memo;
late String filename;

class MaternityPage extends StatefulWidget{
  static const routeName = '/OcrMaternityPage';

  // const MaternityPage({Key? key, this.title}) : super(key: key);
  final List listfromserver_mat;
  final String Imagefromserver_mat;
  const MaternityPage(this.listfromserver_mat, this.Imagefromserver_mat);

  @override
  MaternityPageState createState() => MaternityPageState();
}

class MaternityPageState extends State<MaternityPage>{

  late String sowID1;
  late String sowID2;

  late String birth_year;
  late String birth_month;
  late String birth_day;

  late String adoption_year;
  late String adoption_month;
  late String adoption_day;

  late String expect_year;
  late String expect_month;
  late String expect_day;

  late String teen_month;
  late String teen_day;

  late String givebirth_month;
  late String givebirth_day;

  late String totalbaby;

  late String feedbaby;

  late String weight;

  late String totalteen;
  late String teenweight;

  Widget showImage() {

    return Container(
        margin: EdgeInsets.only(left: 20,right: 20),
        color: const Color(0xffd0cece),
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .width*1.414,
        child: Center(
            child:  widget.Imagefromserver_mat.isEmpty ? Text('No image selected.') : Image.file(File(widget.Imagefromserver_mat))));
  }

  //????????????
  final sowID1_Controller = TextEditingController();
  final sowID2_Controller = TextEditingController();

  //?????????
  final birth_year_Controller = TextEditingController();
  final birth_month_Controller = TextEditingController();
  final birth_day_Controller = TextEditingController();

  //?????????
  final adoption_year_Controller = TextEditingController();
  final adoption_month_Controller = TextEditingController();
  final adoption_day_Controller = TextEditingController();

  //???????????????
  final expect_year_Controller = TextEditingController();
  final expect_month_Controller = TextEditingController();
  final expect_day_Controller = TextEditingController();

  //?????????
  final teen_month_Controller = TextEditingController();
  final teen_day_Controller = TextEditingController();

  //?????????
  final givebirth_month_Controller = TextEditingController();
  final givebirth_day_Controller = TextEditingController();

  //????????????
  final totalbaby_Controller = TextEditingController();
  final feedbaby_Controller = TextEditingController();
  //????????????
  final weight_Controller = TextEditingController();

  //????????????
  final totalteen_Controller = TextEditingController();

  //????????????
  final teenweight_Controller = TextEditingController();

  final vaccine1_fir_Controller = TextEditingController();
  final vaccine1_sec_Controller = TextEditingController();
  final vaccine2_fir_Controller = TextEditingController();
  final vaccine2_sec_Controller = TextEditingController();
  final vaccine3_fir_Controller = TextEditingController();
  final vaccine3_sec_Controller = TextEditingController();
  final vaccine4_fir_Controller = TextEditingController();
  final vaccine4_sec_Controller = TextEditingController();

  final memo_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    if(widget.listfromserver_mat.isNotEmpty){
      if(sowID1_Controller.text.isEmpty) {
        print(widget.listfromserver_mat);

        sowID1_Controller.text = widget.listfromserver_mat[1][24].split('-')[0];
        sowID2_Controller.text = widget.listfromserver_mat[1][24].split('-')[1];

        birth_year_Controller.text = widget.listfromserver_mat[1][0];
        birth_month_Controller.text = widget.listfromserver_mat[1][1];
        birth_day_Controller.text = widget.listfromserver_mat[1][2];

        adoption_year_Controller.text = widget.listfromserver_mat[1][3];
        adoption_month_Controller.text = widget.listfromserver_mat[1][4];
        adoption_day_Controller.text = widget.listfromserver_mat[1][5];

        expect_year_Controller.text = widget.listfromserver_mat[1][6];
        expect_month_Controller.text = widget.listfromserver_mat[1][7];
        expect_day_Controller.text = widget.listfromserver_mat[1][8];

        teen_month_Controller.text = widget.listfromserver_mat[1][13];
        teen_day_Controller.text = widget.listfromserver_mat[1][14];

        givebirth_month_Controller.text = widget.listfromserver_mat[1][9];
        givebirth_day_Controller.text = widget.listfromserver_mat[1][10];

        totalbaby_Controller.text = widget.listfromserver_mat[1][11];
        feedbaby_Controller.text = widget.listfromserver_mat[1][12];

        weight_Controller.text = widget.listfromserver_mat[1][25];
        totalteen_Controller.text = widget.listfromserver_mat[1][15];
        teenweight_Controller.text = widget.listfromserver_mat[1][26];

        vaccine1_fir_Controller.text = widget.listfromserver_mat[1][16];
        vaccine1_sec_Controller.text = widget.listfromserver_mat[1][17];
        vaccine2_fir_Controller.text = widget.listfromserver_mat[1][18];
        vaccine2_sec_Controller.text = widget.listfromserver_mat[1][19];
        vaccine3_fir_Controller.text = widget.listfromserver_mat[1][20];
        vaccine3_sec_Controller.text = widget.listfromserver_mat[1][21];
        vaccine4_fir_Controller.text = widget.listfromserver_mat[1][22];
        vaccine4_sec_Controller.text = widget.listfromserver_mat[1][23];

        // memo_Controller.text = widget.listfromserver_mat[0];

        filename = widget.listfromserver_mat[0];
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("?????????"),
        ),
        body: Scrollbar(
              thumbVisibility: true, //always show scrollbar
              thickness: 10, //width of scrollbar
              radius: Radius.circular(20), //corner radius of scrollbar
              scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
              child: SingleChildScrollView(
                child: Column(children:<Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 20,right: 20,top: 20),
                      child: Table(
                        textBaseline: TextBaseline.alphabetic,
                        border: TableBorder.all(),
                        columnWidths: const {0: FractionColumnWidth(.0),1: FractionColumnWidth(.4), 2: FractionColumnWidth(.4), 3: FractionColumnWidth(.1),4: FractionColumnWidth(.1)},
                        children: [
                          TableRow(
                            children: [
                              const TableCell(
                                child: SizedBox(height: 30,),
                              ),
                              Column(children:const[
                                Text('????????????',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                              ]),
                              Column(children:[
                                TextField(controller: sowID1_Controller,
                                  decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                              ]),
                              Column(children:[
                                Text('-',style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
                              ], ),
                              Column(children:[
                                TextField(controller: sowID2_Controller,
                                  decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.text,textAlign: TextAlign.center,),
                              ]),

                            ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('?????????')
                            ]),
                            Column(children:[
                              TextField(controller: birth_year_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: birth_month_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: birth_day_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},                  children: [
                        TableRow( children: [
                          TableCell(
                            child: SizedBox(height: 30,),
                          ),
                          Column(children:[
                            Text('?????????')
                          ]),
                          Column(children:[
                            TextField(controller: adoption_year_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                          Column(children:[
                            TextField(controller: adoption_month_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                          Column(children:[
                            TextField(controller: adoption_day_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                        ],),
                      ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.25), 3: FractionColumnWidth(.3),4: FractionColumnWidth(.3)},                  children: [
                        TableRow( children: [
                          TableCell(
                            child: SizedBox(height: 30,),
                          ),
                          Column(children:[
                            Text('???????????????')
                          ]),
                          Column(children:[
                            TextField(controller: expect_year_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                          Column(children:[
                            TextField(controller: expect_month_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                          Column(children:[
                            TextField(controller: expect_day_Controller,
                              decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                          ]),
                        ],),
                      ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('?????????')
                            ]),
                            Column(children:[
                              TextField(controller: givebirth_month_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: givebirth_day_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175),4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('????????????', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller: totalbaby_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              Text('??????????????????', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller: feedbaby_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              Text('????????????(kg)', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller: weight_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.43), 3: FractionColumnWidth(.42)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('?????????', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller:  teen_month_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: teen_day_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0: FractionColumnWidth(.0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.35), 3: FractionColumnWidth(.15),4: FractionColumnWidth(.35)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('????????????', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller: totalteen_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              Text('????????????(kg)', textAlign: TextAlign.center)
                            ]),
                            Column(children:[
                              TextField(controller: teenweight_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0:FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175),4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('??????1')
                            ]),
                            Column(children:[
                              TextField(controller: vaccine1_fir_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: vaccine1_sec_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              Text('??????2')
                            ]),
                            Column(children:[
                              TextField(controller: vaccine2_fir_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: vaccine2_sec_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(
                        border: TableBorder.all(),
                        columnWidths: {0: FractionColumnWidth(.0), 1: FractionColumnWidth(.15), 2: FractionColumnWidth(.175), 3: FractionColumnWidth(.175), 4: FractionColumnWidth(.15), 5: FractionColumnWidth(.175), 6: FractionColumnWidth(.175)},
                        children: [
                          TableRow( children: [
                            TableCell(
                              child: SizedBox(height: 30,),
                            ),
                            Column(children:[
                              Text('??????3')
                            ]),
                            Column(children:[
                              TextField(controller: vaccine3_fir_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: vaccine3_sec_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              Text('??????4')
                            ]),
                            Column(children:[
                              TextField(controller: vaccine4_fir_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                            Column(children:[
                              TextField(controller: vaccine4_sec_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.number,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      child: Table(

                        border: TableBorder.all(),
                        columnWidths: {0: FractionColumnWidth(0),1: FractionColumnWidth(.15), 2: FractionColumnWidth(.85)},
                        children: [
                          TableRow(children: [
                            TableCell(
                              child: SizedBox(height: 100,),
                            ),
                            Column(children:[
                              Text('????????????')
                            ]),
                            Column(children:[
                              TextField(controller: memo_Controller,
                                decoration: const InputDecoration(hintText: " "),style: TextStyle(fontSize: 20),keyboardType: TextInputType.text,textAlign: TextAlign.center,),
                            ]),
                          ],),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0), // ?????? ??????
                    showImage(),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          FloatingActionButton(
                            heroTag: 'send_button',
                            tooltip: 'send changed ocr',
                            onPressed: () async{
                              sow_no = sowID1_Controller.text + "-" + sowID2_Controller.text;
                              sow_birth = birth_year_Controller.text +"-" + birth_month_Controller.text + "-" + birth_day_Controller.text;
                              sow_buy = adoption_year_Controller.text + "-" +  adoption_month_Controller.text + "-" + adoption_day_Controller.text;
                              sow_expectdate = expect_year_Controller.text + "-" + expect_month_Controller.text + "-" + expect_day_Controller.text;
                              sow_givebirth = givebirth_month_Controller.text + "-" + givebirth_day_Controller.text;
                              sow_totalbaby = totalbaby_Controller.text;
                              sow_feedbaby = feedbaby_Controller.text;
                              sow_babyweight = weight_Controller.text; //????????????
                              sow_sevrerdate = teen_month_Controller.text +"-"+ teen_day_Controller.text;//?????????
                              sow_sevrerqty   = totalteen_Controller.text;//????????????
                              sow_sevrerweight = teenweight_Controller.text;//????????????
                              vaccine1 = vaccine1_fir_Controller.text + "-" + vaccine1_sec_Controller.text;
                              vaccine2 = vaccine2_fir_Controller.text + "-" + vaccine2_sec_Controller.text;
                              vaccine3 = vaccine3_fir_Controller.text + "-" + vaccine3_sec_Controller.text;
                              vaccine4 = vaccine4_fir_Controller.text + "-" + vaccine4_sec_Controller.text;
                              // "ocr_imgpath":'17',
                              memo = memo_Controller.text;

                              await maternity_insert();
                              List<dynamic> list = await maternity_getocr();
                              Navigator.of(context).popUntil((route) => route.isFirst);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => MaternityListPage(list)));

                              },
                            child: Icon(Icons.arrow_circle_right_sharp),
                          ),
                        ])
                    ])
                )
              )
        );
  }
}
//????????? ????????????
maternity_insert() async{
  final api ='http://211.107.210.141:3000/api/ocrmaternityInsert';
  final data = {
    "sow_no": sow_no,
    "sow_birth": sow_birth,
    "sow_buy": sow_buy,
    "sow_expectdate": sow_expectdate,
    "sow_givebirth": sow_givebirth,
    "sow_totalbaby": sow_totalbaby,
    "sow_feedbaby": sow_feedbaby,
    "sow_babyweight": sow_babyweight,
    "sow_sevrerdate": sow_sevrerdate, //????????????
    "sow_sevrerqty": sow_sevrerqty, //?????????
    "sow_sevrerweight": sow_sevrerweight, //????????????
    "vaccine1": vaccine1,
    "vaccine2": vaccine2,
    "vaccine3": vaccine3,
    "vaccine4": vaccine4,
    "ocr_imgpath": filename,
    "memo": memo,
  };
  final dio = Dio();
  Response response;
  response = await dio.post(api,data: data);
  print(response);
  if(response.statusCode == 200){
    resultToast('Ocr ????????? insert success... \n\n');
  }
}