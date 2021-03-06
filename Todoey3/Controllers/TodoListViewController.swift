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
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		
		loadItems()
		
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
		
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done!
		
		saveItems()
		
		//		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
		//			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		//		} else {
		//			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		//		}
		
		
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
			
			self.saveItems()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create new Item"
			textField = alertTextField
		}
		
		alert.addAction(action)
		
		present(alert, animated: true, completion: nil)
		
	}
	
	func saveItems() {
		let encoder = PropertyListEncoder()
		
		do {
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		} catch {
			print("Error")
		}
		tableView.reloadData()
	}
	
	func loadItems() {
		if let data = try? Data(contentsOf: dataFilePath!) {
			let decoder = PropertyListDecoder()
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch {
				print("decode error")
			}
		}
	}
	
}

