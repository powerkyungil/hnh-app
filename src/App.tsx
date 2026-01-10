import { useState } from 'react';
import AdminMainPage from './pages/AdminMainPage';
import NoticeDetailPage from './pages/NoticeDetailPage';
import NoticeListPage from './pages/NoticeListPage';

export type Notice = {
  id: number;
  title: string;
  date: string;
  summary: string;
  content: string;
};

const notices: Notice[] = [
  {
    id: 1,
    title: '4월 출근 정책 변경 안내',
    date: '2024.04.01',
    summary: '유연근무제 운영 시간 및 승인 절차가 변경됩니다.',
    content:
      '4월 1일부터 유연근무제 운영 시간이 오전 7시~오후 10시로 확대됩니다. 변경된 제도는 매주 금요일 승인 절차를 거쳐 반영됩니다.',
  },
  {
    id: 2,
    title: '보안 교육 이수 안내',
    date: '2024.03.28',
    summary: '신규 보안 교육이 배포되었습니다. 4월 5일까지 이수해주세요.',
    content:
      '신규 보안 교육은 피싱 대응 및 사내 정보 보호를 포함합니다. 모든 구성원은 4월 5일까지 교육을 완료해야 합니다.',
  },
  {
    id: 3,
    title: '근태 시스템 점검 공지',
    date: '2024.03.25',
    summary: '3월 30일 22:00~23:00 시스템 점검이 예정되어 있습니다.',
    content:
      '점검 시간 동안 출퇴근 기록이 제한될 수 있습니다. 점검 완료 후 자동으로 기록이 동기화됩니다.',
  },
  {
    id: 4,
    title: '대체휴무 신청 방법',
    date: '2024.03.20',
    summary: '대체휴무 신청은 근태 시스템에서 사전 등록이 필요합니다.',
    content:
      '대체휴무 신청 시 사유를 입력하고 담당 관리자 승인 후 확정됩니다. 승인 완료 후 근태 현황에 반영됩니다.',
  },
  {
    id: 5,
    title: '근무지 안전 수칙 안내',
    date: '2024.03.18',
    summary: '근무지 안전 수칙을 다시 확인해주세요.',
    content:
      '안전 수칙을 준수하고 위험 요소 발견 시 즉시 관리자에게 보고해 주세요.',
  },
  {
    id: 6,
    title: '프로젝트 회고 일정',
    date: '2024.03.15',
    summary: '3월 말 회고 일정이 확정되었습니다.',
    content:
      '부서별 회고 일정은 3월 마지막 주에 진행됩니다. 캘린더를 확인해 주세요.',
  },
  {
    id: 7,
    title: '재택근무 신청 절차 변경',
    date: '2024.03.12',
    summary: '재택근무 신청이 간소화되었습니다.',
    content:
      '재택근무 신청은 근태 시스템에서 24시간 전 등록으로 변경됩니다.',
  },
  {
    id: 8,
    title: '사내 행사 안내',
    date: '2024.03.08',
    summary: '사내 봄 행사 일정이 공개되었습니다.',
    content:
      '행사 일정과 프로그램은 공지사항 상세에서 확인할 수 있습니다.',
  },
  {
    id: 9,
    title: '휴가 사용 안내',
    date: '2024.03.05',
    summary: '연차 사용 기준이 업데이트되었습니다.',
    content:
      '연차는 분기별 최소 1회 이상 사용해야 하며, 미사용 시 이월이 제한됩니다.',
  },
  {
    id: 10,
    title: '업무 시스템 점검',
    date: '2024.03.01',
    summary: '업무 시스템 점검이 진행됩니다.',
    content:
      '3월 2일 새벽 2시부터 4시까지 시스템 점검이 진행됩니다.',
  },
];

const App = () => {
  const [selectedNotice, setSelectedNotice] = useState<Notice | null>(null);
  const [activeMenu, setActiveMenu] = useState<'attendance' | 'notice'>(
    'attendance'
  );

  if (selectedNotice) {
    return (
      <NoticeDetailPage
        notice={selectedNotice}
        onBack={() => setSelectedNotice(null)}
      />
    );
  }

  return (
    <>
      {activeMenu === 'attendance' ? (
        <AdminMainPage
          notices={notices}
          activeMenu={activeMenu}
          onNoticeSelect={(notice) => setSelectedNotice(notice)}
          onMenuChange={setActiveMenu}
        />
      ) : (
        <NoticeListPage
          notices={notices}
          activeMenu={activeMenu}
          onNoticeSelect={(notice) => setSelectedNotice(notice)}
          onMenuChange={setActiveMenu}
        />
      )}
    </>
  );
};

export default App;
