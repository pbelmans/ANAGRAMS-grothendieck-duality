# dimension of the projective space
n = 9
# degrees of the defining polynomials
m = [2, 2, 2, 2, 2, 2]

R.<t> = PowerSeriesRing(ZZ)

# compute the Hilbert series for a complete intersection of degrees m in PG(n, k)
def Hilbert(n, m, prec = 20):
  H = 1 / (1-t.O(prec))**(n+1)
  for mi in m: H = H * (1 - t**mi)
  return H

# compute N, where N is the number in FAC related to the degrees m
def N(n, m):
  return sum([mi for mi in m]) - n - 1

# compute h^q(X, O_X(r)) of a complete intersection of degrees m in PG(n, k)
def h(n, m, q, r):
  assert len(m) <= n

  # global sections: we can compute this
  if q == 0:
    # zero-dimensional schemes require some magic for the Hilbert function
    if n - len(m) == 0:
      return reduce(lambda mi, mj: mi * mj, m)

    # compute the dimension of the global sections from the Hilbert function
    if r >= 0:
      return Hilbert(n, m, prec = r + 1).padded_list()[r]
    # no global sections, negative Serre twist
    else:
      0

  # apply Serre duality
  elif q == n - len(m):
    return h(n, m, 0, N(n, m) - r)

  # nothing in the middle terms
  return 0

for r in reversed(range(-6, 7)):
  for q in range(-1, n - len(m) + 2):
    print h(n, m, q, r), " ",
  print ""
