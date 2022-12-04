import java.io.File
import java.io.InputStream
import java.nio.file.Paths


fun isOneRangeInsideOther(first:Pair<Int,Int>,second:Pair<Int,Int>): Boolean {
    // Completely outside
    if(first.first>second.second) return false;
    // Partly inside on left
    else if(first.first>second.first) return false;
    // Partly inside on right
    else if(first.second < second.second) return false;
    // Completely outside
    else if(first.second < second.first) return false;

    return true;
}

fun isOneRangeOverlapping(first:Pair<Int,Int>,second:Pair<Int,Int>): Boolean {
    // Completely outside
    if(first.first>second.second) return false;
    // Completely outside
    else if(first.second < second.first) return false;

    return true;
}

fun checkRanges(ranges:String): Int {
    val splitRanges = ranges.split(",");
    val firstRange = Pair(splitRanges[0].split("-")[0].toInt(),splitRanges[0].split("-")[1].toInt());
    val secondRange = Pair(splitRanges[1].split("-")[0].toInt(),splitRanges[1].split("-")[1].toInt());

    if(isOneRangeInsideOther(firstRange,secondRange)) return 1;

    if(isOneRangeInsideOther(secondRange,firstRange)) return 1;

    return 0;
}

fun checkRangesPart2(ranges:String): Int {
    val splitRanges = ranges.split(",");
    val firstRange = Pair(splitRanges[0].split("-")[0].toInt(),splitRanges[0].split("-")[1].toInt());
    val secondRange = Pair(splitRanges[1].split("-")[0].toInt(),splitRanges[1].split("-")[1].toInt());

    if(isOneRangeOverlapping(firstRange,secondRange)) return 1;

    if(isOneRangeOverlapping(secondRange,firstRange)) return 1;

    return 0;
}
fun main() {
    val input: InputStream = File("./input.txt").inputStream()
    val lineList = mutableListOf<String>()
    val lineList2 = mutableListOf<String>()

    input.bufferedReader().forEachLine { lineList.add(it); lineList2.add(it)}

    val total = lineList.fold(0) { sum, element -> sum + checkRanges(element)}
    val totalPart2 = lineList.fold(0) { sum, element -> sum + checkRangesPart2(element)}

    println(total)
    println(totalPart2)

}