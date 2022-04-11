
import UIKit
import SnapKit

class userViewController: UIViewController {

    var labelWritten = "Welcome User"
    var buttonTitle = "Log Out"


    let myLabel : UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .lightGray
        return lbl}()
    
    let logOutButton : UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.backgroundColor = .white
        return btn}()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        super.view.addSubview(myLabel)
        myLabel.text = labelWritten
        myLabel.textColor = .white
        myLabel.snp.makeConstraints { make -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 300, left: 150, bottom: 500, right: 150))
        }
        super.view.addSubview(logOutButton)
        logOutButton.setTitle(buttonTitle, for: .normal)
        logOutButton.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(super.view).inset(UIEdgeInsets(top: 550, left: 120, bottom: 350, right: 120))
        }
        logOutButton.addTarget(self, action: #selector(logOutButtonClicked), for: .touchUpInside)
    }
    
    @objc func logOutButtonClicked(myButton: UIButton, sender: Any) {
        let nextVC = logInViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
