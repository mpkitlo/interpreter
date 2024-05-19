int x;

void set(int y) {
    x = y;
}

void print_x(){
    print(x);
}

int main() {
    int x = 5;

    print(x);

    set(10);

    print(x);

    print_x();

    return 0;
}