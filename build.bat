@echo off
REM Activate Conda environment
call "%USERPROFILE%\miniforge3\Scripts\activate.bat" stardist-napari

REM Navigate to your Jupyter Book folder
cd /d C:\Users\bryan\bioimaging

REM Build the Jupyter Book
jupyter-book build .

REM Open the HTML version in the browser
start _build\html\index.html
