import EmployeeCard, { AttendanceStatus } from '../components/EmployeeCard';
import '../styles/admin-main.css';

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

const AdminMainPage = () => {
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
      </main>
    </div>
  );
};

export default AdminMainPage;
