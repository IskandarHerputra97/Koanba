//
//  HomeInteractor.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

class HomeInteractor: BaseInteractor {
    weak var presenter: HomeInteractorOutput?
}

extension HomeInteractor: HomeUseCase {
    func fetchMovieList(pageNumber: Int) {
        NetworkManager().fetchMovieList(completion: { [weak self] movieList, error in
            guard let self = self else { return }
            if let movieList = movieList {
                self.presenter?.successFetchMovieList(data: movieList)
            } else {
                self.presenter?.errorFetchMovieList()
            }
        }, page: pageNumber)
    }
    
    func searchMovie(query: String) {
        NetworkManager().searchMovie(completion: { [weak self] movieData, error in
            guard let self = self else { return }
            if let movieData = movieData {
                self.presenter?.successSearchMovie(data: movieData)
            } else {
                self.presenter?.errorSearchMovie()
            }
        }, query: query)
    }
}
