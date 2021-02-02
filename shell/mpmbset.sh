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
bcprog="scale=10
define f(cr,ci) {
  auto n,r,c,tmpr,tmpc;
  n=0;
  r=0.0;
  c=0.0;
  while (r*r+c*c<30) {
    tmpr=r*r-c*c+cr;
    tmpc=2*r*c+ci;
    r=tmpr;
    c=tmpc;
    n=n+1;
    if (n>255)
      return(256);
  }
  return(n);
}
define g(l,r,t,b,nx,ny,dx,dy) {
  auto sx,sy,cr,ci,x,y;
  sx = (r - l) / (2 * nx);
  sy = (b - t) / (2 * ny);
  ci = t;
  for (y = 0; y < ny; ++y) {
    cr = l;
    for (x = 0; x < nx; ++x) {
      print f(cr+dx*sx,ci+dy*sy), \"\\n\";
      cr += 2 * sx;
    }
    ci += 2 * sy;
  }
}
g($l,$r,$t,$b,$nx,$ny,%s,%s)"

prog1=$(printf "$bcprog" 0 0)
prog2=$(printf "$bcprog" 1 0)
prog3=$(printf "$bcprog" 0 1)
prog4=$(printf "$bcprog" 1 1)

paste <(echo "$prog1" | bc) <(echo "$prog2" | bc) <(echo "$prog3" | bc) <(echo "$prog4" | bc) |
while read a b c d; do
  if [ -z "$b" ]; then break; fi
  idx=0
  if [ $a -lt 256 ]; then
    idx=$(($idx + 1))
  fi
  if [ $b -lt 256 ]; then
    idx=$(($idx + 2))
  fi
  if [ $c -lt 256 ]; then
    idx=$(($idx + 4))
  fi
  if [ $d -lt 256 ]; then
    idx=$(($idx + 8))
  fi
  printf '%s' "${blocks[$idx]}"
  n=$(($n + 1))
  if [ $n -eq $nx ]; then printf '\n'; n=0; fi
done
