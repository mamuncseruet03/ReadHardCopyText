//
//  ViewController.swift
//  MetroHacks2017
//
//  Created by Aalap Patel on 5/20/17.
//  Copyright © 2017 Aalap Patel. All rights reserved.
//

import UIKit
import TesseractOCR
import Foundation

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {
    @IBOutlet weak var textView1: UITextView!
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var notesImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textView1.layer.cornerRadius = 20
        textView1.clipsToBounds = true
        notesImage.layer.cornerRadius = 4
        notesImage.clipsToBounds = true
        let tesseract = G8Tesseract(language: "eng")
        tesseract?.delegate = self
        
        
        //CHANGE THIS IMAGE
        tesseract?.image = UIImage(named: "images.png")
        
        
        tesseract?.recognize()
        
        print(tesseract?.recognizedText ?? 0)
        var string = "\(String(describing: tesseract?.recognizedText))"
        
        // alternative: not case sensitive
        
//        var newString: String?
//        if string.lowercased().range(of:"is") != nil {
//            newString = string.replacingOccurrences(of: " is ", with: ",")
//            
//        }
//        if string.lowercased().range(of:"the") != nil {
//            newString = newString?.replacingOccurrences(of: "the", with: "")
//        }
//        
//        if string.lowercased().range(of:" - ") != nil {
//            newString = newString?.replacingOccurrences(of: " - ", with: ",")
//        }
//        
//        if string.lowercased().range(of:"are") != nil {
//            
//            
//            
//            
//            newString = newString?.replacingOccurrences(of: "are", with: ",")
//            
//            
//        }
        
        //print(newString!)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func scanButtonPressed(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Where is your image?", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not available")
            }
            
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        
        
        
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        notesImage.image = image
        
        UserDefaults.standard.set(UIImagePNGRepresentation(image), forKey: "notesImage")
        
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
func openUrl(urlStr:String!) {
    
    if let url = NSURL(string:urlStr) {
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
}

