//
//  KavakChallengeTests.swift
//  KavakChallengeTests
//
//  Created by Juan Tocino on 19/08/2021.
//

import XCTest
@testable import KavakChallenge

class KavakChallengeTests: XCTestCase {
    
    let resultService = ResultService()
    var finishCallBack = false
    var getBookVar : ResultModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetBooksCallback(result: ResultModel){
        self.finishCallBack = true
        self.getBookVar = result
    }
    
    func printError(error: String){
        Swift.print(error)
    }
    
    //Test para verificar si el get trae al menos un libro.
    func testGetUsers(){
        let expect = expectation(description: "...")
        DispatchQueue.global(qos: .userInitiated).async { // 1
            self.resultService.getResults(succesBlock: self.testGetBooksCallback, failureBlock: self.printError)
            while(true){
                if(self.finishCallBack){
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
