//
//  ViewController.swift
//  AnimationChain
//
//  Created by SongMingxu on 09/01/2018.
//  Copyright (c) 2018 Gengxin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var animView: UIView!
    override func viewDidAppear(_ animated: Bool) {
        animateIt()
    }
    func animateIt() {
        let width = view.frame.width
        let height = view.frame.height
        AnimationChain
            .start(duration: 1.0){[weak self] () in
                self?.animView.frame.origin.x = width - 138
            }
            .next(duration: 1.0){[weak self] () in
                self?.animView.frame.origin.y = height - 138
            }
            .next(duration: 1.0){[weak self] () in
                self?.animView.frame.origin.x = 10
            }
            .next(duration: 1.0){[weak self] () in
                self?.animView.frame.origin.y = 10
            }
            .end{[weak self]success in
                let ac = UIAlertController(title: "Done",
                                           message: success ? "Succeed" : "Failed",
                                           preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: {_ in ac.dismiss(animated: true)}))
                self?.present(ac, animated: true)
            }
    }

}

