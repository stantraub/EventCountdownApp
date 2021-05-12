//
//  TitleSubtitleCellViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/11/21.
//

import Foundation

final class TitleSubtitleCellViewModel {
    
    // MARK: - Properties
    
    enum CellType {
        case text
        case date
        case image
    }
    
    let title: String
    let placeholder: String
    let type: CellType
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        return dateFormatter
    }()
    private(set) var subtitle: String
    private(set) var onCellUpdate: () -> Void = {}

    // MARK: - Lifecycle
    
    init(title: String, subtitle: String, placeholder: String, type: CellType, onCellUpdate: @escaping() -> Void) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
        self.type = type
        self.onCellUpdate = onCellUpdate
    }
    
    // MARK: - Helpers
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
    
    func update(_ date: Date) {
        let dateString = dateFormatter.string(from: date)
        self.subtitle = dateString
        onCellUpdate()
    }
}
