#include <stdio.h>
#include <unistd.h>
#include <iostream>
#include <jni.h>
#include "com_magc_jni_HelloWorld.h"
#include <stdio.h>

#include "a.h"

JNIEXPORT void JNICALL Java_com_magc_jni_HelloWorld_DisplayHello (JNIEnv *env, jobject obj)
{
    printf("From jni_helloworldImpl.cpp :");
    printf("Hello world ! \n");
    usleep(1200*1000*1000);
    test();
    return;
}

void jni_callback(int i)
{
    std::cout<<"#@@## int i" <<i <<std::endl;
    return;
}

jint OnLoad( JavaVM * pJavaVM, void * reserved )
{
    printf("önload\n");
    return JNI_VERSION_1_8;
}

