//
//  HomePresenter.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

class HomePresenter: BasePresenter {
    weak var view: HomeView?
    var interactor: HomeUseCase?
    var router: HomeWireFrame?
    
    var isSearchMode: Bool = false
    var pageNumber: Int = 1
    var tempMovieData: [Movie] = []
    var tempSearchMovieData: [Movie] = []
}

extension HomePresenter: HomePresentation {
    func navigateToDetail(indexPathRow: Int) {
        var param: [String: Any] = [String: Any]()
        if isSearchMode {
            param["movieId"] = tempSearchMovieData[indexPathRow].id
        } else {
            param["movieId"] = tempMovieData[indexPathRow].id
        }
        router?.navigateToDetail(data: param)
    }
    
    func fetchMovieList(pageNumber: Int) {
        interactor?.fetchMovieList(pageNumber: pageNumber)
    }
    
    func searchMovie(query: String) {
        interactor?.searchMovie(query: query)
    }
}

extension HomePresenter: HomeInteractorOutput {
    func successFetchMovieList(data: NowPlayingMovieList) {
        if let movieData = data.results {
            tempMovieData += movieData
        }
        pageNumber = data.page ?? 1
        view?.reloadTableView()
    }
    
    func errorFetchMovieList() {
        print("Error fetching movie!")
    }
    
    func successSearchMovie(data: SearchedMovie) {
        if let movieData = data.results {
            tempSearchMovieData += movieData
        }
        pageNumber = data.page ?? 1
        view?.reloadTableView()
    }
    
    func errorSearchMovie() {
        print("Error fetching searched movie!")
    }
}
