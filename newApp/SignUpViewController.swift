import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    var buttonTitle = "Sign Up"
    var labelWritten = "Welcome"
    
    let myLabel : UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .lightGray
        return lbl}()
        
    let userName :  UITextField = {
        let name = UITextField()
        name.placeholder = " user name"
        name.layer.cornerRadius = 8
        name.layer.borderWidth = 1
        name.backgroundColor = .white
        name.textColor = .black
        return name}()
    
    let emailText : UITextField = {
        let email = UITextField()
        email.placeholder = " email adress"
        email.layer.cornerRadius = 8
        email.layer.borderWidth = 1
        email.backgroundColor = .white
        email.textColor = .black
        return email}()
    
    let passwordText : UITextField = {
        let password = UITextField()
        password.placeholder = " password"
        password.layer.cornerRadius = 8
        password.layer.borderWidth = 1
        password.backgroundColor = .white
        password.textColor = .black
        return password}()
    
    let passwordVerifyText : UITextField = {
        let password = UITextField()
        password.placeholder = " password again"
        password.layer.cornerRadius = 8
        password.layer.borderWidth = 1
        password.backgroundColor = .white
        password.textColor = .black
        return password}()
    
    let signUpButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .gray
        return btn}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        super.view.addSubview(signUpButton)
        signUpButton.setTitle(buttonTitle, for: .normal)
        signUpButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 650, left: 120, bottom: 200, right: 120))
        }
        super.view.addSubview(userName)
        userName.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 250, left: 70, bottom: 600, right: 70))
        }
        super.view.addSubview(emailText)
        emailText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 350, left: 70, bottom: 500, right: 70))
        }
        super.view.addSubview(passwordText)
        passwordText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 450, left: 70, bottom: 400, right: 70))
        }
        super.view.addSubview(passwordVerifyText)
        passwordVerifyText.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 550, left: 70, bottom: 300, right: 70))
        }
        
        super.view.addSubview(myLabel)
        myLabel.text = labelWritten
        myLabel.textColor = .black
        myLabel.snp.makeConstraints { make -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 130, left: 170, bottom: 700, right: 120))
        }
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
    }
    
    @objc func signUpButtonClicked(myButton: UIButton, sender: Any) {
        
        if (userName.text != "" && passwordText.text == passwordVerifyText.text && emailText.text != "" && passwordText.text != "" && isValidEmail(email: emailText.text!) && isValidPassword(password: passwordText.text!)) {
            self.register(name: userName.text!, email: emailText.text!, password: passwordText.text!)
        }else{
            self.makeAlert(titleInput: "Error!", messageInput: "Try Again.")}
        
    }
    
    public func register(name: String, email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                self.makeAlert(titleInput: "Error!", messageInput: err.localizedDescription)
            }else{
                self.uploadData(username: name, email: email, password: password)}
                let nextVC = userViewController()
                self.navigationController?.pushViewController(nextVC, animated: true)
        }
    }

    public func uploadData(username: String, email: String, password: String){
        let db = FirebaseFirestore.Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("users").document(uid!).setData(["name"  : userName.text!,
                                                       "email" : emailText.text!,
                                                       "password" : passwordText.text!,
                                                       "count" : 0]){ err in
            if let err = err {
                self.makeAlert(titleInput: "Error!", messageInput: err.localizedDescription)
            }}}
    
    public func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)}
    
    public func isValidPassword(password : String) -> Bool{
        let passwordText = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$#!%*?&]).{8,}$")
        return passwordText.evaluate(with: password)}

    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput , message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default)
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alert.addAction(okButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    }

}
