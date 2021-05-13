//
//  EventCellBuilder.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/12/21.
//

import Foundation

struct EventCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
        case .text:
            return TitleSubtitleCellViewModel(
                title: "Name",
                subtitle: "",
                placeholder: "",
                type: .text,
                onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewModel(
                title: "Date",
                subtitle: "",
                placeholder: "Select a date",
                type: .date,
                onCellUpdate: onCellUpdate
            )
        case .image:
            return TitleSubtitleCellViewModel(
                title: "Background",
                subtitle: "",
                placeholder: "",
                type: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
