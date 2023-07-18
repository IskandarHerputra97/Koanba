//
//  MovieDetail.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

// MARK: - MovieDetail
struct MovieDetail: Codable {
    let overview: String?
    let posterPath: String?
    let title: String?
    let runtime: Int?
    let genres: [Genre]?
    
    enum CodingKeys: String, CodingKey {
        case overview
        case posterPath = "poster_path"
        case title
        case runtime
        case genres
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int?
    let name: String?
}
