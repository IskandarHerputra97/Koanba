//
//  DetailContract.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import UIKit

// MARK: - ViewController
protocol DetailView: AnyObject {
    var presenter: DetailPresentation? { get set }
    
    func reloadCollectionView()
}

// MARK: - Interactor
protocol DetailUseCase: AnyObject {
    var presenter: DetailInteractorOutput? { get set }
    
    func fetchMovieDetail(movieId: Int)
    func fetchMovieCredits(movieId: Int)
}

// MARK: - Router
protocol DetailWireFrame: AnyObject {
    func createModule(data: [String: Any]?) -> BaseViewController
    
    func popViewController()
}

// MARK: - Presenter
protocol DetailPresentation: AnyObject {
    var view: DetailView? { get set }
    var interactor: DetailUseCase? { get set }
    var router: DetailWireFrame? { get set }
    
    var data: [String: Any]? { get set }
    var movieId: Int { get set }
    var movieDetailData: MovieDetail? { get set }
    var movieCreditsData: MovieCredit? { get set }
    
    func viewDidLoad()
    func fetchMovieDetail()
    func popViewController()
    func fetchMovieCredits()
}

protocol DetailInteractorOutput: AnyObject {
    func successFetchMovieDetail(data: MovieDetail)
    func errorFetchMovieDetail()
    func successFetchMovieCredits(data: MovieCredit)
    func errorFetchMovieCredits()
}
