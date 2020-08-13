//
//  UIViewController+Extensions.swift
//  EventsApp
//
//  Created by Vlastimir on 21/07/2020.
//

import UIKit

extension UIViewController {
    static func instatiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}
