//
//  InputViewController.swift
//  Part13
//
//  Created by 葡萄酒 on 2021/08/25.
//

import UIKit

class InputViewController: UIViewController {

    var item: String?

    @IBOutlet private weak var inputTextField: UITextField!

    @IBAction func changeInputTextField(_ sender: UITextField) {
        item = String(inputTextField.text!)
    }
}
