//
//  BookModel.swift
//  ChallengeKavak
//
//  Created by Juan Tocino on 14/05/2022.
//

import Foundation

public struct BookModel: Codable {
    public let isbn: String
    public let title: String
    public let author: String
    public let description: String
    public let genre: String
    public let img: String
    public let imported: Bool
}
