//
//  ViewController.swift
//  todoList1
//
//  Created by Admin on 26/10/22.
/*This is a to do list project in which we add a table view in which we are creating cell
1> when user will click in the + button it will show an popup though which user can add a new item
2> When user will click into cell or the save item it will get checkmarked with blue tick or he can deselect it.
 the other features are added in -> LIST project
 
*/
import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["fish","chicken","egg"]

    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //retrieve data(setting iteamArray equal to array under user default)
        if let item = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = item
        }
        
    }
    // creating table view datasource method
    // no. of rows or creating cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        //setting the text lable
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    // table view delegate method
    // it will get fire when ever we click in the cell of a table view
    //its tell the delegate the row is selected and o/p is display in console
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("number of row is: ",indexPath.row)
        //print(itemarray[indexPath.row])
        //for adding check-mark
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        // for removing check-mark
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // add new item section
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todolist", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen when user will click the add item button on our uialert
            self.itemArray.append(textField.text!)
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
            //print(textField.text) // it will print the user input
        }
        //this block will execute when we click add button
        alert.addTextField{(alertTextField) in
            alertTextField.placeholder = "create new item"
            textField = alertTextField
        }
        //adding action
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        //print(textField.text)
    }
    
}

