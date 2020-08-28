1. 다음 조건을 만족하는 'merged' 라는 이름의 DataFrame을 만드시오
merged.head()
-	state/region	ages	year	population	state
0	AL	under18	2012	1117489.0	Alabama
1	AL	total	2012	4817528.0	Alabama
2	AL	under18	2010	1130966.0	Alabama
3	AL	total	2010	4785570.0	Alabama
4	AL	under18	2011	1125763.0	Alabama
merges.shape
merged.isnull().any()
2. 'merged' DataFrame의 Null 값을 다음 조건에 맞게 채우시오
'stat/resion'이 'PR' 인 경우에 'state' 값은 'Puerto Rico'
'stat/resion'이 'USA' 인 경우에 'state' 값은 'United States'
3. 다음 조건을 만족하는 'final' 이라는 이름의 DataFrame을 만드시오
final.head()
-	state/region	ages	year	population	state	area (sq. mi)
0	AL	under18	2012	1117489.0	Alabama	52423.0
1	AL	total	2012	4817528.0	Alabama	52423.0
2	AL	under18	2010	1130966.0	Alabama	52423.0
3	AL	total	2010	4785570.0	Alabama	52423.0
4	AL	under18	2011	1125763.0	Alabama	52423.0
final.shape
final.isnull().any()
4. 2010년도 각 주의 인구밀도를 구하시오
인구밀도 : 총인구 / 면적
