//
//  DetailPresenter.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

class DetailPresenter: BasePresenter {
    weak var view: DetailView?
    var interactor: DetailUseCase?
    var router: DetailWireFrame?
    
    var data: [String : Any]?
    var movieId: Int = 0
    var movieDetailData: MovieDetail?
    var movieCreditsData: MovieCredit?
}

extension DetailPresenter: DetailPresentation {
    func viewDidLoad() {
        unwrapData()
    }
    
    private func unwrapData() {
        if let data = data {
            if let movieId = data["movieId"] as? Int {
                self.movieId = movieId
                fetchMovieDetail()
                fetchMovieCredits()
            }
        }
    }
    
    func fetchMovieDetail() {
        interactor?.fetchMovieDetail(movieId: movieId)
    }
    
    func popViewController() {
        router?.popViewController()
    }
    
    func fetchMovieCredits() {
        interactor?.fetchMovieCredits(movieId: movieId)
    }
}

extension DetailPresenter: DetailInteractorOutput {
    func successFetchMovieDetail(data: MovieDetail) {
        movieDetailData = data
        view?.reloadCollectionView()
    }
    
    func errorFetchMovieDetail() {
        print("errorFetchMovieDetail")
    }
    
    func successFetchMovieCredits(data: MovieCredit) {
        movieCreditsData = data
        view?.reloadCollectionView()
    }
    
    func errorFetchMovieCredits() {
        print("errorFetchMovieCredits")
    }
}
