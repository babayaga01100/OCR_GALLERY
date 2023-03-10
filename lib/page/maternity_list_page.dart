import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../functions/functions.dart';
import 'maternity_modify_page.dart';

class MaternityListPage extends StatefulWidget {

  final List<dynamic> listfromserver_list_mat;
  const MaternityListPage(this.listfromserver_list_mat);

  @override
  MaternityListPageState createState() => MaternityListPageState();
}

class MaternityListPageState extends State<MaternityListPage> {
  int num  = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    final List<int> ocr_seq = <int>[];
    final List<String> sow_no = <String>[];
    final List<String> upload_day = <String>[];

    if(widget.listfromserver_list_mat.isNotEmpty) {
      num = widget.listfromserver_list_mat[0][0];
      for (int i = 1; i < num + 1; i ++) {
        ocr_seq.add(widget.listfromserver_list_mat[i][0]);
        sow_no.add(widget.listfromserver_list_mat[i][1]);
        upload_day.add(widget.listfromserver_list_mat[i][2]);
      }
    }

    return Scaffold(
        appBar: AppBar(title: Text('분만사 기록보기')),
        body: Scrollbar(
            thumbVisibility: true, //always show scrollbar
            thickness: 10, //width of scrollbar
            radius: Radius.circular(20), //corner radius of scrollbar
            scrollbarOrientation: ScrollbarOrientation.right, //which side to show scrollbar
            child:Column(
              children: [
                Row(children: <Widget>[
                  SizedBox(width: 20,),
                  Container(
                      width: 70.0,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      alignment: Alignment.center,
                      child: Text("모돈번호", style: TextStyle(fontSize: 18),)
                  ),
                  SizedBox(width: 20,),
                  Container(
                      width: 160.0,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      alignment: Alignment.center,
                      child: Text("업로드 시간", style: TextStyle(fontSize: 18),)
                  ),
                  SizedBox(width: 20,),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                      width: 50.0,
                      child: Text("수정", style: TextStyle(fontSize: 18),)
                  ),
                  SizedBox(width: 10,),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text("삭제", style: TextStyle(fontSize: 18),)
                  ),
                ]),
                Expanded(
                    child: ListView.separated(
                    padding: const EdgeInsets.all(8),
                    itemCount: ocr_seq.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        // height: 50,
                        // color: Colors.amber[sow_no[index]],
                        // child: Center(child: Text('Entry ${ocr_seq[index]}')),
                        child: (
                            Stack(
                              children: [
                                for(int i = 0 ; i < ocr_seq.length ; i++)
                                  ListTile(
                                      title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children:[Text(sow_no[index]), Text(upload_day[index])]),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(onPressed: () async{
                                            List list = await maternity_selectrow(ocr_seq[index]);

                                            print("분만사 selectrow 결과");
                                            print(list);

                                            String returnfilepath = await downloadFile("ocrmatimages/"+list[19].toString().split("/").last);

                                            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                MaternityModifyPage(list, returnfilepath)));
                                            //   print("서버에게 받은 리스트 null 값임");

                                          }, icon: const Icon(Icons.edit)),
                                          IconButton(onPressed: ()async{
                                            await maternity_deleterow(ocr_seq[index]);
                                            List<dynamic> list = await maternity_getocr();
                                            print("maternity return get ocr->");
                                            Navigator.pop(context,MaterialPageRoute(builder: (context)=> MaternityListPage(list)));
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=> MaternityListPage(list)));
                                          },icon: const Icon(Icons.delete)),

                                        ],
                                      )


                                  ) ,
                                Container(
                                  height: 1,
                                  color: Colors.black,
                                )
                              ],
                            )
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => const Divider(),
                    )
                )
              ],
            )
        )
    );
  }
}