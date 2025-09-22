```{admonition} 🛠️ TensorFlow GPU Troubleshooting Checklist
:class: warning

Check if TensorFlow detects your GPU:

```bash
python -c "import tensorflow as tf; print('GPUs:', tf.config.list_physical_devices('GPU'))"
```

### ✅ Checklist

- ✅ **GPU is installed and recognized by the system**
  - Run `nvidia-smi`
  - Should return GPU details. If it fails, check your NVIDIA driver.

- ✅ **Correct NVIDIA driver is installed**
  - Match the driver version with your CUDA version (e.g., CUDA 11.2 → Driver ≥ 460.x)
  - Download from [NVIDIA's website](https://www.nvidia.com/Download/index.aspx)

- ✅ **CUDA and cuDNN are installed (or provided via conda)**
  - If using `conda`, installing `cudatoolkit` and `cudnn` is usually sufficient
  - Check versions:
    - `cudatoolkit=11.2`
    - `cudnn=8.1.0`

- ✅ **TensorFlow version is GPU-compatible**
  - Use `tensorflow==2.10` for CUDA 11.2/cuDNN 8.1.0
  - Confirm GPU support:
    ```python
    from tensorflow.python.client import device_lib
    print(device_lib.list_local_devices())
    ```

- ✅ **Environment activation**
  - Ensure you're in the correct conda/mamba environment:
    ```bash
    conda activate stardist-gpu
    ```

- ✅ **No conflicting installations**
  - Avoid mixing pip/conda CUDA installs outside managed environments

- ✅ **Reboot if needed**
  - After (re)installing drivers or CUDA

### ❌ Common Issues

- ❌ `nvidia-smi` fails → Driver not installed or incompatible
- ❌ No GPUs listed → TensorFlow not compiled for GPU, or driver/CUDA mismatch
- ❌ Runtime errors → Version mismatch or bad installation

```
