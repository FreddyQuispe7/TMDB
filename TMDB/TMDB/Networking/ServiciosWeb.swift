//
//  ServiciosWeb.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 10/03/21.
//

import Foundation
import Alamofire

class ServiciosWeb {
    
    class func validarConLogin(usuario:String,
                               contrasena:String,
                               token:String,
                               api_key:String,
                               completar:@escaping (_ successAPI:Bool, _ messageAPI:String)->()){
        let urlString = "\(URLBASE)\(VALIDATE_WITH_LOGIN)"
        let params:[String:Any] = ["username": usuario,
                                   "password": contrasena,
                                   "request_token": token,
                                   "api_key": api_key]
        AF.request(urlString, method: .post,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString))
            .responseJSON{ JSON  in
                if let jsonDatos = JSON.value as? [String:Any] {
                    var statusMessage = ""
                    let success = jsonDatos["success"] as? Bool ?? false
                    print(success)
                    
                    if !success {
                        statusMessage = jsonDatos["status_message"] as? String ?? ""
                    } else {
                        statusMessage = ""
                    }
                    
                    completar(success, statusMessage)
                    
                } else {
                    print("error en el servicio")
                }
        }
    }
}
