
import Foundation
import SpriteKit
import UIKit


class GameOverScene: SKScene {
    var replay = SKSpriteNode()
    let labelMenu = SKLabelNode(fontNamed: "Chalkduster")
    
    init(size: CGSize, won:Bool) {
        super.init(size: size)
        
        
        backgroundColor = .white
        
        // 2
        
        let message = won ? "You Won!" : "You Lose :["
        
        // 3
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width/2, y: size.height/2+100)
        addChild(label)
        let replayTexture = SKTexture(imageNamed: "replay")
        replay = SKSpriteNode(texture: replayTexture)
        replay.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(replay)
        
        
        labelMenu.text = "Back to Menu"
        labelMenu.fontSize = 40
        labelMenu.fontColor = SKColor.black
        labelMenu.position = CGPoint(x: size.width/2, y: size.height/2-100)
        
        addChild(labelMenu)
        
        
    }
    
    func restart(){
        SKAction.run() { [weak self] in
            guard let `self` = self else { return }
            let reveal = SKTransition.push(with: .up, duration: 0.5)
            let gameScene = GameScene()
            self.view?.presentScene(gameScene, transition: reveal)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        if replay.contains(location!) {
            run(SKAction.sequence([
                
                SKAction.run() { [weak self] in
                    // 5
                    guard let `self` = self else { return }
                    let reveal = SKTransition.push(with: .up, duration: 0.5)
                    let scene = GameScene(size: self.size)
                    self.view?.presentScene(scene, transition:reveal)
                }
            ]))
        }
        
        if labelMenu.contains(location!) {
            print("back")
            run(SKAction.sequence([
                
                SKAction.run() { [weak self] in
                    // 5
                    guard let `self` = self else { return }
                    let reveal = SKTransition.push(with: .up, duration: 0.5)
                    let scene = MenuScene(size: self.size)
                    self.view?.presentScene(scene, transition:reveal)
                }
            ]))
            
            
        }
    }
    
    // 6
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
