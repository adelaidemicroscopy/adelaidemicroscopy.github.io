
# Running your own StarDist3D model in napari {#stardist-napari}
## Requirements
You should have already performed the following:
- Installed Miniforge per this post.
- Trained your own StarDist model per this post {in preparation} (optional if you plan to use the pre-trained model).
- Installed Git (download at: <https://git-scm.com/downloads/win>)

## 1 Install napari with StarDist plugin
We will create a new conda environment to run StarDist as a napari plugin.

**1.1** Create a custom Conda environment `stardist-napari`
Enter the following command in the Miniforge Prompt and press {kbd}`Enter`:
```bash
mamba create -n stardist-napari python=3.8 pip cudatoolkit=11.2 cudnn=8.1.0 -y
```
This process may take a few minutes while downloading and extracting the required packages. 

**1.2** Activate the environment
```bash
mamba activate stardist-napari
```

The Miniforge Prompt will change from `(base) C:\...>` to `(stardist-napari) C:\...` or similar

**1.3** Install the specified versions of TensorFlow, NumPy and Napari that are compatible for running StarDist with GPU support. In the Miniforge Prompt, enter each command line-by-line and press `enter`.
```bash
pip install tensorflow==2.10
pip install numpy==1.23.5
pip install "napari[all]==0.4.18"
```

**1.4** Confirm that Tensorflow can detect the system GPU 
In the active `stardist-napari` environment, run the following Python code:
```python
python -c "import tensorflow as tf; print('Num GPUs Available:', len(tf.config.list_physical_devices('GPU'))); print(tf.config.list_physical_devices('GPU'))"
```

✅**Expected output (if the GPU is detected):**
```bash
Num GPUs Available: 1
[PhysicalDevice(name='/physical_device:GPU:0', device_type='GPU')]
```

❌**If GPU is not detected:**
```bash
Num GPUs Available: 0
[]
```

**1.5** StarDist plugin installation in napari (git required)
Enter the following command to install the StarDist plugin in the napari environment:
```bash
pip install git+https://github.com/stardist/stardist-napari.git
```

**1.6** Open napari
You can open the napari GUI using the following command:
```bash
napari
```

```{figure} C:/users/a1230264/bioimaging/images/napari-gui.png
---
width: 100%
---
napari GUI
```

### 2 Testing the stardist-napari plugin with a pre-trained model
If installed correctly, StarDist (including pretrained models and sample data) should be included when you open napari. 

We will run a pre-trained model and our own model on a sample image to test our installation.

**2.1** In napari, open the sample image from the menu `File > Open Sample > stardist-napari > Nuclei (3D)`

**2.2** Open the stardist-napari plugin from the menu `Plugins > StarDist (stardist-napari)`

```{figure} C:/users/a1230264/bioimaging/images/napari-gui-stardist.png
---
width: 100%
---
StarDist sample data and napari plugin
```

**2.3** In the StarDist sidepanel, set the below parameters as follows:
- Input Image: `nuclei_3D`
- Model Type: `3D`
- Pre-trained Model: `3D_demo`
- Output Type: `Both`
- click `Set optimized postprocessing thresholds (for selected model)` to update the NMS Postprocessing parameters.

**2.4** Click `Run` to produce the StarDist labels and polyhedra
Cell labels (one colour per cell) will appear on the `nuclei_3D` image as below. You can view these both in 2D and 3D by clicking the `Toggle ndisplay` button (second button in the bottom left panel, or press {kbd}`Ctrl+Y`).

```{figure} C:/users/a1230264/bioimaging/images/napari-gui-stardist-label-image.png
---
width: 100%
---
StarDist3D nuclear labels predicted on demo image
```

### 3 Running the stardist-napari plugin with your own trained model
We can perform nuclear segmentation using our own trained StarDist model as created in the previous post.

**3.1** In the StarDist sidepanel, set the below parameters as follows:
- Input Image: `nuclei_3D`
- Model Type: `Custom 2D/3D`
- Pre-trained Model: Click `Choose directory`, in the dialog window navigate to the trained model, e.g. `D:\adelaidemicroscopy\stardist3d\models\example_model\` and click `Select Folder`
- click `Set optimized postprocessing thresholds (for selected model)` to update the NMS Postprocessing parameters.

**3.2** Click `Run` to produce the StarDist labels and polyhedra
<!-- INSERT FIGURE TO SHOW IMAGE OF NAPARI + stardist side panel for model custom 3D -->
<!-- INSERT FIGURE TO SHOW IMAGE OF NAPARI + labeled image data in 2D and 3D -->

Note that my model did not do as good a job as the 3D_demo model.


## What is next?
Now that you have nice segmentation of cell nuclei you might be interested in performing quantitative analysis on these objects.

See this post

## Concluding Remarks
By following these instructions you:

1. installed compatible CUDA and CUDnn libraries that allow TensorFlow 2.10 to run operations on your NVIDIA GPU. 
2. installed miniforge and navigated the `Miniforge Prompt` to manage Python environments on your device
3. successfully created custom Python environments `stardist-train` and `stardist-napari` for training and applying custom 2D and 3D stardist models on your local device GPU
  These environment used:
  - python 3.8
  - tensorflow 2.10
  - stardist 0.8.5
  - numpy 1.23.5
  - gputools 0.2.15 (`stardist-train` only)
  - napari 0.4.18 (`stardist-napari` only)
4. in the `stardist-train` environment, ran the example stardist Jupyter Notebooks to train and evaluate your own stardist models on demo data
5. in the `stardist-napari` environment, opened the napari GUI, installed the `stardist-napari 2024.8.6.1` plugin, and applied pre-trained and your own custom stardist models for nuclei segmentation on the sample image

To see how Adelaide Microscopy have used stardist for researcher data visit the blog


To apply this to your own dataset, check out the post LINK for instructions on test/train data annotation and example case from our lab. Including how to perform measurementson the data.


## References

### Step 1 CUDA
1. Download and install the `CUDA Toolkit for Windows 10` via the link <https://developer.nvidia.com/cuda-11.2.2-download-archive?target_os=Windows&target_arch=x86_64&target_version=10&target_type=exenetwork>

### Step 2 cuDNN
1. A Nvidia Developer account is required to download cuDNN. Sign-up here <https://developer.nvidia.com/login>
2. Visit the link ...
3. Unzip the cuDNN archive and copy the files into the CUDA installation directory, e.g. `C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2`
4. Restart your computer

### Step 5
Some conflicts exist between different versions of Tensorflow, Python, CUDA and others. I suggest that you install the specific versions of packages as described in the instructions below.
1. Create the `stardist` conda environment
Open the anaconda prompt `Start > Anaconda Prompt`, and type the following:
```bash
conda create -n stardist python==3.10
```
When conda asks you to proceed, type `y` and hit `Enter`.

2. Activate

Create a StarDist conda environment

```{warning}
It is recommended that you install that package versions as listed. Compatibility issues can occur if package versions are not carefully matched, e.g. TensorFlow does not detect the GPU. If you are experiencing issues, create the `stardist-train` environment using the below `stardist-train.yml` file.
```

To install from the requirements file, create your `stardist-train` environment as above by typing the following command in the Miniforge Prompt and press {kbd}`Enter`:
```bash
mamba create -n stardist-train python=3.8 pip cudatoolkit=11.2 cudnn=8.1.0 -y
```

Then activate the environment:



To recrea
To run the 3D StarDist notebook locally, it is important that the correct packages are installed.



```bash
mamba create -n napari-stardist python=3.8 pip cudatoolkit=11.2 cudnn=8.1.0 -y
mamba activate napari-stardist
```
```
pip install tensorflow==2.10
pip install "numpy>=1.20,<1.24"
pip install stardist==0.8.5
pip install "napari[all]==0.4.18"
```






Let's point our shell
```bash
jupyter notebook --notebook-dir=D:/
```


## Pitfalls
<!-- This section describes pitfalls I encountered in my analysis -->
E.g., applying the model to the incorrect image type


THE FOLLOWING INSTRUCTIONS ARE OLD AND MAY PRODUCE A HTTP ERROR
You can open the napari GUI using the following command:
```bash
napari
```

- To install the StarDist plugin, click on the menu `Plugins > Install/Uninstall Plugins...`
- In the dialog box, search for 'stardist'
- Click the `Install` button next to the package called `stardist-napari`

<!-- INSERT FIGURE TO SHOW IMAGE OF NAPARI and INSTALL DIALOG BOX pointing to stardist-napari -->

- Close napari and reopen by entering `napari` at the Miniforge prompt
