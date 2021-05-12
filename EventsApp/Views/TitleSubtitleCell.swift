//
//  TitleSubtitleCell.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/11/21.
//

import UIKit

final class TitleSubtitleCell: UITableViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TitleSubtitleCell"
    
    private enum Config {
        static let padding: CGFloat = 15
    }
    
    let subtitleTextField = UITextField()
    private let titleLabel = UILabel()
    private let verticalStackView = UIStackView()
    
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
    
    // MARK: - Helpers
    
    private func setupViews() {
        verticalStackView.axis = .vertical
        titleLabel.font = .systemFont(ofSize: 22, weight: .medium)
        subtitleTextField.font = .systemFont(ofSize: 20, weight: .medium)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
    }
    
    private func setupLayout() {
        verticalStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                 bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                 paddingTop: Config.padding, paddingLeft: Config.padding, paddingBottom: Config.padding, paddingRight: Config.padding)
    }
    
    func configure(with viewModel: TitleSubtitleCellViewModel) {
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
    }
}
