Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A753C8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 21:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C64C010E58B;
	Mon, 25 Aug 2025 21:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IL8DG+KY";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8DA10E583
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 21:46:54 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3c79f0a5b8bso2048224f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 14:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756158413; x=1756763213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A/+sdLF85eJj55geRcXIlkK774YkLTPUenKjFLlnTYE=;
 b=IL8DG+KYPH2+uqSyZRg/qaF1sztjEfDhNf6eXth9lyKjITgwvUGkh1drm7hNdKy0j9
 DeUYKRTOxi7lTlhsWMZdXg7WOuccq4tFCXHNX32wYWt2CNOFCD8QGP/TYMdfJDrsoY1r
 QqCkv9imL1Xi93EfqLGOcE3B5dWTcvz6najSgZ8n/9XmzLif2xWYlZky2QGRRyc6nQnB
 Z8QhoaLa9Zb21HfFo0f6Bq7xDTyjfwpJDMfKwpAJguBKpUAkoGtPQr+fnlLcexod2HmP
 JBvRF9tnaNxlCAUL6YBPqL+BNGUKT0X8vX3qZOyDTNe8TrABKOYdTsvfLmt64D4UKU3T
 wOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756158413; x=1756763213;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A/+sdLF85eJj55geRcXIlkK774YkLTPUenKjFLlnTYE=;
 b=j22jtUd4koww2m6EO2pKGoTy/CNo5DQQzX7z+gtD4LVtleFFEfBmaXV0zluE0o32hv
 xnm/aRd2+99Rx5w775hRPX0hZbU+KOcpFYT7Gygkvwfqp3BeVBQsJfEXZs5uw1SCyAdK
 o9AFLP2Ng/u528N+XK625HJ2V2D2dc45gJ4C9q7STXfI5OzvmgjbM8Aa3LVXGkW/bClL
 Pd8lPfscDcJSbMTbC/aPWIBwUwJXdcIkkxkDgXb65Nujo/nQWcS9Tr56Gz5JoZxnj6tm
 nYJIgYoIfeZQz/i+qwPv37UUP+nwlH1pajVF1Kaj10zR7KaEsRZj2cpsn6TmuChyxeBV
 cx2A==
X-Gm-Message-State: AOJu0Yxnc6FdDqCc4zwk2hjj1FKLsyMGSCSQbTr2XWMtm39+5U5vxr/Q
 rATmFR0j4HnrY15dfE3hDy1yKQp5csYr4/mEQFjPOCdWOn5Ko1PmyAhxIvVXYA==
X-Gm-Gg: ASbGnct7WlGOAQbxMPP3vkEUVe6AFTVxoiJMTRmqbtgaKl863bqSeQlCSNbrPZJLvWK
 S+nJLH6YFy50XRA87YKrgPAkOSAaneiLLdl31V09Xz34H6zuei8E4YxmszwMO3pyLpro+b4XS2M
 pGQbN2Khyk6B/R6ASZTd/d9N8cLZ4kWAwBX++Hz2AupSXl4wnQn9RV6hLni/3KQDrZ/SkEmUZ6a
 E9lceHPksfhXIXfLdjxkgHhTCrOEt+EBq389CLxnWTebE/otVHpPpcgOKMgTJ4MTKo5nHjz48qo
 xMRFozetJIENfWo9qCfk30KCpWsHsBYS6oK7c2bz/gpasdgFY7RLzK7nde/I9F/5y6zNCTTG2QI
 lZPrCH31gc4IQTvsUyofj4igPbvbLA+n3jfMB3ErhtLLuU5KMkYjM2HPYphQUGzDxIkBPetztPd
 vMOi6+FPLf07tzfpvGPVlAWiOVBQ==
X-Google-Smtp-Source: AGHT+IECkWSAZ3/nT1crL38DiySYbRwSig6LlSgvIRWANu/U1FEyGKjnMvzZq/Mp4NHRV4T9HWf5TA==
X-Received: by 2002:a5d:64e9:0:b0:3ba:c0d2:3985 with SMTP id
 ffacd0b85a97d-3c5dac17402mr8818142f8f.7.1756158412525; 
 Mon, 25 Aug 2025 14:46:52 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c7117d5977sm13348110f8f.51.2025.08.25.14.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 14:46:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/8] drm/amd/pm: Fix si_upload_smc_data (v2)
Date: Mon, 25 Aug 2025 23:46:30 +0200
Message-ID: <20250825214635.621539-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825214635.621539-1-timur.kristof@gmail.com>
References: <20250825214635.621539-1-timur.kristof@gmail.com>
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
This seems to fix an SMC hang that happens in si_set_sw_state.

Fixes: 841686df9f7d ("drm/amdgpu: add SI DPM support (v4)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 26 +++++++++++-----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 33b9d4beec84..b16009d342c3 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -5834,23 +5834,23 @@ static int si_upload_smc_data(struct amdgpu_device *adev)
 	if (amdgpu_crtc == NULL)
 		return 0;
 
-	if (amdgpu_crtc->line_time <= 0)
-		return 0;
+	int first_crtc_id = amdgpu_crtc->crtc_id;
+	int first_crtc_line_time = amdgpu_crtc->line_time;
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_crtc_index,
-				       amdgpu_crtc->crtc_id) != PPSMC_Result_OK)
+	if (first_crtc_line_time <= 0)
 		return 0;
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
-				       amdgpu_crtc->wm_high / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_crtc_index,
+		first_crtc_id);
 
-	if (si_write_smc_soft_register(adev,
-				       SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
-				       amdgpu_crtc->wm_low / amdgpu_crtc->line_time) != PPSMC_Result_OK)
-		return 0;
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_min,
+		amdgpu_crtc->wm_high / first_crtc_line_time);
+
+	si_write_smc_soft_register(adev,
+		SI_SMC_SOFT_REGISTER_mclk_change_block_cp_max,
+		amdgpu_crtc->wm_low / first_crtc_line_time);
 
 	return 0;
 }
-- 
2.50.1

