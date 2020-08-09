import UIKit

class Node {
    var val: Int
    var next = [Node]()

    init() {
        self.val = 0
    }

    init(_ val: Int, next: [Node] = []) {
        self.val = val
        self.next = next
    }
}

//public final class Djikstra {
//    private var adjMatrix = [[Int]]()
//
//    public func shortestPath(_ N: Int, _ adj: [[Int]], _ from: Int) {
//        self.adjMatrix = Array(repeating: Array(repeating: Int.max, count: N), count: N)
//
//        for path in adj {
//            self.adjMatrix[path[0]][path[1]] = path[2]
//        }
//
//        var queue = [Node]()
//
//    }
//}

public final class Djikstra {
    private var adjMatrix = [[Int]]()

    public func shortestPath(_ N: Int, _ adj: [[Int]], _ from: Int) -> [Int] {
        self.adjMatrix = Array(repeating: Array(repeating: Int.max, count: N), count: N)

        for path in adj {
            self.adjMatrix[path[0]][path[1]] = path[2]
        }

        var queue = [from]
        var isVisited = Set<Int>()
        var minPath = Array(repeating: Int.max, count: N)
        minPath[from] = 0
        var prev = 0

        while !queue.isEmpty {
            let node = queue.remove(at: prev)
            isVisited.insert(node)

            for j in 0..<adj[node].count {
                if minPath[j] < adj[node][j] + minPath[node] {
                    minPath[j] = adj[node][j] + minPath[node]
                }

                if !isVisited.contains(j) { queue.append(j) }
            }

            var minimum = Int.max
            for node in queue {
                if minPath[node] < minimum {
                    minimum = minPath[node]
                    prev = node
                }
            }

            
        }

        return minPath
    }
}
