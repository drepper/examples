#!/bin/bash
l=-1.5
r=1.0
t=1.0
b=-1.0

nx=$(($(tput cols) - 1))
ny=$(($(tput lines) - 1))

blocks=(' ' '▘' '▝' '▀' '▖' '▌' '▞' '▛' '▗' '▚' '▐' '▜' '▄' '▙' '▟' '█')

bcprog="scale=10
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
define g(l,r,t,b,nx,ny,dx,dy) {
  auto sx,sy,cr,ci,x,y;
  sx = (r - l) / (2 * nx);
  sy = (b - t) / (2 * ny);
  ci = t+dy*sy;
  for (y = 0; y < ny; ++y) {
    cr = l+dx*sx;
    for (x = 0; x < nx; ++x) {
      print f(cr,ci), \"\\n\";
      cr += 2*sx;
    }
    ci += 2*sy;
  }
}
g($l,$r,$t,$b,$nx,$ny,%s,%s)
"

n=0
clear
paste <(printf "$bcprog" 0 0 | bc) <(printf "$bcprog" 1 0 | bc) <(printf "$bcprog" 0 1 | bc) <(printf "$bcprog" 1 1 | bc) |
while read a b c d; do
  if [ -z "$b" ]; then break; fi
  idx=$(($a / 256 + ($b / 256) * 2 + ($c / 256) * 4 + ($d / 256) * 8))
  printf '%s' "${blocks[$idx]}"
  n=$(($n + 1))
  if [ $n -eq $nx ]; then printf '\n'; n=0; fi
done
