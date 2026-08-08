Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3426CC5B56F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69ECE10E6A7;
	Mon, 10 Aug 2026 06:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jDC9JUiz";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8594310E085
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Aug 2026 21:10:48 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-ca7c1176317so496215a12.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Aug 2026 14:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786223448; x=1786828248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+ZnZdNInXJH3ydcuEXxhiXYZkKv9ONVp9lgUwHUOreg=;
 b=jDC9JUizbBnYiWopSTp5UJIBZ4zoA2Xb+02RaWgr1JzIzy5LO9UEpYAbNGnVoC1J5W
 yEX+wozS3YdAqeLN8+tOjaEBn0bF0zpScGGZInZQw6nEPmH1eN5g8hKDVO7aunWNTH8u
 a1WvLPQ3ZLYK55xEFESwKr65P1llGSG/2TQIMVcOrGpLfVcBc0daW9FCl/YIjVZSgf4j
 xHH9WA1H3rDaOK9sbYg+ljX6r17emMd6NVb/6y7JQ2yIf52xTA/R1xF+ZX+p4Gr6C6K2
 BxzJqmqzEztQXkLkbJiEF5wbBOTlagGgt8PQDvdGKq+a092DoZXVOj4JKomadc2W4FOu
 RAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786223448; x=1786828248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+ZnZdNInXJH3ydcuEXxhiXYZkKv9ONVp9lgUwHUOreg=;
 b=XvmjZib1UNRu1Sv/YTGa9t49XGWYGFHXSummFJaz2JFUG1pixo8HCseWlYHXHzh3oa
 8mBX+bbJUEXxHOG6TUUpmV85Et40MY8oZw3FcOYY4PzN+EE0Irxrud4XEzRbsx96qh8R
 JEqEjQr3XjNy5YijDlZm8RS88Q0aVKp3m4iraJgSPoxtGWvw354CdMSOtRBWJgW1ybyX
 IYvd2sREMW174tAUnhDBTWb69Aql2RZ973VEiRU1qvNYsWOaXM1tIedPzcKQT66siVu8
 ZxXlLV5V0YixRULjeyTeg6GFVVzV421+9HNneC+6zcco1A60mZQ8dTOb9c3Ozg3MCfbB
 mQOg==
X-Gm-Message-State: AOJu0YxrjL3C4okgzsdMUTfIL14P55coDY0E1ro2Up8zJybLdp0fMHaH
 9EDbvTJ3l8OOiIYH0q9ldz8btFTSq49zhW6RSCtEuTi9IoewKjgv57X1
X-Gm-Gg: AR+sD10tQGujM3kKoqzZOaXg/kw0UlRiBle0cpxbo+/sZGhfy1hBn+YQ6Mpj1jfgVV1
 PEJHKVAo1Ab7BiB4c/QpAsX3h6d2XqFw4P9fL7q5zmRkJ3wKez6pcoqOmcLuUXnA+YO8KDMuKiR
 nJ5ZJCs0H2kqwcCbCL+vRY0Kl6f0Tz5LrA0TiOyfDtCkIk8Q2HbUZLn6CWTzFgNCtHPLdb5k2aA
 A0qNxPG28LGbf6jsv7Xv7D67c87jcchFWuyQfXiF/dCD5VXe+wUfremT4GRIRzDhz2Vac2h+7lN
 hxgE7oz7IQvL/F6EGrnVtRgB+UFf6KTLaj84WCzDf45sPHjtHvcHhvhEeSs8OboSMFzUM/9F+6L
 mXCVjJEYdaFw0yDAQDkURjZsBRq28A2cfItB9OA2P00MUXObtMmKHMfvcG/+2R8ZHgoUPljBsh+
 oFrajZUoN4r0YGgxTw2OQAoL0N+LbITfTMDitfQTr5DtOAiYk9nFlL9rt7if8UBsS025x/owY5C
 phf6cmL4eE=
X-Received: by 2002:a05:6a20:3949:b0:3c3:a9ad:a747 with SMTP id
 adf61e73a8af0-3cbce92f86bmr9478414637.26.1786223447996; 
 Sat, 08 Aug 2026 14:10:47 -0700 (PDT)
Received: from localhost.localdomain ([103.178.204.72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315bec5aac2sm25713133eec.30.2026.08.08.14.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:10:47 -0700 (PDT)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com, simona@ffwll.ch,
 Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH 5/5] drm/amdgpu/aca: Fix off-by-one buffer size parameter in
 add_aca_sysfs
Date: Sat,  8 Aug 2026 21:08:52 +0000
Message-ID: <20260808210852.2938-6-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
References: <20260808210852.2938-1-sreekuttan2156239@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

snprintf() guarantees NUL-termination within the size limit specified by
its second argument. Passing 'sizeof(handle->attr_name) - 1'
unnecessarily reduces the usable buffer capacity by one byte, causing
sysfs attribute names to be truncated early.

Pass 'sizeof(handle->attr_name)' directly to snprintf() in add_aca_sysfs()
to allow full use of the allocated buffer space.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
index 47f3bcd5de0b..99c315283f06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_aca.c
@@ -682,7 +682,7 @@ static int add_aca_sysfs(struct amdgpu_device *adev, struct aca_handle *handle)
 {
 	struct device_attribute *aca_attr = &handle->aca_attr;
 
-	snprintf(handle->attr_name, sizeof(handle->attr_name) - 1, "aca_%s", handle->name);
+	snprintf(handle->attr_name, sizeof(handle->attr_name), "aca_%s", handle->name);
 	aca_attr->show = aca_sysfs_read;
 	aca_attr->attr.name = handle->attr_name;
 	aca_attr->attr.mode = S_IRUGO;
-- 
2.54.0

