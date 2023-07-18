//
//  DetailRouter.swift
//  KoanbaTechnicalTest
//
//  Created by Iskandar Herputra Wahidiyat on 14/07/23.
//

import Foundation

public class DetailRouter: BaseRouter {
    weak var viewController: DetailViewController?
    
    public override func createModule(data: [String: Any]? = nil) -> BaseViewController {
        let view: BaseViewController & DetailView = DetailViewController()
        let presenter: DetailPresentation & DetailInteractorOutput = DetailPresenter()
        let interactor: DetailUseCase = DetailInteractor()
        let router: DetailWireFrame = self
        
        view.presenter = presenter
        presenter.view = view
        presenter.data = data
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewController = view as? DetailViewController
        return view
    }
}

extension DetailRouter: DetailWireFrame {
    func popViewController() {
        guard let viewController = viewController else { return }
        NavigationManager.shared.navDelegate?.popViewController(viewController, animated: true, completion: nil)
    }
}
