import { useState } from 'react';
import AdminMainPage from './pages/AdminMainPage';
import NoticeDetailPage from './pages/NoticeDetailPage';

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
];

const App = () => {
  const [selectedNotice, setSelectedNotice] = useState<Notice | null>(null);

  if (selectedNotice) {
    return (
      <NoticeDetailPage
        notice={selectedNotice}
        onBack={() => setSelectedNotice(null)}
      />
    );
  }

  return (
    <AdminMainPage
      notices={notices}
      onNoticeSelect={(notice) => setSelectedNotice(notice)}
    />
  );
};

export default App;
