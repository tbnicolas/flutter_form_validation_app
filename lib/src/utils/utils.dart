
bool isNumeric(String str){
  if(str.isEmpty) return false;
  final n = num.tryParse(str);
  return (n == null)? false: true;
}