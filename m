Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48463C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39CC10EA16;
	Thu, 28 Aug 2025 15:11:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AInNYD/a";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E18310EA16
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:11:20 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45b49f7aaf5so6271905e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393879; x=1756998679; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6VcBRB5r+o395RQ21tXpVQBli8ohQDty4HTq3PJjEsM=;
 b=AInNYD/a0x4B38Q0ew6WqLw33zv9rdc66+la4negPq9ftw+by6LDIBxPINCXXYAi1o
 OK3C24s5tiriYzqUP63U0pX3jpb6UbjELkXldHr8ZeFIDqBt96ee9iE/BNFRT5t+5bp2
 Smqh5MzCtSCB8McAJXBRqeJQRP3dR5yLpPFKOvhxUZH9zNkPfuw+5MeJCQs0zWxcWaaM
 3swpBWbpnul/CUfyHEotWJs/5PBwk2Mi42pRBwZwPwdioDBrKmBpumFhZHUkdJx6jPjW
 DvG03vbpDXOkYjzYSupJkqJtbKZz9csDTNr3naovJr51eCOsLBDp290EaN0PKgKzZTsD
 Jp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393879; x=1756998679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6VcBRB5r+o395RQ21tXpVQBli8ohQDty4HTq3PJjEsM=;
 b=sBIgP6QjfMpFZaWyiqmABEIUR7IFU0sRGXz5lbQdmseOsqC4AuFfoZm5pPmFVearM9
 ZP+VhHDA0dvqo4PiEjnQ94GVaJHDKdMJtBLt9h9Qm8pUwhaNyGv9+OzPxapKcpyAFaxu
 hw1Ys8ABsdhdGxxbcJoQHTY1rSx7Hm2mPS5u4Rq5c7OICMJ1WjkguPkbehTRwAt0XoGI
 7ths5NcysGcl7mpBau3FgV97Ii0Nv1pV/Z5M5HkoStGazUfGolvUYsICN8YVfqN8QT0n
 5oaQeakzgAOihcIeUOWKjHoZvcIbvXYe0/e2goXH1Cx6Gzkr60Nkzdtw3njc/5XPuc4/
 uHSg==
X-Gm-Message-State: AOJu0Yyg/0WcOBPgQGVcTgmtIBAOylUZ7GfKu+g4FHgaIADplFLueSSU
 hDj4+4/7nBBUouYdBX5SvJ6fhtmQMTGTjQnokml2sK/orcP+OFkhm2yiZUqb+A==
X-Gm-Gg: ASbGncvxTzElNM7CR4QYm5EPTAEgkwKFdvUjtXZLbOXwBB8ANEfJoALHG7O3kQFOU6W
 MxD8sFJMPf+FBoqij281iMWKTkmyo7HRDBbjXPw7Q5Vna4G2O42i4sKY8meCZK3F007unUJEdhO
 JY+Gj4SpysvnYpVZnlqrICBVKh5k+ooBdM+T1sYVc/ccbrup0DCFY827zCkbju0reP0ekkBlepa
 VlWkDMGNIE3T7EA8Ew61zXgH0kXDpXiBoMcZLWJbLZRvDbtwlzjijuTX93WqgGnq7rGvTwvpZOv
 GzO9Svd2Bi9HjlF8DxNILyx3W1Kl5FmmmPc4NkXEsXThySBtQ8FSQKkNaL9RcudIrxi5vCZbq1y
 +1ELMIP6LUJ13WGv5LkmgN9+DjPYA4F+f6mN2UK7zcbCvIpujkHoEudUHQioN9JSolGkIXg9Pkk
 MX5IyvL5ZRsOr7R2DKAO5VVEJ0q7Rsg5P4zHk2
X-Google-Smtp-Source: AGHT+IH/NWCWcdkkUIWvvo8tUwVEf5TWZU2HszO5VRM3DYzRRNzoNSezcaTGxk8MqGGFmzC8zIom5g==
X-Received: by 2002:a05:600c:1f88:b0:45b:67e9:121f with SMTP id
 5b1f17b1804b1-45b67e91509mr122187755e9.16.1756393878505; 
 Thu, 28 Aug 2025 08:11:18 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f306bffsm77448875e9.16.2025.08.28.08.11.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:11:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/10] drm/amd/pm: Fix si_upload_smc_data (v3)
Date: Thu, 28 Aug 2025 17:11:06 +0200
Message-ID: <20250828151112.15965-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828151112.15965-1-timur.kristof@gmail.com>
References: <20250828151112.15965-1-timur.kristof@gmail.com>
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

Fix that by not checking the return value, just like other
calls to si_write_smc_soft_register.

v3:
Additionally, when no display is plugged in, there is no need
to restrict MCLK switching, so program the registers to zero.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 43 ++++++++++++----------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index e71070a23b91..6736c592dfdc 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5813,9 +5813,9 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 {
 	struct amdgpu_crtc *amdgpu_crtc = NULL;
 	int i;
-
-	if (adev->pm.dpm.new_active_crtc_count == 0)
-		return 0;
+	u32 crtc_index = 0;
+	u32 mclk_change_block_cp_min = 0;
+	u32 mclk_change_block_cp_max = 0;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
 		if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
@@ -5824,26 +5824,31 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 		}
 	}
 
-	if (amdgpu_crtc == NULL)
-		return 0;
+	/* When a display is plugged in, program these so that the SMC
+	 * performs MCLK switching when it doesn't cause flickering.
+	 * When no display is plugged in, there is no need to restrict
+	 * MCLK switching, so program them to zero.
+	 */
+	if (adev->pm.dpm.new_active_crtc_count && amdgpu_crtc) {
+		crtc_index = amdgpu_crtc->crtc_id;
 
-	if (amdgpu_crtc->line_time <= 0)
-		return 0;
+		if (amdgpu_crtc->line_time) {
+			mclk_change_block_cp_min = amdgpu_crtc->wm_high / amdgpu_crtc->line_time;
+			mclk_change_block_cp_max = amdgpu_crtc->wm_low / amdgpu_crtc->line_time;
+		}
+	}
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_crtc_index,
-				       amdgpu_crtc->crtc_id) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_crtc_index,
+		crtc_index);
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-				       amdgpu_crtc->wm_high / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
+		mclk_change_block_cp_min);
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-				       amdgpu_crtc->wm_low / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
+		mclk_change_block_cp_max);
 
 	return 0;
 }
-- 
2.51.0

