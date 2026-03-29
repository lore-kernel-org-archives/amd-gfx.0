Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E74F3D60A
	for <amd-gfx@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86F3510E0DB;
	Sun, 29 Mar 2026 16:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qusw+/PW";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B268F10E0DB
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 16:03:11 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fe2024a9so26015675e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 29 Mar 2026 09:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774800190; x=1775404990; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g5YxyZX+ZQH3uTx9eO+hVr1f6zQnbPrR/m207Wzy/FA=;
 b=Qusw+/PWXInTdpAA1Sk75XmpXx3FKlyjEeHdDOgFHyFtLIX4SpGLlLSL4HUAPRb3CQ
 TkhoW5wG1M1wo7Q7Muy8eUqaqO0OUgVBvaWsZ/weeCnUTnk5Vdsc3aKN/1Mu8ucWWiEv
 CQW5LZZiQQUpSsXEoMHCE8VVByn+lcpNO39OTybjd0pAGBEyt2sfergDbHdF8XtVxFdm
 fajGP8esjrNj7u4m1F71jDQWG/NkQhLzd85UTW5No6oApPg3ms/UZJ2kMtjpN+rhkAy6
 YNL+NpMReUtlST9ajGVC6putCR8osuzsi2YVeM5Eaw4BHmXr2Hvrd7zRPP2B7SYqushM
 i1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774800190; x=1775404990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g5YxyZX+ZQH3uTx9eO+hVr1f6zQnbPrR/m207Wzy/FA=;
 b=F69kmddBt53g2tpE0JZV4qGsig/gXzGlJ2d9AXvJzWgBn5Rdg+Ld7oiqdPw/wDUYPU
 OClzIH6mwGajV43S3ypty5/RAdgd0j0MYqsQxlTrGteWQcBwRwba6qERIiwA+RaBnAz7
 0eOfU67a3NM3Fo4cDQxnNxzGWxses0UckGOrMQBrtR2tVf1xdWJ5SxvyaIKEL2FiHIe9
 HgyrQttAmrAaC66TY8KOVK/iBUVczeTPBLhSGivel6WSCKBACjl/JxcRrpmPeGyVq9pH
 t/v5TLIKFYHy1GpR9Xh1AgUB/ADpekckZxuXXiprjaPf08RZGeD7EpfmgVIoypf28Utq
 GYLw==
X-Gm-Message-State: AOJu0YzhWwRftHmRZ51eaWYWMCJ/oslh0sL5RVuLOKNUmmnLOZE9gCd0
 jdyYMFlkh5QMV8hpCa9W4AM7HsfzEKIKqO1g5KtX7X3ka0J7/KB99WjlWik6cA==
X-Gm-Gg: ATEYQzxNXohresz01sJw0z5PyVBqkJnkBDZBL6pVTDGxPdSBHWs2bdKm34vZceVGIe/
 uGCWRyv8yaez2iC/hWFv/NOxDhcSeTCPSJMJWY0RQ5wDl8wcZP2Or7WSEXRz5leL7z29BhU+cZm
 J9tcXDLbis4Krj8jLT2V4YReKTp/FN4c5Rlj0NsObKqBWhdBvqFS09wPDXoGdFhxCp4uy8jS2tT
 2soXU35vurJPO1UI6RnplnIL6BLbKveBbe4KnJtNoBLY1chpHL5OJ0ANhAQTrChOb1YLy4lYTjX
 Mn7xO5U+qCgltB9H2iON0XxNChxMP9mxPcsEN2bGfgUAPhKPbuaodOpluKI25Kp5FpNaKAkHqHD
 5mTv8iNlEF2DQbzzKJ8AetmGs/l/BUU1V78L3ZlLzURBM1WbBYg5zXzeEcGELZ5T/vzua0fL9oW
 BcLjruq0QLMF1QMKimSiB2OkZI8ik+GkL20Kq0tu+yVtqtoAqYJKPaLK47xsfzJLdpXXw=
X-Received: by 2002:a05:600c:a106:b0:485:4394:b0e with SMTP id
 5b1f17b1804b1-48727d882bamr118059675e9.12.1774800190145; 
 Sun, 29 Mar 2026 09:03:10 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1BC26F.dsl.pool.telekom.hu.
 [94.27.194.111]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d38a5fsm217428915e9.12.2026.03.29.09.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Mar 2026 09:03:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/9] drm/amd/pm/ci: Use highest MCLK on CI when MCLK DPM is
 disabled
Date: Sun, 29 Mar 2026 18:02:58 +0200
Message-ID: <20260329160306.3417458-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160306.3417458-1-timur.kristof@gmail.com>
References: <20260329160306.3417458-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

When MCLK DPM is disabled for any reason, populate the MCLK
table with the highest MCLK DPM level, so that the ASIC can
use the highest possible memory clock to get good performance
even when MCLK DPM is disabled.

Fixes: 9f4b35411cfe ("drm/amd/powerplay: add CI asics support to smumgr (v3)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
index ad1fd3150d03e..858f118130452 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/ci_smumgr.c
@@ -1322,6 +1322,14 @@ static int ci_populate_all_memory_levels(struct pp_hwmgr *hwmgr)
 			return result;
 	}
 
+	if (data->mclk_dpm_key_disabled && dpm_table->mclk_table.count) {
+		/* Populate the table with the highest MCLK level when MCLK DPM is disabled */
+		for (i = 0; i < dpm_table->mclk_table.count - 1; i++) {
+			levels[i] = levels[dpm_table->mclk_table.count - 1];
+			levels[i].DisplayWatermark = PPSMC_DISPLAY_WATERMARK_HIGH;
+		}
+	}
+
 	smu_data->smc_state_table.MemoryLevel[0].EnabledForActivity = 1;
 
 	dev_id = adev->pdev->device;
-- 
2.53.0

