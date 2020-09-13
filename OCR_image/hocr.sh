#!/bin/bash
SOURCE="tesseract/myfiles/"
lang=eng
set -- "$SOURCE"*.jpg
echo i"$1"
echo "hello"
for img_file; do
    echo -e  "\r\n File: $img_file"
    OMP_THREAD_LIMIT=1 tesseract --tessdata-dir tesseract/tessdata  "${img_file}" "${img_file%.*}"  --psm 11  --oem 1  -l $lang -c page_separator='' hocr
    #source venv/bin/activate
    PYTHONIOENCODING=UTF-8 hocr-extract-images -b tesseract/myfiles/ -p "${img_file%.*}"-%03d.exp0.tif  "${img_file%.*}".hocr 
    #deactivate
done
rename s/exp0.txt/exp0.gt.txt/ tesseract/myfiles/*exp0.txt

echo "Image files converted to tif. Correct the ground truth files and then run ocr-d train to create box and lstmf files"
