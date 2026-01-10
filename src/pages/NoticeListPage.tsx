import { useEffect, useMemo, useRef, useState } from 'react';
import NoticeCard from '../components/NoticeCard';
import { Notice } from '../App';
import '../styles/admin-main.css';

type NoticeListPageProps = {
  notices: Notice[];
  activeMenu: 'attendance' | 'notice';
  onNoticeSelect: (notice: Notice) => void;
  onMenuChange: (menu: 'attendance' | 'notice') => void;
};

const PAGE_SIZE = 6;

const NoticeListPage = ({
  notices,
  activeMenu,
  onNoticeSelect,
  onMenuChange,
}: NoticeListPageProps) => {
  const [visibleCount, setVisibleCount] = useState(PAGE_SIZE);
  const sentinelRef = useRef<HTMLDivElement | null>(null);

  const visibleNotices = useMemo(
    () => notices.slice(0, visibleCount),
    [notices, visibleCount]
  );

  useEffect(() => {
    const sentinel = sentinelRef.current;
    if (!sentinel) return;

    const observer = new IntersectionObserver(
      (entries) => {
        if (entries[0]?.isIntersecting) {
          setVisibleCount((prev) =>
            Math.min(prev + PAGE_SIZE, notices.length)
          );
        }
      },
      { rootMargin: '120px' }
    );

    observer.observe(sentinel);
    return () => observer.disconnect();
  }, [notices.length]);

  const hasMore = visibleCount < notices.length;

  return (
    <div className="admin-layout">
      <aside className="admin-sidebar">
        <h1 className="admin-sidebar__title">관리자 모드</h1>
        <nav className="admin-sidebar__nav">
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
            <p className="admin-main__eyebrow">공지사항</p>
            <h2 className="admin-main__title">전체 공지 목록</h2>
          </div>
        </header>
        <section className="admin-main__notice-list admin-main__notice-list--full">
          {visibleNotices.map((notice) => (
            <NoticeCard
              key={notice.id}
              title={notice.title}
              date={notice.date}
              summary={notice.summary}
              onClick={() => onNoticeSelect(notice)}
            />
          ))}
        </section>
        <div className="admin-main__infinite">
          {hasMore ? (
            <p className="admin-main__infinite-text">더 불러오는 중...</p>
          ) : (
            <p className="admin-main__infinite-text">마지막 공지입니다.</p>
          )}
          <div ref={sentinelRef} />
        </div>
      </main>
    </div>
  );
};

export default NoticeListPage;
