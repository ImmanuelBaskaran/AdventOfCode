filename = "input.txt"
prioritySum = 0
with open(filename) as file:
    while True:
        line = file.readline()
        if not line: break
        line2 = file.readline()
        if not line2: break
        line3 = file.readline()
        if not line3: break
        rucksack = set(list(line.rstrip()))
        rucksack2 = set(list(line2.rstrip()))
        rucksack3 = set(list(line3.rstrip()))
        common = list(rucksack.intersection(rucksack2,rucksack3))
        # since there is only one common item in all three rucksacks
        if common[0].isupper():
            prioritySum+=ord(common[0]) - 64 + 26
            print(ord(common[0]) - 64 + 26)
        else:
            prioritySum += ord(common[0]) - 96
            print(ord(common[0]) - 96)

print(prioritySum)