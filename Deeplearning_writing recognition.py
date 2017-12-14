import numpy as np
import tensorflow as tf
import matplotlib.pyplot as plt
from tensorflow.examples.tutorials.mnist import input_data


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
print(type(mnist))
print(mnist.train.num_examples)
print(mnist.test.num_examples)
print(mnist.validation.num_examples)

print("-------------------------------------")
train_img = mnist.train.images
train_label = mnist.train.labels
test_img = mnist.test.images
test_label = mnist.test.labels
print(" train_img 的 type : %s" % (type(train_img)))
print(" train_img 的 dimension : %s" % (train_img.shape,))
print(" train_label 的 type : %s" % (type(train_label)))
print(" train_label 的 dimension : %s" % (train_label.shape,))
print(" test_img 的 type : %s" % (type(test_img)))
print(" test_img 的 dimension : %s" % (test_img.shape,))
print(" test_label 的 type : %s" % (type(test_label)))
print(" test_label 的 dimension : %s" % (test_label.shape,))

trainimg = mnist.train.images
trainlabel = mnist.train.labels
print(trainlabel)
#nsample = 1
#randidx = np.random.randint(trainimg.shape[0],size = nsample)
#print(randidx)
# for i in [0,1,2,3,4,5,6]:
#     curr_img = np.reshape(trainimg[i,:],(28,28))
#     curr_label = np.argmax(trainlabel[i,:])
#     plt.matshow(curr_img,cmap = plt.get_cmap('Greens'))
#     plt.title("" + str(i + 1)+ "th Training Data" + "Label is " + str(curr_label))
#     plt.show()

learning_rate = 0.5
x = tf.placeholder(tf.float32, [None, 784])
print(x)
W = tf.Variable(tf.zeros([784, 10]))
b = tf.Variable(tf.zeros([10]))
y = tf.nn.softmax(tf.matmul(x, W) + b)
y_ = tf.placeholder(tf.float32 , [None , 10])
cross_entropy = tf.reduce_mean(-tf.reduce_sum(y_ * tf.log(y), reduction_indices=[1]))
train_step = tf.train.GradientDescentOptimizer(learning_rate).minimize(cross_entropy)

init = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init)
for i in range(1000):
    batch_xs, batch_ys = mnist.train.next_batch(100)
    sess.run(train_step, feed_dict = {x: batch_xs, y_: batch_ys})
correct_prediction = tf.equal(tf.argmax(y,1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))
print(sess.run(accuracy, feed_dict={x: mnist.test.images, y_: mnist.test.labels}))
sess.close()




