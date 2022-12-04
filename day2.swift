import Foundation

let input = """
<#Your input#>
"""

enum Shape: Int {
    case rock = 1
    case paper
    case scissor

    init(_ character: Character) {
        switch character {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissor
        default:
            fatalError("Unknown")
        }
    }

    func winner() -> Shape {
        rawValue == 3 ? .rock : Shape(rawValue: rawValue + 1)!
    }

    func winner(against other: Shape) -> Score {
        if self == other {
            return .draw
        }

        if self == other.winner() {
            return .win
        }

        return .lose
    }
}

enum Score: Int {
    case win = 6
    case draw = 3
    case lose = 0

    init(_ character: Character) {
        switch character {
        case "X":
            self = .lose
        case "Y":
            self = .draw
        case "Z":
            self = .win
        default:
            fatalError("Unknown")
        }
    }

    func shape(forMatching shape: Shape) -> Shape {
        switch self {
        case .win:
            return shape.winner()
        case .draw:
            return shape
        case .lose:
            return shape.winner().winner()
        }
    }
}

let lines = input.components(separatedBy: "\n")

let level1 = lines
    .map {
        let opponent = Shape($0.first!)
        let you = Shape($0.last!)
        return you.rawValue + you.winner(against: opponent).rawValue
    }
    .reduce(0, +)

print(level1)

let level2 = lines
    .map {
        let opponent = Shape($0.first!)
        let you = Score($0.last!)
        return you.rawValue + you.shape(forMatching: opponent).rawValue
    }
    .reduce(0, +)

print(level2)
