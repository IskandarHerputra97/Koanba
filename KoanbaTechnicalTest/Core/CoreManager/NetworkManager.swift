//
//  NetworkManager.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
}

struct NetworkManager {
    private func createRequest(for url: String) -> URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNTYxZmI2MWNjZDEzYjVkZWE3NjJlNThiMjBmOTBlMyIsInN1YiI6IjVmMGIwNDQ5ZWZlMzdjMDAzOGM1M2U5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ZBpwu0LkVZr5F7G-9wSh8rOpN6CN_A0f4yAxOzKZyfI", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, error)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
            
        }
        dataTask.resume()
    }
    
    typealias NowPlayingMovieCompletionClosure = ((NowPlayingMovieList?, Error?) -> Void)
    typealias MovieDetailCompletionClosure = ((MovieDetail?, Error?) -> Void)
    typealias SearchMovieCompletionClosure = ((SearchedMovie?, Error?) -> Void)
    typealias MovieCreditsClosure = ((MovieCredit?, Error?) -> Void)
    
    public func fetchMovieList(completion: NowPlayingMovieCompletionClosure?, page: Int) {
        var url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
        url.appendQueryItem(name: "page", value: "\(page)")
        
        guard let request = createRequest(for: "\(url)") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieDetail(completion: MovieDetailCompletionClosure?, movieId: Int) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(movieId)") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func searchMovie(completion: SearchMovieCompletionClosure?, query: String) {
        var url = URL(string: "https://api.themoviedb.org/3/search/movie")!
        url.appendQueryItem(name: "query", value: query)
    
        guard let request = createRequest(for: "\(url)") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    public func fetchMovieCredits(completion: MovieCreditsClosure?, movieId: Int) {
        guard let request = createRequest(for: "https://api.themoviedb.org/3/movie/\(movieId)/credits") else {
            completion?(nil, NetworkError.invalidUrl)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
