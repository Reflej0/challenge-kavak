//
//  ResultService.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import Foundation
import Alamofire

public class ResultService {
    
    private let session = Session()
    private let url: String = "https://run.mocky.io/v3/25cdebdb-b572-4a63-b905-0a0b19538000"
    // https://raw.githubusercontent.com/ejgteja/files/main/books.json
    //No me permitía la request a esa url.

    public func getResults(succesBlock successBlock: @escaping (ResultModel) -> Void, failureBlock: @escaping (String) -> Void) {
        guard let url = URL(string: url) else { return }
        let headers : [String:String] = [:]
        session.request(URLRequest.buildRequest( httpMethod: HTTPMethod.get.rawValue, url: url, headers: headers)).responseDecodable(of: ResultModel.self){ (response) in
            switch response.result {
                case.success(let data): do {
                    successBlock(data)
                }
                case.failure(let data): do {
                    failureBlock(data.errorDescription ?? "Error genérico")
                }
            }
        }
    }
}
