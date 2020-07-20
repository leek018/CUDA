## HelloCuda

+ RTX 2060 capability 7.5 
+ nvcc hello.cu -o hello -gencode arch=compute_75,code=sm_75

## SIMT

+ Gpu의 아키텍쳐는 SIMD 보다는 SIMT라고 불린다
  + SIMD : 하나의 Instruction이 여러개의 데이터에 적용됨
    + 여러 데이터에 각 코어가 할당되는데 자신만의 control context를 갖고 있지 않고 공유한다.
  + SIMT : 하나의 Instruction이 여러개의 쓰레드에 적용됨
    + 워프 안에 있는 쓰레드들은 PC(control unit)를 통해 관리된다
    + 각 쓰레드들은 자신만의 control context를 갖고 있다.
    + 만약 워프내에 분기가 있다면 하나를 처리하고 다른 하나를 처리하는 serialization이 발생한다 이걸 Divergent라고 불리고 성능면에서 페널티를 불러 일으킨다

## Multi-core CPU vs GPU

+  Multi-core CPU
  + Control이 크다
+ GPU
  + Control이 작다

## C extension Keyword

+ \_\_global\_\_
  + host 에서 호출하여 device에서 실행되는 함수
  + 리턴 값은 항상 void
  + device는 호출 할 수 없다. 고로 재귀호출이 불가능
  + 함수 내에 static 변수를 가질 수 없다.
  + 가변형 인수를 가질 수 없다.
+ \_\_device\_\_
  + devcie 호출 device에서 실행
  + 재귀호출 불가능
  + 함수 내에 static 변수를 가질 수 없다.
  + 가변형 인수를 가질 수 없다.
+ \_\_host\_\_(default)
  + host 호출 host 실행

+ \_\_device\_\_ \_\_host\_\_
  + host , device 양쪽에서 모두 사용할 수 있는 함수

## 변수 수식어와 메모리

+ \_\_device\_\_
  + \_\_device\_\_ 변수는 global 메모리 영역에 할당되어 프로그램이 종료될 때까지 유효
  + \_\_device\_\_ 변수에는 모든 thread가 접근 할 수 있고 host에서는 api를 통해 읽기와 쓰기가 가능
+ \_\_constant\_\_
  + constant 메모리 영역에 할당되어 프로그램이 종료될 때까지 유효
  + 모든 thread에서 접근 할 수 있고 읽기만 가능
  + 단 host에서는 값을 쓸 수 있음.
  + 모든 쓰레드들이 동시에 동일한 주소를 접근할 때 디바이스에서 짧은 접근 지연과 높은 대역폭을 가진 읽기 전용 접근이 가능하다.
+ \_\_shared\_\_
  + 공유 메모리 영역에 할당되어 실행 중인 thread block 상에서만 유효
  + \_\_shared\_\_ 변수는 block 내의 thread는 접근하여 읽고 쓰는 것이 가능.
+ register
  +  개개의 쓰레드들에게 할당되는데, 각 쓰레드는 자신의 레지스터들만 접근할 수 있다. 커널 함수는 각 쓰레드가 자신만이 빈번하게 사용되는 변수를 담기 위해 주로 레지스터를 사용한다

## kernel

+ <<< numBlocks , thread per Blocks>>>
+ <<< dimGrid, dimBlock >>>