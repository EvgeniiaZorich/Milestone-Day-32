//
//  ViewController.swift
//  Milestone Day-32
//
//  Created by Евгения Зорич on 08.01.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shopList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSomething))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startShopping))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        title = "Shopping list"
        startShopping()
    }
    
    @objc func startShopping() {
        shopList.removeAll(keepingCapacity: true)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shopList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = shopList[indexPath.row]
        return cell
    }
    
    @objc func addSomething() {
        let ac = UIAlertController(title: "Enter item", message: nil, preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.submit(item)
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        shopList.insert(item, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @objc func shareTapped() {
        var array = [Any]()
        let list = shopList.joined(separator: "\n")
        array.append(list)
        let vc = UIActivityViewController(activityItems: array, applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
}
