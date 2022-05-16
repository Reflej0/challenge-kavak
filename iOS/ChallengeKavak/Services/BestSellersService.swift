//
//  BestSellersService.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import Foundation
import Alamofire

public class BestSellersService {
    
    private let session = Session()
    private let url: String = "https://run.mocky.io/v3/f8c898f3-1c6b-4c1d-9ba8-f301ad635721"
    // https://raw.githubusercontent.com/ejgteja/files/main/best_sellers.json
    //No me permitía la request a esa url.

    public func getResults(succesBlock successBlock: @escaping (ResultBestSellersModel) -> Void, failureBlock: @escaping (String) -> Void) {
        guard let url = URL(string: url) else { return }
        let headers : [String:String] = [:]
        session.request(URLRequest.buildRequest( httpMethod: HTTPMethod.get.rawValue, url: url, headers: headers)).responseDecodable(of: ResultBestSellersModel.self){ (response) in
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


