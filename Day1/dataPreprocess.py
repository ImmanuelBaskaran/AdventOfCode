# Since COBOL requires the input file to be in a certain format, this script preprocesses the input
filename = "input"
transformedFilename = "inputCleaned.txt"

lists = []
workingList = []
longest_row = 0
currentRowLength = 0
with open(filename) as file:
    lines = [line.rstrip() for line in file]
    for line in lines:
        if not line == "":
            currentRowLength+=1
            workingList.append('{0: >5}'.format(line))
        else:
            lists.append(workingList)
            workingList = []
            longest_row = max(currentRowLength,longest_row)
            currentRowLength = 0
    for row in lists:
        row.extend(['    0'] * (longest_row - len(row)))
    for row in lists:
        print(' '.join(row))
with open(transformedFilename, 'w') as file:
    for row in lists:
        file.write(' '.join(row))
        file.write('\n')