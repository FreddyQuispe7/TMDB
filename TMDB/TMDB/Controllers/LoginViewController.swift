//
//  LoginViewController.swift
//  TMDB
//
//  Created by Freddy Alexander Quispe Torres on 10/03/21.
//

import UIKit

class LoginViewController: UIViewController {
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var contrasenaTextField: UITextField!
    @IBOutlet weak var btnIniciarSesion: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        btnIniciarSesion.isEnabled = false
        btnIniciarSesion.alpha = 0.6
    }

    @IBAction func edicionTextFields(_ sender: UITextField) {
        var usuario = ""
        var contrasena = ""
        
        if sender == usuarioTextField {
            usuario = sender.text!.replacingOccurrences(of: " ", with: "")
            contrasena = contrasenaTextField.text!.replacingOccurrences(of: " ", with: "")
        }
        
        if sender == contrasenaTextField {
            usuario = usuarioTextField.text!.replacingOccurrences(of: " ", with: "")
            contrasena = sender.text!.replacingOccurrences(of: " ", with: "")
        }
        
        btnIniciarSesion.isEnabled = !usuario.isEmpty && !contrasena.isEmpty ? true : false
        btnIniciarSesion.alpha = !usuario.isEmpty && !contrasena.isEmpty ? 1.0 : 0.6
    }
    
    @IBAction func iniciarSesion(_ sender: Any) {
        let usuario = usuarioTextField.text!.replacingOccurrences(of: " ", with: "")
        let contrasena = contrasenaTextField.text!.replacingOccurrences(of: " ", with: "")
        
        ServiciosWeb.renovarToken(api_key: API_KEY) { requestToken in
            ServiciosWeb.validarConLogin(usuario: usuario,
                                         contrasena: contrasena,
                                         token: requestToken,
                                         api_key: API_KEY) { success, statusMessage  in
                if success {
                    print("Login exitoso")
                    let datosSesion = ["sesion":true,"usuario":usuario] as [String : Any]
                    self.defaults.set(datosSesion, forKey: "sesionUsuario")
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.presentarAlert(message: statusMessage)
                }
            }
        }
    }
    
    func presentarAlert(message: String) {
        let alert = UIAlertController(title: "App TDMB", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
