#!/bin/bash
l=-1.5
r=1.0
t=1.0
b=-1.0

nx=$(($(tput cols) - 1))
ny=$(($(tput lines) - 1))

blocks=(' ' '▘' '▝' '▀' '▖' '▌' '▞' '▛' '▗' '▚' '▐' '▜' '▄' '▙' '▟' '█')
n=0

clear
cat <<EOF |
scale=10
define f(cr,ci) {
  auto n,r,c,tmp;
  n=0;
  r=0.0;
  c=0.0;
  while (r*r+c*c<4 && ++n < 256) {
    tmp=r*r-c*c+cr;
    c=2*r*c+ci;
    r=tmp;
  }
  return(n);
}
define g(l,r,t,b,nx,ny) {
  auto sx,sy,cr,ci,x,y;
  sx = (r - l) / (2 * nx);
  sy = (b - t) / (2 * ny);
  ci = t;
  for (y = 0; y < ny; ++y) {
    cr = l;
    for (x = 0; x < nx; ++x) {
      print f(cr,ci), " ", f(cr+sx,ci), " ", f(cr,ci+sy), " ", f(cr+sx,ci+sy), "\n";
      cr += 2*sx;
    }
    ci += 2*sy;
  }
}
g($l,$r,$t,$b,$nx,$ny)
EOF
bc |
while read a b c d; do
  if [ -z "$b" ]; then break; fi
  idx=$(($a / 256 + ($b / 256) * 2 + ($c / 256) * 4 + ($d / 256) * 8))
  printf '%s' "${blocks[$idx]}"
  n=$(($n + 1))
  if [ $n -eq $nx ]; then printf '\n'; n=0; fi
done
