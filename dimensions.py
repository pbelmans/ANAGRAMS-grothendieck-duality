import math
import sys

# dimension of projective space
n = int(sys.argv[1])
degrees = list(range(-1, n+2))
twists = list(range(-3-2*n, 3+n))

def binomial(n, r):
  if n < 0 or r < 0 or (n - r) < 0:
    return 0
  return math.factorial(n) / (math.factorial(r) * math.factorial(n-r))

print "\\begin{tabular}{c|", "c" * len(degrees), "}"

# r is Serre twist indexing
for r in reversed(twists):
  # show the twist on the left
  print r, " & ",

  # i is cohomological indexing
  for i in degrees:
    if i == 0:
      print binomial(n+r, r),
    elif i == n:
      print binomial(-r-1, -n-r-1),
    else:
      print 0,
    if i != degrees[-1]: print " & ", 
    else: print "\\\\",

  print "\n",

print "\\hline"
print "\\diagbox[dir=NE]{$r$}{$i$} ",
# show the degrees on the bottom
for i in degrees:
  print " & ", i,

print "\\end{tabular}"
