package main

import (
	"fmt"
	"os"
	"sort"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

type Monkey struct {
	items     []int
	operation func(int) int
	test      func(int) int
	testValue int
}

func parseTest(testLine string, trueLine string, falseLine string) func(int) int {
	test, _ := strconv.Atoi(strings.TrimSpace(testLine))
	trueValue, _ := strconv.Atoi(strings.TrimSpace(trueLine))
	falseValue, _ := strconv.Atoi(strings.TrimSpace(falseLine))
	testfunc := func(x int) int {
		if x%test == 0 {
			return trueValue
		} else {
			return falseValue
		}
	}
	return testfunc
}

func parseOperation(operationLine string) func(int) int {
	splitLine := strings.Fields(operationLine)
	if splitLine[3] == "*" {
		if splitLine[4] == "old" {
			sqr := func(x int) int { return x * x }
			return sqr
		} else {
			operand, _ := strconv.Atoi(strings.TrimSpace(splitLine[4]))
			mult := func(x int) int { return x * operand }
			return mult
		}
	} else {
		operand, _ := strconv.Atoi(strings.TrimSpace(splitLine[4]))
		add := func(x int) int { return x + operand }
		return add
	}
}

func parseStartingItems(itemsLine string) []int {
	var startingItems []int
	for _, i := range strings.Split(itemsLine, ",") {
		j, err := strconv.Atoi(strings.TrimSpace(i))
		if err != nil {
			panic(err)
		}
		startingItems = append(startingItems, j)
	}
	return startingItems
}

func parseMonkeyString(string2 string) Monkey {
	lines := strings.Split(string2, "\n")
	startingItems := parseStartingItems(strings.Split(lines[1], "  Starting items:")[1])
	operation := parseOperation(strings.Split(lines[2], "  Operation: ")[1])
	test := parseTest(strings.Split(lines[3], "  Test: divisible by ")[1],
		strings.Split(lines[4], "    If true: throw to monkey ")[1],
		strings.Split(lines[5], "    If false: throw to monkey ")[1])

	testValue, _ := strconv.Atoi(strings.TrimSpace(strings.Split(lines[3], "  Test: divisible by ")[1]))
	return Monkey{
		startingItems,
		operation,
		test,
		testValue,
	}
}

func main() {
	dat, err := os.ReadFile("./input.txt")
	check(err)
	var monkeys []Monkey
	var sb strings.Builder
	for i, s := range strings.Split(string(dat), "\n") {
		if (i+1)%7 != 0 {
			sb.WriteString(s + "\n")
		} else {
			monkeys = append(monkeys, parseMonkeyString(sb.String()))
			sb.Reset()
		}
	}
	part1(monkeys)

	var monkeys2 []Monkey
	var sb2 strings.Builder
	for i, s := range strings.Split(string(dat), "\n") {
		if (i+1)%7 != 0 {
			sb2.WriteString(s + "\n")
		} else {
			monkeys2 = append(monkeys2, parseMonkeyString(sb2.String()))
			sb2.Reset()
		}
	}
	part2(monkeys2)
}

func part1(monkeys []Monkey) {
	var monkeyBusiness []int

	for j := 0; j < len(monkeys); j++ {
		monkeyBusiness = append(monkeyBusiness, 0)
	}
	for i := 0; i < 20; i++ {
		for j := 0; j < len(monkeys); j++ {
			for _, element := range monkeys[j].items {
				worry := element
				worry = monkeys[j].operation(worry)
				worry = worry / 3
				monkeys[monkeys[j].test(worry)].items = append(monkeys[monkeys[j].test(worry)].items, worry)
				monkeyBusiness[j] = monkeyBusiness[j] + 1
			}
			monkeys[j].items = nil
		}
	}
	sort.Sort(sort.IntSlice(monkeyBusiness))
	fmt.Println(monkeyBusiness[len(monkeys)-1] * monkeyBusiness[len(monkeys)-2])
}

func part2(monkeys []Monkey) {
	var monkeyBusiness []int

	for j := 0; j < len(monkeys); j++ {
		monkeyBusiness = append(monkeyBusiness, 0)
	}
	productOfAllTestValues := 1
	for j := 0; j < len(monkeys); j++ {
		productOfAllTestValues = productOfAllTestValues * monkeys[j].testValue
	}

	for i := 0; i < 10000; i++ {
		for j := 0; j < len(monkeys); j++ {
			for _, element := range monkeys[j].items {
				worry := element
				worry = monkeys[j].operation(worry)
				worry = worry % productOfAllTestValues
				monkeys[monkeys[j].test(worry)].items = append(monkeys[monkeys[j].test(worry)].items, worry)
				monkeyBusiness[j] = monkeyBusiness[j] + 1
			}
			monkeys[j].items = nil
		}
	}
	sort.Sort(sort.IntSlice(monkeyBusiness))
	fmt.Println(monkeyBusiness[len(monkeys)-1] * monkeyBusiness[len(monkeys)-2])
}
