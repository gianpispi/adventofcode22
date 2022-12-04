import Foundation

let input = """
<#Your input#>
"""

let elvesArray = input.components(separatedBy: "\n\n")
let sums = elvesArray
    .map {
        $0.components(separatedBy: "\n")
            .map { Int($0)! }
            .reduce(0, +)
    }

print("Part 1: ", sums.max()!)

// part 2
let partTwo = sums
    .sorted(by: >)
    .prefix(3)
    .reduce(0, +)
print("Part 2:", partTwo)
