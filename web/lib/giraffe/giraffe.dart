import "dart:html";
import "dart:math";
import "../genetic_algorithm/individual.dart";
import "neck_gene.dart";

class Giraffe extends Individual{

  int width = 40;
  int headHeight = 50;
  int bodyHeight = 100;

  Giraffe({NeckGene neckGene}){
    super.id = _randomString(8);
    super.chromosome = new List();
    if (neckGene != null){
      super.chromosome.add(new NeckGene(neckHeight: neckGene.value));
    }
    else{
      super.chromosome.add(new NeckGene());
    }
  }

  void setScore(int idealScore){
    score = (idealScore - this.headHeight - this.bodyHeight - this.chromosome[0].value).abs();
  }

  void mutate(){Random rnd = new Random();
    int randomInt = 0;
    new List<int>.generate(5, (i) => rnd.nextInt(10)).forEach( (n) => randomInt += n);
    new List<int>.generate(5, (i) => rnd.nextInt(10)).forEach( (n) => randomInt -= n);

    //Update the gene
    this.chromosome[0].value += randomInt;
  }

  void randomize(){
    int randomNeckHeight = new Random().nextInt(50);
    this.chromosome[0].value = randomNeckHeight;
  }

  void renderInDiv(String divId){

    //HTML
    String templateHtml = """
    <div id="${id}" class="giraffe">
        <div class="giraffe__head"></div>
        <div class="giraffe__neck"></div>
        <div class="giraffe__body"></div>
      </div>
    """;

    DivElement divFather = querySelector("#${divId}");
    divFather.appendHtml(templateHtml);

    int neckHeight = this.chromosome[0].value;
    int height = neckHeight + bodyHeight + headHeight;

    //STYLES
    DivElement giraffeDiv = querySelector("#${id}");
    String divFatherHeight = divFather.style.height;

    DivElement divGiraffeHead = giraffeDiv.querySelector(".giraffe__head");
    divGiraffeHead.style.marginTop = "${int.parse(divFatherHeight.substring(0, divFatherHeight.length - 2)) - height}px";
    divGiraffeHead.style.height = "${headHeight}px";
    divGiraffeHead.style.width = "${width}px";

    DivElement divGiraffeNeck = giraffeDiv.querySelector(".giraffe__neck");
    divGiraffeNeck.style.height = "${neckHeight}px";
    divGiraffeNeck.style.width = "${width/4}px";
    divGiraffeNeck.style.marginLeft = "${width*3/4}px";
    divGiraffeNeck.style.backgroundColor = "#E4E400";

    DivElement divGiraffeBody = giraffeDiv.querySelector(".giraffe__body");
    divGiraffeBody.style.height = "${bodyHeight}px";
    divGiraffeBody.style.width = "${width}px";
  }

  void killRender(){
    DivElement giraffeDiv = querySelector("#${id}");
    giraffeDiv.remove();
  }

  String _randomString(int length) {
   var rand = new Random();
   var codeUnits = new List.generate(
      length, 
      (index){
         return rand.nextInt(25)+98;
      }
   );
   
   return new String.fromCharCodes(codeUnits);
  }
}