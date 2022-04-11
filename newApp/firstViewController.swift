import UIKit
import SnapKit


class firstViewController: UIViewController {
    
    var buttonTitle1 = "Sign Up"
    var buttonTitle2 = "Log In"
    
    
    let nextBtn : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn}()

    let loginButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn}()
    
    let signUpButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        super.view.addSubview(nextBtn)
        nextBtn.setTitle("Next", for: .normal)
        nextBtn.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 270, left: 70, bottom: 580, right: 70))
        }
       
        super.view.addSubview(signUpButton)
        signUpButton.setTitle(buttonTitle1, for: .normal)
        signUpButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 360, left: 70, bottom: 490, right: 70))
        }
        
        super.view.addSubview(loginButton)
        loginButton.setTitle(buttonTitle2, for: .normal)
        loginButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 450, left: 70, bottom: 400, right: 70))
        }
        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }

    
    @objc func signUpButtonClicked(myButton: UIButton, sender: Any) {
        let nextVC = SignUpViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func loginButtonClicked(myButton: UIButton, sender: Any) {
        let nextVC = logInViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func nextButtonClicked(myButton: UIButton, sender: Any) {
        let nextVC = OnboardingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

}
