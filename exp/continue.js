i = 0
while (i < 3) {
    p(1);
    i = i + 1;
    if (i < 3) continue;
    p(2);
    break;
}
p(3);
