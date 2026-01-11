import '../styles/admin-main.css';

type EmployeeAttendancePageProps = {
  onBack: () => void;
};

type DayStatus = '근무 중' | '출근 전' | '퇴근 완료' | '휴가';

type CalendarDay = {
  date: number;
  status: DayStatus;
};

const calendarDays: CalendarDay[] = [
  { date: 1, status: '근무 중' },
  { date: 2, status: '퇴근 완료' },
  { date: 3, status: '근무 중' },
  { date: 4, status: '휴가' },
  { date: 5, status: '출근 전' },
  { date: 6, status: '퇴근 완료' },
  { date: 7, status: '근무 중' },
  { date: 8, status: '근무 중' },
  { date: 9, status: '출근 전' },
  { date: 10, status: '퇴근 완료' },
  { date: 11, status: '근무 중' },
  { date: 12, status: '근무 중' },
  { date: 13, status: '휴가' },
  { date: 14, status: '출근 전' },
  { date: 15, status: '퇴근 완료' },
  { date: 16, status: '근무 중' },
  { date: 17, status: '근무 중' },
  { date: 18, status: '출근 전' },
  { date: 19, status: '퇴근 완료' },
  { date: 20, status: '휴가' },
  { date: 21, status: '근무 중' },
  { date: 22, status: '근무 중' },
  { date: 23, status: '출근 전' },
  { date: 24, status: '퇴근 완료' },
  { date: 25, status: '근무 중' },
  { date: 26, status: '근무 중' },
  { date: 27, status: '출근 전' },
  { date: 28, status: '퇴근 완료' },
  { date: 29, status: '근무 중' },
  { date: 30, status: '휴가' },
];

const statusClassMap: Record<DayStatus, string> = {
  '근무 중': 'calendar-status--working',
  '출근 전': 'calendar-status--pending',
  '퇴근 완료': 'calendar-status--done',
  휴가: 'calendar-status--vacation',
};

const EmployeeAttendancePage = ({ onBack }: EmployeeAttendancePageProps) => {
  return (
    <div className="employee-calendar-layout">
      <header className="employee-calendar-header">
        <button className="employee-back" type="button" onClick={onBack}>
          ← 메인으로
        </button>
        <div>
          <p className="employee-calendar-eyebrow">출근 현황</p>
          <h2 className="employee-calendar-title">2024년 4월</h2>
        </div>
      </header>
      <section className="employee-calendar">
        <div className="employee-calendar__weekdays">
          {['일', '월', '화', '수', '목', '금', '토'].map((day) => (
            <span key={day}>{day}</span>
          ))}
        </div>
        <div className="employee-calendar__grid">
          {calendarDays.map((day) => (
            <div key={day.date} className="employee-calendar__cell">
              <span className="employee-calendar__date">{day.date}</span>
              <span
                className={`employee-calendar__status ${
                  statusClassMap[day.status]
                }`}
              >
                {day.status}
              </span>
            </div>
          ))}
        </div>
      </section>
      <section className="employee-calendar-legend">
        <span className="legend-item calendar-status--working">근무 중</span>
        <span className="legend-item calendar-status--pending">출근 전</span>
        <span className="legend-item calendar-status--done">퇴근 완료</span>
        <span className="legend-item calendar-status--vacation">휴가</span>
      </section>
    </div>
  );
};

export default EmployeeAttendancePage;
