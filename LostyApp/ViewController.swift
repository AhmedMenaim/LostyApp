//
//  ViewController.swift
//  Losty
//
//  Created by Crypto on 7/12/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var objects = [MyObject]()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Lost Things"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add , target: self, action: #selector(Lost))
        context = appdelegate.persistentContainer.viewContext
        
        tableViewOutlet.register(UINib(nibName:"ObjectCell",bundle: nil), forCellReuseIdentifier: "ObjectCell")
        
        
    }
    
    @objc func Lost(){
        
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        
        let ObjectDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ObjectDetailsViewController") as? ObjectDetailsViewController
        self.navigationController?.pushViewController(ObjectDetailsViewController!, animated: true)
    }
    
    func fetchData(){
        let fetchRequest = NSFetchRequest<MyObject>(entityName: "MyObject")
        
        do {
            objects = try context.fetch(fetchRequest)
        }
        catch {
            print(error)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        tableViewOutlet.reloadData()
        
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = objects[indexPath.row]
        var image = UIImage()
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "ObjectCell") as! ObjectCell
        
        if let data = object.image as Data? {
            image = UIImage(data: data)!
        }
        cell.configCell(name: object.name!, date: object.date!, image: image)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = objects[indexPath.row]
        let storyboard = UIStoryboard(name: "Main",bundle: nil)
        
        let ObjectDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ObjectDetailsViewController") as? ObjectDetailsViewController
        ObjectDetailsViewController!.object = object
        self.navigationController?.pushViewController(ObjectDetailsViewController!, animated: true)
        
    }
    
}




