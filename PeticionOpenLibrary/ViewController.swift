//
//  ViewController.swift
//  PeticionOpenLibrary
//
//  Created by Erik Basto Segovia on 28/08/17.
//  Copyright © 2017 Erik Basto Segovia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var isbnTextField: UITextField!
    
    @IBOutlet weak var respondeTextView: UITextView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        isbnTextField.delegate = self
        activityIndicator.stopAnimating()   
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let isbnValue = isbnTextField.text
        if(isStringEmpty(stringValue: isbnValue!))
        {
            let alert = UIAlertController(title: "Aviso", message: "No se ha proporcionado el ISBN.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        else
        {
            activityIndicator.startAnimating()
            respondeTextView.text =  BusquedaISBN(isbn: isbnValue!)
            
            activityIndicator.stopAnimating()
            let alert = UIAlertController(title: "Busqueda", message: "Busqueda Finalizada!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return true
        }

        
    }

    
    func BusquedaISBN(isbn: String) -> String
    {
        //https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:978-84-376-0494-7
        if Reachability.isConnectedToNetwork() == true
        {
            let scriptUrl = "https://openlibrary.org/api/books"
            let urlWithParams = scriptUrl + "?jscmd=data&format=json&bibkeys=ISBN:\(isbn)"
            let myUrl = NSURL(string: urlWithParams);
            
            let datos:NSData? = NSData(contentsOf: myUrl! as URL)
            let responseString: String = NSString(data: datos! as Data, encoding: String.Encoding.utf8.rawValue)! as String
            
            return responseString
        }
        else
        {
            let alert = UIAlertController(title: "Aviso", message: "No cuenta con acceso a la red.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return ""

        }
        
        
    }
    
    func isStringEmpty( stringValue:String) -> Bool
    {
        var stringValue = stringValue
        var returnValue = false
        
        if stringValue.isEmpty  == true
        {
            returnValue = true
            return returnValue
        }
        stringValue = stringValue.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if(stringValue.isEmpty == true)
        {
            returnValue = true
            return returnValue
            
        }
        
        return returnValue
        
    }
}

