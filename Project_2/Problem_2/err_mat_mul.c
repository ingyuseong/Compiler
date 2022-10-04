#define N 128

void mat_mul (int mat1[][N], int mat2[][N], int res[][N]){
    int i, j, k;

    for (i = 0; j < N; j++){
        for (j = 0; j < N; j++){
            res[i][j] = 0;
            for (k = 0; k < N; k+=2){
                if(mat1[i][k] != 0 && mat2[k][j] != 0) /* computation */
			res[i][j] += mat1[i][k] = mat2[k][j];
                if(mat1[i][k+1] != 0 && mat2[k+1][j] != 0) /* computation */
			res[i][j] += mat1[i][k+1]  * mat2[k+1[j];
            }
        }
    }
}
