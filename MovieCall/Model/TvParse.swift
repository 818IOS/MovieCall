//
//  TvParse.swift
//  MovieCall
//
//  Created by Juanito Martinon on 10/10/23.
//

import Foundation



struct TvParse: Codable {
    let page: Int
    let results: [TvResults]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct TvResults: Codable {
    let adult: Bool
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int
    let originCountry: [OriginCountry]
    let originalLanguage: OriginalLanguage
    let originalName, overview: String
    let popularity: Double
    let posterPath: String?
    let firstAirDate, name: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum OriginCountry: String, Codable {
    case au = "AU"
    case ca = "CA"
    case jp = "JP"
    case us = "US"
    case fr = "FR"
    case gb = "GB"
    case br = "BR"
    case pt = "PT"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
    case pt = "pt"
}
