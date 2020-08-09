import UIKit

struct Heap<Element> {
    private var elements: [Element]
    private let priorityFunction: (Element, Element) -> Bool

    public var isEmpty: Bool { self.elements.isEmpty }
    public var count: Int { self.elements.count }

    public var first: Element? { self.elements.first }
    public var isRoot: (Int) -> Bool = { $0 == 0 }
    public var leftChildIdx: (Int) -> Int = { $0 * 2 + 1 }
    public var rightChildIdx: (Int) -> Int = { $0 * 2 + 2 }
    public var parentIdx: (Int) -> Int = { ($0-1)/2 }

    public func peek() -> Element? { self.elements.first }

    init(_ elements: [Element] = [], _ priorityFunction: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.priorityFunction = priorityFunction
        self.buildHeap()
    }

    mutating func buildHeap() {
        for i in (0..<count/2).reversed() {
            siftDown(i)
        }
    }

    // returns true if second param is higher than the first param
    public func isHigherPriority(_ at: Int, _ than: Int) -> Bool {
        self.priorityFunction(elements[at],elements[than])
    }

    func highestPriorityIndex(_ parentIdx: Int, _ childIdx: Int) -> Int {
        guard childIdx < count && isHigherPriority(childIdx, parentIdx) else { return parentIdx }
        return childIdx
    }

    func highestPriorityIndex(_ parent: Int) -> Int {
        return highestPriorityIndex(highestPriorityIndex(parent, leftChildIdx(parent)), rightChildIdx(parent))
    }

    mutating func swapElement(_ firstIdx: Int, _ secondIdx: Int) {
        guard firstIdx != secondIdx else { return }
        elements.swapAt(firstIdx, secondIdx)
    }

    mutating func enqueue(_ element: Element) {
        self.elements.append(element)
        siftUp(count-1)
    }

    mutating func siftUp(_ i: Int) {
        let parent = parentIdx(i)
        guard !isRoot(i), isHigherPriority(i, parent) else { return }
        elements.swapAt(i, parent)
        siftUp(parent)
    }

    mutating func siftDown(_ i: Int) {
        let child = highestPriorityIndex(i)
        if i == child { return }
        swapElement(i, child)
        siftUp(child)
    }

    mutating func dequeue() -> Element? {
        guard !isEmpty else { return nil }
        self.elements.swapAt(0, count-1)
        let last = self.elements.removeLast()
        if !isEmpty { siftDown(0) }
        return last
    }
}

var heap = Heap([3, 2, 8, 5, 0], <)

heap.dequeue()
heap.dequeue()
heap.dequeue()
heap.dequeue()
heap.dequeue()
heap.count
