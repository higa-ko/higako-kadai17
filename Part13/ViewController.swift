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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet private weak var tableView: UITableView!

    private let addSegue = "addSegue"
    private let editSegue = "editSegue"

    private var items: [Item] = [
        Item(name: "りんご", isChecked: true),
        Item(name: "みかん", isChecked: false),
        Item(name: "バナナ", isChecked: true),
        Item(name: "パイナップル", isChecked: false)
    ]

    private var itemName: String?
    private var rowForEditing: Int?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let moment = segue.destination as? UINavigationController else { return }
        guard let inputVC = moment.topViewController as? InputViewController else { return }

        switch segue.identifier ?? "" {
        case addSegue:
            inputVC.mode = .add
        case editSegue:
            inputVC.mode = .edit(itemName ?? "")
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
        rowForEditing = indexPath.row
        itemName = items[rowForEditing!].name
        self.performSegue(withIdentifier: editSegue, sender: self)
    }

    // swiftlint:disable line_length
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    // swiftlint:enable line_length

        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction private func exitCancel(segue: UIStoryboardSegue) {
    }

    @IBAction private func exitSave(segue: UIStoryboardSegue) {
        guard let inputViewController = segue.source as? InputViewController else { return }
        guard let itemName = inputViewController.editedItemName else { return }
        guard itemName != "" else { return }

        guard let mode = inputViewController.mode else { return }

        switch mode {
        case .add:
            items.append(Item(name: itemName, isChecked: true))
        case .edit:
            guard let rowForEditing = rowForEditing else { return }
            items[rowForEditing].name = itemName
        }

        tableView.reloadData()
    }
}
