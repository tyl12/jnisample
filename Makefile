all:
	g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux jni_helloworldImpl.cpp -o libHello.so
	g++ -std=c++11 -shared -fPIC a.cpp -o a.so
	java -Djava.library.path=. com.magc.jni.HelloWorld
