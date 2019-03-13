import "individual.dart";

abstract class GeneticAlgorithm<T extends Individual>{

  Set<T> population;
  T bestIndividual;

  GeneticAlgorithm();

  //Inital population
  void initRandomPopulation();

  //Fitness function
  void evaluatePopulation(int idealScore);

  // Selection and CrossOver/Merge
  T nextSeedIndividual();

  //Update the bestIndividual
  void setBestIndividual();

  // Next Population (mutations over _nextSeedIndividual)
  void nextPopulation();

  
}