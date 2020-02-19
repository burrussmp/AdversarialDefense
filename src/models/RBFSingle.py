
import keras.backend as K
import numpy as np
import keras
from keras.models import Model,load_model
from keras.layers import Dense, Dropout, Activation, Flatten, BatchNormalization,Lambda
from keras.layers import Conv2D, MaxPooling2D,Input,AveragePooling2D
import os
import cv2
from .RBFLayer import RBFLayer
from .ResNetLayer import ResNetLayer
from .Losses import RBF_Soft_Loss,RBF_Loss,DistanceMetric,RBF_LAMBDA
from keras.callbacks import ModelCheckpoint, LearningRateScheduler, TensorBoard, EarlyStopping, History,ReduceLROnPlateau
from keras.preprocessing.image import ImageDataGenerator


class RBFSingle():
    def __init__(self,input_shape=(1024),output=43):
        inputs = Input(shape=input_shape)
        dense = Dense(input_shape,activation='tanh')(inputs)
        outputs = RBFLayer(output,0.5)(dense)
        model = Model(inputs=output, outputs=outputs)
        model.compile(loss=RBF_Soft_Loss,optimizer=keras.optimizers.Adam(),metrics=[DistanceMetric])
        self.model = model


    def predict(self,X):
        predictions = self.model.predict(X)
        lam = RBF_LAMBDA
        Ok = np.exp(-1*predictions)
        top = Ok*(1+np.exp(lam)*Ok)
        bottom = np.prod(1+np.exp(lam)*Ok,axis=1)
        predictions = np.divide(top.T,bottom).T
        return predictions

    def train(self,X,Y,saveTo,epochs=100):
        def lr_schedule(epoch):
            lr = 1e-3
            if epoch > 180:
                lr *= 0.5e-3
            elif epoch > 160:
                lr *= 1e-3
            elif epoch > 120:
                lr *= 1e-2
            elif epoch > 80:
                lr *= 1e-1
            print('Learning rate: ', lr)
            return lr
        lr_scheduler = LearningRateScheduler(lr_schedule)
        lr_reducer = ReduceLROnPlateau(factor=np.sqrt(0.1),
            cooldown=0,
            patience=5,
            min_lr=0.5e-6)
        checkpoint = ModelCheckpoint(saveTo, monitor='DistanceMetric', verbose=1, save_best_only=True, save_weights_only=False, mode='max', period=1)
        callbacks = [checkpoint, lr_reducer, lr_scheduler]
        datagen = ImageDataGenerator()
        idx = int(0.8*(Y.shape[0]))-1
        indices = np.arange(X.shape[0])
        training_idx = np.random.choice(indices,idx,replace=False)
        validation_idx = np.delete(indices,training_idx)
        x_train = X[training_idx]
        y_train = Y[training_idx]
        x_test = X[validation_idx]
        y_test = Y[validation_idx]
        # Fit the model on the batches generated by datagen.flow().
        self.model.fit_generator(datagen.flow(x_train, y_train, batch_size=16),
                            validation_data=(x_test, y_test),
                            epochs=epochs, verbose=1,steps_per_epoch=int(Y.shape[0]/16),
                            callbacks=callbacks)

    def load(self,weights):
        self.model = load_model(weights, custom_objects={'RBFLayer': RBFLayer,'DistanceMetric':DistanceMetric,'RBF_Soft_Loss':RBF_Soft_Loss})

    def evaluate(self,X,Y):
        predictions = self.predict(X)
        accuracy = np.sum(np.argmax(predictions,axis=1) == np.argmax(Y, axis=1)) / len(Y)
        print('The accuracy of the model: ', accuracy)
        print('Number of samples: ', len(Y))

    def reject(self,X):
        predictions = self.model.predict(X)
        lam = RBF_LAMBDA
        Ok = np.exp(-1*predictions)
        bottom = np.prod(1+np.exp(lam)*Ok,axis=1)
        return 1.0/bottom