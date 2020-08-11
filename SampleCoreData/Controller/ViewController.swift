//
//  ViewController.swift
//  SampleCoreData
//
//  Created by Anik on 9/7/20.
//  Copyright © 2020 Anik. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ViewController: UIViewController {
    
    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var showTextTableView: UITableView!
    
    
    let reuseIdentifier = "tableViewCell"
    var notes: [SavedText] = []
    let ref = Database.database().reference(withPath: "text")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showTextTableView.delegate = self
        showTextTableView.dataSource = self
        
        
        fetch()
        scrollToBottom()
        
        let gradiendLayer = CAGradientLayer()
        gradiendLayer.frame = self.view.bounds
        gradiendLayer.colors = [UIColor.red.cgColor, UIColor.white.cgColor]
        self.view.layer.insertSublayer(gradiendLayer, at: 0)
    }
    
    // send button pressed, save the data, fetch it and reload the tableView then make it show the last row
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if editTextField.text != ""{
            save(textToSaveInCoreData: editTextField.text!)
            fetch()
            self.ref.child(editTextField.text!).setValue(editTextField.text)
        }
        editTextField.text = ""
        
        showTextTableView.reloadData()
        scrollToBottom()
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    //You should know what it does by now
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    //Same as before
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let textCell: TableViewCell = showTextTableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! TableViewCell
        textCell.showText.text = notes[indexPath.row].note

        
        return textCell
    }
    
    
    
}
