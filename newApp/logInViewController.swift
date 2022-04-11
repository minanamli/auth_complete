
import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseStorage
import GoogleSignIn
import FacebookLogin
import FacebookCore
import FacebookShare
import FirebaseFirestore
import CryptoKit
import SwiftUI

class logInViewController: UIViewController, LoginButtonDelegate {

    
    var buttonTitle = "Log In"
    var labelWritten = "Welcome"
    
    let myLabel : UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .lightGray
        return lbl}()
    
    let emailLoginText : UITextField = {
        let email = UITextField()
        email.layer.cornerRadius = 8
        email.layer.borderWidth = 1
        email.backgroundColor = .white
        email.textColor = .black
        return email}()
    
    let passwordLoginText : UITextField = {
        let password = UITextField()
        password.layer.cornerRadius = 8
        password.layer.borderWidth = 1
        password.backgroundColor = .white
        password.textColor = .black
        return password}()
    
    let loginButton1 : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn}()
    
    let googleSignInButton : GIDSignInButton = {
        let btn = GIDSignInButton()
        return btn}()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        let loginButton = FBLoginButton()
        loginButton.delegate = self
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ (make) -> Void in
                  make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 650, left: 120, bottom: 200, right: 120))}
        
        
        super.view.addSubview(loginButton1)
        loginButton1.setTitle(buttonTitle, for: .normal)
        loginButton1.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 550, left: 120, bottom: 350, right: 120))
        }
        super.view.addSubview(googleSignInButton)
        googleSignInButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 600, left: 120, bottom: 250, right: 120))
        }
        super.view.addSubview(emailLoginText)
        emailLoginText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 360, left: 70, bottom: 490, right: 70))
        }
        super.view.addSubview(passwordLoginText)
        passwordLoginText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 450, left: 70, bottom: 400, right: 70))
        }
        super.view.addSubview(myLabel)
        myLabel.text = labelWritten
        myLabel.textColor = .white
        myLabel.snp.makeConstraints { make -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 250, left: 170, bottom: 550, right: 120))
        }
        loginButton1.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        googleSignInButton.addTarget(self, action: #selector(signInWithGoogle), for: .touchUpInside)

    }
    
//    FACEBOOK
    
    @objc func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
           print(error.localizedDescription)
           return
         }
        
        let current = AccessToken.current!.tokenString
        let credential = FacebookAuthProvider.credential(withAccessToken: current)
        
    
        Auth.auth().signIn(with: credential) { authResult, error123 in
            if let error123 = error123 {
                print(authResult?.user.email)
                let nextVC = userViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
                let uname = authResult?.user.displayName
                let uemail = authResult?.user.email
                self.uploadData(email: uemail, name: uname)
              }
            }

//            print(authResult?.user.email)
//            self.performSegue(withIdentifier: "deneme", sender: nil)
//            let uname = authResult?.user.displayName
//            let uemail = authResult?.user.email
//            self.uploadData(email: uemail, name: uname)
//            print("baasarili")
        

        func setupLoginButton() {
            loginButton.delegate = self
            loginButton.loginTracking = .limited
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
    }
    
//    GOOGLE
    
    @objc func signInWithGoogle(_ sender: Any) {
        guard let clientID = FirebaseApp.app()?.options.clientID else{ return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
            if error != nil {
                makeAlert(titleInput: "ERROR!", messageInput: error!.localizedDescription)
            }else{
                
                 }

            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { authResult, error in
                
                if let error = error {
                    makeAlert(titleInput: "ERROR!", messageInput: error.localizedDescription)
                }else{
                    print(authResult?.user.email)
                    let nextVC = userViewController()
                    self.navigationController?.pushViewController(nextVC, animated: true)
                    let uname = authResult?.user.displayName
                    let uemail = authResult?.user.email
                    uploadData(email: uemail, name: uname)
                }
            }
        }
      }
    
    
    @objc func loginButtonClicked(myButton: UIButton, sender: Any) {
        if ( emailLoginText.text != "" && passwordLoginText.text != ""){
            let nextVC = userViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
            Auth.auth().signIn(withEmail: emailLoginText.text!, password: passwordLoginText.text!) { [weak self] authResult, error in
                guard self != nil else { return }}}else {
                    makeAlert(titleInput: "Try Again", messageInput: "Cancel")
                }
    }

    
    func uploadData(email: String?, name: String?){
        let db = FirebaseFirestore.Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(uid!).setData(["email" : email,
                                                       "name"  : name,
                                                       "count" : 0]){ err in
            if let err = err {
                self.makeAlert(titleInput: "Error!", messageInput: err.localizedDescription)
            }}
    }

    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput , message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

