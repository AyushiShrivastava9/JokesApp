//
//  Practice2Tests.swift
//  Practice2Tests
//
//  Created by Ayushi on 21/07/23.
//

import XCTest
@testable import Practice2

class Practice2Tests: XCTestCase {

    func testExample() throws {
        let vm = JokeListViewModel()
        
        XCTAssertTrue(vm.noOfRows() == 0)
        XCTAssertEqual(vm.item(at: 5), nil)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
