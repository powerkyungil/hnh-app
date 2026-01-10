import NoticeCard from '../components/NoticeCard';
import { Notice } from '../App';
import '../styles/admin-main.css';

type AdminMainPageProps = {
  notices: Notice[];
  activeMenu: 'dashboard' | 'attendance' | 'notice';
  onNoticeSelect: (notice: Notice) => void;
  onMenuChange: (menu: 'dashboard' | 'attendance' | 'notice') => void;
};

const attendanceSummary = [
  { label: '출근 전', value: 4 },
  { label: '근무 중', value: 12 },
  { label: '퇴근 완료', value: 7 },
  { label: '휴가자', value: 2 },
];

const AdminMainPage = ({
  notices,
  activeMenu,
  onNoticeSelect,
  onMenuChange,
}: AdminMainPageProps) => {
  const latestNotices = notices.slice(0, 3);

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
            <p className="admin-main__eyebrow">관리자 대시보드</p>
            <h2 className="admin-main__title">오늘의 출근 요약</h2>
          </div>
        </header>
        <section className="admin-main__summary-grid">
          {attendanceSummary.map((item) => (
            <article key={item.label} className="admin-main__summary-card">
              <span className="admin-main__summary-label">{item.label}</span>
              <strong>{item.value}명</strong>
            </article>
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
