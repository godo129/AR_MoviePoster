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
        let configuration = ARImageTrackingConfiguration()
        
        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "MoviePosters", bundle: Bundle.main) {
            configuration.trackingImages = trackedImages
            configuration.maximumNumberOfTrackedImages = 1
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
            print(imageAnchor.referenceImage.name)
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            let planeNode = SCNNode(geometry: plane)
            node.addChildNode(planeNode)
        }
        
        return node
    }

}
