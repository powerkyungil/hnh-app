import './EmployeeCard.css';

export type AttendanceStatus = '출근' | '퇴근' | '미출근';

type EmployeeCardProps = {
  name: string;
  position: string;
  checkInTime: string;
  checkOutTime: string;
  status: AttendanceStatus;
};

const statusLabelMap: Record<AttendanceStatus, string> = {
  출근: '근무 중',
  퇴근: '퇴근 완료',
  미출근: '출근 전',
};

const statusClassMap: Record<AttendanceStatus, string> = {
  출근: 'status--working',
  퇴근: 'status--done',
  미출근: 'status--pending',
};

const EmployeeCard = ({
  name,
  position,
  checkInTime,
  checkOutTime,
  status,
}: EmployeeCardProps) => {
  return (
    <article className="employee-card">
      <header className="employee-card__header">
        <div>
          <p className="employee-card__name">{name}</p>
          <p className="employee-card__role">{position}</p>
        </div>
        <span className={`employee-card__status ${statusClassMap[status]}`}>
          {statusLabelMap[status]}
        </span>
      </header>
      <div className="employee-card__body">
        <div className="employee-card__time">
          <span className="employee-card__label">오늘 출근시간</span>
          <strong>{checkInTime}</strong>
        </div>
        <div className="employee-card__time">
          <span className="employee-card__label">오늘 퇴근시간</span>
          <strong>{checkOutTime}</strong>
        </div>
        <div className="employee-card__time">
          <span className="employee-card__label">출근현황</span>
          <strong>{statusLabelMap[status]}</strong>
        </div>
      </div>
    </article>
  );
};

export default EmployeeCard;
