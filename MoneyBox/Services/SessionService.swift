//
//  SessionService.swift
//  MoneyBox
//
//  Created by Nuhu Sulemana on 29/11/2023.
//

import Foundation

class SessionService {
    static let shared = SessionService()
    var user: UserModel?
    private init() {}
}
