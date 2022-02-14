//
//  BookViewController.swift
//  Login_app
//
//  Created by user214343 on 2/4/22.
//

import UIKit
import CoreData

class BookViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var authorname: UITextField!
    @IBOutlet weak var bookname: UITextField!
    var data : [String?] = []
    var data1 : [String?] = []
    var people: [NSManagedObject] = []
    var authordata : String?
    var bookdata :  String?
    
    @IBOutlet weak var namelist: UITableView!
    
    @objc func addTapped(){
        authordata = authorname.text
        bookdata = bookname.text
        

        data.append(authordata)
        data1.append(bookdata)
                
        namelist.reloadData()
        if let values = authordata, let value = bookdata{
            save(name: values, booknam: value)
            getvalue()
        }
        authorname.text = ""
        bookname.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getvalue()
    }
    
    override func viewDidLoad() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))

        super.viewDidLoad()
        namelist.delegate = self
        namelist.dataSource = self
        print(NSHomeDirectory())

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        let person = people[indexPath.row]
            
            cell.detailTextLabel?.text = person.value(forKeyPath: "authorname") as? String
        cell.textLabel?.text = person.value(forKeyPath: "bookname") as? String
        cell.textLabel?.font = UIFont.systemFont(ofSize: 23.0)
        return cell
        
        
    }
    
    func save(name: String, booknam : String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Entity",
                                   in: managedContext)!
      
      let person = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      person.setValue(name, forKeyPath: "authorname")
      person.setValue(booknam, forKeyPath: "bookname")

      // 4
      do {
        try managedContext.save()
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }
    
    func getvalue(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
          let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Entity")
          
          //3
          do {
            people = try managedContext.fetch(fetchRequest)
              namelist.reloadData()
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }
        
    }

}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

