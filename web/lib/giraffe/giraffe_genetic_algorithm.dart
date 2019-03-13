import "../genetic_algorithm/genetic_algorithm.dart";
import "giraffe.dart";
import "neck_gene.dart";

class GiraffeGeneticAlgorithm extends GeneticAlgorithm<Giraffe> {
  int populationSize;

  GiraffeGeneticAlgorithm(int populationSize) {
    this.populationSize = populationSize;
  }

  //Inital population
  void initRandomPopulation(){
    population = new Set();
    for (int i=0; i < populationSize; i++){
      Giraffe g = new Giraffe();
      g.randomize();
      population.add(g);
    }
  }

  //Fitness function
  void evaluatePopulation(int idealScore){
    population.forEach((p) => p.setScore(idealScore));
  }

  // Selection and CrossOver/Merge result
  Giraffe nextSeedIndividual(){
    List<Giraffe> giraffesByScore = population.toList();
    giraffesByScore.sort((a,b) => a.score.compareTo(b.score));

    return _mergeGiraffes(giraffesByScore[0], giraffesByScore[1]);
  }

  //Update the bestIndividual
  void setBestIndividual(){
    List<Giraffe> giraffesByScore = population.toList();
    giraffesByScore.sort((a,b) => a.score.compareTo(b.score));

    Giraffe bestPopulationGiraffe = giraffesByScore[0];
    if (bestIndividual == null || bestPopulationGiraffe.score < bestIndividual.score){
      bestIndividual = new Giraffe(neckGene: bestPopulationGiraffe.chromosome[0]);
      bestIndividual.id = "best_${bestIndividual.id}";
      bestIndividual.score =bestPopulationGiraffe.score;
    }
  }

  // Next Population (mutations over _nextSeedIndividual)
  void nextPopulation(){
     Giraffe nextSeedGiraffe =  this.nextSeedIndividual();

    population.clear();
    for (int i = 0; i < populationSize; i++){
      Giraffe g = new Giraffe(neckGene: nextSeedGiraffe.chromosome[0]);
      g.mutate();
      population.add(g);
    }
  }

  //Merge 2 giraffes
  Giraffe _mergeGiraffes(Giraffe giraffe1, Giraffe giraffe2){
    int mediumNeckHeight = ((giraffe1.chromosome[0].value+giraffe2.chromosome[0].value)/2).round();
    Giraffe g = new Giraffe(neckGene: new NeckGene(neckHeight: mediumNeckHeight));
    
    return g;
  }
}
