Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8FECA0EC2
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 13:42:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFC410E53E;
	Mon,  4 Aug 2025 13:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ezs+qJwj";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9366C10E53B
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 13:42:01 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45994a72356so11775885e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 06:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754314920; x=1754919720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1zqBrACZHazW9xk0L5enad8a/HETC5tkDS4OEdO0/WU=;
 b=ezs+qJwj9JlBUfHXbLS0GEQTqxyJJFxb6dsVOrIb9rCW7AruIe+SXaYu2dKOZV2Li8
 Uyg+CGoteR7jMtfYMYDcBumBLKnulQ7wq1KWktCbrQfLzsH8t4jFKu2LWLVqzLo2wVEv
 uGVTMtVMDemOi5tnJqh+yFMGB5cTams4FOZMMFl3wm436Ffjdda1Ovv6uhoDipI27EnV
 aQCRnnqqiJJyVhWYnFumFf9lbVwVOn9TT7m+Kg8ylBXB5xgkE8SoFvTQtQ8zAYQ2p6jk
 b9d+TjeBgO3+9bx4X5PEf/B9xRnciSPLM1LcKRxU8AIjAcd1IwdP3y37DxLw9fBaf0Ao
 i2iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314920; x=1754919720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1zqBrACZHazW9xk0L5enad8a/HETC5tkDS4OEdO0/WU=;
 b=dDPlqUqehno2QGBC/lU3b9F4USD17WeHSQ22ComsAsDF46436gsIQghtN2BKnsbynh
 WjAXKD79HIpKucQgLNsTMH3yJ3g4qE7zq8Zuigolc74hpXMbc6iiwtBmwbJTROErXUW8
 DqNIPTsaNZUMR52m0L82AjM2wYxNVbXK9SQ9LeDIXlJllj7+Y+yifj6YxErbfvFgqFqR
 wheI5RmtlSTjvHNNS20z2YK5T8yZf78fw6+p6rmluJD9iA7r+tCQUlUIHnKZNgSWXCZQ
 3audS5rrEydM7CZrIcHcgH4kNJQvaTGDvcuYJMJR6DvKwEAU4B45hBpyIPeLtFsFZGmd
 EroA==
X-Gm-Message-State: AOJu0YxZpM8ph/KHzmrP1Bog52IDp0q2DItKk2VK0xhl9B9d/qsHzsQY
 S+Wz40uk6cxOWIMXHRRwGE4uGw2y4U/8Ob7v7FRuFn5BnqB9MyVQumUU890TNA==
X-Gm-Gg: ASbGnct78jGeGxEetLLtPp9is90vn0VoyAxKqiOrsJIe2WjbXzy2NxJv3ofLlSqf8jB
 JNSETrf6NcXGf3BfbtgglFY6LX99ZaAvEsTi5KOcAR6dBNI9UiU/Mzy7dvgJYT9Mgar3Ndt5BK1
 EAYGyqNrriLr2+G+r/xFTOi5Yqh3/xKq1/f2UTMSTgJQ2JbeOLrjuiJXESiMSvMruKQBaRWZYCs
 6ySII4sFYsWI1o7rlG/ex0WbBWgsNmcqbhIPFpwD2tTx6v974xz9ovILE4rzUkQ9CWNznSww/Nb
 pgM7Ijo515pApvBHL1VK4TlhjBJG9Othr6ty/AEiHNiNVITy9JCSUiRBJmJdHMK0ZqDGUCiw/aD
 Wb6G2AQBu9mx9DyFtj75pIvBPGLyB9QZZVeQ5krCcIVMjJGWtiuZut3cBBDzFonbp0oq0Ti3I2o
 VzawLEyVk7z+V3bagNJ8bw3kskpeE1A8QoCOib
X-Google-Smtp-Source: AGHT+IEn0YuHoE8oQnDuufuQZKgeIt+jblvnpaGGspTe2ydM/Qn6VJId5nSfO45ts7/+61D7fZgOUw==
X-Received: by 2002:a05:600c:4f08:b0:459:dfa8:b85e with SMTP id
 5b1f17b1804b1-459dfa8bd26mr10456925e9.0.1754314919679; 
 Mon, 04 Aug 2025 06:41:59 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24DABD00A4734C1D2078832B.dsl.pool.telekom.hu.
 [2001:4c4e:24da:bd00:a473:4c1d:2078:832b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589ee621adsm172056395e9.30.2025.08.04.06.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 06:41:59 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/6] drm/amd/pm: Fix si_upload_smc_data
Date: Mon,  4 Aug 2025 15:41:52 +0200
Message-ID: <20250804134154.95875-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250804134154.95875-1-timur.kristof@gmail.com>
References: <20250804134154.95875-1-timur.kristof@gmail.com>
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

The si_upload_smc_data function uses si_write_smc_soft_register
to set some register values in the SMC, and expects the result
to be PPSMC_Result_OK which is 1.

The PPSMC_Result_OK / PPSMC_Result_Failed values are used for
checking the result of a command sent to the SMC.

However, the si_write_smc_soft_register actually doesn't send
any commands to the SMC and returns zero on success,
so this check was incorrect.

Fix that by correctly interpreting zero as success.
This seems to fix an SMC hang that happens in si_set_sw_state.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 31 +++++++++++++---------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 33b9d4beec84..e9f034ade214 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5820,6 +5820,7 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_crtc *amdgpu_crtc = NULL;
 	int i;
+	int ret;
 
 	if (adev->pm.dpm.new_active_crtc_count == 0)
 		return 0;
@@ -5837,20 +5838,26 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 	if (amdgpu_crtc->line_time <= 0)
 		return 0;
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_crtc_index,
-				       amdgpu_crtc->crtc_id) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		adev,
+		SI_SMC_SOFT_REGISTER_crtc_index,
+		amdgpu_crtc->crtc_id);
+	if (ret)
+		return ret;
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-				       amdgpu_crtc->wm_high / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
+		amdgpu_crtc->wm_high / amdgpu_crtc->line_time);
+	if (ret)
+		return ret;
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-				       amdgpu_crtc->wm_low / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	ret = si_write_smc_soft_register(
+		adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
+		amdgpu_crtc->wm_low / amdgpu_crtc->line_time);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.50.1

