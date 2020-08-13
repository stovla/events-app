//
//  EditEventViewModel.swift
//  EventsApp
//
//  Created by Vlastimir on 13/08/2020.
//

import UIKit

final class EditEventViewModel {
    let title = "Edit"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [EditEventViewModel.Cell] = []
    
    weak var coordinator: EditEventCoordinator?
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundCellViewModel: TitleSubtitleCellViewModel?
    
    private let cellBuilder: EventsCellBuilder
    private let eventService: EventServiceProtocol
    private let event: Event
    
    lazy var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(
        event: Event,
        cellBuilder: EventsCellBuilder,
        coreDataManager: EventServiceProtocol = EventService()
    ) {
        self.event = event
        self.cellBuilder = cellBuilder
        self.eventService = coreDataManager
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let date = dateFormatter.date(from: dateString),
              let image = backgroundCellViewModel?.image
        else {
            coordinator?.didFinish()
            return
        }
        let inputData = EventService.EventInputData(name: name, date: date, image: image)
        eventService.perform(.update(event), data: inputData)
        coordinator?.didFinishUpdateEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
            case .titleSubtitle(let titleSubtitleViewModel):
                titleSubtitleViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
            case .titleSubtitle(let titleSubtitleCellViewModel):
                guard titleSubtitleCellViewModel.type == .image else { return }
                coordinator?.showImagePicker { image in
                    titleSubtitleCellViewModel.update(image)
                }
        }
    }
    
    deinit {
        print("add event view model is dealocated")
    }
}

private extension EditEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundCellViewModel = backgroundCellViewModel else {
            return
        }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundCellViewModel)
        ]
        
        guard let name = event.name, let date = event.date, let imageData = event.image, let image = UIImage(data: imageData) else { return }
        
        nameCellViewModel.update(name)
        nameCellViewModel.update(date)
        nameCellViewModel.update(image)
    }
}
