import "../genetic_algorithm/gene.dart";

class NeckGene extends Gene{

  NeckGene({int neckHeight}){
    super.name = "neckHeight";
    super.value = 70;

    if (neckHeight != null){
      super.value = neckHeight;
    }
  }
}