//
//  AddEventViewController.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import UIKit

final class AddEventViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: AddEventViewModel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupViews()

        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
    
    // MARK: - Helpers
    
    private func setupViews() {
        tableView.dataSource = self
        tableView.register(TitleSubtitleCell.self, forCellReuseIdentifier: TitleSubtitleCell.identifier)
        tableView.tableFooterView = UIView()
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tappedDone))
        navigationController?.navigationBar.tintColor = .black
        
        // to force large titles
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
    }
    
    private func setupHierarchy() {
        
    }
    
    // MARK: - Selectors
    
    @objc private func tappedDone() {
        viewModel.tappedDone()
    }
}

extension AddEventViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.cell(for: indexPath)
        switch type {
        case .titleSubtitle(let viewModel):
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleSubtitleCell.identifier, for: indexPath) as! TitleSubtitleCell
            cell.configure(with: viewModel)
            cell.subtitleTextField.delegate = self
            return cell
        case .titleImage:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
}

extension AddEventViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return false }
        let text = currentText + string
        
        let point = textField.convert(textField.bounds.origin, to: tableView)
        if let indexPath = tableView.indexPathForRow(at: point) {
            viewModel.updateCell(for: indexPath, subtitle: text)
        }
        
        return true
    }
}
