import EmployeeCard, { AttendanceStatus } from '../components/EmployeeCard';
import NoticeCard from '../components/NoticeCard';
import { Notice } from '../App';
import '../styles/admin-main.css';

type AdminMainPageProps = {
  notices: Notice[];
  onNoticeSelect: (notice: Notice) => void;
};

const employees: Array<{
  id: number;
  name: string;
  position: string;
  checkInTime: string;
  checkOutTime: string;
  status: AttendanceStatus;
}> = [
  {
    id: 1,
    name: '김하늘',
    position: '마케팅 팀장',
    checkInTime: '08:55',
    checkOutTime: '18:10',
    status: '퇴근',
  },
  {
    id: 2,
    name: '박지수',
    position: '개발자',
    checkInTime: '09:12',
    checkOutTime: '-',
    status: '출근',
  },
  {
    id: 3,
    name: '이현수',
    position: '디자이너',
    checkInTime: '-',
    checkOutTime: '-',
    status: '미출근',
  },
];

const AdminMainPage = ({ notices, onNoticeSelect }: AdminMainPageProps) => {
  const latestNotices = notices.slice(0, 3);

  return (
    <div className="admin-layout">
      <aside className="admin-sidebar">
        <h1 className="admin-sidebar__title">관리자 모드</h1>
        <nav className="admin-sidebar__nav">
          <button className="admin-sidebar__link admin-sidebar__link--active">
            출근현황
          </button>
          <button className="admin-sidebar__link">공지사항</button>
        </nav>
      </aside>
      <main className="admin-main">
        <header className="admin-main__header">
          <div>
            <p className="admin-main__eyebrow">오늘의 출근 현황</p>
            <h2 className="admin-main__title">직원 출퇴근 현황</h2>
          </div>
          <div className="admin-main__summary">
            <div>
              <span className="admin-main__summary-label">근무 중</span>
              <strong>12명</strong>
            </div>
            <div>
              <span className="admin-main__summary-label">미출근</span>
              <strong>3명</strong>
            </div>
          </div>
        </header>
        <section className="admin-main__cards">
          {employees.map((employee) => (
            <EmployeeCard key={employee.id} {...employee} />
          ))}
        </section>
        <section className="admin-main__notices">
          <div className="admin-main__section-header">
            <div>
              <p className="admin-main__eyebrow">공지사항</p>
              <h3 className="admin-main__section-title">최신 공지 3건</h3>
            </div>
            <span className="admin-main__section-hint">전체보기 준비 중</span>
          </div>
          <div className="admin-main__notice-list">
            {latestNotices.map((notice) => (
              <NoticeCard
                key={notice.id}
                title={notice.title}
                date={notice.date}
                summary={notice.summary}
                onClick={() => onNoticeSelect(notice)}
              />
            ))}
          </div>
        </section>
      </main>
    </div>
  );
};

export default AdminMainPage;
