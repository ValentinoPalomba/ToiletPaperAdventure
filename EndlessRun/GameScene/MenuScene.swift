//
//  MenuScene.swift
//  EndlessRun
//
//  Created by Valentino Palomba on 31/03/2020.
//  Copyright © 2020 Valentino Palomba. All rights reserved.
//

import Foundation
import SpriteKit
import SafariServices




class MenuScene : SKScene {
    var Titolo : SKLabelNode!
    var Donate : SKLabelNode!
    var Play : SKLabelNode!
    var scoreLabel : SKLabelNode!
    weak var ViewController: UIViewController?
    var SetCHarachters : SKLabelNode!
    override func didMove(to view: SKView) {
        backgroundColor = .white
        Titolo = SKLabelNode(fontNamed: "Chalkduster")
        Donate = SKLabelNode(fontNamed: "Chalkduster")
        Play = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        SetCHarachters = SKLabelNode(fontNamed: "Chalkduster")
        Titolo.text = "Toilet Paper Adventure"
        Donate.text = "Donate"
        Play.text = "Play"
        scoreLabel.text = "MAX SCORE : \(defaults.integer(forKey: "Score"))"
        SetCHarachters.text = "Set Characters"
        
        Play.position = CGPoint(x: view.center.x-150, y: view.center.y+20)
        Titolo.position = CGPoint(x: view.center.x, y: view.center.y+110)
        Donate.position = CGPoint(x: view.center.x, y: view.center.y-90)
        scoreLabel.position = CGPoint(x: view.frame.maxX-90, y: view.center.y+160)
        SetCHarachters.position = CGPoint(x: frame.midX + 150, y: view.center.y+20)
        SetCHarachters.fontSize = 25
        scoreLabel.fontSize = 18
        Titolo.fontSize = 40
        Donate.fontSize = 25
        Play.fontSize = 30
        scoreLabel.fontColor = SKColor.black
        Titolo.fontColor = SKColor.black
        Donate.fontColor = SKColor.black
        Play.fontColor = SKColor.black
        SetCHarachters.fontColor = SKColor.black
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addMonster),
                SKAction.wait(forDuration: 3.0)
            ])
        ))
        
        run(SKAction.repeatForever(
                  
                  SKAction.sequence([
                      SKAction.run(addToiletPaper),
                      SKAction.wait(forDuration: TimeInterval(2.0), withRange: TimeInterval(2.0))
                  ])
              ))
        addChild(scoreLabel)
               addChild(Play)
               addChild(Titolo)
               addChild(Donate)
        addChild(SetCHarachters)
        
    }
    
    func random() -> CGFloat {
           return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
       }
       
       func random(min: CGFloat, max: CGFloat) -> CGFloat {
           return random() * (max - min) + min
       }
       
    
    
    func addMonster() {
           
           // Create sprite
           let monster = SKSpriteNode(imageNamed: "virus")
           
           monster.physicsBody = SKPhysicsBody(rectangleOf: monster.size) // 1
           monster.physicsBody?.isDynamic = true // 2
           monster.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
           monster.physicsBody?.node?.name = "monster"
           monster.physicsBody?.contactTestBitMask = PhysicsCategory.projectile // 4
           monster.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        monster.zPosition = -10
           // Determine where to spawn the monster along the Y axis
        let actualY = random(min: 0, max: size.height)
           
           // Position the monster slightly off-screen along the right edge,
           // and along a random position along the Y axis as calculated above
           monster.position = CGPoint(x: size.width + monster.size.width/2, y: actualY)
           
           // Add the monster to the scene
           addChild(monster)
           
           // Determine speed of the monster
           let actualDuration = random(min: CGFloat(4.0), max: CGFloat(8.0))
           
           // Create the actions
           let actionMove = SKAction.move(to: CGPoint(x: -monster.size.width/2, y: actualY),
                                          duration: TimeInterval(actualDuration))
           
           //        let loseAction = SKAction.run() { [weak self] in
           //            guard let `self` = self else { return }
           //            let reveal = SKTransition.flipHorizontal(withDuration: 0.5)
           //            let gameOverScene = GameOverScene(size: self.size, won: false)
           //            self.view?.presentScene(gameOverScene, transition: reveal)
           //        }
           
           
           let actionMoveDone = SKAction.removeFromParent()
           
           monster.run(SKAction.sequence([actionMove, actionMoveDone]))
       }
       
    
    func addToiletPaper() {
        let toiletPaper = SKSpriteNode(imageNamed: "toiletPaper")
        toiletPaper.physicsBody = SKPhysicsBody(rectangleOf: toiletPaper.size) // 1
        toiletPaper.physicsBody?.isDynamic = true // 2
        toiletPaper.physicsBody?.categoryBitMask = PhysicsCategory.monster // 3
        toiletPaper.physicsBody?.node?.name = "toiletPaper"
        toiletPaper.physicsBody?.contactTestBitMask = PhysicsCategory.player // 4
        toiletPaper.physicsBody?.collisionBitMask = PhysicsCategory.none // 5
        toiletPaper.zPosition = -10
        let actualDuration = random(min: CGFloat(2.0), max: CGFloat(4.0))
        let actualY = random(min: 0, max: size.height)
        
        toiletPaper.position = CGPoint(x:  toiletPaper.size.width/2, y: actualY-50)
        
        addChild(toiletPaper)
        
        
        
        let actionMove = SKAction.move(to: CGPoint(x: size.width, y:actualY),
                                       duration: TimeInterval(actualDuration))
        
        let actionMoveDone = SKAction.removeFromParent()
        
        toiletPaper.run(SKAction.sequence([actionMove, actionMoveDone]))
        
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        if Donate.contains(location!){
            if let url = URL(string: "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/donate") {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true
                
                let vc = SFSafariViewController(url: url, configuration: config)
                scene?.view?.window?.rootViewController?.present(vc, animated: true)
                    
                
                
            }
        }
        
        if Play.contains(location!) {
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
        if SetCHarachters.contains(location!) {
            run(SKAction.sequence([
                SKAction.run() { [weak self] in
                    // 5
                    guard let `self` = self else { return }
                    let reveal = SKTransition.push(with: .up, duration: 0.5)
                    let scene = PlayerChoiceScene(size: self.size)
                    self.view?.presentScene(scene, transition:reveal)
                }
            ]))
        }
    }
    
}
