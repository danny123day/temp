import tensorflow as tf
import numpy as np
hello = tf.constant('Hello, TensorFlow!')
sess = tf.Session()
#print(sess.run(hello))
#print("ERROR")

x_data = np.random.rand(100).astype(np.float32)
y_data = x_data * 0.1 + 0.3
w = tf.Variable(tf.random_uniform([1],-1.0,1.0))
b = tf.Variable(tf.zeros([1]))
y = w * x_data + b

loss = tf.reduce_mean(tf.square(y - y_data))
optimizer = tf.train.GradientDescentOptimizer(learning_rate = 0.5)
train = optimizer.minimize(loss)

#初始化
init = tf.global_variables_initializer()

#將神經網絡畫出來
sess = tf.Session()
sess.run(init)

#將回歸線係數模擬出來
for i in range(201):
    sess.run(train)
    if i % 20 == 0:
        print(i , sess.run(w) , sess.run(b) )

#關閉Session
sess.close()











