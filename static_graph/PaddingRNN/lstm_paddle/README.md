# lstm language_model

## 简介

循环神经网络语言模型的介绍可以参阅论文[Recurrent Neural Network Regularization](https://arxiv.org/abs/1409.2329)，本文主要是说明基于lstm的语言的模型的实现，数据是采用ptb dataset，下载地址为
http://www.fit.vutbr.cz/~imikolov/rnnlm/simple-examples.tgz

## 数据下载
用户可以自行下载数据，并解压， 也可以利用目录中的脚本

cd data; sh download_data.sh

## 训练

运行命令
`CUDA_VISIBLE_DEVICES=0 python  train.py --data_path data/simple-examples/data/  --model_type large --use_gpu True`
 开始单卡训练模型。

运行命令
`CUDA_VISIBLE_DEVICES=0 python  train.py --data_path data/simple-examples/data/  --model_type large --use_gpu True --inference_only True`
model_type 为模型配置的大小，目前支持 small，medium, large 三种配置形式
开始单卡预测

实现采用双层的lstm，具体的参数和网络配置 可以参考 train.py， lm_model.py 文件中的设置


## 与tf结果对比

tf采用的版本是1.12

large config



|         |单卡训练速度|单卡训练显存占用（最大batchsize)|单卡GPU预测速度（batch_size=1)|单卡GPU预测显存占用(batch_size=1)|
| --------   | -----:   | :----: |:----: |:----: |
|fluid dev|146/epoch|500|236s|6121MB|
|tf 1.12  |83/epoch|1642|46s|1095MB|
