#!/bin/bash

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/inceptionv3_dataset_partitioned/' \
-M 'InceptionV3' \
-T \
-W '../weights/inception_v3_weights_tf_dim_ordering_tf_kernels.h5' \
-O 'sgd' \
-o '../weights/InceptionV3/heat_weights_inceptionv3.h5'\
-H

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/vgg16_dataset_partitioned/' \
-M 'VGG16' \
-T \
-W '../weights/vgg16_weights_tf_dim_ordering_tf_kernels.h5' \
-O 'sgd' \
-o '../weights/VGG16/heat_weights_vgg16.h5' \
-H

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/resnet50_dataset_partitioned/' \
-M 'ResNet50' \
-T \
-W '../weights/resnet50_weights_tf_dim_ordering_tf_kernels.h5' \
-O 'sgd' \
-o '../weights/ResNet50/heat_weights_resnet50.h5'\
-H

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/daveii_dataset_partitioned/' \
-M 'DaveII' \
-W '../weights/DaveII/regular_weights_daveii.h5' \
-O 'sgd' \
-o '../weights/DaveII/heat_weights_daveii.h5' \
-H

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/vgg16_dataset_partitioned/' \
-M 'VGG16' \
-W '../weights/vgg16_weights_tf_dim_ordering_tf_kernels.h5' \
-O 'sgd' \
-o '../weights/VGG16/heat_endtoend_weights_vgg16.h5' \
-H

python3 train.py -D '/media/scope/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/resnet50_dataset_partitioned/' \
-M 'ResNet50' \
-W '../weights/ResNet50/heat_endtoend_weights_resnet50.h5' \
-O 'sgd' \
-o '../weights/ResNet50/heat_endtoend_weights_resnet50.h5' \
-H

python3 train.py -D '/media/burrussmp/99e21975-0750-47a1-a665-b2522e4753a6/ILSVRC2012/daveii_dataset_partitioned/' \
-M 'DaveII' \
-O 'sgd' \
-o '../weights/DaveII/regular_rbf.h5' \
-H