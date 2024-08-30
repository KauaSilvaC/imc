class Pessoa {
  String _nome = "";
  double _peso = 0;
  double _altura = 0;

   setNome(String nome){
    _nome = nome;
  }
    String getNome(){
    return _nome;
  }

   setPeso(double peso){
    _peso = peso;
  }
    double getPeso(){
    return _peso;
  }

   setAltura(double altura){
    _altura = altura;
  }
    double getAltura(){
    return _altura;
  }

            

}



double calcularImc (double peso, double altura ) {
 double imc = 0;
 if ((peso!=0) && (altura!=0) ){
    imc = peso/(altura*altura);
 } else{

 }
 return imc;
}