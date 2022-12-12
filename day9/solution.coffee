class RopeLink
  @x : 0;
  @y : 0;
  constructor: (@childLink)->
    @x = 0;
    @y = 0;

  update: (x1,y1) ->
    @x += x1;
    @y += y1;
    if @childLink != null
        if Math.abs(@x-@childLink.x) > 1 || Math.abs(@y-@childLink.y) > 1
          @childLink.update(Math.sign(@x-@childLink.x),Math.sign(@y-@childLink.y))

  getPosition: ->
    {@x,@y}

part1 = (instructions) ->
  ropeTail = new RopeLink(null)
  ropeHead = new RopeLink(ropeTail);
  positionsVisited = new Set();
  for instruction in instructions
    for i in [1..parseInt(instruction.split(" ")[1])]
      switch instruction.split(" ")[0]
        when "U" then ropeHead.update(0,1);
        when "D" then ropeHead.update(0,-1);
        when "L" then ropeHead.update(-1,0);
        when "R" then ropeHead.update(1,0);
      positionsVisited.add JSON.stringify ropeTail.getPosition()
  console.log(positionsVisited.size);


part2 = (instructions) ->
  ropeLinks = []

  for i in [1..10]
    ropeLinks.push(new RopeLink(null))

  for i in [0..8]
    ropeLinks[i].childLink = ropeLinks[i+1]

  ropeHead = ropeLinks[0];
  ropeTail = ropeLinks[9];

  positionsVisited = new Set();
  for instruction in instructions
    for i in [1..parseInt(instruction.split(" ")[1])]
      switch instruction.split(" ")[0]
        when "U" then ropeHead.update(0,1);
        when "D" then ropeHead.update(0,-1);
        when "L" then ropeHead.update(-1,0);
        when "R" then ropeHead.update(1,0);
      positionsVisited.add JSON.stringify ropeTail.getPosition()

  console.log(positionsVisited.size);

{readFileSync} = require('fs');

file = readFileSync("./input.txt")

part1(file.toString().split("\n"))
part2(file.toString().split("\n"))

