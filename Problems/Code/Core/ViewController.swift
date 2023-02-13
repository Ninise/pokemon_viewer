//
//  ViewController.swift
//  Problems
//
//  Created on 2019-04-29.
//  Copyright © 2019 MetaLab Design. All rights reserved.
//

import UIKit

class ViewController<ViewType: UIView>: UIViewController {

    // MARK: - Properties

    var customView: ViewType {
        return view as! ViewType
    }

    // MARK: - Life Cycle

    override func loadView() {
        view = ViewType(frame: UIScreen.main.bounds)
    }

}
