import SwiftUI


#if os(iOS)
import UIKit
import MediaPlayer


@available(iOS 13.0, *)
public struct MediaPickerView: UIViewControllerRepresentable {
    public func makeCoordinator() -> Coordinator {
        Coordinator(mediaPicker: self)
    }
    
    public class Coordinator: NSObject, MPMediaPickerControllerDelegate {
        var mediaPicker: MediaPickerView
        
        init(mediaPicker: MediaPickerView) {
            self.mediaPicker = mediaPicker
        }
        
        public func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
            self.mediaPicker.mediaItemCollection?.wrappedValue = mediaItemCollection
            
            if let mediaItem = mediaItemCollection.items.first {
                self.mediaPicker.mediaItem?.wrappedValue = mediaItem
            }
            
            self.mediaPicker.onPickedItems?(mediaItemCollection)
        }
        
        public func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
            self.mediaPicker.onCancelled?()
        }
    }
    
    public func makeUIViewController(context: Context) -> MPMediaPickerController {
        let controller = MPMediaPickerController(mediaTypes: mediaTypes)
        controller.allowsPickingMultipleItems = allowsPickingMultipleItems
        controller.showsCloudItems = showsCloudItems
        controller.prompt = prompt
        controller.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        return controller
    }
    
    public func updateUIViewController(_ uiViewController: MPMediaPickerController, context: Context) {
        let controller = uiViewController
        controller.allowsPickingMultipleItems = allowsPickingMultipleItems
        controller.showsCloudItems = showsCloudItems
        controller.prompt = prompt
        controller.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
    }
    
    var mediaItemCollection: Binding<MPMediaItemCollection?>? = nil
    var mediaItem: Binding<MPMediaItem?>? = nil
    
    var mediaTypes: MPMediaType
    var allowsPickingMultipleItems = false
    var showsCloudItems = true
    var prompt = nil as String?
    var showsItemsWithProtectedAssets = true
    
    var onPickedItems: ((MPMediaItemCollection) -> Void)? = nil
    var onCancelled: (() -> Void)? = nil
    
    public init(
        _ mediaItem: Binding<MPMediaItem?>,
        forSelecting mediaTypes: MPMediaType,
        allowsPickingMultipleItems: Bool = false,
        showsCloudItems: Bool = true,
        prompt: String? = nil as String?,
        showsItemsWithProtectedAssets: Bool = true,
        onPickedItems: ((MPMediaItemCollection) -> Void)? = nil,
        onCancelled: (() -> Void)? = nil
    ) {
        self.mediaItem = mediaItem
        self.mediaTypes = mediaTypes
        self.allowsPickingMultipleItems = allowsPickingMultipleItems
        self.showsCloudItems = showsCloudItems
        self.prompt = prompt
        self.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        self.onPickedItems = onPickedItems
        self.onCancelled = onCancelled
    }
    
    public init(
        _ mediaItemCollection: Binding<MPMediaItemCollection?>,
        forSelecting mediaTypes: MPMediaType,
        allowsPickingMultipleItems: Bool = false,
        showsCloudItems: Bool = true,
        prompt: String? = nil as String?,
        showsItemsWithProtectedAssets: Bool = true,
        onPickedItems: ((MPMediaItemCollection) -> Void)? = nil,
        onCancelled: (() -> Void)? = nil
    ) {
        self.mediaItemCollection = mediaItemCollection
        self.mediaTypes = mediaTypes
        self.allowsPickingMultipleItems = allowsPickingMultipleItems
        self.showsCloudItems = showsCloudItems
        self.prompt = prompt
        self.showsItemsWithProtectedAssets = showsItemsWithProtectedAssets
        self.onPickedItems = onPickedItems
        self.onCancelled = onCancelled
    }
    
    public typealias UIViewControllerType = MPMediaPickerController
}
#endif
