//
//  SearchedMovie.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 17/07/23.
//

import Foundation

// MARK: - SearchedMovie
struct SearchedMovie: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
