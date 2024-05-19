void print_1() {
    print("1");
}

int main() {
    void print_1() {
        print("2");
    }

    print_1();

    return 0;
}