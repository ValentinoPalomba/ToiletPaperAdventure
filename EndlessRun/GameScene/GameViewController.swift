
import UIKit
import SpriteKit
import Foundation

let defaults = UserDefaults.standard



class GameViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let scene = MenuScene(size: view.bounds.size)
    
    let skView = view as! SKView
    scene.ViewController = self
    skView.ignoresSiblingOrder = true
    scene.scaleMode = .resizeFill
    
    skView.presentScene(scene)
  }
    
    
   
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
   
  
}
