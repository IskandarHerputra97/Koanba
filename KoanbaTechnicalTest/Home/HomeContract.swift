//
//  HomeContract.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

// MARK: - ViewController
protocol HomeView: AnyObject {
    var presenter: HomePresentation? { get set }
    
    func reloadTableView()
}

// MARK: - Interactor
protocol HomeUseCase: AnyObject {
    var presenter: HomeInteractorOutput? { get set }
    
    func fetchMovieList(pageNumber: Int)
    func searchMovie(query: String)
}

// MARK: - Router
protocol HomeWireFrame: AnyObject {
    func createModule(data: [String: Any]?) -> BaseViewController
    
    func navigateToDetail(data: [String: Any])
}

// MARK: - Presenter
protocol HomePresentation: AnyObject {
    var view: HomeView? { get set }
    var interactor: HomeUseCase? { get set }
    var router: HomeWireFrame? { get set }
    
    var isSearchMode: Bool { get set }
    var pageNumber: Int { get set }
    var tempMovieData: [Movie] { get set }
    var tempSearchMovieData: [Movie] { get set }
    
    func navigateToDetail(indexPathRow: Int)
    func fetchMovieList(pageNumber: Int)
    func searchMovie(query: String)
}

protocol HomeInteractorOutput: AnyObject {
    func successFetchMovieList(data: NowPlayingMovieList)
    func errorFetchMovieList()
    func successSearchMovie(data: SearchedMovie)
    func errorSearchMovie()
}
