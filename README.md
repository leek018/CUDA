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
  + ㅇ
  + ㅇ
  + ㅇ
+ GPU
  + Control이 작다

