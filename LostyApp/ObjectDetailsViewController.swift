//
//  ObjectDetailsViewController.swift
//  Losty
//
//  Created by Crypto on 7/13/19.
//  Copyright © 2019 Crypto. All rights reserved.
//

import UIKit
import CoreData

class ObjectDetailsViewController: UIViewController {
    
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldDate: UITextField!
    
    @IBOutlet weak var imageViewOutlett: UIImageView!
    
    @IBOutlet weak var buttonImportPhoto: UIButton!
    
    @IBOutlet weak var buttonSaveOutlet: UIButton!
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var context = NSManagedObjectContext.init(concurrencyType: .mainQueueConcurrencyType)
    
    var object: MyObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        context = appdelegate.persistentContainer.viewContext
        if object != nil {
            textFieldName.text = object?.name
            textFieldDate.text = object?.date
            if let data = object?.image as Data? {
                imageViewOutlett.image = UIImage(data: data)
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func importPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
    }
    
    
    @IBAction func saveData(_ sender: Any) {
        if object != nil {
            object?.name = textFieldName.text
            object?.date = textFieldDate.text
            object?.image = imageViewOutlett.image?.jpegData(compressionQuality: 1) as NSData?
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
        else {
            
            
            
            let object = MyObject(context: context)
            object.id = Int64.random(in: 1...1000000)
            object.name = textFieldName.text
            object.date = textFieldDate.text
            object.image = imageViewOutlett.image?.jpegData(compressionQuality: 1) as NSData?
            do {
                try context.save()
            }
            catch {
                print(error)
            }
        }
        self.navigationController?.popViewController(animated: true)
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
extension ObjectDetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        imageViewOutlett.image = image
        picker.dismiss(animated: true, completion: nil)
    }
}
