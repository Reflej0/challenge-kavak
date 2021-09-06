//
//  BestSellersService.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import Foundation

import Foundation
import Alamofire

public class BestSellersService{
    
    private let session: Session = Session()
    private let url: String = "https://run.mocky.io/v3/dfe48c75-f817-450f-bdc2-000c37e34e77"
    // https://raw.githubusercontent.com/ejgteja/files/main/best_sellers.json
    //No me permitía la request a esa url.

    public func getResults(succesBlock successBlock: @escaping (ResultBestSellersModel) -> Void, failureBlock: @escaping (String) -> Void){
        let url = URL(string: self.url)!
        let headers : [String:String] = [:]
        self.session.request(URLRequest.buildRequest( httpMethod: HTTPMethod.get.rawValue, url: url, headers: headers)).responseDecodable(of: ResultBestSellersModel.self){ (response) in
            switch response.result{
            case.success(let data): do{
                successBlock(data)
            }
            case.failure(let data): do{
                failureBlock(data.errorDescription ?? "Error genérico")
            }
            }
        }
    }
}

