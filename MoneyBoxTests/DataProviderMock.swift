//
//  DataProviderMock.swift
//  MoneyBoxTests
//
//  Created by Nuhu Sulemana on 30/11/2023.
//

import XCTest
import Networking

final class DataProviderMock: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLogin() throws {
        StubData.read(file: "LoginSucceed") { (result: Result<LoginResponse, Error>) in
            guard let value = try? result.get() else {
                XCTFail("Login Failed")
                return
            }
            XCTAssertEqual(value.session.bearerToken, "GuQfJPpjUyJH10Og+hS9c0ttz4q2ZoOnEQBSBP2eAEs=")
        }
    }

}
