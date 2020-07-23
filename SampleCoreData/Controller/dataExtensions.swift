//
//  dataExtensions.swift
//  SampleCoreData
//
//  Created by Anik on 23/7/20.
//  Copyright © 2020 Anik. All rights reserved.
//

import UIKit
import CoreData

extension ViewController{
    
    //save the data
    func save(textToSaveInCoreData: String){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let savedText = SavedText(context: managedContext)
        savedText.note = textToSaveInCoreData
        
        do {
            try managedContext.save()
        } catch  {
            debugPrint(error.localizedDescription)
        }
    }
    
    //fetch the data
    func fetch(){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        let feachRequest = NSFetchRequest<SavedText>(entityName: "SavedText")
        
        do {
            notes = try managedContext.fetch(feachRequest)
        } catch  {
            debugPrint(error.localizedDescription)
        }
    }
    
    //this makes the tableView show the final row, the last one inserted
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.notes.count - 1, section: 0)
            self.showTextTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
