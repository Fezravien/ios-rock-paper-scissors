

# Rock-Scissor-Paper && MukChiPa Game 👊✌️✋



## 로직 설계도

<img width="694" alt="image" src="https://user-images.githubusercontent.com/44525561/110445936-02185980-8102-11eb-85ba-a552afc1f5b1.png">



### Step1 

<img width="481" alt="스크린샷 2021-03-09 오후 5 43 49" src="https://user-images.githubusercontent.com/44525561/110446034-18261a00-8102-11eb-8504-88159aea90cc.png">
<img width="483" alt="스크린샷 2021-03-09 오후 5 44 17" src="https://user-images.githubusercontent.com/44525561/110446048-1bb9a100-8102-11eb-8c58-bdec1957a47f.png">
<img width="563" alt="스크린샷 2021-03-09 오후 5 44 26" src="https://user-images.githubusercontent.com/44525561/110446061-1f4d2800-8102-11eb-92b8-559d293e34a9.png">


#### 가위, 바위, 보 게임

- 사용자로부터 입력받은 정수 가위(1), 바위(2), 보(3), 종료(0)를 기준으로 랜덤으로 1~3 사이의 수(가위, 바위, 보)를 생성한 컴퓨터와 게임을 한다.
  - 비기면 게임 재시작
  - 특정한 값이 아닐 시 **"잘못된 입력입니다. 다시 시도해주세요."** 출력 후 게임 재시작
- 1, 2, 3, 0 정수 외 다른 값들은 오류처리`(do-try-catch-throw)`를 열거형으로 `Error` 프로토콜을 이용해 처리했다.
- 사용자에게 입력받는 `userTyping` 에서 입력을 판단해주는 `isValidInput`, `checkedInput`은 사용자에게 보여지지 않는 부분이므로 `private`로 접근제어를 활용했다. 
- 상태값을 정리하기 위해 `enum`, `struct` 을 사용했다.
  - enum 으로 사용했을때 `.rawValue`를 자주 사용해서 `struct`를 통해 원시값만 정리했었다.
  - 원시값을 처리하기 위해 `struct` 를 사용하는 것은 중복된 작업을 사용함을 느끼게되었다. 



---

### Step2

<img width="613" alt="스크린샷 2021-03-09 오후 5 37 41" src="https://user-images.githubusercontent.com/44525561/110446128-2bd18080-8102-11eb-8dbd-9abb2e75b4e7.png">


#### 묵찌빠 게임

- 가위바위보 게임의 결과값을 가지고 묵찌빠 게임으로 확장시켰다
  - 확장의 의미에 맞게 클래스의 `상속`을 적극 활용하기 위해 고민을 했다.
  - 가위바위보 게임에서 이기는 쪽에게 턴을 주고 묵찌빠 게임으로 이어간다.
  - 비기면 승리, 비기지 않을 때 이긴쪽에게 턴을 주며 재시작 한다.
- 상태값을 정리함에 있어서 중복되는 부분을 묶어서 `struct`로 묶었다. (GameCondition)
