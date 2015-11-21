# create a list of prime factors 
class PrimeFactorizer:
    def __init__(self, n):
        self.n = n
        self.factor = []
        d = 2
        while self.n > 1:
            while self.n % d == 0:
                self.n /= d
                self.factor.append(d)
            d += 1
            if d*d > self.n:
                if self.n > 1:
                    self.factor.append(self.n)
                break
