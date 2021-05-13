//
//  EventCell.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/12/21.
//

import UIKit

final class EventCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifer = "EventCell"
    
    private let timeRemainingLabels = [UILabel(), UILabel(), UILabel(), UILabel()]
    private let dateLabel = UILabel()
    private let eventNameLabel = UILabel()
    private let backgroundImageView = UIImageView()
    private var verticalStackView = UIStackView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        (timeRemainingLabels + [dateLabel, eventNameLabel, backgroundImageView]).forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        timeRemainingLabels.forEach {
            $0.font = .systemFont(ofSize: 28, weight: .medium)
            $0.textColor = .white
        }
        
        dateLabel.font = .systemFont(ofSize: 22, weight: .medium)
        dateLabel.textColor = .white
        eventNameLabel.font = .systemFont(ofSize: 34, weight: .bold)
        eventNameLabel.textColor = .white
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .trailing
    }
    
    private func setupHierarchy() {
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(verticalStackView)
        contentView.addSubview(eventNameLabel)
        
        timeRemainingLabels.forEach {
            verticalStackView.addArrangedSubview($0)
        }
        verticalStackView.addArrangedSubview(dateLabel)
        verticalStackView.addArrangedSubview(eventNameLabel)
    }
    
    private func setupLayout() {
        backgroundImageView.pinToSuperviewEdges([.left, .top, .right])
        let bottomConstraint = backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        bottomConstraint.priority = .required - 1
        bottomConstraint.isActive = true
        backgroundImageView.setHeight(250)
        
        verticalStackView.pinToSuperviewEdges([.top, .right, .bottom], constant: 15)
        
        eventNameLabel.pinToSuperviewEdges([.left, .bottom], constant: 15)
    }
    
    func configure(with viewModel: EventCellViewModel) {
        viewModel.timeRemainingStrings.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }
        dateLabel.text = viewModel.dateText
        
        viewModel.loadImage { image in
            self.backgroundImageView.image = image
        }
    }
}
