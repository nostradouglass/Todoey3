//
//  ViewController.swift
//  Todoey3
//
//  Created by Kelly Douglass on 4/30/18.
//  Copyright © 2018 Kelly Douglass. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	let itemArray = ["Item 1", "Item 2", "Item 3"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

// MARK - TableView Datasource methods

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
		
		cell.textLabel?.text = itemArray[indexPath.row]
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(itemArray[indexPath.row])
		
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		} else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		
		tableView.deselectRow(at: indexPath, animated: true)
		
		
		
	}
	

}
