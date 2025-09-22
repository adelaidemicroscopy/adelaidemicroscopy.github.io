# Auto-Context (Two-Stage) Pixel Classification for Image Segmentation using ilastik with FIJI

Accurate image segmentation, that is, the distinct separation of image pixels into background and object (or labelled object classes) is an inescapable problem in biological image analysis.

At Adelaide Microscopy, we have used machine learning based solution, including the ilastik toolkit which can be integrated within ImageJ macro for downstream image processing and analysis.

Herein, we describe configuration of ilastik and FIJI and illustrate their use on challenging photography and microCT image segmentation.


Machine learning, and introduction of ... using Random Forest classifier can address limitations over traditional methods that include variable intensity conditions at acquisition.



# Setting up ilastik with FIJI
ilastik can be downloaded for Windows, Linux or Apple devices via the link. Note that ilastik does provide GPU-enabled builds for faster neural network predictions. However, the Pixel Classification and Autocontext workflows do not use GPU for calculations.

Download FIJI at the link.

This is some sample text.

# Case Study 1
An Adelaide Microscopy user wanted to quantify lesion progression (e.g., lesion number, size or colour intensity) in models of ... leaf disease.

RGB .jpg images of leaf were acquired in laboratory conditions under constant artificial lighting conditions.

Due to specimen orientation, shadowing was present in the acquired photos which presented a challenge to segment lesions using global thresholds.

# Case Study 2
An Adelaide Microscopy user wanted to quantify the marginal gap between dental crowns on plastic tooth moulds. Each tooth-crown specimen was scanned using 3D microCT.

Typically research in this area has for whatever reason evaluated the marginal gap only in two dimensions at multiple measurement points in the 3D image stack. If we could accurately segment the tooth and crown, then full 3D measurements could be possible.

Traditionally, microCT image segmentation uses global threshold defined as the mean pixel intensity between two intensity peaks in the image histogram. However, the tooth, being of plastic was radiotranslucent in the provided images and ... 

