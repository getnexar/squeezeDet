#!/bin/bash

export USE_GPU=0

if [ $# -eq 0 ]
then
  echo "[ERROR] Missing an argument; please specify the model to use. Use -h or --help for more detailed usage instructions."
fi

while test $# -gt 0; do
  case "$1" in
    -h|--help)
      echo "Usage: ./scripts/train.sh (squeezeDet|squeezeDet+|resnet50) [options]"
      echo " "
      echo "options:"
      echo "-h, --help                show brief help"
      echo "-gpu                      run with gpu"
      exit 0
      ;;
    -gpu)
      shift
      export USE_GPU=1
      shift
      ;;
    *)
      break
      ;;
  esac
done

# =========================================================================== #
# command for squeezeDet:
# =========================================================================== #
if [[ "$1" == "squeezeDet" ]]
then
  python ./src/train.py \
  --dataset=NEXAREAR \
  --pretrained_model_path=/opt/data/NEXAREAR/pretrained_models/squeezenet_v1.1.pkl \
  --data_path=/opt/data/NEXAREAR \
  --image_set=train \
  --train_dir=/opt/logs/NEXAREAR/SqueezeDet/train \
  --net=squeezeDet \
  --summary_step=100 \
  --checkpoint_step=500 \
  --gpu=$USE_GPU
fi

# =========================================================================== #
# command for squeezeDet+:
# =========================================================================== #
if [[ "$1" == "squeezeDet+" ]]
then
  python ./src/train.py \
  --dataset=NEXAREAR \
  --pretrained_model_path=/opt/data/NEXAREAR/pretrained_models/squeezenet_v1.0_SR_0.750.pkl \
  --data_path=/opt/data/NEXAREAR \
  --image_set=train \
  --train_dir=/opt/logs/NEXAREAR/SqueezeDetPlus/train  \
  --net=squeezeDet+ \
  --summary_step=100 \
  --checkpoint_step=500 \
  --gpu=$USE_GPU
fi

# =========================================================================== #
# command for resnet50:
# =========================================================================== #
if [[ "$1" == "resnet50" ]]
then
  python ./src/train.py \
  --dataset=NEXAREAR \
  --pretrained_model_path=/opt/data/NEXAREAR/pretrained_models/ResNet-50-weights.pkl  \
  --data_path=/opt/data/NEXAREAR \
  --image_set=train \
  --train_dir=/opt/logs/NEXAREAR/ResNet50/train  \
  --net=resnet50 \
  --summary_step=100 \
  --checkpoint_step=500 \
  --gpu=$USE_GPU
fi