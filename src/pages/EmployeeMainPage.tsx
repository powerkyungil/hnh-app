import { useEffect, useMemo, useState } from 'react';
import '../styles/admin-main.css';

type EmployeeMainPageProps = {
  onRoleChange: (role: 'admin' | 'employee') => void;
};

const EmployeeMainPage = ({ onRoleChange }: EmployeeMainPageProps) => {
  const [now, setNow] = useState(new Date());
  const [checkedIn, setCheckedIn] = useState(false);

  useEffect(() => {
    const timer = setInterval(() => setNow(new Date()), 1000);
    return () => clearInterval(timer);
  }, []);

  const statusLabel = checkedIn ? '근무 중' : '출근 전';
  const statusClass = checkedIn
    ? 'employee-status--working'
    : 'employee-status--pending';

  const timeText = useMemo(
    () =>
      now.toLocaleTimeString('ko-KR', {
        hour: '2-digit',
        minute: '2-digit',
        second: '2-digit',
      }),
    [now]
  );

  return (
    <div className="employee-layout">
      <header className="employee-header">
        <div>
          <p className="employee-name">김하늘</p>
          <p className="employee-role">마케팅 팀장</p>
        </div>
        <button
          className="employee-switch"
          type="button"
          onClick={() => onRoleChange('admin')}
        >
          관리자 모드
        </button>
      </header>
      <section className="employee-status-card">
        <div>
          <p className="employee-time-label">현재 시간</p>
          <h2 className="employee-time">{timeText}</h2>
        </div>
        <span className={`employee-status ${statusClass}`}>{statusLabel}</span>
      </section>
      <section className="employee-action">
        <button
          type="button"
          className={`employee-check ${checkedIn ? 'is-active' : ''}`}
          onClick={() => setCheckedIn((prev) => !prev)}
        >
          {checkedIn ? '퇴근' : '출근'}
        </button>
        <p className="employee-action-hint">
          중앙 버튼을 눌러 {checkedIn ? '퇴근' : '출근'} 처리하세요.
        </p>
      </section>
    </div>
  );
};

export default EmployeeMainPage;
