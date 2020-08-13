//
//  EventsCellBuilder.swift
//  EventsApp
//
//  Created by Vlastimir on 03/08/2020.
//

import Foundation

struct EventsCellBuilder {
    func makeTitleSubtitleCellViewModel(_ type: TitleSubtitleCellViewModel.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewModel {
        switch type {
            case .text:
                return TitleSubtitleCellViewModel(
                    title: "Name",
                    subtitle: "",
                    placeholder: "Add a name",
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
                    title: "background",
                    subtitle: "",
                    placeholder: "",
                    type: .image,
                    onCellUpdate: onCellUpdate
                )
        }
    }
}
