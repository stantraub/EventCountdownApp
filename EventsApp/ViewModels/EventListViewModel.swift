//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import Foundation

final class EventListViewModel {
    
    // MARK: - Properties
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    let title = "Event"
    
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    
    private let coreDataManager: CoreDataManager
    
    private(set) var cells: [Cell] = []

    // MARK: - Lifecycle
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        
        cells = events.map {
            .event(EventCellViewModel($0))
        }
        onUpdate()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        cells[indexPath.row]
    }
}
