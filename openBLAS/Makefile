libmylib.so :test_cblas_dgemm.s test_cblas_dgemm.c
	gcc -shared -fPIC -o libmylib.so test_cblas_dgemm.c -I /usr/include/openblas -lopenblas
test_cblas_dgemm.s : test_cblas_dgemm.c
	gcc -fPIC -o test_cblas_dgemm.s test_cblas_dgemm.c -I /usr/include/openblas -lopenblas
