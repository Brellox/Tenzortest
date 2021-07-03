//
//  Network.swift
//  Tenzortest
//
//  Created by Иван Суслов on 23.05.2021.
//

import Foundation

public protocol NetworkProtocol {
    
    func makeQuery(params: QueryParams, completion: @escaping(Result<ApiResponse, Error>)->Void)
}

extension NetworkProtocol {
    
    func getApiKey() -> String {
        return "febb84755ab6ca735ea71ac6cc71af1f"
    }
}

public protocol QueryParams {}

public protocol ApiResponse {}
