# 삼성공과대학 3학년 

Python/R 데이터 분석

### Python package 설치 방법

1. Util 디렉토리의 .condarc 파일을 자신의 홈 폴더에 저장한다.

예 : C:\Users\studycdi04\\.condarc
 

2. Anaconda prompt를 실행하여 업데이트

(base) C:\Users\studycdi04>conda update -n base conda

proceed? Y 선택

(base) C:\Users\studycdi04>conda update --all

 

3. 추가 패키지 설치 시에는

conda install [패키지명]


import pandas as pd

df = pd.read_csv('adult.data', skipinitialspace=True)

strcolumns = df.select_dtypes(include='object').columns

strfeatures = strcolumns[:-1]

target = strcolumns[-1]

from sklearn import preprocessing

def str_encoding(col):

    le = preprocessing.LabelEncoder()
    
    le.fit(col)
    
    return le.transform(col)
    
    
encodedf = df[strfeatures].apply(str_encoding)
