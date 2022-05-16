//
//  ChallengeKavakTests.swift
//  ChallengeKavakTests
//
//  Created by Juan Tocino on 14/05/2022.
//

import XCTest
@testable import ChallengeKavak

class ChallengeKavakTests: XCTestCase {
    
    let resultService = ResultService()
    var finishCallBack = false
    var getBookVar : ResultModel?
    
    func testGetBooksCallback(result: ResultModel) {
        finishCallBack = true
        getBookVar = result
    }
    
    func printError(error: String) {
        Swift.print(error)
    }
    
    //Test para verificar si el get trae al menos un libro.
    func testGetBooks() {
        let expect = expectation(description: "...")
        DispatchQueue.global(qos: .userInitiated).async {
            self.resultService.getResults(succesBlock: self.testGetBooksCallback, failureBlock: self.printError)
            while (true) {
                if self.finishCallBack {
                    XCTAssertGreaterThan(self.getBookVar!.results.books.count, 0)
                    expect.fulfill()
                    break;
                }
            }
        }
        waitForExpectations(timeout: 5000) { error in
                // ...
            }
    }

}
