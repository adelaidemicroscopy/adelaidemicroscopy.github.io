# Cellpose in QuPath for high throughput characterization of intestinal villi in progeny of broiler chickens
[Bryant Roberts](https://www.adelaide.edu.au/directory/bryant.roberts), September 2025

By following the instructions within this procedure you will:
1. Use the Cellpose version 3 "Human-in-the-loop" approach to train your own segmentation model.
2. Use Cellpose in QuPath to validate your model predictions.
3. Use Cellpose in QuPath for high-throughput characterization of the intestinal villi from broiler chicks.

## Method summary
“Intestinal villi were segmented using Cellpose (version X.X) with the human-in-the-loop workflow. Although Cellpose is typically designed for single-cell or nuclear segmentation, we adapted it to treat each villus as a single ‘cell-like object.’ Representative images (n = 5–10) were manually annotated to provide ~20–50 villi per image as ground truth. The model was iteratively refined through 2–3 rounds of annotation and retraining until segmentation performance was visually consistent across the dataset. The approximate villus width (~150–200 pixels) was used to set the diameter parameter in the Cellpose GUI. Segmentation results were subsequently used for quantitative morphometric analysis.”


## 1 Train a cellpose model using the "Human-in-the-loop" approach
Cellpose's "Human-in-the-Loop" approach is a workflow designed to make cell labelling more efficient by combining automatic segmentation with interactive label correction and model retraining.

It works in the following steps: 
1. run a cellpose pretrained model to predict cell segmentation on the first image in your dataset.
2. correct segmentations (e.g., add missing cells, correct cell outlines, remove incorrect segments/false positives).
3. retrain the model.
4. apply the model to the next image in the dataset.
5. iterate steps 2 to 4 for remaining images in your dataset.

By applying and iteratively training a model, Cellpose will progressively accuratle predict most object segments and thus reduces the need for exhaustive manual annotations from the user.

**Dataset**
- Hematoxylin and eosin (H&E) stained slides of intestinal tissue were scanned at ...x magnification using nanozoomer.
- Images are .nd format

**Requirements**
- **Training dataset:** Save ~10 representative subimages of intestinal villi in a single folder. The images should: 
    - cover variability in staining, density, brightness
    - contain ~20 villi for segmentation, providing up to 200 toal annotations

**Procedure**
1. Open the Cellpose GUI. If you followed the previous instructions in the [blog post](#qupath-cellpose), in command prompt enter:
```bash
conda activate cellpose3
cellpose
```
2. Drag the first image from your training dataset into the GUI.

```{figure} C:/users/a1230264/bioimaging/_static/cellpose_villi_image.png
---
width: 100%
---
Intestinal villi (hematoxylin stain) in the Cellpose GUI
```

3. Click `run cyto3` and the first prediction of villi will be shown
    - Note, the default `diameter (pixels):` may not be suitable and should be adjusted accord to the expected with of your object. Cellpose is often applied for single cell or nuclear segmentation, but we adapted it to treat each villus as a single "cell-like" object by setting the diameter parameter to `200 pixels`, approximately equal to the villus width.
    - In the GUI, `diameter (pixels)` is shown visually beneath the bottom left corner of the image

```{figure} C:/users/a1230264/bioimaging/_static/cellpose_villi_predict_030pix.png
---
width: 100%
---
"cyto3" model prediction of intestinal villi using 30 pixel diameter
```

```{figure} C:/users/a1230264/bioimaging/_static/cellpose_villi_predict_200pix.png
---
width: 100%
---
"cyto3" model prediction of intestinal villi using 200 pixel diameter
```

4. Correct segmentations.
    - To remove a segmentation hold `Ctrl` and `left click` on it.
    - To draw a segmentation, with the mouse, `right click` (do not hold the button) and draw an outline around missing villi. The origin of the outline will be highlighted by a red circle. Return the cursor to the red circle to finish the segmentation, or `right click` anywhere to end the segmentation (this will draw a straight line from the cursor location to the red circle).
5. Once satisfied with the labels, you will now train the model. From the cellpose GUI menu bar, click `Models > Train new model with image+mask in folder`. The `train settings` dialog box will open.
6. In the right panel you should see the image name, and the number of predicted segmented villi. Update the `model_name` with something meaningful. The default settings for `learning_rate`,`weight_decay` and `n_epochs` should be fine.
7. Click `OK` to begin model training. This should take some time depending on compute resources, image sizes, number of detections etc. 
8. When the model training finished, the next image in your dataset is opened and the model predictions are shown. Repeat steps 4 to 7 on this new image. The model is again updated and predictions will be shown on the third image.
9. Repeat the process for all images in your training dataset.
