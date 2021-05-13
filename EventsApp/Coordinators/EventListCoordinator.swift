//
//  EventListCoordinator.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import UIKit

final class EventListCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    var onSaveEvent = {}
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListVC: EventListViewController = .instantiate()
        let viewModel = EventListViewModel()
        viewModel.coordinator = self
        onSaveEvent = viewModel.reload
        eventListVC.viewModel = viewModel
        navigationController.setViewControllers([eventListVC], animated: false)
    }
    
    func startAddEvent() {
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        addEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
