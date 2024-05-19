int nat(int a){
    print(a);
    if(a == 0){
        return 0;
    }
    nat(a-1);

    return 0;
}

int main(){
    nat(10);

    return 0;
}