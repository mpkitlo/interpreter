int main(){
    int y = 3 + 4;
    int z = 5 + 6;

    int w = y * z;
    int a = y / z;
    int x = y % z;

    bool b1 = false;
    bool b2 = true;

    print(y);
    print(z);
    print(w);
    print(a);
    print(x);

    print(y < z);
    print(y == z);
    print(y > z);
    print(y <= z);
    print(y >= z);

    print(b1 && b2);
    print(b1 || b2);

    return 0;
}