filename = "input.txt"
prioritySum = 0
with open(filename) as file:
    for line in file:
        rucksack = list(line.rstrip())
        compartment1Unique = set(rucksack[:len(rucksack)//2])
        compartment2Unique = set(rucksack[len(rucksack) // 2:])
        common = list(compartment1Unique.intersection(compartment2Unique))
        # since there is only one common item in both compartments
        if common[0].isupper():
            prioritySum+=ord(common[0]) - 64 + 26
            print(ord(common[0]) - 64 + 26)
        else:
            prioritySum += ord(common[0]) - 96
            print(ord(common[0]) - 96)

print(prioritySum)