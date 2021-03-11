//
//  ServiciosWeb.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 10/03/21.
//

import Foundation
import Alamofire

class ServiciosWeb {
    
    class func renovarToken(api_key:String,
                               completar:@escaping (_ requestTokenAPI:String)->()){
        let urlString = "\(URLBASE)\(CREATE_NEW_TOKEN)"
        let params:[String:Any] = ["api_key": api_key]
        AF.request(urlString, method: .get,
                   parameters: params,
                   encoding: URLEncoding(destination: .queryString))
            .responseJSON{ JSON  in
                if let jsonDatos = JSON.value as? [String:Any] {
                    let success = jsonDatos["success"] as? Bool ?? false
                    
                    if success {
                        let requestToken = jsonDatos["request_token"] as? String ?? ""
                        print("Token renovado:", requestToken)
                        completar(requestToken)
                    } else {
                        completar("")
                    }
                    
                } else {
                    print("error en el servicio")
                }
        }
    }
    
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
                    
                    if !success {
                        statusMessage = jsonDatos["status_message"] as? String ?? ""
                        let statusCode = jsonDatos["status_code"] as? Int ?? 0
                        print(statusCode)
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
