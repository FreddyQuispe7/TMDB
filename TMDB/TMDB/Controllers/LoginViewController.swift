//
//  LoginViewController.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 10/03/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        usuarioTextField.text = "fquispe7"
        contrasenaTextField.text = "Fq030483"
    }

    @IBAction func iniciarSesion(_ sender: Any) {
        let usuario = usuarioTextField.text ?? ""
        let contrasena = contrasenaTextField.text ?? ""
        
        ServiciosWeb.validarConLogin(usuario: usuario,
                                     contrasena: contrasena,
                                     token: request_token,
                                     api_key: api_key) { success, statusMessage  in
            if success {
                self.presentarAlert(message: "Login Exitoso")
            } else {
                self.presentarAlert(message: statusMessage)
            }
        }
    }
    
    func presentarAlert(message: String) {
        let alert = UIAlertController(title: "App TDMB", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
