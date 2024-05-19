void incRef(int &a){
    a = a + 1;
}

void incVal(int a){
    a = a + 1;
    print(a);
}

int main(){
    int a = 0;
    incRef(a);
    print(a);
    incVal(a);
    print(a);

    return 0;
}