//
//  ViewController.swift
//  ToDoList
//
//  Created by Jyothi on 7/08/2016.
//  Copyright © 2016 joe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var data = [[String:AnyObject]]()

    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
        
    @IBOutlet weak var table: UITableView!
    
    @IBAction func buttonAction(sender: UIButton) {
        let tempDict = ["name" :textfield.text!, "isCompleted" : false]
        data.append(tempDict as! [String : AnyObject])
        table.reloadData()
        textfield.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registering tap gesture to dismiss keyboard when tapped on table view i.e outside textField
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        self.table.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        table.separatorInset  = UIEdgeInsetsZero            // to extend cell border to leading edge
        table.tableFooterView = UIView(frame: CGRectZero)  // to hide extra unwanted cells
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     *  Called when the user click on the tableView (outside the UITextField).
     */
    func hideKeyboard() {
        textfield.resignFirstResponder()
    }
    
    // called when user click outside tableView and UITextField
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)    {
        self.view.endEditing(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = data[indexPath.row]["name"] as? String
        if let flag = data[indexPath.row]["isCompleted"] as? Bool
        {
            if flag {
                cell.accessoryType = .Checkmark
            }
            else {
                cell.accessoryType = .None
            }
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedCell = tableView.cellForRowAtIndexPath(indexPath)
        
        if let flag = data[indexPath.row]["isCompleted"] as? Bool
        {
            if flag {
                selectedCell?.accessoryType = .None
                data[indexPath.row]["isCompleted"] = false
            }
            else {
                selectedCell?.accessoryType = .Checkmark
                data[indexPath.row]["isCompleted"] = true
            }
        }
        else {
            selectedCell?.accessoryType = .Checkmark
            data[indexPath.row]["isCompleted"] = true
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true) // deselecting table cell after selection
        
    }

}

