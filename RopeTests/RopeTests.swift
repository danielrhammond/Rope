//
//  RopeTests.swift
//  RopeTests
//
//  Created by Daniel Hammond on 1/2/15.
//  Copyright (c) 2015 Daniel Hammond. All rights reserved.
//

import Cocoa
import XCTest
import Rope

class RopeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testToString() {
        let r = Rope(fromString: "foobars")
        XCTAssert(r.toString() == "foobars", "\(r.toString()) != 'foobars'")
    }
    
    func testToStringEmpty() {
        let r = Rope(fromString: "")
        XCTAssert(r.toString() == "", "\(r.toString()) != ''")
    }
    
    func testOffsetAccess() {
        let r = Rope(fromString: "01234")
        for i in 0...4 {
            let c:Character = r.getCharacter(i)
            let expected = Character("\(i)")
            XCTAssert(c == expected, "Char at index \(i) (\(c)) != \(i)")
        }
    }
    
    func testCharacterInsert() {
        let r = Rope(fromString: "abcd")
        r.insertCharacter("a", atIndex: 1)
        XCTAssert(r.toString() == "aabcd", "expected 'aabcd' got '\(r.toString())'")
    }
    
    func testConcat() {
        let r1 = Rope(fromString: "foo")
        let r2 = Rope(fromString: "bar")
        let combined = r1 + r2
        XCTAssert(combined.toString() == "foobar", "'foo' + 'bar' should == 'foobar' got \(combined.toString()) instead")
    }
    
    /*
    func testExample() {
        let n = Node(value: "", weight: 1)
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    */
}
