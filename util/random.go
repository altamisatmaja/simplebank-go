package util

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

const alphabet = "abcdefghijklmnopqrstuvwxyz"

func init() {
	rand.Seed(time.Now().UnixNano())
}

func RandomInt(min, max int64) int64 {
	return min + rand.Int63n(max-min+1)
}

func RandomString(n int) string {
	var sb strings.Builder
	k := len(alphabet)

	for i := 0; i < n; i++ {
		c := alphabet[rand.Intn(k)]
		sb.WriteByte(c)
	}

	return sb.String()
}

func RandomOwnerName() string {
	return RandomString(5)
}

func RandomMoney() int64 {
	return RandomInt(0, 10000)
}

func RandomCurrency() string {
	currencies := []string{EUR, USD, IDR}

	n := len(currencies)
	return currencies[rand.Intn(n)]
}

// generate email
func RandomEmail() string {
	return fmt.Sprintf("%s@email.com", RandomString(6))
}
