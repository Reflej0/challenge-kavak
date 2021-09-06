//
//  ResultService.swift
//  KavakChallenge
//
//  Created by Juan Tocino on 19/08/2021.
//

import Foundation
import Alamofire

public class ResultService{
    
    private let session: Session = Session()
    private let url: String = "https://run.mocky.io/v3/ac8aa27f-704a-452a-8846-b7e8744ea3d8"
    // https://raw.githubusercontent.com/ejgteja/files/main/books.json
    //No me permitía la request a esa url.

    public func getResults(succesBlock successBlock: @escaping (ResultModel) -> Void, failureBlock: @escaping (String) -> Void){
        let url = URL(string: self.url)!
        let headers : [String:String] = [:]
        self.session.request(URLRequest.buildRequest( httpMethod: HTTPMethod.get.rawValue, url: url, headers: headers)).responseDecodable(of: ResultModel.self){ (response) in
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

