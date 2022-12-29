//
//  ViewController.swift
//  Note-app
//
//  Created by Danyaal Kashif on 12/27/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - Initializations
    @IBOutlet weak var notesTableView: UITableView!
    var notesArray = [Note]()
    
    
    //MARK: - Segue Data
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let vc = segue.destination as! AddNoteViewController
        // passes the note and tells view controller to use update route instead of add
        if segue.identifier == "updateNoteSegue"{
            vc.note = notesArray[notesTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
        
    }
    
    
    
    
    
    //MARK: - LifeCycle Hooks
    override func viewWillAppear( _ animated: Bool) {
        //update cells with note info on every instance they appear on screen
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //update cells with note info on every instance they appear on screen
        APIFunctions.functions.fetchNotes()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
        
        
        notesTableView.delegate = self
        notesTableView.dataSource =  self
        // Do any additional setup after loading the view.
    }
    //MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! NotePrototypeCell
        //customizes cell for date not and title
        cell.title.text = notesArray[indexPath.row].title
        cell.note.text = notesArray[indexPath.row].note
        cell.date.text = notesArray[indexPath.row].date
        return cell
    }
    
    
}

//MARK: - Custom Delegates
protocol DataDelegate{
    func updateArray(newArray: String)
}


extension ViewController: DataDelegate{
    func updateArray(newArray: String) {
        do{
            notesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print("notesArray data: ")
            print(notesArray)
        } catch{
            print("Failed to decode!")
        }
        self.notesTableView?.reloadData()
    }
}
