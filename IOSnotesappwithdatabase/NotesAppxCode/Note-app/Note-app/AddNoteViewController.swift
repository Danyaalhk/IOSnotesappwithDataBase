//
//  AddNoteViewController.swift
//  Note-app
//
//  Created by Danyaal Kashif on 12/28/22.
//

import UIKit

class AddNoteViewController: UIViewController {
    //MARK: - Initalization
    var note: Note?
    var update = false
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var bodyTextField: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
//MARK: - UI Buttons:
    @IBAction func saveClick(_ sender: Any) {
        //creates date string from system date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        //checks if note black and if update path or add path
        if titleTextField.text == "" && bodyTextField.text == ""{
            print("note was empty, nothing was saved")
        }else{
            if update == false{
                APIFunctions.functions.AddNote(date: date, title: titleTextField.text!, note: bodyTextField.text)
                
            }else{
                APIFunctions.functions.updateNote(date: date, title: titleTextField.text!, note: bodyTextField.text, id: note!._id)
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func deleteClick(_ sender: Any) {
        print("Deleted note: \(note!._id) \(titleTextField.text ?? "no title")")
        APIFunctions.functions.deleteNote(id: note!._id)
        //returns to main screen
        self.navigationController?.popViewController(animated: true)
        
    }
    
//MARK: - LifeCycle Hook
    override func viewWillAppear(_ animated: Bool) {
        //disables delete button when user is initially creatring a note
        if update == false{
            self.deleteButton.isEnabled = false
            self.deleteButton.title = ""
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //pre-populate note text fields when opening an already saved note
        if update == true{
            print(note!.title)
            titleTextField.text = note!.title
            bodyTextField.text = note!.note
        }
        //print("controller connected...")
        
        // Do any additional setup after loading the view.\
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
