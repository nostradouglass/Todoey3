//
//  ViewController.swift
//  Todoey3
//
//  Created by Kelly Douglass on 4/30/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	private var itemArray = [Item]()
	
	private let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		let newItem = Item()
		newItem.title = "number 1"
		itemArray.append(newItem)
		
		let newItem2 = Item()
		newItem2.title = "number 2"
		itemArray.append(newItem2)
		
		 if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
			itemArray = items
		}
	}

// MARK - TableView Datasource methods

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
		
		cell.textLabel?.text = item.title
		
		cell.accessoryType = item.done! ? .checkmark : .none
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(itemArray[indexPath.row])
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done!
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		
		tableView.reloadData()
		
		tableView.deselectRow(at: indexPath, animated: true)
		
	}
	
	//MARK = ADD New Items
	
	@IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
		
		var textField = UITextField()
		
		let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			// What will happen once the user click the add item button on UIAlert
			
			let newItem = Item()
			newItem.title = textField.text!
			
			self.itemArray.append(newItem)
			
			self.defaults.set(self.itemArray, forKey: "TodoListArray")
			
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new Item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
		
	}
	

}

