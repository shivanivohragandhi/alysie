//
//  AddPostViewController.swift
//  Alysei
//
//  Created by Gitesh Dang on 12/04/21.
//

import UIKit
import TLPhotoPicker
import Photos
import YPImagePicker

class AddPostViewController: UIViewController, UITextViewDelegate , TLPhotosPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnCamera: UIButton!
    @IBOutlet weak var btnGallery: UIButton!
    @IBOutlet weak var btnPostPrivacy: UIButton!
    @IBOutlet weak var txtPost: UITextView!
    @IBOutlet weak var btnStackView: UIStackView!
    @IBOutlet weak var viewHeaderShadow: UIView!
    @IBOutlet weak var collectionViewImage: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var postPrivacyTableView: UITableView!
    @IBOutlet weak var imgPrivacy: UIImageView!
    
    
    
    var privacyArray = ["Public","Followers","Just Me"]
    var privacyImageArray = ["Public","Friends","OnlyMe"]
    
    var postDesc: String?
//    var picker = UIImagePickerController()
    var uploadImageArray = [UIImage]()
    var uploadImageArray64 = [String]()
//    var selectedAssets = [TLPHAsset]()
    var imagesFromSource = [UIImage]()
    var ypImages = [YPMediaItem]()
    var descriptionPost: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        txtPost.text = AppConstants.kEnterText
        setUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setUI()
    }
    func setUI(){
        txtPost.delegate = self
        self.viewHeaderShadow.addShadow()
        btnCamera.layer.borderWidth = 0.5
        btnCamera.layer.borderColor = UIColor.lightGray.cgColor
        btnGallery.layer.borderWidth = 0.5
        btnGallery.layer.borderColor = UIColor.lightGray.cgColor
        // collectionViewHeight.constant = 0
        //collectionViewImage.isHidden = true
        postPrivacyTableView.isHidden = true
        
        txtPost.layer.borderWidth = 0.5
        txtPost.layer.borderColor = UIColor.lightGray.cgColor
        txtPost.textColor = UIColor.lightGray
        let roleID = UserRoles(rawValue:Int.getInt(kSharedUserDefaults.loggedInUserModal.memberRoleId)  ) ?? .voyagers
        var name = ""
        switch roleID {
        case .distributer1, .distributer2, .distributer3, .producer, .travelAgencies :
            name = "\(kSharedUserDefaults.loggedInUserModal.companyName ?? "")"
        //                case .voiceExperts, .voyagers:
        case .restaurant :
            name = "\(kSharedUserDefaults.loggedInUserModal.restaurantName ?? "")"
        default:
            name = "\(kSharedUserDefaults.loggedInUserModal.firstName ?? "") \(kSharedUserDefaults.loggedInUserModal.lastName ?? "")"
        }
        userName.text = name
        if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().profilePhoto) {
          //  if let profilePhoto = LocalStorage.shared.fetchImage(UserDetailBasedElements().coverPhoto) {
            self.userImage.image = profilePhoto
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.masksToBounds = true
            switch roleID {
            case .distributer1, .distributer2, .distributer3:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.distributer1.rawValue).cgColor
            case .producer:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.producer.rawValue).cgColor
            case .travelAgencies:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.travelAgencies.rawValue).cgColor
            case .voiceExperts:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voiceExperts.rawValue).cgColor
            case .voyagers:
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.voyagers.rawValue).cgColor
            case .restaurant :
                self.userImage.layer.borderColor = UIColor.init(hexString: RolesBorderColor.restaurant.rawValue).cgColor
            default:
                self.userImage.layer.borderColor = UIColor.white.cgColor
            }
        }else{
            self.userImage.layer.cornerRadius = (self.userImage.frame.width / 2.0)
            self.userImage.layer.borderWidth = 5.0
            self.userImage.layer.borderColor = UIColor.white.cgColor
        }
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()


    }
    //    func setInitialUI(){
    //        self.txtPost.text = ""
    //        self.collectionViewImage.isHidden = true
    //        self.collectionViewHeight.constant = 0
    //        self.uploadImageArray = [UIImage]()
    //        self.btnPostPrivacy.setTitle("Public", for: .normal)
    //        self.imgPrivacy.image = UIImage(named: "Public")
    //    }
    @IBAction func btnCamera(_ sender: UIButton){
        //self.showImagePicker(withSourceType: .camera, mediaType: .image)
        
        
    }
    @IBAction func btnGallery(_ sender: UIButton){
        //self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
//        alertToAddImage()
    }
    
   // private func alertToAddImage() -> Void {
        
//        let alert:UIAlertController = UIAlertController(title: AlertMessage.kSourceType, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//
//        let cameraAction = UIAlertAction(title: AlertMessage.kTakePhoto,
//                                         style: UIAlertAction.Style.default) { (action) in
//            self.showImagePicker(withSourceType: .camera, mediaType: .image)
//        }
//
//        let galleryAction = UIAlertAction(title: AlertMessage.kChooseLibrary,
//                                          style: UIAlertAction.Style.default) { (action) in
//            self.showImagePicker(withSourceType: .photoLibrary, mediaType: .image)
//        }
//
//        let cancelAction = UIAlertAction(title: AlertMessage.kCancel,
//                                         style: UIAlertAction.Style.cancel) { (action) in
//            print("\(AlertMessage.kCancel) tapped")
//        }
//        alert.addAction(cameraAction)
//        alert.addAction(galleryAction)
//
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true, completion: nil)
    //}
    private func alertToAddCustomPicker() -> Void {
//        let viewCon = CustomPhotoPickerViewController()
//        viewCon.delegate = self
//        viewCon.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
//            self?.showExceededMaximumAlert(vc: picker)
//        }
//        var configure = TLPhotosPickerConfigure()
//        configure.allowedVideoRecording = false
//        configure.allowedPhotograph = true
//        configure.usedCameraButton = true
//
//        configure.mediaType = .image
//        configure.numberOfColumn = 3
//
//
//        viewCon.configure = configure
//        viewCon.selectedAssets = self.selectedAssets
//        viewCon.logDelegate = self
//
//        viewCon.modalPresentationStyle = .fullScreen
//        self.navigationController?.present(viewCon, animated: true, completion: nil)
//        self.present(viewCon, animated: false, completion: nil)

        var config = YPImagePickerConfiguration()
        config.screens = [.library, .photo]
        config.library.maxNumberOfItems = 100000
        config.showsPhotoFilters = false
        self.descriptionPost = txtPost.text
        config.library.preselectedItems = ypImages
        let picker = YPImagePicker(configuration: config)

        picker.didFinishPicking { [unowned picker] items, cancelled in
            self.ypImages = items
            for item in items {
                switch item {
                case .photo(let photo):
                    self.imagesFromSource.append(photo.modifiedImage ?? photo.image)
                    print(photo)
                
                case .video(let video):
                    print(video)
                }
                self.txtPost.text = self.descriptionPost
            }
            self.collectionViewImage.reloadData()
            picker.dismiss(animated: true, completion: nil)
        }

        self.present(picker, animated: true, completion: nil)

    }

//    func dismissPhotoPicker(withPHAssets: [PHAsset]) {
////        // if you want to used phasset.
//        print("dismiss")
////        print("selectedAssets-----------\(self.selectedAssets)")
////        self.collectionViewImage.reloadData()
//    }

//    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
//        // use selected order, fullresolution image
//        print("dismiss")
//        self.selectedAssets = withTLPHAssets
//
//        print("selectedAssest-----------------\(self.selectedAssets)")
//
//        self.collectionViewImage.reloadData()
//        self.btnScroll()
//
//        //iCloud or video
////        getAsyncCopyTemporaryFile()
//    }

//    func photoPickerDidCancel() {
//        // cancel
//        print("cancel")
//    }

//    func dismissComplete() {
//        // picker dismiss completion
//        print("complete")
//    }

    func showExceededMaximumAlert(vc: UIViewController) {
        let alert = UIAlertController(title: "", message: "Exceed Maximum Number Of Selection", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func postAction(_ sender: UIButton){
        if (txtPost.text == AppConstants.kEnterText && self.imagesFromSource.count == 0) {
//            showAlert(withMessage: "Please enter some post")
            showAlert(withMessage: "Post can't be empty")

        }else{
        addPostApi()
        }
        
        
        // showAlert(withMessage: "Post Successfully")
    }
    
    @IBAction func changePrivacyAction(_ sender: UIButton){
        postPrivacyTableView.isHidden = false
    }
//    private func showImagePicker(withSourceType type: UIImagePickerController.SourceType,mediaType: MediaType) -> Void {
        
//        if UIImagePickerController.isSourceTypeAvailable(type) {
//
//            self.picker.mediaTypes = mediaType.CameraMediaType
//            self.picker.allowsEditing = true
//            self.picker.sourceType = type
//            self.present(self.picker,animated: true,completion: {
//                self.picker.delegate = self
//            })
//            self.picker.delegate = self }
//        else{
//            self.showAlert(withMessage: "This feature is not available.")
//        }
//    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = AppConstants.kEnterText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let spaceCount = textView.text.filter{$0 == " "}.count
        if spaceCount <= 199{
            return true
        }else{
            return false
        }
    }
    
}
//MARK:- Custom Picker
extension AddPostViewController: TLPhotosPickerLogDelegate {
    //For Log User Interaction
    func selectedCameraCell(picker: TLPhotosPickerViewController) {
        print("selectedCameraCell")
    }

    func selectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("selectedPhoto")
        print(picker.selectedAssets.count)
        //self.collectionViewImage.reloadData()
        // let image = picker.selectedAssets[at]
        //  print(image)
    }

    func shouldDismissPhotoPicker(withTLPHAssets: [TLPHAsset]) -> Bool {
        return true
    }
    
    func deselectedPhoto(picker: TLPhotosPickerViewController, at: Int) {
        print("deselectedPhoto")
       // self.collectionViewImage.reloadData()
    }
    
    func selectedAlbum(picker: TLPhotosPickerViewController, title: String, at: Int) {
         print("selectedAlbum")
    }
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            let alert = UIAlertController(title: "", message: "Denied albums permissions granted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        let alert = UIAlertController(title: "", message: "Denied camera permissions granted", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        picker.present(alert, animated: true, completion: nil)
    }
    
//    func showUnsatisifiedSizeAlert(vc: UIViewController) {
//        let alert = UIAlertController(title: "Oups!", message: "The required size is: 300 x 300", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//        vc.present(alert, animated: true, completion: nil)
//    }
}
//MARK: - ImagePickerViewDelegate Methods -

//extension AddPostViewController: UIImagePickerControllerDelegate {
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
//
//        guard let selectedImage = info[.editedImage] as? UIImage else { return }
//        print(selectedImage.description)
//        self.dismiss(animated: true) {
//            self.uploadImageArray.append(selectedImage)
//            // let compressImageData = selectedImage.jpegData(compressionQuality: 0.5)
//            // let image = UIImage(data: compressImageData!)
//            // let image : UIImage = selectedImage
//            // let imageData = image?.pngData()
//            // let base64String = imageData!.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
//            // let base64String = imageData?.base64EncodedString(options: .lineLength64Characters)
//            // self.uploadImageArray64.append(base64String ?? "")
//            // self.collectionViewHeight.constant = 200
//            // self.collectionViewImage.isHidden = false
//            self.collectionViewImage.reloadData()
//            //print("UploadImage------------------------------------\(self.uploadImageArray)")
//        }
//
//    }
//}

//MARK: UICollectionViewDataSource,UICollectionViewDelegate

extension AddPostViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.imagesFromSource.count == 0 {
            return 1
        }else{
            print("count-------------\(self.imagesFromSource.count)")
            return imagesFromSource.count + 1
            //return uploadImageArray.count + 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {return UICollectionViewCell()}
            if imagesFromSource.count == 0{
            cell.viewAddImage.isHidden = false
            cell.btnDelete.isHidden = true
        }else {

                    if indexPath.row < imagesFromSource.count{
                    cell.viewAddImage.isHidden = true
                    cell.btnDelete.isHidden = false
                        self.uploadImageArray = [UIImage]()
                        for image in 0..<self.imagesFromSource.count {
                           
                             let asset = self.imagesFromSource[image]
//                            let image = asset.fullResolutionImage ?? UIImage()
                            self.uploadImageArray.append(asset)
                            
                        }
                        cell.image.image = uploadImageArray[indexPath.row]
                       
                }else{
                   
                cell.viewAddImage.isHidden = false
                cell.btnDelete.isHidden = true

        }
            cell.btnDelete.tag = indexPath.row
            cell.btnDeleteCallback = { tag in
                self.imagesFromSource.remove(at: tag)
                //self.uploadImageArray.remove(at: tag)
                self.collectionViewImage.reloadData()
            }
            return cell
        }
       
        return cell
    }
    
    func btnScroll() {
        collectionViewImage.scrollToItem(at: IndexPath(item: self.imagesFromSource.count, section: 0), at: UICollectionView.ScrollPosition.right, animated:true)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.imagesFromSource.count == 0{
            return CGSize(width: collectionView.bounds.width , height: 200)
        }else{
            return CGSize(width: collectionView.bounds.width / 3, height: 200)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.imagesFromSource.count ==  0 {
           // alertToAddImage()
            alertToAddCustomPicker()
        }else if indexPath.row >= self.imagesFromSource.count{
            //alertToAddImage()
            alertToAddCustomPicker()
        }
    }
}
//MARK: UITableView
extension AddPostViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = postPrivacyTableView.dequeueReusableCell(withIdentifier: "PostPrivacyTableViewCell", for: indexPath) as? PostPrivacyTableViewCell else {return UITableViewCell()}
        cell.selectionStyle = .none
        cell.labelPrivacy.text = privacyArray[indexPath.row]
        cell.imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        postPrivacyTableView.isHidden = true
        btnPostPrivacy.setTitle(privacyArray[indexPath.row], for: .normal)
        imgPrivacy.image = UIImage(named: privacyImageArray[indexPath.row])
    }
    
    
}

extension AddPostViewController {
    func addPostApi(){

        postDesc = txtPost.text
        if txtPost.text == AppConstants.kEnterText {
            postDesc = ""
        }

        let params: [String:Any] = [
            
            "action_type": "post",
            "body": postDesc ?? "",
            "privacy": btnPostPrivacy.title(for: .normal)?.lowercased() ?? ""
            
        ]
        //        let params = ["params":["action_type": "post","body":txtPost.text ?? "","privacy": btnPostPrivacy.title(for: .normal) ?? "",
        //                                "attachments": []]]
        
        //var compressedImages = [UIImage]()
        let imageParam : [String:Any] = [APIConstants.kImage: self.uploadImageArray,
                                         // APIConstants.kImageName: "attachments"]
                                         //        let imageParam : [String:Any] = [APIConstants.kImage: [],
                                         APIConstants.kImageName: "attachments"]
        
        //var imageParams = [[String:Any]]()
        //imageParams.append(imageParam)
        
        print("ImageParam------------------------------\(imageParam)")
        CommonUtil.sharedInstance.postRequestToImageUpload(withParameter: params, url: APIUrl.kPost, image: imageParam, controller: self, type: 0)
        //
        //        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kPost, requestMethod: .post, requestImages: imageParam, requestVideos: [:], requestData: params) { (dictResponse, error, errorType, statusCode) in
        //            self.showAlert(withMessage: "Post Successfully")
        //            self.txtPost.text = ""
        //            self.collectionViewImage.isHidden = true
        //            self.collectionViewHeight.constant = 0
        //            self.uploadImageArray = [UIImage]()
        //            self.btnPostPrivacy.setTitle("Public", for: .normal)
        //            self.imgPrivacy.image = UIImage(named: "Public")
        //        }
        //
        //      }
        
        
        //        TANetworkManager.sharedInstance.requestMultiPart(withServiceName: APIUrl.kPost, requestMethod: .post, requestImages: imageParam, requestVideos: [:], requestData: params) { (dictResponse, error, errorType, statusCode) in
        //            self.showAlert(withMessage: "Post Successfully")
        //            self.txtPost.text = ""
        //            self.collectionViewImage.isHidden = true
        //            self.collectionViewHeight.constant = 0
        //            self.uploadImageArray = [UIImage]()
        //            self.btnPostPrivacy.setTitle("Public", for: .normal)
        //            self.imgPrivacy.image = UIImage(named: "Public")
        //        }
        
        //        TANetworkManager.sharedInstance.requestApi(withServiceName: APIUrl.kPost, requestMethod: .POST, requestParameters: params, withProgressHUD: true) { (dictResponse, error, errortype, statuscode) in
        //            self.showAlert(withMessage: "Post Successfully")
        //            self.txtPost.text = ""
        //            self.collectionViewImage.isHidden = true
        //            self.collectionViewHeight.constant = 0
        //            self.uploadImageArray = [UIImage]()
        //            self.btnPostPrivacy.setTitle("Public", for: .normal)
        //            self.imgPrivacy.image = UIImage(named: "Public")
        //        }
        //    }
    }
    
    override func didUserGetData(from result: Any, type: Int) {
//        self.showAlert(withMessage: "Post Successfully") {
//        }
        self.txtPost.text = ""
        self.uploadImageArray = [UIImage]()
        self.btnPostPrivacy.setTitle("Public", for: .normal)
        self.imgPrivacy.image = UIImage(named: "Public")
        self.imagesFromSource.removeAll()
        self.uploadImageArray.removeAll()
        self.collectionViewImage.reloadData()

        self.tabBarController?.selectedIndex = Tabbar.home.rawValue

    }
}
class ImageCollectionViewCell:UICollectionViewCell{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var viewAddImage: UIView!
    
    var btnDeleteCallback:((Int) -> Void)? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewAddImage.layer.borderWidth = 0.5
        viewAddImage.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func btnDeleteAction(_ sender: UIButton){
        btnDeleteCallback?(sender.tag)
    }
}

class PostPrivacyTableViewCell: UITableViewCell{
    @IBOutlet weak var labelPrivacy: UILabel!
    @IBOutlet weak var imgPrivacy: UIImageView!
}

