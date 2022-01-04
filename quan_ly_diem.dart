import 'package:flutter/material.dart';

class QuanLyDiem extends StatelessWidget {
  const QuanLyDiem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"QLDiem",
      home: DanhSachHS(),
    );
  }
}

class DanhSachHS extends StatefulWidget {
  const DanhSachHS({Key? key}) : super(key: key);

  @override
  _DanhSachHSState createState() => _DanhSachHSState();
}

List data = ['Nguyễn Văn A','Lê Thị B','Trần Đình C','Nguyễn D', 'Võ Thị E'];
int ind = 0;
List<double> tb2 = [0,0,0,0,0];
List<double> nv2 = [0,0,0,0,0];
List<double> t2 = [0,0,0,0,0];
List<double> av2 = [0,0,0,0,0];

class _DanhSachHSState extends State<DanhSachHS> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Quản lý điểm học sinh"),
          leading: Icon(Icons.school),
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index){
              String name = data.elementAt(index);
              return ListTile(
                title: TextButton(
                  onPressed:(){
                    setState(() {
                      ind = index;
                    });
                    if(tb2[index] == 0){
                      Route route = MaterialPageRoute(builder: (context) => NhapDiem());
                      Navigator.push(context, route);
                    }
                    else{
                      Route route = MaterialPageRoute(builder: (context) => HienThiDiem());
                      Navigator.push(context, route);
                    }
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(20.0),
                  ),
                  child: Text(name.toString()),
                ),
                leading: Icon(Icons.person),
                trailing: Text(tb2[index].toStringAsFixed(1)),
              );
            })
    );
  }
}

class NhapDiem extends StatefulWidget {
  const NhapDiem({Key? key}) : super(key: key);

  @override
  _NhapDiemState createState() => _NhapDiemState();
}

class _NhapDiemState extends State<NhapDiem> {
  var fKey= GlobalKey<FormState>();
  var nv = TextEditingController();
  var t = TextEditingController();
  var av = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhập điểm"),
        leading: IconButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => QuanLyDiem());
            Navigator.push(context, route);
          },
          icon: Icon(Icons.arrow_back,),
        ),
      ),
      body: Form(
        key: fKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[
              SizedBox(height: 30,),
              Center(
                child: Text("Nhập điểm học sinh " + data[ind],
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20,),
                  Text('Điểm Ngữ Văn:  '),
                  Expanded(
                    child: TextFormField(
                      controller: nv,
                      keyboardType: TextInputType.number,
                      validator: (value){
                        if (value == null || value.isEmpty || int.parse(value) < 0 || int.parse(value) > 10) {
                              return "Không hợp lệ. Vui lòng nhập lại điểm!";
                        }
                        else {
                          nv2[ind]=double.parse(nv.text);
                          return null;
                        }
                      },
                      decoration: InputDecoration(

                        border: UnderlineInputBorder(),
                        hintText: "Điểm ngữ văn",
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20,),
                  Text('Điểm Toán:  '),
                  SizedBox(width: 23,),
                  Expanded(child: TextFormField(
                    controller: t,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if (value == null || value.isEmpty || int.parse(value) < 0 || int.parse(value) > 10) {
                           return "Không hợp lệ. Vui lòng nhập lại điểm!";
                      }
                      else {
                        t2[ind]=double.parse(t.text);
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Điểm toán",
                    ),
                  ),
                  ),
                  SizedBox(width: 20,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20,),
                  Text('Điểm Anh Văn:  '),
                  Expanded(child: TextFormField(
                    controller: av,
                    keyboardType: TextInputType.number,
                    validator: (value){
                      if (value == null || value.isEmpty || int.parse(value) < 0 || int.parse(value) > 10) {
                        return "Không hợp lệ. Vui lòng nhập lại điểm!";
                      }
                      else {
                        av2[ind]=double.parse(av.text);
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Điểm anh văn",
                    ),
                  ),
                  ),
                  SizedBox(width: 20,),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Cập nhật thành công!"),
                    );
                  },
                );
                if (fKey.currentState!.validate()){
                  Route route = MaterialPageRoute(builder: (context) => QuanLyDiem());
                  Navigator.push(context, route);
                  setState(() {
                    tb2[ind] = trung_binh(double.parse(nv.text),double.parse(t.text),double.parse(av.text));
                  });
                }
              },
              child: Text("Cập nhật"),
            ),
            TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.red,
                ),
                onPressed: (){
                  Route route = MaterialPageRoute(builder: (context) => QuanLyDiem());
                  Navigator.push(context, route);
                },
                child: Text("Hủy"))
          ],
        )
      ),
    );
  }

  static double trung_binh(double van, double t, double av){
    double ave=0;
    ave = (van + t + av)/3;
    return ave;
  }
}

class HienThiDiem extends StatelessWidget {
  const HienThiDiem({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => QuanLyDiem());
            Navigator.push(context, route);
          },
          icon: Icon(Icons.arrow_back,),
        ),
        title: Text("Thông tin điểm số"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Họ và tên: ",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 65,),
                Text(data[ind],
                  style: TextStyle(
                  fontSize: 20,
                ),),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Điểm ngữ văn:",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 32,),
                Text(nv2[ind].toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Điểm toán:",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 64,),
                Text(t2[ind].toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Điểm anh văn:",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 33,),
                Text(av2[ind].toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                SizedBox(width: 20,),
                Text("Điểm trung bình:",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 12,),
                Text(tb2[ind].toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 20,
                  ),
                )
              ],
            )
          ],

        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: TextButton(
          onPressed: () {
            Route route = MaterialPageRoute(builder: (context) => NhapDiem());
            Navigator.push(context, route);
          },
          child: Text("Sửa điểm"),
        ),
      ),
    );

  }
}

