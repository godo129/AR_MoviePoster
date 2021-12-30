//
//  ViewController.swift
//  AR_MoviePoster
//
//  Created by hong on 2021/12/30.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "MoviePosters", bundle: Bundle.main) {
            configuration.detectionImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 2
        }

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            if imageAnchor.referenceImage.name == "spiderman_nowayhome" {
                let videoNode = SKVideoNode(fileNamed: "spiderman_nowayhome.mp4")
                videoNode.play()
                let videoScene = SKScene(size: CGSize(width: 640, height: 480))
                videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
                videoScene.addChild(videoNode)
                videoNode.yScale = -1.0
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi/2
                node.addChildNode(planeNode)
                
                let textGeo = SCNText(string: "spiderman_nowayhome", extrusionDepth: 1.0)
                textGeo.firstMaterial?.diffuse.contents = UIColor.white.cgColor
                let textNode = SCNNode(geometry: textGeo)
                textNode.position = SCNVector3(planeNode.position.x-0.07, planeNode.position.y, planeNode.position.z-0.07)
                textNode.scale = SCNVector3(0.001,0.001,0.001)
                textNode.eulerAngles.x = -.pi/2
                node.addChildNode(textNode)
                
            }
            
            if imageAnchor.referenceImage.name == "kingsMan_firstAgent" {
                
                let videoNode = SKVideoNode(fileNamed: "kingsMan_firstAgent.mp4")
                videoNode.play()
                let videoScene = SKScene(size: CGSize(width: 640, height: 480))
                videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
                videoScene.addChild(videoNode)
                videoNode.yScale = -1.0
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                plane.firstMaterial?.diffuse.contents = videoScene
                let planeNode = SCNNode(geometry: plane)
                planeNode.eulerAngles.x = -.pi/2
                node.addChildNode(planeNode)
            }
            
        }
        
        return node
    }

}
