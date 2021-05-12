//
//  UIViewController+Extensions.swift
//  EventsApp
//
//  Created by Stanley Traub on 5/10/21.
//

import UIKit

extension UIViewController {
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}

