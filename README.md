### Soldesk 그래픽 기반의 실시간 AI 서비스를 활용한 Cross-flatform 개발자 양성과정 6회차 최종 프로젝트 4조의 프로젝트입니다.(2023/12/05 ~ 2024/01/05)
Spring과 [Django](https://github.com/KimYuKyeong00/Dj.git) 두 서버를 이용해 구현하였습니다 이는 그 중 Spring에 해당하는 서버의 코드입니다.


이 프로젝트는 영상 매체를 이용한 정보 전달에 도움을 주기 위해 기획되었습니다.
비디오 관련 산업이 성장함에 따라 비디오를 통해 정보를 전달하는 사례가 점정 증가하고 있습니다. 비디오를 다루는 툴과 서비스의 필요성을 느낀 저희는 이번 프로젝트의 주제로 영상 업로드를 보조하기 위한 웹 어플리케이션을 선정하게 되었습니다.

사용된 기술 스택: Java,Spring, JavaScript,JQuery, JSP, CSS,OracleDB, Python, Django,ApacheTomcat


IDE : VSCODE(Django), Eclipse(e-gov, Spring MVC)

역할 : 백엔드(자막추출, 태그추천, 타임라인, 요약기능 담당), 영상 분석 AI 학습, 미디어 파일 처리, 인터페이스 기능 검수.

---------------------------------------------------------------------


## 주요 기능 
1. 영상에서 자막(텍스트) 추출
2. 태그 추천
3. 요약 텍스트 생성
4. 타임라인 생성
5. 영상 정보 레이아웃 작성
6. 문의 게시판
7. 로그인 관련 기능



----------------------------------------------------------------------
   

### <자막추출, 태그추천, 타임라인 생성, 요약 생성>
- 영상을 업로드 한뒤 영상분석 버튼을 누르면 자막이 추출되며, 추천태그도 텍스트박스 상단에 생성됩니다. 태그를 누르면 #[태그]의 형태로 텍스트 박스에 추가되며, 자막을 클릭하면 클릭한 부분의 타임라인이 텍스트박스에 기록됩니다.
- 요약하기 버튼을 클릭하면 자막으로 추출된 텍스트의 요약본이 텍스트박스에 추가됩니다.
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/0c19c5e4-2c41-494a-9151-928e0721a0cd)


----


### <영상 정보란 레이아웃 제공>
- 체크박스로 요소를 추가, 제거할 수 있으며 드래그로 순서를 변경할 수 있습니다.
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/8e58c1cc-ee91-4d2e-bba2-33996794a324)


----


### <메인페이지>
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/5b971acb-f7e8-4bd0-9983-37aa288917eb)

-----

### <로그인 관련>
- 회원 가입시 이메일 인증을 구현해두었습니다.
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/c5b616cc-aad1-42bb-af72-801a3f6c22e7)


----

### <문의게시판>
- 기본적으로 자유게시판의 형식입니다
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/489b48cb-5718-471d-8595-aeb9f6148980)


----

### <요약 기능 모델 fine-tuning>

[AI-Hub 방송콘텐츠데이터](https://www.aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=data&dataSetSn=591) 를 사용하여 학습된 모델인 [Ko-Bart모델](https://github.com/seujung/KoBART-summarization) 을 fine-tuning을 진행했습니다.

학습은 리소스부족 때문에colab에서 진행하였으며 그 내부에서 라이브러리 충돌을 방지하기 위해 conda가상환경을 세팅하여 시행하였습니다.

초기 loss 값 약 9 에서 학습 이후 loss값이 약 2로 감소하였습니다.


![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/0b546328-ada7-4a30-a33a-2f050cf352a8)
![image](https://github.com/KimYuKyeong00/Team4/assets/152937847/0617ea79-ff9f-4e65-81be-92440d9c3c61)


----
문제점


- 영상에서 음성을 추출하는 과정, 모델을 이용하여 요약내용을 추출하는 과정 등 많은 컴퓨팅 리소스를 필요로하는 서비스로 실제 배포 진행시 많은 비용이 필요할 가능성이 높다는 문제점이 있습니다.
- 모델에 너무 짧은 텍스트가 입력되면 특정 단어를 반복하거나, 원본보다 긴 결과를 출력하는 등의 문제가 있습니다.(기존모델, fine-tuning된 모델 동일) 다양한 입력 길이에 대한 추가적인 학습이 필요하다고 판단하였지만 해당사항을 만족하는 데이터를 공개적인 소스에서는 찾지 못했습니다.
- 서비스 구현에 있어서 외부 api(STT) 에 의존하고 있습니다.



----
사용전 주의사항 
- GoogleCloud-api 사용을 위해 서비스 계정을 생성하고 활성화 해야 합니다.
- 사용자가 업로드한 리소스가 저장될 경로를 수정해야 합니다. (com.team.dec051.timeline.Constants.java 에서 경로를 변경할 수 있습니다.)
- ServletContext 에서 Oracle계정과 관련한 부분을 (계정과 비밀번호) 를 수정해야합니다.
- 저작권, 용량의 문제로 인해 fine-tuning을 마친 모델은 제공할 수 없습니다. 따라서 현재는 자체적으로 fine-tuning 된 모델을 사용하는 버전이 아니라 pretrained된 모델을 사용하는 상태로 되어있습니다. 조정된 모델이 있다면 모델을 지정하는 부분을 주석화하고, 주석화 되어있는 부분을 활성화 해야합니다.
- 모델을 서버에 미리 로딩해두는 버전의 코드가 아닙니다.(리소스 이슈) 리소스가 충분하다면 주석화되어있는 모델을 미리 로딩해두는 부분을 활성화해야 합니다.


----
모델 출처 
- https://github.com/seujung/KoBART-summarization

데이터 출처
- https://www.aihub.or.kr/aihubdata/data/view.do?currMenu=115&topMenu=100&aihubDataSe=data&dataSetSn=591
