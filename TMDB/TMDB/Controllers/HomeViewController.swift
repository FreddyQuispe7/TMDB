//
//  HomeViewController.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 11/03/21.
//

import UIKit

class HomeViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
        validarSesion()
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let objVacio = [String : Any]()
        self.defaults.set(objVacio, forKey: "sesionUsuario")
        viewWillAppear(false)
    }

    func validarSesion() {
        if Usuario.shared.verificarSesion() {
            let usuario = Usuario.shared.consultaUsuario()
            title = "Bienvenido(a) \(usuario)"
            return
        } else {
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let _vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
            self.navigationController?.pushViewController(_vc, animated: true)
        }
    }

}
