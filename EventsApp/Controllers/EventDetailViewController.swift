//
//  EventDetailViewController.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/13/21.
//

import UIKit

final class EventDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            timeRemainingStackView.setup()
        }
    }
    @IBOutlet weak var timeRemainingStackView: TimeRemainingStackView!
    
    var viewModel: EventDetailViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onUpdate = { [weak self] in
            guard let strongSelf = self,
                  let timeRemainingViewModel = strongSelf.viewModel.timeRemainingViewModel else { return }
            strongSelf.backgroundImageView.image = strongSelf.viewModel.image
            strongSelf.timeRemainingStackView.configure(with: timeRemainingViewModel)
        }
        
        navigationItem.rightBarButtonItem = .init(image: UIImage(systemName: "pencil"), style: .plain, target: viewModel, action: #selector(viewModel.editButtonTapped))
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel.viewDidDisappear()
    }
}
