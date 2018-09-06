

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    var imagesList = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagesList.append(#imageLiteral(resourceName: "logo1"))
        imagesList.append(#imageLiteral(resourceName: "logo2"))
        imagesList.append(#imageLiteral(resourceName: "logo3"))
        // Do any additional setup after loading the view, typically from a nib.
        imageView.animationImages = [
            imagesList[1],
            imagesList[2],
            imagesList[3]
            ]
        
        imageView.animationDuration = 6
        imageView.startAnimating()
        
    }

}


//UIImage(named: "logo1")!,
//UIImage(named: "logo2")!,
//UIImage(named: "logo3")!,
//UIImage(named: "logo4")!,
//UIImage(named: "logo5")!,
//UIImage(named: "logo6")!,
//UIImage(named: "logo7")!,
//UIImage(named: "logo8")!
