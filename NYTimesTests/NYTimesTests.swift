//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Radha Krishna on 27/07/19.
//  Copyright © 2019 Radha Krishna. All rights reserved.
//

import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {
    
    var sut: URLSession!


    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = URLSession(configuration: .default)

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil

    }
    
    func testValidCallToNYTimesAPI() {
        let url =
            URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/1.json?api-key=kV9WzlQR0ZAIiTOSZyGbGwI4H6bEqTiQ")
        let expect = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expect.fulfill()
        }
        dataTask.resume()
        wait(for: [expect], timeout: 5)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }


    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            MasterViewModel.init()

        }
    }

}
