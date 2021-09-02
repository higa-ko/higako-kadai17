//
//  InputViewController.swift
//  Part13
//
//  Created by 葡萄酒 on 2021/08/25.
//

import UIKit

class InputViewController: UIViewController {

    var itemName: String?

    @IBOutlet private weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.text = itemName
    }

    @IBAction func changeInputTextField(_ sender: UITextField) {
        itemName = inputTextField.text ?? ""
    }
}
