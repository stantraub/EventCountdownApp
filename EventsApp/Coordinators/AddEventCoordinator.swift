//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigtionController: UINavigationController
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigtionController = navigationController
    }
    
    func start() {
        let modalNavigationController = UINavigationController()
        let addEventVC: AddEventViewController = .instantiate()
        modalNavigationController.setViewControllers([addEventVC], animated: false)
        let addEventViewModel = AddEventViewModel()
        addEventViewModel.coordinator = self
        addEventVC.viewModel = addEventViewModel
        navigtionController.present(modalNavigationController, animated: true)
    }
    
    func didFinishAddEvent() {
        parentCoordinator?.childDidFinish(self)
    }
}
