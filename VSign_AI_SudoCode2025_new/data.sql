-- drop database signLanguage;
-- create database signLanguage;
-- use signLanguage;


-- ==========================================================
-- RESET DATABASE: SIGN LANGUAGE LEARNING PLATFORM
-- ==========================================================
-- Tắt kiểm tra foreign key (MySQL)
SET FOREIGN_KEY_CHECKS = 0;

-- Xóa dữ liệu bảng con trước
-- DELETE FROM users_aisessionlog;
-- DELETE FROM users_usertest;
-- DELETE FROM users_userflashcard;
-- DELETE FROM users_aisession;
-- DELETE FROM users_reminder;

-- -- Xóa dữ liệu bảng chính
-- DELETE FROM users_testquestion;
-- DELETE FROM users_flashcard;
-- DELETE FROM users_topic;

-- Reset auto_increment
ALTER TABLE users_topic AUTO_INCREMENT = 1;
ALTER TABLE users_flashcard AUTO_INCREMENT = 1;
ALTER TABLE users_testquestion AUTO_INCREMENT = 1;
ALTER TABLE users_userflashcard AUTO_INCREMENT = 1;
ALTER TABLE users_usertest AUTO_INCREMENT = 1;
ALTER TABLE users_aisession AUTO_INCREMENT = 1;
ALTER TABLE users_aisessionlog AUTO_INCREMENT = 1;
ALTER TABLE users_reminder AUTO_INCREMENT = 1;

-- Bật lại kiểm tra foreign key
SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================================
-- DATABASE SEED DATA
-- ==========================================================

INSERT INTO `auth_user` VALUES 
    (1,'pbkdf2_sha256$1000000$tHdwLwehkOz0jTDgVAaVcI$KAFUkv0xtdIUm8sIZuH4xdCM2owwWx7Piq9tji0YoY4=','2025-11-06 15:04:46.261764',0,'ConLan','','','suongdtt1139@ut.edu.vn',0,1,'2025-11-06 15:04:33.589207'),
    (2,'pbkdf2_sha256$1000000$ds5AgywURUQCQqZbYxzlON$YK0c9sY93CDKVSj++0rQCmptyrIQcArfTnWUIetcxdk=','2025-11-13 12:44:26.254826',0,'Haha','','','thanhsuongdoan756@gmail.com',0,1,'2025-11-06 15:33:11.240330'),
    (3,'pbkdf2_sha256$1000000$kOYkEHKylhLsKwNyncAbPX$wAOIvZV8+M01KTFK+qujorsC+6by6d19+QlfZIAlNRU=',NULL,1,'Mswng','','','msuong1265@gmail.com',1,1,'2025-11-06 15:42:38.819773'),
    (4,'!GsvSQ3ClaZVFqlDqDx4g3go78LQ63Km8ulW7kIXZ','2025-11-08 16:16:04.717580',0,'suong','Sương','Thanh','',0,1,'2025-11-08 16:13:23.165269'),
    (5,'',NULL,0,'anonymous_user','','','',0,1,'2025-11-14 08:05:20.510158');
    
INSERT INTO users_customer (customer_id, email, sex, date_of_birth, joined_date, is_activated, user_id) VALUES 
    ('2NJj1','suongdtt1139@ut.edu.vn','Nữ','2005-12-06','2025-11-06 15:04:34.684653', 1, 1),
    ('aFH57','thanhsuongdoan756@gmail.com','male','2005-12-08','2025-11-06 15:33:12.174224', 1, 2),
    ('fPxOK',NULL,'Khác',NULL,'2025-11-08 16:13:23.637455', 1, 4),
    ('MEzHh',NULL,'Khác',NULL,'2025-11-14 08:05:20.515677', 1, 5),
    ('vo20H',NULL,'Khác',NULL,'2025-11-06 15:42:39.380784', 1, 3);


--  TOPICS
INSERT INTO users_topic (id, title, description, created_at) VALUES
(1, 'Bảng chữ cái', 'Video hướng dẫn các ký hiệu chữ cái.', NOW()),
(2, 'Cảm xúc', 'Video mô tả các cảm xúc trong ngôn ngữ ký hiệu.', NOW()),
(3, 'Đồ ăn', 'Các hành động và danh từ về đồ ăn.', NOW()),
(4, 'Động vật', 'Tên các loài động vật trong ký hiệu.', NOW()),
(5, 'Gia đình', 'Các thành viên trong gia đình bằng ký hiệu.', NOW()),
(6, 'Sức khỏe', 'Từ vựng về sức khỏe và nghề y.', NOW()),
(7, 'Cụm từ phổ biến', 'Các câu giao tiếp thông dụng.', NOW()),
(8, 'Phương tiện', 'Các loại xe và phương tiện giao thông.', NOW()),
(9, 'Thời tiết', 'Các từ vựng về khí hậu và thời tiết.', NOW());

-- ==========================================================
-- 3. FLASHCARDS (Gộp toàn bộ dữ liệu)
-- ==========================================================
-- Batch 1: Giữ nguyên thứ tự ID 1-21 để khớp với Test Question cũ
INSERT INTO users_flashcard (id, topic_id, front_text, back_text, media) VALUES
-- Topic 1: Chữ cái (ID 1-5)
(1, 1, 'a', 'Bàn tay nắm lại thành nắm đấm. Ngón cái duỗi thẳng, áp sát vào cạnh ngón trỏ. Lòng bàn tay hướng ra trước.', 'https://youtu.be/NomiGmVc4MQ'),
(2, 1, 'ă', 'Ký hiệu chữ A, thêm chuyển động vẽ dấu á (dấu trăng khuyết) trên không trung.', 'https://youtu.be/usCxkLlN0ts'),
(3, 1, 'â', 'Ký hiệu chữ A, thêm chuyển động vẽ dấu mũ trên không trung.', 'https://youtu.be/O3nSyPvLeJg'),
(4, 1, 'b', 'Bàn tay mở phẳng, các ngón tay khép sát nhau, ngón cái gập vào lòng bàn tay hoặc ép sát cạnh bàn tay.', 'https://youtu.be/M5cAidaMJ9c'),
(5, 1, 'c', 'Các ngón tay và ngón cái cong lại tạo thành hình vòng cung (chữ C).', 'https://youtu.be/hAASqHb-0kk'),

-- Topic 2: Cảm xúc (ID 6-7)
(6, 2, 'bực bội', 'Tay bấu vào ngực xoay mạnh hoặc đưa lên cổ (nghẹn), mặt nhăn lại.', 'https://youtu.be/n8dYykrGIBo'),
(7, 2, 'cảm ơn', 'Tay chạm môi hoặc cằm, đưa xuống và ra trước (gửi lời từ miệng).', 'https://youtu.be/SGq3z87G8B8'),

-- Topic 3: Đồ ăn (ID 8-9)
(8, 3, 'ăn', 'Chụm ngón tay đưa vào miệng (mô phỏng hành động ăn).', 'https://youtu.be/_bPOGUZpgvs'),
(9, 3, 'ăn sáng', 'Hành động ăn + ký hiệu buổi sáng (mặt trời mọc).', 'https://youtu.be/cAhgjaaQLUA'),

-- Topic 4: Động vật (ID 10-15)
(10, 4, 'cá sấu', 'Hai bàn tay úp và ngửa, chạm cổ tay vào nhau, mở ra khép lại như hàm cá sấu đớp.', 'https://youtu.be/peRzaZl2tK0'),
(11, 4, 'con báo', 'Mô tả vết đốm trên thân báo và động tác vuốt râu.', 'https://youtu.be/RcDcS-OmQzI'),
(12, 4, 'con cọp', 'Hai tay xòe cong (vuốt), đặt trước ngực, đưa lên xuống so le (hổ vồ mồi).', 'https://youtu.be/IsNioqe9G_w'),
(13, 4, 'con dơi', 'Hai tay bắt chéo trước ngực, ngón tay co lại (móc), mô phỏng tư thế dơi treo ngược.', 'https://youtu.be/N0ED5so2aAA'),
(14, 4, 'con gấu', 'Hai tay chéo trước ngực, bàn tay nắm lại hoặc xòe ra như móng vuốt gấu.', 'https://youtu.be/K6IUHA-TyA4'),
(15, 4, 'con nai', 'Tay hình mái nhà (Â) hoặc xoè rộng, đưa zíc-zắc lên trên (sừng phân nhánh).', 'https://youtu.be/cv9daofHqPM'),

-- Topic 5: Gia đình (ID 16-21)
(16, 5, 'anh trai', 'Kết hợp dấu hiệu nam giới (vuốt cằm/mũ) và dấu hiệu thứ bậc (cao hơn).', 'https://youtu.be/ZK0-GRNLPlc'),
(17, 5, 'bà', 'Mô tả tóc búi sau đầu hoặc má nhăn + giới tính nữ.', 'https://youtu.be/pqH8Oy67v6c'),
(18, 5, 'bố', 'Ngón cái chạm bên phải cằm hoặc đặt tay lên cằm (dấu hiệu nam giới).', 'https://youtu.be/xHfdXJE3f1k'),
(19, 2, 'buồn', 'Mặt xệ xuống, tay đưa từ mặt xuống ngực (năng lượng đi xuống).', 'https://youtu.be/SxdB5z3TJRE'), -- Note: Sửa topic_id thành 2 (Cảm xúc) nhưng giữ ID 19
(20, 5, 'con', 'Ngón trỏ chỉ ra phía trước hoặc động tác xoa đầu trẻ nhỏ.', 'https://youtu.be/59lwLUCJK4s'),
(21, 6, 'bệnh nhân', 'Mặt buồn, tay sờ trán (kiểm tra nhiệt độ) hoặc chỉ vào bộ phận đau.', 'https://youtu.be/r4bVRFR-GE0');

-- Batch 2: Dữ liệu mới (Tiếp tục ID tự động từ 22)
INSERT INTO users_flashcard (topic_id, front_text, back_text, media) VALUES
-- Topic 1: Chữ cái tiếp theo
(1, 'd', 'Ngón trỏ duỗi thẳng hướng lên trên, các ngón còn lại nắm chặt.', 'https://youtu.be/u9bABLuepwA'),
(1, 'đ', 'Tương tự chữ D, có thêm động tác lắc cổ tay hoặc ngón trỏ gạch ngang.', 'https://youtu.be/Sp7M3_QAr9I'),
(1, 'e', 'Các ngón tay co lại, đầu ngón tay chạm vào ngón cái (mỏ chim).', 'https://youtu.be/huxT5uxyyH4'),
(1, 'ê', 'Ký hiệu chữ E kèm dấu mũ.', 'https://youtu.be/Y45aoULNHVQ'),
(1, 'g', 'Hai tay nắm, ngón trỏ và cái duỗi ra song song.', 'https://youtu.be/Eg_Ed4RwLlQ'),
(1, 'h', 'Ngón trỏ và ngón giữa duỗi thẳng, khép sát nhau, hướng sang trái.', 'https://youtu.be/iwQrztKitoc'),
(1, 'i', 'Ngón út duỗi thẳng hướng lên trên.', 'https://youtu.be/r71Ibsh4DZo'),
(1, 'k', 'Ngón trỏ duỗi thẳng, ngón giữa duỗi thẳng hơi chếch ra (hình chữ K).', 'https://youtu.be/t9DI9HuJTqw'),
(1, 'l', 'Ngón cái và ngón trỏ mở rộng tạo thành góc 90 độ (hình chữ L).', 'https://youtu.be/SjontBGr5IY'),
(1, 'm', 'Ba ngón (trỏ, giữa, áp út) duỗi thẳng và hướng xuống dưới.', 'https://youtu.be/OvAUtBLUEnk'),

-- Topic 2: Cảm xúc tiếp theo
(2, 'ghen tỵ', 'Sử dụng cấu trúc tay chữ G, biểu thị sự ghen tỵ.', 'https://youtu.be/TXsfqfdV_GE'),
(2, 'hứng thú', 'Hai tay xoa vào nhau hoặc cử chỉ thể hiện sự mong chờ.', 'https://youtu.be/aoDZqLcyxNg'),
(2, 'lo lắng', 'Hai tay xoa ngực liên tục hoặc đan tay xoay vòng.', 'https://youtu.be/ZZZk9GGWHZo'),

-- Topic 4: Động vật tiếp theo
(4, 'chim', 'Hai tay khép, đưa sang hai bên vai, vẫy lên xuống.', 'https://youtu.be/TojtVMYba6Y'),
(4, 'chó sói', 'Ký hiệu chó kết hợp mõm dài.', 'https://youtu.be/YjnjdmiLG8c'),
(4, 'chuột túi', 'Hai tay co trước ngực, cơ thể nhún nhảy.', 'https://youtu.be/_uTXxdfvKgk'),
(4, 'hươu', 'Tay chữ V đặt lên đầu (sừng nhỏ).', 'https://youtu.be/bkVKOlKuHK4'),
(4, 'hươu cao cổ', 'Mô tả cổ dài vươn lên.', 'https://youtu.be/DZ8LsUAHOQE'),
(4, 'khỉ', 'Hai tay khum, gãi vào mạn sườn và má.', 'https://youtu.be/uR_xJjkSz7c'),

-- Topic 5: Gia đình tiếp theo
(5, 'chị gái', 'Dấu hiệu nữ giới + thứ bậc cao.', 'https://youtu.be/I8of6I_WyXs'),
(5, 'em', 'Dấu hiệu thứ bậc thấp (tay đặt thấp xuống).', 'https://youtu.be/UTRwy-YE03w'),

-- Topic 6: Sức khỏe tiếp theo
(6, 'hiệu thuốc', 'Mô tả nơi bán thuốc/nghiền thuốc.', 'https://youtu.be/rRTi0YNRYnY'),

-- Topic 7: Cụm từ phổ biến
(7, 'hẹn gặp lại', 'Vẫy tay chào + cử chỉ hẹn gặp.', 'https://youtu.be/qvuXOWh4yWQ'),

-- Topic 8: Phương tiện
(8, 'khinh khí cầu', 'Hai tay khum tạo hình cầu lớn, đưa lên cao.', 'https://youtu.be/W6Xjc47TS2A'),

-- Topic 9: Thời tiết
(9, 'gió', 'Hai tay đưa qua đưa lại trước mặt.', 'https://youtu.be/lnTzLEr2nTs'),
(9, 'lạnh', 'Hai tay ôm lấy người, run rẩy.', 'https://youtu.be/Zh1TJLkeavE'),
(9, 'mát', 'Tay quạt nhẹ tạo gió mát.', 'https://youtu.be/XR0u5QN-fY4');

-- ==========================================================
-- 4. TEST_QUESTIONS (Giữ nguyên logic cũ cho các Flashcard ID 1-21)
-- ==========================================================
INSERT INTO users_testquestion (question, option_a, option_b, option_c, option_d, correct_option, flashcard_id) VALUES
('Đây là ký hiệu nào?', 'a', 'ă', 'â', 'b', 'A', 1),
('Đây là ký hiệu nào?', 'â', 'ă', 'a', 'c', 'B', 2),
('Đây là ký hiệu nào?', 'ă', 'c', 'â', 'b', 'C', 3),
('Đây là ký hiệu nào?', 'c', 'b', 'â', 'a', 'B', 4),
('Đây là ký hiệu nào?', 'b', 'ă', 'c', 'â', 'C', 5),

('Đây là ký hiệu nào?', 'cảm ơn', 'bực bội', 'a', 'â', 'B', 6),
('Đây là ký hiệu nào?', 'bực bội', 'c', 'cảm ơn', 'ăn', 'C', 7),

('Đây là ký hiệu nào?', 'ăn sáng', 'b', 'c', 'ăn', 'D', 8),
('Đây là ký hiệu nào?', 'ăn', 'ăn sáng', 'c', 'd', 'B', 9),

('Đây là ký hiệu nào?', 'con báo', 'cá sấu', 'con nai', 'con dơi', 'B', 10),
('Đây là ký hiệu nào?', 'cá sấu', 'con gấu', 'con báo', 'con cọp', 'C', 11),
('Đây là ký hiệu nào?', 'con dơi', 'con nai', 'con báo', 'con cọp', 'D', 12),
('Đây là ký hiệu nào?', 'con dơi', 'cá sấu', 'con báo', 'con gấu', 'A', 13),
('Đây là ký hiệu nào?', 'con nai', 'con báo', 'con gấu', 'cá sấu', 'C', 14),
('Đây là ký hiệu nào?', 'con gấu', 'con nai', 'con cọp', 'con dơi', 'B', 15),

('Đây là ký hiệu nào?', 'bà', 'anh trai', 'buồn', 'con', 'B', 16),
('Đây là ký hiệu nào?', 'anh trai', 'con', 'bà', 'bố', 'C', 17),
('Đây là ký hiệu nào?', 'con', 'bà', 'bố', 'buồn', 'C', 18),
('Đây là ký hiệu nào?', 'bà', 'anh trai', 'con', 'buồn', 'D', 19),
('Đây là ký hiệu nào?', 'buồn', 'con', 'bố', 'anh trai', 'B', 20),

('Đây là ký hiệu nào?', 'bệnh nhân', 'ăn', 'con gấu', 'bố', 'A', 21);

-- ==========================================================
-- 5. SEED DATA CHO USERS & LOGS
-- ==========================================================

-- Lịch sử làm bài test
INSERT INTO users_usertest (user_id, test_id, user_answer, is_correct, attempted_at) VALUES
("2NJj1", 1, 'A', TRUE, NOW()),
("2NJj1", 2, 'B', TRUE, NOW()),
("2NJj1", 3, 'C', TRUE, NOW()),
("2NJj1", 4, 'B', TRUE, NOW()),
("2NJj1", 5, 'C', TRUE, NOW()),
("2NJj1", 6, 'B', TRUE, NOW()),
("2NJj1", 7, 'C', TRUE, NOW()),
("2NJj1", 8, '2', TRUE, NOW()),
("2NJj1", 9, '3', TRUE, NOW()),
("2NJj1", 10, '0', TRUE, NOW()),

("aFH57", 1, 'B', FALSE, NOW()),
("aFH57", 1, 'C', FALSE, NOW()),
("aFH57", 1, 'D', FALSE, NOW()), 
("aFH57", 2, 'A', FALSE, NOW()),
("aFH57", 3, 'B', FALSE, NOW()),
("aFH57", 3, 'D', FALSE, NOW()), 
("aFH57", 4, 'A', FALSE, NOW()),
("aFH57", 5, 'B', FALSE, NOW()),
("aFH57", 6, 'C', FALSE, NOW()),

("MEzHh", 1, 'A', TRUE, NOW()),
("MEzHh", 2, 'C', FALSE, NOW()),
("MEzHh", 3, 'C', TRUE, NOW());

-- Tiến độ học Flashcard
INSERT INTO users_userflashcard (user_id, flashcard_id, learned, last_reviewed, correct_count, wrong_count) VALUES
('aFH57', 1, TRUE, NOW(), 3, 0),
('aFH57', 2, TRUE, NOW(), 2, 1),
('2NJj1', 3, FALSE, NULL, 0, 0),
('2NJj1', 6, TRUE, NOW(), 1, 0);

-- Phiên học AI (AI Sessions)
INSERT INTO users_aisession (id, user_id, start_time, end_time, result_summary, feedback) VALUES
(1, 'aFH57', NOW() - INTERVAL 15 MINUTE, NOW(), 'Độ chính xác: 92%', 'Nhận diện chính xác các ký hiệu A, B, và 5. Cần luyện thêm phần "Cảm ơn".'),
(2, '2NJj1', NOW() - INTERVAL 10 MINUTE, NOW(), 'Độ chính xác: 85%', 'Cần giữ tay ổn định hơn khi ký hiệu các chữ cái.');

-- Log chi tiết AI
INSERT INTO users_aisessionlog (session_id, frame_time, recognized_symbol, expected_symbol, is_correct, ai_explanation) VALUES
(1, NOW(), 'A', 'A', TRUE, 'Nhận diện chính xác hình dạng bàn tay.'),
(1, NOW(), 'B', 'B', TRUE, 'Góc nghiêng tay hợp lệ.'),
(1, NOW(), 'C', 'C', FALSE, 'Ngón cái chưa cong đủ để tạo thành hình chữ C.'),
(2, NOW(), '1', '1', TRUE, 'Đúng ký hiệu số 1.'),
(2, NOW(), '5', '5', TRUE, 'Bàn tay mở hoàn chỉnh.');

-- Nhắc nhở (Reminders)
INSERT INTO users_reminder (user_id, topic_id, message, scheduled_time, is_sent) VALUES
('aFH57', 1, 'Ôn lại ký hiệu chữ A–B lúc 19:00 tối nay nhé!', NOW() + INTERVAL 1 HOUR, FALSE),
('2NJj1', 3, 'Đừng quên luyện tập phần "Cảm ơn" trước khi đi ngủ!', NOW() + INTERVAL 2 HOUR, FALSE);