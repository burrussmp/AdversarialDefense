echo "hi"

python3 generate_heatmap_dataset.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/inceptionv3_dataset_partitioned' \
-A 'FGSM' \
-M 'InceptionV3' \
-W '../weights/InceptionV3/regular_weights_inceptionv3.h5'

python3 generate_heatmap_dataset.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/vgg16_dataset_partitioned' \
-A 'FGSM' \
-M 'VGG16' \
-W '../weights/VGG16/regular_weights_vgg16.h5'

python3 generate_heatmap_dataset.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/daveii_dataset_partitioned' \
-A 'FGSM' \
-M 'DaveII' \
-W '../weights/DaveII/regular_weights_daveii.h5'

python3 generate_heatmap_dataset.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/resnet50_dataset_partitioned' \
-A 'FGSM' \
-M 'ResNet50' \
-W '../weights/ResNet50/regular_weights_resnet50.h5'

python3 generate_heatmap_dataset.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/vgg16_dataset_partitioned' \
-A 'FGSM' \
-M 'VGG16' \
-W '../weights/VGG16/regular_endtoend_weights_vgg16.h5'