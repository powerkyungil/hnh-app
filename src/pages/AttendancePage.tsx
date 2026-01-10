import '../styles/admin-main.css';

type AttendancePageProps = {
  activeMenu: 'dashboard' | 'attendance' | 'notice';
  onMenuChange: (menu: 'dashboard' | 'attendance' | 'notice') => void;
};

type AttendanceItem = {
  id: number;
  name: string;
  position: string;
  checkInTime: string;
  checkOutTime: string;
  status: string;
};

const attendanceItems: AttendanceItem[] = [
  {
    id: 1,
    name: '김하늘',
    position: '마케팅 팀장',
    checkInTime: '08:55',
    checkOutTime: '18:10',
    status: '퇴근 완료',
  },
  {
    id: 2,
    name: '박지수',
    position: '개발자',
    checkInTime: '09:12',
    checkOutTime: '-',
    status: '근무 중',
  },
  {
    id: 3,
    name: '이현수',
    position: '디자이너',
    checkInTime: '-',
    checkOutTime: '-',
    status: '출근 전',
  },
  {
    id: 4,
    name: '정소연',
    position: '인사 담당',
    checkInTime: '-',
    checkOutTime: '-',
    status: '휴가',
  },
];

const AttendancePage = ({ activeMenu, onMenuChange }: AttendancePageProps) => {
  return (
    <div className="admin-layout">
      <aside className="admin-sidebar">
        <h1 className="admin-sidebar__title">관리자 모드</h1>
        <nav className="admin-sidebar__nav">
          <button
            className={`admin-sidebar__link ${
              activeMenu === 'dashboard' ? 'admin-sidebar__link--active' : ''
            }`}
            type="button"
            onClick={() => onMenuChange('dashboard')}
          >
            대시보드
          </button>
          <button
            className={`admin-sidebar__link ${
              activeMenu === 'attendance' ? 'admin-sidebar__link--active' : ''
            }`}
            type="button"
            onClick={() => onMenuChange('attendance')}
          >
            출근현황
          </button>
          <button
            className={`admin-sidebar__link ${
              activeMenu === 'notice' ? 'admin-sidebar__link--active' : ''
            }`}
            type="button"
            onClick={() => onMenuChange('notice')}
          >
            공지사항
          </button>
        </nav>
      </aside>
      <main className="admin-main">
        <header className="admin-main__header">
          <div>
            <p className="admin-main__eyebrow">출근현황</p>
            <h2 className="admin-main__title">직원 출퇴근 상세</h2>
          </div>
        </header>
        <section className="attendance-list">
          {attendanceItems.map((item) => (
            <article key={item.id} className="attendance-card">
              <div className="attendance-card__header">
                <div>
                  <p className="attendance-card__name">{item.name}</p>
                  <p className="attendance-card__role">{item.position}</p>
                </div>
                <span className="attendance-card__status">{item.status}</span>
              </div>
              <div className="attendance-card__body">
                <div className="attendance-card__row">
                  <span>오늘 출근시간</span>
                  <strong>{item.checkInTime}</strong>
                </div>
                <div className="attendance-card__row">
                  <span>오늘 퇴근시간</span>
                  <strong>{item.checkOutTime}</strong>
                </div>
                <div className="attendance-card__row">
                  <span>출근현황</span>
                  <strong>{item.status}</strong>
                </div>
              </div>
            </article>
          ))}
        </section>
      </main>
    </div>
  );
};

export default AttendancePage;
