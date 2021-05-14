//
//  EventDetailViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/13/21.
//

import UIKit
import CoreData

final class EventDetailViewModel {
    
    // MARK: - Properties
    
    private let eventID: NSManagedObjectID
    private let eventService: EventServiceProtocol
    private let date = Date()
    
    private var event: Event?
    
    var onUpdate = {}
    var coordinator: EventDetailCoordinator?
    
    var image: UIImage? {
        guard let imageData = event?.image else { return nil }
        return UIImage(data: imageData)
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event?.date,
              let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        
        return TimeRemainingViewModel(
            timeRemainingParts: timeRemainingParts,
            mode: .detail
        )
    }
    
    init(eventID: NSManagedObjectID, eventService: EventServiceProtocol = EventService()) {
        self.eventID = eventID
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func reload() {
        event = eventService.getEvent(eventID)
        onUpdate()
    }
    
    @objc func editButtonTapped() {
        guard let event = event else { return }
        coordinator?.onEditEvent(event: event)
    }
}
