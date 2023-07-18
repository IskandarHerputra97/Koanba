//
//  HomeRouter.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

public class HomeRouter: BaseRouter {
    weak var viewController: HomeViewController?
    
    public override func createModule(data: [String: Any]? = nil) -> BaseViewController {
        let view: BaseViewController & HomeView = HomeViewController()
        let presenter: HomePresentation & HomeInteractorOutput = HomePresenter()
        let interactor: HomeUseCase = HomeInteractor()
        let router: HomeWireFrame = self
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController = view as? HomeViewController
        return view
    }
}

extension HomeRouter: HomeWireFrame {
    func navigateToDetail(data: [String: Any]) {
        guard let viewController = viewController else { return }
        NavigationManager.shared.navDelegate?.navigateToPageWithArgs(NavigationDestination.detail, from: viewController, data: data)
    }
}
