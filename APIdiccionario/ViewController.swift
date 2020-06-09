//
//  ViewController.swift
//  APIdiccionario
//
//  Created by MacBook Air  on 15/05/20.
//  Copyright © 2020 MacBook Air . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var miWebView: UIWebView!
    
    @IBOutlet weak var miTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    var palabra :String?
    
    @IBAction func buscarBoton(_ sender: UIButton)
  {
        
        palabra = miTextField.text!
    let urlCompleto = "https://es.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=\(palabra!.replacingOccurrences(of: " ", with: "%20"))"
         
         //creamos un objeto de la claase URL necesario para hacer la peticion
                let objetoUrl = URL(string:urlCompleto)
         
         
                
                let tarea = URLSession.shared.dataTask(with: objetoUrl!) { (datos, respuesta, error) in
                    
                    if error != nil {
                        
                        print(error!)
                        
                    } else {
                       
                        do{
                            //convertir json a objetos Foundation
                            //mutable containers es para que podamos cambiar los datos del json
                            let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                                //print(json)
                            let querySubJson = json["query"] as! [String:Any]
                                        
                                            //print(querySubJson)
                            let pagesSubJson = querySubJson["pages"] as! [String:Any]
                                            //print(pagesSubJson)
                                        
                            let pageId = pagesSubJson.keys
                                    
                            let primerLlave = pageId.first!
                            
                            let idSubJson = pagesSubJson[primerLlave] as! [String:Any]
                                        
                                            //print(idSubJson)
                                        
                                        
                            let extractStringHtml = idSubJson["extract"] as! String
                                        
                                        print(extractStringHtml)
                                        //para mandar cualquier cosa a la interfaz de usuario lo hacemos aqui dentro de DispatchQueue
                                        DispatchQueue.main.sync(execute: {
                                            
                                            self.miWebView.loadHTMLString(extractStringHtml, baseURL: nil)
                                            
                                        })
                                        
                            
                        }catch {
                            
                            print("El Procesamiento del JSON tuvo un error")
                            
                        }
                    
                    }
                
                }
            tarea.resume()//incializamos la tarea
        }//del boton buscar
    
}

