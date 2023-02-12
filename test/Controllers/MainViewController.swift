//
//  MainViewController.swift
//  test
//
//  Created by Alexey Tregubov on 07.02.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var infoView: InfoView!
    @IBOutlet var sendRequestButton: UIButton!
    @IBOutlet var tagsCollectionView: UICollectionView!
    
    var tags: [Tag]!
    var selectedTagsIndexes: Set<Int> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tags = Data.getTags()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let contentHeight = scrollView.contentSize.height
        let maxHeight = contentHeight - contentHeight * 0.25
        scrollView.contentSize = CGSize(width: view.frame.width, height: maxHeight)
        let hei = view.safeAreaInsets.top
        let hei2 = view.frame.height
//        scrollView.contentSize = CGSize(width: view.frame.width, height: hei)
    }
    
    //MARK: Setup Views
    private func setupViews() {
        setupInfoView()
        setupScrollView()
        setupTagsCollectionView()
        setupSendRequestButton()
    }
    
    private func setupInfoView() {
        infoView.layer.cornerRadius = 32
    }
    
    private func setupScrollView() {
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupTagsCollectionView() {
        tagsCollectionView.showsHorizontalScrollIndicator = false
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
    }
    
    private func setupSendRequestButton() {
        sendRequestButton.layer.cornerRadius = 32
        sendRequestButton.titleLabel?.numberOfLines = 1
        sendRequestButton.clipsToBounds = true
    }
    
    //MARK: Actions
    @IBAction func sendRequestAction(_ sender: Any) {
        let alertController = UIAlertController(title: "Поздравляем!", message: "Ваша заявка успешно отправлена!", preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "Закрыть", style: .default, handler: nil)
        alertController.addAction(closeAction)
        present(alertController, animated: true, completion: nil)
    }
}

//MARK: CollectionView delegate and source
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count * 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        let index = getTagIndex(indexPath: indexPath)
        cell.tagLabel.text = tags[index].title
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        if selectedTagsIndexes.contains(index) {
            cell.setActiveState()
        } else {
            cell.setUnActiveState()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = getTagIndex(indexPath: indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as! TagCell
        if selectedTagsIndexes.contains(index) {
            cell.setUnActiveState()
            selectedTagsIndexes.remove(index)
        } else {
            cell.setActiveState()
            selectedTagsIndexes.insert(index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var offset = collectionView.contentOffset
        let width = collectionView.contentSize.width
        if offset.x < width / 4 {
            offset.x += width / 2
            collectionView.setContentOffset(offset, animated: false)
        } else if offset.x > width / 4 * 3 {
            offset.x -= width / 2
            collectionView.setContentOffset(offset, animated: false)
        }
    }
    
    private func getTagIndex(indexPath: IndexPath) -> Int {
        var index = indexPath.item
        if index > tags.count - 1 {
            index -= tags.count
        }
        
        return index
    }
}
