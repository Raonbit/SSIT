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


기말고사

다음은 데이터를 이용하여 예측 모델을 생성하고 그 결과를 제출하시오.
     1. data.csv : 예측 모델 생성 데이터 
     2. real.csv : 예측 대상 데이터
     3. description.txt : 데이터 설명
 
 
제출 형식
     1. 파일 이름 : 이름.csv
     2. 컬럼 : ID, ANSWER
          - ID : real.csv 의 ID 컬럼 데이터 
          - ANSWER : real.csv 데이터에 대한 예측 값 ( 예측값은 data.csv의 target 값의 형태와 동일한 형태로 제출해야 함)
          
 채점 기준 
     if accuracy > 85 : A
     elif accuracy > 80 : B
     elif accuracy > 60 : C
     else D



target_le = preprocessing.LabelEncoder()

target_le.fit(df[target])

encodetarget = target_le.transform(df[target])

target_le.inverse_transform(encodetarget)
