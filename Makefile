
clean:
	rm -rf *.so *.o *.a ./shared ./static

.PHONY:compilejava
compilejava:
	#generate .class file
	javac com/magc/jni/HelloWorld.java
	#generate jni .h file
	javah com.magc.jni.HelloWorld
	#java -Djava.library.path=.  com.magc.jni.HelloWorld

all: compilejava
	g++ -std=c++11 -shared -fPIC a.cpp -o liba.so
	g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   jni_helloworldImpl.cpp   -o libHello.so  -L ./  -l:liba.so
	#g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   jni_helloworldImpl.cpp   -o libHello.so  -L ./  -la
	java -Djava.library.path=.  com.magc.jni.HelloWorld

testshared:
	mkdir -p static shared

	gcc -std=c++11 -fPIC -c -o shared/a.o a.cpp
	gcc -std=c++11 -shared -o shared/liba.so  shared/a.o

	g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   jni_helloworldImpl.cpp   -o shared/libHello.so  -L ./shared  -l:liba.so
	export LD_LIBRARY_PATH=./:./shared/  &&  java -Djava.library.path=.:shared/  com.magc.jni.HelloWorld


teststatic:
	mkdir -p static shared
	gcc -std=c++11 -fPIC -c -o static/a.o a.cpp
	ar rcs static/liba.a static/a.o

	#g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   jni_helloworldImpl.cpp   -o static/libHello.so  -L ./static  -la
	#g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   -o static/libHello.so  jni_helloworldImpl.cpp static/liba.a
	g++ -shared -fPIC -I /home/tony/bin/jdk1.8.0_152/include  -I /home/tony/bin/jdk1.8.0_152/include/linux   jni_helloworldImpl.cpp   -o static/libHello.so  -L ./static  -la
	export LD_LIBRARY_PATH=./:./static/  &&  java -Djava.library.path=.:static/  com.magc.jni.HelloWorld

