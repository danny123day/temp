import tensorflow as tf 

input1 = tf.placeholder(tf.float32)
input2 = tf.placeholder(tf.float32)
output = tf.multiply(input1 , input2)


sess = tf.Session() 
print(sess.run([output], feed_dict = {input1: [7], input2: [3]}))
print(sess.run([output], feed_dict = {input1: [[4,2]], input2: [[3],[3]]}))
print([output])

input1 = tf.constant([3])
input2 = tf.constant([5])
added = tf.add(input1, input2)
multiplied = tf.multiply(input1, input2)
result = sess.run([added , multiplied])
print(result)



