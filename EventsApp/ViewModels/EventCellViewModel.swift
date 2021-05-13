//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/12/21.
//

import UIKit
import CoreData

struct EventCellViewModel {
    
    // MARK: - Properties
    
    let date = Date()
    static let imageCache = NSCache<NSString, UIImage>()
    
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    private let event: Event
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var onSelect: (NSManagedObjectID) -> Void = { _ in }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
    var timeRemainingViewModel: TimeRemainingViewModel? {
        guard let eventDate = event.date,
              let timeRemainingParts = date.timeRemaining(until: eventDate)?.components(separatedBy: ",") else { return nil }
        
        return TimeRemainingViewModel(
            timeRemainingParts: timeRemainingParts,
            mode: .cell
        )
    }

    // MARK: - Lifecycle
    
    init(_ event: Event) {
        self.event = event
    }
    
    // MARK: - Lifecycle
    
    func loadImage(completion: @escaping(UIImage?) -> Void) {
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                guard let imageData = self.event.image,
                      let image = UIImage(data: imageData)
                    else {
                        completion(nil)
                        return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
                
            }
            
        }
    }
    
    func didSelect() {
        onSelect(event.objectID)
    }
}
