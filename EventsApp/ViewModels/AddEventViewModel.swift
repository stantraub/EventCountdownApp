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
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    
    var coordinator: AddEventCoordinator?
    
    func viewDidLoad() {
        cells = [
            .titleSubtitle(
                TitleSubtitleCellViewModel(
                    title: "Name",
                    subtitle: "",
                    placeholder: "",
                    type: .text,
                    onCellUpdate: {}
                )
            ),
            .titleSubtitle(
                TitleSubtitleCellViewModel(
                    title: "Date",
                    subtitle: "",
                    placeholder: "Select a date",
                    type: .date,
                    onCellUpdate: { [weak self] in
                        self?.onUpdate()
                    }
                )
            ),
            .titleSubtitle(
                TitleSubtitleCellViewModel(
                    title: "Background",
                    subtitle: "",
                    placeholder: "",
                    type: .image,
                    onCellUpdate: { [weak self] in
                        self?.onUpdate()
                    }
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
        }
    }
}


