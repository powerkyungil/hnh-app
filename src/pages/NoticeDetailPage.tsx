import { Notice } from '../App';
import '../styles/admin-main.css';

type NoticeDetailPageProps = {
  notice: Notice;
  onBack: () => void;
};

const NoticeDetailPage = ({ notice, onBack }: NoticeDetailPageProps) => {
  return (
    <div className="admin-detail">
      <div className="admin-detail__header">
        <button className="admin-detail__back" type="button" onClick={onBack}>
          ← 목록으로
        </button>
        <p className="admin-detail__date">{notice.date}</p>
        <h1 className="admin-detail__title">{notice.title}</h1>
      </div>
      <section className="admin-detail__content">
        <p>{notice.content}</p>
      </section>
    </div>
  );
};

export default NoticeDetailPage;
