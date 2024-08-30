import 'package:flutter/material.dart';
import 'package:org/classes/pessoa.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de IMC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Calculadora de IMC'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  
Widget fieldNome(){
  return Padding(
    padding: const EdgeInsets.only(top: 5,bottom: 5),
    child: TextFormField( //NOME
      controller: textDataNome,
      keyboardType: TextInputType.text,
      obscureText: false,
      decoration:  const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))), labelText: "Nome", icon: Icon(Icons.people_alt_outlined),
              ),     
            ),
  );
}

Widget fieldPeso(){
  return Padding(padding: const EdgeInsets.only(top: 5,bottom: 5), 
  child:  TextFormField(//PESO
    controller: textDataPeso,
    keyboardType: TextInputType.number,
    obscureText: false,
    decoration:  const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))), labelText: "Peso", icon: Icon(Icons.balance_outlined)
            ),     
          ) ,);
 
}

Widget fieldAltura(){
  return Padding(
    padding: const EdgeInsets.only(top: 5,bottom: 5),
    child: TextFormField(//altura
    controller: textDataAltura,
      keyboardType: TextInputType.number,
      obscureText: false,
      decoration:  const InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))), labelText: "Altura", icon: Icon(Icons.height_outlined)
              ),     
            ),
  );
}

  

  var textDataNome = TextEditingController();
  var textDataPeso = TextEditingController();
  var textDataAltura = TextEditingController();
 double resultado = 0.0;
  String nome = "";
  double peso = 0;
  double altura = 0;

  Pessoa pessoa = Pessoa();
  
  Widget tipoImc(double resultado){
    if(resultado<16){
      return const Text('Magreza Grave');
    } else if (resultado>= 16 && resultado<17){
      return const Text('Magreza Moderada');
    }else if (resultado>= 17 && resultado<18.5){
      return const Text('Magreza Leve');
    }else if (resultado>= 18.5 && resultado<25){
      return const Text('Saudável');
    }else if (resultado>= 25 && resultado<30){
      return const Text('Sobrepeso');
      }else if (resultado>= 30 && resultado<35){
      return const Text('Obesidade Grau 1');
      }else if (resultado>= 35 && resultado<40){
      return const Text('Obesidade Grau 2 severa');
      }else if (resultado>= 40){
      return const Text('Obesidade Grau 3 morbida');
      } else{
        return const Text('Sem valor válido');
      }
  }


 

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Form(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                fieldNome(),
                fieldPeso(),
                fieldAltura(),
        
              ],))
        
            ),
            ElevatedButton(onPressed: (){
        
        
              try{
                   if (textDataNome.text.isEmpty) {
                        throw Exception("O nome não pode ser vazio.");
                      }
        
                      pessoa.setNome(textDataNome.text);

              } catch (n){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("O nome não pode ser vazio", textAlign: TextAlign.center),
                      actions: [
                         Center(
                           child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Fecha o diálogo
                                       },
                                child: const Text("Ok", textAlign: TextAlign.center,),
                                     ),
                         ),
                      ],
                    );
                  });
              }
              try{
                
                  if (textDataPeso.text.isEmpty || double.tryParse(textDataPeso.text) == 0) {
                        pessoa.setPeso(0);
                        throw Exception("O peso deve ser diferente de zero");
                      }
                      pessoa.setPeso(double.parse(textDataPeso.text));
              } catch (n){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("O peso deve ser diferente de zero", textAlign: TextAlign.center),
                      actions: [
                         Center(
                           child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Fecha o diálogo
                                       },
                                child: const Text("Ok", textAlign: TextAlign.center,),
                                     ),
                         ),
                      ],
                    );
                  });
              }
              
              try{
                   if (textDataAltura.text.isEmpty || double.tryParse(textDataAltura.text) == 0) {
                        pessoa.setPeso(0);
                        throw Exception("A altura deve ser diferente de zero");
                      }
        
                      pessoa.setAltura(double.parse(textDataAltura.text));
              } catch (n){
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: const Text("A altura deve ser diferente de zero", textAlign: TextAlign.center),
                      actions: [
                         Center(
                           child: TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Fecha o diálogo
                                       },
                                child: const Text("Ok", textAlign: TextAlign.center,),
                                     ),
                         ),
                      ],
                    );
                  });
              }
              
        
              setState(() {
              resultado = (calcularImc(pessoa.getPeso(), pessoa.getAltura()));
             
              });
        
            


            }, child: const Text('Calcular'),),
           
              Text("O nome é: ${pessoa.getNome()}."),
              Text("O peso é ${pessoa.getPeso()} Kg"),
              Text("A altura é: ${pessoa.getAltura()} m"),
              Text("O cálculo do IMC é: $resultado"),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [const Text("Seu ICM é: "), tipoImc(resultado) ],)
            
            ],
        
          ),
        ),
      ),
     
      );
  }
}