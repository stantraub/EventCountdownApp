//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/13/21.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    
    // MARK: - Properties
    
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    
    // MARK: - Helpers
    
    func setup() {
        timeRemainingLabels.forEach {
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configure(with viewModel: TimeRemainingViewModel) {
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: viewModel.fontSize, weight: .medium)
            $0.textColor = .white
            $0.text = ""

        }
        
        viewModel.timeRemainingParts.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
    
        alignment = viewModel.alignment
    }

}
