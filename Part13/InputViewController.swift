//
//  InputViewController.swift
//  Part13
//
//  Created by 葡萄酒 on 2021/08/25.
//

import UIKit

enum Mode {
    case add
    case edit(String)
}

class InputViewController: UIViewController {

    private(set) var editedItemName: String?
    var mode: Mode?

    @IBOutlet private weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        inputTextField.text = editedItemName

        guard let mode = mode else { return }

        switch mode {
        case .add:
            break
        case .edit(let name):
            inputTextField.text = name
        }
    }

    @IBAction func changeInputTextField(_ sender: UITextField) {
        editedItemName = inputTextField.text ?? ""
    }
}
