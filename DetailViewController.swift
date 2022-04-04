//
//  DetailViewController.swift
//  HomeOwnerZC
//
//  Created by Zhiyi Chen on 3/28/22.
//

import UIKit

class DetailViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    var imageStore: ImageStore!
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        // If the device has a camera, take a picture. otherwise
        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        imagePicker.delegate = self
        // Place the image picker on the screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get picked image from info dictionary
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        // Put the image on the screen in the image view
        imageView.image = image
        
        // Store the image to image store for the item’s key
        imageStore.setImage(image, forKey: item.itemKey )
        
        // Dismiss the image picker off the screen
        dismiss(animated: true, completion: nil)
    }
    let numberFormatter: NumberFormatter = NumberFormatter()
    
    var item: Item! {
        didSet {
            navigationItem.title = item.name
        }
    }

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialField.text = item.serialNumber
        valueField.text = String(item.valueInDollars)
        dateLabel.text = "\(item.dateCreated)"
        
        let key = item.itemKey
        let imageToDispaly = imageStore.image(forKey: key)
        imageView.image = imageToDispaly
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.name = nameField.text ?? "";
        item.serialNumber = serialField.text
        if let valueText = valueField.text,
           let value = numberFormatter.number(from: valueText) {
            item.valueInDollars = value.intValue
        } else {
            item.valueInDollars = 0
        }
    }

}
