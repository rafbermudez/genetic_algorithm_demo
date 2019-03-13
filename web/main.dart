import 'dart:html';
import 'dart:async';
import 'lib/giraffe/giraffe_genetic_algorithm.dart';
import 'lib/giraffe/giraffe.dart';
import 'lib/tree/tree.dart';

Tree tree;
GiraffeGeneticAlgorithm geneticAlgorithm;
Giraffe bestSpecimen;

void main() {
  initTree();
  initControls();
}

void initTree() {
  tree = new Tree("tree1");
  tree.render(querySelector('#tree-container'));

  querySelector('#crece').onClick.listen(treeGrowUp);
  querySelector('#decrece').onClick.listen(treeGrowDown);
}

//CONTROLS
void initControls() {
  querySelector('#crece').onClick.listen(treeGrowUp);
  querySelector('#decrece').onClick.listen(treeGrowDown);
  querySelector('#play').onClick.listen(play);
}

void treeGrowUp(MouseEvent e) {
  tree.growUp();
  bestSpecimen.setScore(tree.height);
}

void treeGrowDown(MouseEvent e) {
  tree.growDown();
  bestSpecimen.setScore(tree.height);
}

void play(MouseEvent e) {
  querySelector("#play").hidden = true;
  initAlgorithm();
}

void updateIteration() {
  InputElement inputIteration =
      querySelector(".controls__info").querySelector("input");
  inputIteration.value = (int.parse(inputIteration.value) + 1).toString();
}

//GENETIC ALGORITHM
void initAlgorithm() {
  geneticAlgorithm = new GiraffeGeneticAlgorithm(8);

  //INIT RANDOM POPULATION
  geneticAlgorithm.initRandomPopulation();
  geneticAlgorithm.population.forEach((g) {
    g.renderInDiv("population-container");
  });

  evaluate();
}

void evaluate() {
  updateIteration();

  //POPULATION EVALUATION
  geneticAlgorithm.evaluatePopulation(tree.height);

  //SET BEST INDIVIDUAL
  geneticAlgorithm.setBestIndividual();
  if (bestSpecimen == null) {
    bestSpecimen = geneticAlgorithm.bestIndividual;
    bestSpecimen.renderInDiv("best-specimen-container");
  } else if (geneticAlgorithm.bestIndividual.id != bestSpecimen.id) {
    bestSpecimen.killRender();
    bestSpecimen = geneticAlgorithm.bestIndividual;
    bestSpecimen.renderInDiv("best-specimen-container");
  }

  new Future.delayed(const Duration(seconds: 1), () => iterate());
}

void iterate() {
  geneticAlgorithm.population.forEach((g) => g.killRender());
  geneticAlgorithm.nextPopulation();
  geneticAlgorithm.population.forEach((g) {
    g.renderInDiv("population-container");
  });

  evaluate();
}
