import tensorflow as tf
print("------------part1------------")
#part1
#1x2矩陣
matrix1 = tf.constant([[3, 3]])
#2x1矩陣
matrix2 = tf.constant([[2],[4]])

sess = tf.Session()
print(sess.run(matrix1))
print(sess.run(matrix2))
product = tf.matmul(matrix1,matrix2)
print(sess.run(product))

print("------------part2------------")
#part2
sess = tf.InteractiveSession()
#1x2矩陣
matrix1 = tf.Variable([[3, 3]])
#2x1矩陣
matrix2 = tf.constant([[2],[4]])
#初始化matrix1
matrix1.initializer.run()
result = tf.matmul(matrix1 , matrix2)
print(result.eval())
#啟動
with tf.Session() as sess:
    result = sess.run([product])
    print(result)

sess.close()

    