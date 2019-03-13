import "dart:html";

class Tree {
  
  String id;
  int width = 100;
  int height = 200;
  int topHeight = 30;
  int growSize = 30;

  Tree(String id){
    this.id = id;
  }

  void render(DivElement divFather){

    //HTML
    String templateHtml = """
    <div id="${id}" class="tree">
        <div class="tree__top"></div>
        <div class="tree__trunk"></div>
      </div>
    """;

    divFather.appendHtml(templateHtml);

    //STYLES
    DivElement treeDiv = querySelector('#${id}');
    treeDiv.style.height = "${height}px";
    int divFatherHeight = int.parse(divFather.style.height.substring(0, divFather.style.height.length - 2));
    treeDiv.style.marginTop = "${divFatherHeight - height}px";

    DivElement divTreeTop = treeDiv.querySelector(".tree__top");
    divTreeTop.style.height = "${topHeight}px";
    divTreeTop.style.width = "${width}px";
    divTreeTop.style.backgroundColor = "green";

    DivElement divTreeTrunk = treeDiv.querySelector(".tree__trunk");
    divTreeTrunk.style.height = "${height-topHeight}px";
    divTreeTrunk.style.width = "${width/4}px";
    divTreeTrunk.style.marginLeft = "${width/4}px";
    divTreeTrunk.style.backgroundColor = "brown";
  }

  void growUp(){
    DivElement treeDiv = querySelector('#${id}');;
    int treeDivMarginTop = int.parse(treeDiv.style.marginTop.substring(0, treeDiv.style.marginTop.length - 2));
    treeDiv.style.marginTop = "${treeDivMarginTop - growSize}px";

    DivElement divTreeTrunk = treeDiv.querySelector(".tree__trunk");
    int treeDivTrunkHeight = int.parse(divTreeTrunk.style.height.substring(0, divTreeTrunk.style.height.length - 2));
    divTreeTrunk.style.height = "${treeDivTrunkHeight + growSize}px";

    this.height += growSize;
  }

  void growDown(){
    DivElement treeDiv = querySelector('#${id}');;
    int treeDivMarginTop = int.parse(treeDiv.style.marginTop.substring(0, treeDiv.style.marginTop.length - 2));
    treeDiv.style.marginTop = "${treeDivMarginTop + growSize}px";

    DivElement divTreeTrunk = treeDiv.querySelector(".tree__trunk");
    int treeDivTrunkHeight = int.parse(divTreeTrunk.style.height.substring(0, divTreeTrunk.style.height.length - 2));
    divTreeTrunk.style.height = "${treeDivTrunkHeight - growSize}px";

    this.height -= growSize;
  }
}