//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import Foundation

final class EventListViewModel {
    
    let title = "Event"
    var coordinator: EventListCoordinator?
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
}
