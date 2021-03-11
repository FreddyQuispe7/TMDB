//
//  Usuario.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 11/03/21.
//

import Foundation

class Usuario{
    static let shared = Usuario()
    init (){}
    
    let defaults = UserDefaults.standard
    
    func verificarSesion()->Bool{
        let sesion = defaults.object(forKey: "sesionUsuario") as? [String:Any] ?? [String:Any]()
        let sesionU = sesion["sesion"] as? Bool ?? false
        return sesionU
    }
    
    func consultaUsuario()->String{
        var usuario=""
        let sesion = defaults.object(forKey: "sesionUsuario") as? [String:Any] ?? [String:Any]()
        usuario = sesion["usuario"] as? String ?? ""
        return usuario
    }
}
