
#include <thread>
#include <iostream>
#include "a.h"

using namespace std;

extern "C"  void jni_callback(int i);

void callback(int i) {
    jni_callback(i);
    return;
}


void test(){
    cout<<__FUNCTION__<<endl;
    thread t = thread([&](){
            cout<<"thread running"<<endl;
            callback(3);
            }
            );
    t.join();
}

