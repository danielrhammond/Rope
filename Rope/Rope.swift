//
//  Rope.swift
//  Rope
//
//  Created by Daniel Hammond on 1/2/15.
//  Copyright (c) 2015 Daniel Hammond. All rights reserved.
//

import Foundation

let NODE_STRING_LENGTH = 2

public class Rope {
    var value:String?
    var weight:Int
    var left:Rope?
    var right:Rope?
    
    public init(value:String, weight:Int) {
        self.value = value
        self.weight = weight
    }
    
    public init(value:String) {
        self.value = value
        self.weight = countElements(value)
    }
    
    public init(asLeaf left:Rope, right:Rope?) {
        self.left = left
        self.right = right
        var weight = left.weight
        // TODO: seems like there should be an nicer way to do this, maybe can we produce a sequence of lefts to make just a reduce() (?)
        var l = left
        while (l.left? != nil) {
            l = l.left!
            weight += l.weight
        }
        self.weight = weight
    }
    
    public convenience init(fromString string:String) {
        var lastRow:[Rope] = []
        var gen = string.generate()
        var value = ""
        while let char = gen.next() {
            value.append(char)
            if countElements(value) == NODE_STRING_LENGTH {
                lastRow.append(Rope(value: value))
                value = ""
            }
        }
        lastRow.append(Rope(value: value))
        while countElements(lastRow) > 1 {
            var newRow:[Rope] = []
            while countElements(lastRow) > 0 {
                var left = lastRow.removeAtIndex(0)
                var right:Rope?
                if lastRow.first != nil {
                    right = lastRow.removeAtIndex(0)
                }
                newRow.append(Rope(asLeaf: left, right: right))
            }
            lastRow = newRow
        }
        self.init(asLeaf: lastRow.first!, right: nil)
    }
 
    public func toString() -> String {
        if let val = value {
            return val
        } else {
            if let right = self.right {
                return self.left!.toString() + right.toString()
            } else {
                return self.left!.toString()
            }
        }
    }
    
    public func insertCharacter(character:Character, atIndex:Int) {
        // Needs implementation
    }
    
    public func getCharacter(atIndex:Int) -> Character {
        if self.weight <= atIndex {
            return self.right!.getCharacter(atIndex - self.weight)
        } else {
            if let left = self.left {
                return left.getCharacter(atIndex)
            } else {
                let arr = Array(self.value!)
                let charStr = arr[atIndex]
                return charStr
            }
        }
    }

    public subscript(index: Int) -> Character {
        get {
            return self.getCharacter(index)
        }
        set(newValue) {
            return insertCharacter(newValue, atIndex: index)
        }
    }
}

public func +(lhs:Rope, rhs:Rope) -> Rope {
    return Rope(asLeaf: lhs, right: rhs)
}
