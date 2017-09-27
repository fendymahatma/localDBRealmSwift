//
//  ViewController.swift
//  localdatabase
//
//  Created by kliklabs indo kreasi on 9/27/17.
//  Copyright © 2017 kliklabs. All rights reserved.
//

import UIKit
import RealmSwift
import PMAlertController

class ViewController: UITableViewController {
    
    let realm = try! Realm()
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Human"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(handleAdd))
        
        tableView.register(ViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let human = self.realm.objects(Human.self)
        try! self.realm.write {
            if human[indexPath.row].is_dead == false {
                human[indexPath.row].is_dead = true
                self.tableView.reloadData()
            }
            else
            {
                human[indexPath.row].is_dead = false
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realm.objects(Human.self).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ViewCell
        
        // select semua data Human di database local
        let human = realm.objects(Human.self)
        cell.name.text = "\(human[indexPath.row].name)"
        cell.age.text = "\(human[indexPath.row].age)"
        
        if human[indexPath.row].is_dead == false
        {
            cell.backgroundColor = .red
        }
        else
        {
            cell.backgroundColor = .white
        }
        return cell
    }
    
    //biar bisa di swap
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // isinya swap apa aja
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        
        // edit
        let edit = UITableViewRowAction(style: .normal, title: "edit") { action, index in
            let human = self.realm.objects(Human.self)
            try! self.realm.write {
                human[index.row].name = "Thomas Pynchon"
                self.tableView.reloadData()
            }

        }
        edit.backgroundColor = .lightGray
        
        // delete
        let delete = UITableViewRowAction(style: .normal, title: "delete") { action, index in
            let human = self.realm.objects(Human.self)
            try! self.realm.write {
                self.realm.delete(human[index.row])
                self.tableView.reloadData()
            }
        }
        delete.backgroundColor = .red
        
        // all
        return [delete, edit]
    }
    
    func handleAdd()
    {
        let alert = UIAlertController(title: "Add Human", message: "", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (name) in
            name.placeholder = "Name"
            name.textColor = UIColor.lightGray
        }
        alert.addTextField { (age) in
            age.placeholder = "Age"
            age.keyboardType = .numberPad
            age.textColor = UIColor.lightGray
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: { [weak alert] (_) in
            let name = alert?.textFields![0]
            let age = alert?.textFields![1]
            
            if name?.text == "" ||  age?.text == ""{
                print("please fill the field")
            }
            else if (age?.hashValue)! < 1
            {
                print("age can't be less than 1")
            }
            else
            {
                // cek apa ada data yang sama di database local
                let exist = self.realm.objects(Human.self).filter("name = '\((name?.text!)!)' ")
                if exist.isEmpty
                {
                    // masukin data ke variabel
                    let human_data = Human()
                    human_data.name = (name?.text!)!
                    human_data.age = (age?.hashValue)!
                    
                    // insert data ke database local
                    try! self.realm.write {
                        self.realm.add(human_data)
                        self.tableView.reloadData()
                    }
                }
                else
                {
                    print("udah ada data yang sama")
                }
                
            }
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

