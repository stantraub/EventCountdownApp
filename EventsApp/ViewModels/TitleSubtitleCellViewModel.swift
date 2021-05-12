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
    }
    
    let title: String
    let placeholder: String
    let type: CellType
    private(set) var subtitle: String
    
    // MARK: - Lifecycle
    
    init(title: String, subtitle: String, placeholder: String) {
        self.title = title
        self.subtitle = subtitle
        self.placeholder = placeholder
    }
    
    // MARK: - Helpers
    
    func update(_ subtitle: String) {
        self.subtitle = subtitle
    }
}
