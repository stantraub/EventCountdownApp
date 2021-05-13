//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/13/21.
//

import UIKit

final class EditEventViewModel {
    
    // MARK: - Properties
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    enum Mode {
        case add
        case edit(Event)
    }
    
    weak var coordinator: EditEventCoordinator?

    let title = "Edit"
    
    var onUpdate: () -> Void = {}
    
    private let event: Event
    private let cellBuilder: EventCellBuilder
    private let coreDataManager: CoreDataManager
    
    private(set) var cells: [EditEventViewModel.Cell] = []
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
    
    // MARK: - Lifecycle
    
    init(event: Event, cellBuilder: EventCellBuilder, coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Helpers
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let image = backgroundImageCellViewModel?.image,
              let date = dateFormatter.date(from: dateString) else { return }
        
        coreDataManager.updateEvent(event: event, name: name, date: date, image: image)
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(for indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let viewModel):
            viewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let model):
            guard model.type == .image else {
                return
            }
            coordinator?.showImagePicker { image in
                model.update(image)
            }
        }
    }
}

private extension EditEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel,
              let dateCellViewModel = dateCellViewModel,
              let backgroundImageCellViewModel = backgroundImageCellViewModel else { return }
        
        cells = [
            .titleSubtitle(
                nameCellViewModel
            ),
            .titleSubtitle(
                dateCellViewModel
            ),
            .titleSubtitle(
                backgroundImageCellViewModel
            )
        ]
        
        guard let name = event.name,
              let date = event.date,
              let imageData = event.image,
              let image = UIImage(data: imageData) else { return }
        
        nameCellViewModel.update(name)
        dateCellViewModel.update(date)
        backgroundImageCellViewModel.update(image)
    }
}
