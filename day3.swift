import Foundation

let input = """
<#Your input#>
"""

extension Character {
    var priority: Int {
        Int(asciiValue! - (isUppercase ? 38 : 96))
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

let lines = input.components(separatedBy: "\n")

let level1 = lines
    .map(processLineLevel1)
    .reduce(0, +)

print(level1)

func processLineLevel1(_ string: String) -> Int {
    let halfLength = string.count / 2
    let firstHalf = string.prefix(halfLength)
    let secondHalf = string.suffix(halfLength)
    return Set(firstHalf).intersection(Set(secondHalf)).first!.priority
}

let level2 = lines
    .chunked(into: 3)
    .map(processLinesLevel2)
    .reduce(0, +)
print(level2)

func processLinesLevel2(_ group: [String]) -> Int {
    return group
        .dropFirst()
        .reduce(into: Set(group.first!)) { partialResult, line in
            partialResult.formIntersection(line)
        }
        .map(\.priority)
        .first!
}
