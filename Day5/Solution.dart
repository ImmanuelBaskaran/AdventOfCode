import 'dart:collection';
import 'dart:io';



void main(){

  // Parsing
  var contents = File('input.txt').readAsLinesSync();
  part1(contents);
  part2(contents);
}

void part1(List<String> contents) {
  var towerList = <String>[];
  var currentLine;
  var currentIndex = 0;
  do {
    currentLine = contents[currentIndex];
    towerList.add(currentLine);
    currentIndex++;
  }while(currentLine.length>0);

  // Dart doesn't have a stack natively
  var towers = <Queue>[];

  for(var i = towerList[towerList.length-2].split("   ").length; i>=0;i--){
    towers.add(Queue<String>());
  }

  for(var i = currentIndex-3; i>=0;i--){
    for(var j = 0; j < towers.length;j++){
      if(j*4+1>towerList[i].length) break;
      if(towerList[i][j * 4 + 1] == " ") continue;
      towers[j].addFirst(towerList[i][j * 4 + 1]);
    }
  }



  for(var i = currentIndex; i<contents.length;i++){
    var instruction = contents[i].split(" ");
      if(instruction[0]=="move") {
        for(var j = 0; j < int.parse(instruction[1]);j++){
          towers[int.parse(instruction[5])-1].addFirst(towers[int.parse(instruction[3])-1].removeFirst());
        }
      }
    }

  for(var j = 0; j < towers.length-1;j++){
    stdout.write(towers[j].first);
  }
  stdout.write("\n");
}

void part2(List<String> contents) {
  var towerList = <String>[];
  var currentLine;
  var currentIndex = 0;
  do {
    currentLine = contents[currentIndex];
    towerList.add(currentLine);
    currentIndex++;
  }while(currentLine.length>0);

  // Dart doesn't have a stack natively
  var towers = <Queue>[];

  for(var i = towerList[towerList.length-2].split("   ").length; i>=0;i--){
    towers.add(Queue<String>());
  }

  for(var i = currentIndex-3; i>=0;i--){
    for(var j = 0; j < towers.length;j++){
      if(j*4+1>towerList[i].length) break;
      if(towerList[i][j * 4 + 1] == " ") continue;
      towers[j].addFirst(towerList[i][j * 4 + 1]);
    }
  }


  var arms = Queue<String>();
  for(var i = currentIndex; i<contents.length;i++){
    var instruction = contents[i].split(" ");
    if(instruction[0]=="move") {
        for(var j = 0; j < int.parse(instruction[1]);j++){
          arms.add(towers[int.parse(instruction[3])-1].removeFirst());
        }
        for(var j = 0; j < int.parse(instruction[1]);j++) {
          towers[int.parse(instruction[5]) - 1].addFirst(arms.removeLast());
        }
    }
  }

  for(var j = 0; j < towers.length-1;j++){
    stdout.write(towers[j].first);
  }
  stdout.write("\n");
}