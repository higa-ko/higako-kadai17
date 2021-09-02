//
//  ViewController.swift
//  Part13
//
//  Created by 葡萄酒 on 2021/08/23.
//

import UIKit

struct Item {
    var name: String
    var isChecked: Bool
}

enum Mode {
    case add, edit
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!

    private let addSegue = "addSegue"
    private let editSegue = "editSegue"

    var mode = Mode.add

    private var items: [Item] = [
        Item(name: "りんご", isChecked: true),
        Item(name: "みかん", isChecked: false),
        Item(name: "バナナ", isChecked: true),
        Item(name: "パイナップル", isChecked: false)
    ]

    private var itemName: String?
    private var number: Int?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let moment = segue.destination as? UINavigationController else { return }
        guard let inputVC = moment.topViewController as? InputViewController else { return }

        switch segue.identifier ?? "" {
        case addSegue:
            mode = .add
        case editSegue:
            mode = .edit
            inputVC.itemName = itemName
        default:
            print("存在しないidentifierが指定されている")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckCell", for: indexPath)

        cell.textLabel!.text = items[indexPath.row].name

        if items[indexPath.row].isChecked {
            cell.imageView?.tintColor = .white
        } else {
            cell.imageView?.tintColor = .orange
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        items[indexPath.row].isChecked.toggle()

        let indexPaths = [indexPath]
        tableView.reloadRows(at: indexPaths, with: .fade)
    }

    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        number = indexPath.row
        itemName = items[number!].name
        self.performSegue(withIdentifier: editSegue, sender: self)
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitSave(segue: UIStoryboardSegue) {
        guard let inputViewController = segue.source as? InputViewController else { return }
        guard let data = inputViewController.itemName else { return }
        guard data != "" else { return }

        switch mode {
        case .add:
            items.append(Item(name: data, isChecked: true))
        case .edit:
            items[number!].name = data
        }

        tableView.reloadData()
    }
}
