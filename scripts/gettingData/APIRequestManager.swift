
//  APIRequestManager.swift
//  BechdelTestApi
//
//  Created by Isabela Braconi Pontual on 08/10/24.
//

import Foundation

@Observable
final class APIRequestManager {
    var welcomeElements: [WelcomeElement] = []
    
    var completeMovies: [CompleteMovie] = []
    
    static let shared = APIRequestManager()
    
    private init () {}
}
