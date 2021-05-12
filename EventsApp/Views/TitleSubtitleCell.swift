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
    
    private let datePickerView = UIDatePicker(frame: .init(x: 0, y: 0, width: 100, height: 100))
    private let toolbar = UIToolbar()
    lazy var doneButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
    }()
    
    private let photoImageView = UIImageView()
    
    private var viewModel: TitleSubtitleCellViewModel?
    
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
        
        toolbar.setItems([doneButton], animated: true)
        datePickerView.datePickerMode = .date
        photoImageView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        photoImageView.layer.cornerRadius = 10
    }
    
    private func setupHierarchy() {
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(subtitleTextField)
        verticalStackView.addArrangedSubview(photoImageView)
    }
    
    private func setupLayout() {
        verticalStackView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor,
                                 bottom: contentView.bottomAnchor, right: contentView.rightAnchor,
                                 paddingTop: Config.padding, paddingLeft: Config.padding, paddingBottom: Config.padding, paddingRight: Config.padding)
        
        photoImageView.setHeight(200)
    }
    
    func configure(with viewModel: TitleSubtitleCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleTextField.text = viewModel.subtitle
        subtitleTextField.placeholder = viewModel.placeholder
        
        subtitleTextField.inputView = viewModel.type == .text ? nil : datePickerView
        subtitleTextField.inputAccessoryView = viewModel.type == .text ? nil : toolbar
        
        photoImageView.isHidden = viewModel.type != .image
        subtitleTextField.isHidden = viewModel.type == .image
        
        verticalStackView.spacing = viewModel.type == .image ? 15 : verticalStackView.spacing
    }
    
    @objc private func tappedDone() {
        viewModel?.update(datePickerView.date)
    }
}
