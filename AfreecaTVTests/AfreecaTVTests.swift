//
//  AfreecaTVTests.swift
//  AfreecaTVTests
//
//  Created by 배태원 on 2023/01/08.
//

import XCTest
@testable import AfreecaTV

final class AfreecaTVTests: XCTestCase {
    
    //HomeController test
    var sut: HomeController!
    var tableView: UITableView!
    
    override func setUpWithError() throws {
        //HomeController에 대한 플레이스홀더인 테스트 중인 시스템 또는 테스트 클래스의 객체를 생성합니다
        try super.setUpWithError()
        sut = HomeController()
    }
    
    override func tearDownWithError() throws {
        // 테스트가 끝나면 SUT 객체를 해제
        sut = nil
        tableView = nil
        try super.tearDownWithError()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    func testgetData() throws {
        // given
        
        //      // when
        let viewController = HomeController()
        let tableView = UITableView()
        
//        // when
        
        viewController.tableView(tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
//
      
        
        //      // then
    }
    
}
