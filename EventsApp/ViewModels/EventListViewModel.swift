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
        
    private(set) var cells: [Cell] = []
    private let eventService: EventServiceProtocol

    // MARK: - Lifecycle
    
    init(eventService: EventServiceProtocol = EventService()) {
        self.eventService = eventService
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        EventCellViewModel.imageCache.removeAllObjects()
        let events = eventService.getEvents()
        
        cells = events.map {
            var eventCellViewModel = EventCellViewModel($0)
            if let coordinator = coordinator {
                eventCellViewModel.onSelect = coordinator.onSelect
            }
            return .event(eventCellViewModel)
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
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .event(let model):
            model.didSelect()
        }
    }
}
