//
//  ViewController.swift
//  UICollectionViewCellDragNDrop
//
//  Created by Sainath Bamen on 15/05/23.
//

import UIKit

class ViewController: UIViewController {
    private var colour:[UIColor] = [
        .systemRed,
        .systemBlue,
        .systemCyan,
        .systemGray,
        .systemMint,
        .systemPink,
        .systemTeal,
        .systemBrown,
        .systemTeal
    ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(longGesture))
        collectionView.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func longGesture(_ gesture:UILongPressGestureRecognizer){
        let gestureLocation = gesture.location(in: collectionView)
        switch gesture.state{
            
        case .began:
            guard let targetIndexPath  = collectionView.indexPathForItem(at: gestureLocation) else{
                return
            }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
            
            
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
            
        }
        
        
    }
    
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colour.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colour[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colour.remove(at: sourceIndexPath.row)
        colour.insert(item, at: destinationIndexPath.row)
    }
    
    
}

extension UIColor: UICollectionViewDelegateFlowLayout{
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 3.2
               , height: collectionView.frame.width / 3.2)
    }
    
}

