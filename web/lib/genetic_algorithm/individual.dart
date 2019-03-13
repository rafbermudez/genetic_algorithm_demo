import "gene.dart";

abstract class Individual{
  
  String id;
  List<Gene> chromosome;
  int generation = 0;
  int score = 0;
  
  void setScore(int idealScore);
  void mutate(); //chromosome mutation
  void randomize(); //Randomize chromosome

  //Renderize helpers
  void renderInDiv(String divId);
  void killRender();
}