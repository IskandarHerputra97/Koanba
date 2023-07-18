//
//  DetailInteractor.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

class DetailInteractor: BaseInteractor {
    weak var presenter: DetailInteractorOutput?
}

extension DetailInteractor: DetailUseCase {
    func fetchMovieDetail(movieId: Int) {
        NetworkManager().fetchMovieDetail(completion: { [weak self] movieDetail, error in
            guard let self = self else { return }
            if let movieDetail = movieDetail {
                self.presenter?.successFetchMovieDetail(data: movieDetail)
            } else {
                self.presenter?.errorFetchMovieDetail()
            }
        }, movieId: movieId)
    }
    
    func fetchMovieCredits(movieId: Int) {
        NetworkManager().fetchMovieCredits(completion: { [weak self] movieCredits, error in
            guard let self = self else { return }
            if let movieCredits = movieCredits {
                self.presenter?.successFetchMovieCredits(data: movieCredits)
            } else {
                self.presenter?.errorFetchMovieCredits()
            }
        }, movieId: movieId)
    }
}
