//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/13/21.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let eventID: NSManagedObjectID

    var parentCoordinator: EventListCoordinator?
    var onUpdateEvent = {}

    
    // MARK: - Lifecycle
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.eventID = eventID
    }
    
    // MARK: - Helpers
    
    func start() {
        let detailVC: EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        onUpdateEvent = {
            eventDetailViewModel.reload()
            self.parentCoordinator?.onUpdateEvent()
        }
        detailVC.viewModel = eventDetailViewModel
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: Event) {
        let editEventCoordinator = EditEventCoordinator(
            event: event,
            navigationController: navigationController
        )
        
        editEventCoordinator.parentCoordinator = self
        childCoordinators.append(editEventCoordinator)
        editEventCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
