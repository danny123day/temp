import tensorflow as tf 

state = tf.Variable(0,name = "counter")

#每次更新後加1
one = tf.constant(1)
new_value = tf.add(state , one)
update = tf.assign(state , new_value)

init_op = tf.global_variables_initializer()
sess = tf.Session()
sess.run(init_op)

print(sess.run(state))
for i in range(3) :
    sess.run(update)
    print(sess.run(state))

sess.close()
print("range(3):",range(3))