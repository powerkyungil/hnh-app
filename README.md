# HNH Commute Manager

Flutter 애플리케이션으로 구현된 소규모 기업 출퇴근 관리 시스템 예제입니다. 대표와 직원이 각각 가입하고, 대표는 회사 코드와 위치 정보를 등록하며, 직원은 코드로 가입하여 출퇴근 기록을 남길 수 있습니다.

## 주요 기능

- **회원 가입**
  - 대표는 회사 정보(회사명, 위도/경도)를 입력하여 회사 코드를 생성하고 첫 번째 구성원이 됩니다.
  - 직원은 회사 코드와 개인정보를 입력해 기존 회사에 합류합니다.
- **로그인 및 대시보드**
  - 대표는 대시보드에서 직원들의 당일 출퇴근 현황을 확인할 수 있습니다.
  - 직원은 자신의 당일 출퇴근 시간을 확인할 수 있습니다.
- **출근/퇴근 기록**
  - 지도에 회사 위치를 표시하고, 현재 위치가 회사 반경 300m 이내일 때만 출근/퇴근 버튼을 활성화합니다.
  - Geolocator 플러그인을 통해 현재 위치를 조회하고 거리 계산은 Haversine 공식을 이용합니다.

## 프로젝트 구조

```
lib/
├── app.dart                  # MaterialApp 설정 및 라우팅
├── main.dart                 # 앱 진입점
├── models/                   # Company, Member, AttendanceRecord 모델
├── providers/                # AppState: 상태 관리 및 비즈니스 로직
├── screens/                  # 로그인/가입/대시보드 UI
├── services/                 # LocationService: 거리 계산 로직
└── widgets/                  # CompanyMap: GoogleMap 위젯
```

## 실행 방법

1. Flutter SDK 3.10 이상 설치 및 환경 구성
2. 필요한 패키지 설치:
   ```bash
   flutter pub get
   ```
3. 에뮬레이터 또는 물리 기기에서 실행:
   ```bash
   flutter run
   ```

> **참고:** Google Maps와 Geolocator 플러그인을 사용하므로 Android/iOS 설정 (API Key, 권한) 이 필요합니다. 실제 서비스에 적용할 경우 Firestore 등의 백엔드 연동과 영속 저장소 구현이 추가로 필요합니다.

## 테스트

현재 예제는 상태 관리와 UI 흐름을 중심으로 구성되어 있으며, 단위 테스트는 포함되어 있지 않습니다.
