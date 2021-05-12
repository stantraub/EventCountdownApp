//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import Foundation

final class AddEventViewModel {
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
        case titleImage
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                TitleSubtitleCellViewModel(
                    title: "Name",
                    subtitle: "",
                    placeholder: ""
                )
            ),
            .titleSubtitle(
                TitleSubtitleCellViewModel(
                    title: "Date",
                    subtitle: "",
                    placeholder: "Select a date"
                )
            )
        ]
        
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishAddEvent()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        cells[indexPath.row]
    }
    
    func tappedDone() {
        // extract info from cell view models and save in core data
    }
    
    func updateCell(for indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let viewModel):
            viewModel.update(subtitle)
        case .titleImage:
            break
        }
    }
}


