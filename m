Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06842D20692
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Dec 2025 13:40:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BF010E981;
	Thu,  4 Dec 2025 13:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGjcutSO";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B387F10E95A
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Dec 2025 13:20:23 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-47774d3536dso9329445e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Dec 2025 05:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764854422; x=1765459222; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YklG8feiR5FU/k+rcsWunlToF1mBL/k2qOqrOj6/0mM=;
 b=dGjcutSOBWPiEev/EZaudR/GqLd0z6CzAvEGWJ/CQs3lotnTAFzTVVQb/dLvCFM7pM
 Q30ZSq6vZMIkY6/8Ge0kn0h7HoHJ+ZkrSeCqYUdxMJrGNf1WDmVQE9wfo4WPyndRZDhF
 RZJ9C8WYH/2jqHz7QbgTjT09MxhbhMJ0CNQRPPKejp7dsLpeugVBugEIJjl6+82r5isL
 K+8iR7R//xTo+1E8hUSiV9/mvOgjwYMtmm+rRbrHGwH7bg1uRm79K5b1ZVXeWplidC+J
 5UIx/asSKzrKNvPebAccyyAwqOzUIOkorWVOmQznkb0VFJwJim8qpbkTxBxcUe90BkKH
 X2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764854422; x=1765459222;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YklG8feiR5FU/k+rcsWunlToF1mBL/k2qOqrOj6/0mM=;
 b=AF8mK1lr4s7mI2JhwpCVgxzZtfkjBynP9onnz7WaQbs+OxggZ+Em90rQZxEpxN/TH7
 AQgIc5cvMQjJwzeqs/ywBsQUe2d+QR+DC4/dBbAHNV4LQYuHXQTQTiver2SuZOSTZLrJ
 vCngYjXCqFl/rPSuY0OqHYygjy1VOkwiJ9L0eLq/OjBoBjEqUnP59gprRIzy4vArXmGG
 9AsHeegxfDGKVvtv3mPXLsV2uwheO/cstWf7OWTrVJjfKcINCQ2tZgnLrn+KOLghWDZk
 +UNvrv75VD6eNn2JZ8APLdJ65ZhujNJqq4Sn/tSrATKKX4o0DaKpB3toDoz/yzkJ/9B4
 OMHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm6JxbPYRST9ukn8BOdf6zryTJCHhQlEeXwkOLikM8bGA6y3/QSMhQ2up0IeDSamR5efca26sz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywqs6M8vo4yatDTw7wn25DIEUQTMZN7FmwOIp3HBAZzVIi3KUbc
 1c3Do61xYPd13TQocH9BYXw2NHwoApGQnHc79AuHojvKlddH2duWFoauJXPlZK2Xam4=
X-Gm-Gg: ASbGncv4nTH64jUIcG1HSOb89hatDjvS6RUqu3Crbdmu1nuzPkhGjCiqvnybFiPxIPF
 JI2yrsJ5XvHs16YzDLqeYybdjKPosgUopREKJoefCXwuU+FwAr6ao3IfkIGEo3Dd8pngPcgLqKx
 De4GsFFq7OacZ7/oCOCKUnOSjqv7sYHNa9OyNQ/jT4SZPbeqn8EHIyl+V9TAmtwgxi8lMtz9QrI
 hU1FoDuqORhQ3VaAJjE5QJFix9lVqvKSOGgfBYy/nil4UVI/mI2UH47Z/iU1oQiFVTBFp8LZvrk
 rIu8DuSLSbU5ZIZBsiUKDA8YOUuH29ZhfL2AtlY4ymmBYy9pLVaKJRhjEJcimHJUkygP/hRSU/i
 xEkS2HEe3OD3Bd4OLTgVMl6/t/g8PbRqqRUzT4+1Ty1V0hirk/lLghTACfVtEuTFaHVbwwfCC2E
 8UPKE04f8lnakcR7AibMYqrlKAJmsibsv86TlO
X-Google-Smtp-Source: AGHT+IFcjjEFgmXKpF7SlmgB5UtUoXukvdBKYhqBaRbor0ZYnolgBTjOqdu8w3shLE1sDh0KfSPfjQ==
X-Received: by 2002:a05:600c:a07:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-4792eb10ddcmr30456395e9.3.1764854422033; 
 Thu, 04 Dec 2025 05:20:22 -0800 (PST)
Received: from localhost (h1f65.n1.ips.mtn.co.ug. [41.210.159.101])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-479310b8e70sm31237805e9.5.2025.12.04.05.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 05:20:21 -0800 (PST)
Date: Thu, 4 Dec 2025 16:20:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hersen Wu <hersenxs.wu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "ChiaHsuan (Tom) Chung" <chiahsuan.chung@amd.com>,
 Roman Li <roman.li@amd.com>, Peter Shkenev <mustela@erminea.space>,
 Timur =?iso-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Alex Hung <alex.hung@amd.com>,
 Kun Liu <Kun.Liu2@amd.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amd/display: Fix debugfs output in dp_link_settings_read()
Message-ID: <aTGKkpf2p-Dqg5RL@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:40:42 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This code passes the wrong limit to snprintf().  It does:

	str_len = strlen("Current:  %d  0x%x  %d  ");
	snprintf(rd_buf_ptr, str_len, "....

The limit should  normally be the number of bytes remaining in the
buffer but instead of that it's using the number of bytes in the
unexpanded format string.  So if any of the numbers are more than 1
digit then the output string will have characters missing from the
middle of the output.

Normally, we would do it like this:

	off += scnprintf(p + off, buf_size - off, "...

Also we can use cleanup.h magic to free the "buf" and
simple_read_from_buffer() to copy the buffer to the user as a bit
of a cleanup.

Fixes: 41db5f1931ec ("drm/amd/display: set-read link rate and lane count through debugfs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Not tested.

 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 94 ++++++-------------
 1 file changed, 31 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index cb4bb67289a4..028dfd0aa43d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -185,72 +185,40 @@ static int parse_write_buffer_into_params(char *wr_buf, uint32_t wr_buf_size,
  * check current and preferred settings.
  *
  */
-static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
-				 size_t size, loff_t *pos)
+static ssize_t dp_link_settings_read(struct file *f, char __user *ubuf,
+				     size_t count, loff_t *pos)
 {
 	struct amdgpu_dm_connector *connector = file_inode(f)->i_private;
 	struct dc_link *link = connector->dc_link;
-	char *rd_buf = NULL;
-	char *rd_buf_ptr = NULL;
-	const uint32_t rd_buf_size = 100;
-	uint32_t result = 0;
-	uint8_t str_len = 0;
-	int r;
-
-	if (*pos & 3 || size & 3)
-		return -EINVAL;
-
-	rd_buf = kcalloc(rd_buf_size, sizeof(char), GFP_KERNEL);
-	if (!rd_buf)
-		return 0;
-
-	rd_buf_ptr = rd_buf;
-
-	str_len = strlen("Current:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
-			link->cur_link_settings.lane_count,
-			link->cur_link_settings.link_rate,
-			link->cur_link_settings.link_spread);
-	rd_buf_ptr += str_len;
-
-	str_len = strlen("Verified:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
-			link->verified_link_cap.lane_count,
-			link->verified_link_cap.link_rate,
-			link->verified_link_cap.link_spread);
-	rd_buf_ptr += str_len;
-
-	str_len = strlen("Reported:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
-			link->reported_link_cap.lane_count,
-			link->reported_link_cap.link_rate,
-			link->reported_link_cap.link_spread);
-	rd_buf_ptr += str_len;
-
-	str_len = strlen("Preferred:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
-			link->preferred_link_setting.lane_count,
-			link->preferred_link_setting.link_rate,
-			link->preferred_link_setting.link_spread);
-
-	while (size) {
-		if (*pos >= rd_buf_size)
-			break;
-
-		r = put_user(*(rd_buf + result), buf);
-		if (r) {
-			kfree(rd_buf);
-			return r; /* r = -EFAULT */
-		}
-
-		buf += 1;
-		size -= 1;
-		*pos += 1;
-		result += 1;
-	}
-
-	kfree(rd_buf);
-	return result;
+	size_t size = 1024;
+	int off;
+
+	char *buf __free(kfree) = kcalloc(size, sizeof(char), GFP_KERNEL);
+	if (!buf)
+		return  -ENOMEM;
+
+	off = 0;
+	off += scnprintf(buf + off, size - off, "Current:  %d  0x%x  %d  ",
+			 link->cur_link_settings.lane_count,
+			 link->cur_link_settings.link_rate,
+			 link->cur_link_settings.link_spread);
+
+	off += scnprintf(buf + off, size - off, "Verified:  %d  0x%x  %d  ",
+			 link->verified_link_cap.lane_count,
+			 link->verified_link_cap.link_rate,
+			 link->verified_link_cap.link_spread);
+
+	off += scnprintf(buf + off, size - off, "Reported:  %d  0x%x  %d  ",
+			 link->reported_link_cap.lane_count,
+			 link->reported_link_cap.link_rate,
+			 link->reported_link_cap.link_spread);
+
+	off += scnprintf(buf + off, size - off, "Preferred:  %d  0x%x  %d\n",
+			 link->preferred_link_setting.lane_count,
+			 link->preferred_link_setting.link_rate,
+			 link->preferred_link_setting.link_spread);
+
+	return simple_read_from_buffer(ubuf, count, pos, buf, off);
 }
 
 static ssize_t dp_link_settings_write(struct file *f, const char __user *buf,
-- 
2.51.0

