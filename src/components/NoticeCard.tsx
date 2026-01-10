import './NoticeCard.css';

type NoticeCardProps = {
  title: string;
  date: string;
  summary: string;
  onClick: () => void;
};

const NoticeCard = ({ title, date, summary, onClick }: NoticeCardProps) => {
  return (
    <button className="notice-card" type="button" onClick={onClick}>
      <div>
        <p className="notice-card__date">{date}</p>
        <h3 className="notice-card__title">{title}</h3>
        <p className="notice-card__summary">{summary}</p>
      </div>
      <span className="notice-card__cta">상세보기</span>
    </button>
  );
};

export default NoticeCard;
