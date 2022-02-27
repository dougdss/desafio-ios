//
//  LoginInteractorTests.swift
//  DesafioCoraTests
//
//  Created by user205543 on 2/26/22.
//

import Foundation
@testable import DesafioCora
import XCTest

final class LoginServiceMock: LoginServicing {
    var result: Result<LoginResponse, ServiceError> = .failure(.noResponseData)
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, ServiceError>) -> Void) {
        completion(result)
    }
}

final class LoginPresenterSpy: LoginPresenting {
    private(set) var presentTitleMessageErrorCallCount = 0
    private(set) var presentServiceErrorCallCount = 0
    private(set) var presentLoadingCallCount = 0
    private(set) var errorTitle: String = ""
    private(set) var errorMessage: String = ""
    private(set) var serviceError: ServiceError = .unknowError
    private(set) var presentSuccessCallCount = 0
    private(set) var loginResponseReceived: LoginResponse?
    
    func presentLoading(_ loading: Bool) {
        presentLoadingCallCount += 1
    }
    
    func presentError(_ error: ServiceError) {
        presentServiceErrorCallCount += 1
        serviceError = error
    }
    
    func presentError(title: String, message: String) {
        presentTitleMessageErrorCallCount += 1
        errorTitle = title
        errorMessage = message
    }
    
    func presentSuccess(loginResponse: LoginResponse) {
        presentSuccessCallCount += 1
        loginResponseReceived = loginResponse
    }
}

class LoginInteractorTests: XCTestCase {
    private let mockedService = LoginServiceMock()
    private let presenterSpy = LoginPresenterSpy()
    
    lazy var sut: LoginInteractor = {
        let interactor = LoginInteractor(service: mockedService, presenter: presenterSpy)
        return interactor
    }()
    
    func testLogin_WhenUsernameAndPasswordAreNil_ShouldPresentErrorWithTitleAndMessage() {
        sut.login(username: nil, password: nil)
        
        XCTAssertEqual(presenterSpy.presentTitleMessageErrorCallCount, 1)
        XCTAssertEqual(presenterSpy.errorTitle, "Ops!")
        XCTAssertEqual(presenterSpy.errorMessage, "Informe os dados de acesso.")
    }
    
    func testLogin_WhenUsernameAndPasswordAreInvalid_ShouldPresentServiceError() {
        sut.login(username: "ac", password: "13")
        
        XCTAssertEqual(presenterSpy.presentServiceErrorCallCount, 1)
        XCTAssertEqual(presenterSpy.serviceError, .noResponseData)
    }
    
    func testLogin_WhenUsernameAndPasswordAreValid_ShouldPresentSuccess() {
        mockedService.result = .success(LoginResponse(token: "abcdEFGH1234", id: "1"))
        
        sut.login(username: "ac", password: "13")
        
        XCTAssertEqual(presenterSpy.presentSuccessCallCount, 1)
        XCTAssertEqual(presenterSpy.loginResponseReceived?.token, "abcdEFGH1234")
        XCTAssertEqual(presenterSpy.loginResponseReceived?.id, "1")
    }
}