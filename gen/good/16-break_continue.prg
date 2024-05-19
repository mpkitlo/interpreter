int break_e(){
    int x;
    x = 0;

    while(true){
        if(x == 10){break;}
        x = x + 1;
    }

    return x;
}

int continue_e(){
    int x;
    x = 0;

    while(true){
        if(x == 20){break;}
        if(x >= 10){
            x = x + 1;
            continue;
        }
        if(x == 10){break;}
        x = x + 1;
    }

    return x;
}

int main(){
    print(break_e());

    print(continue_e());

    return 0;
}