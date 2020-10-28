Return-Path: <SRS0=QeQy=ED=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F7CC388F7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:08:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19932247B1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2020 15:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwPIjUgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19932247B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2746E56A;
	Wed, 28 Oct 2020 15:08:17 +0000 (UTC)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1793E6E56A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 15:08:16 +0000 (UTC)
Received: by mail-qv1-xf42.google.com with SMTP id w9so2547611qvj.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Oct 2020 08:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzGtr6Mpm5zUnkt2TT5U/poJOgWa4LbMkJoF8vTjKqQ=;
 b=fwPIjUggtrZ7SGsIL6t6h6+rZ7BprGDsHAZO0Qho/mueOfb+28o0miK7xTWnKrSsxw
 oz0mDTiai8+RQlgTwvhmkydKm4mgjGGw3Ugyd4rUHs/RYl7QShOKHy6g3E75A1cbBOYr
 +Z2uO6pr7PcuFCs34kQXN1s7loui2//VcMIdohBzEpJGqvKG27WoEtMNekHjG5s0cBpg
 33BOW/EbxZAOMS+m4T7+ZMKoktwo11uqyMDs6EflUASlJKkPZV1Cerl1fXQCqJdjmEpp
 4bXC/DhqMuo4ziSM2EaaQXYo3KM96yuZX1yThRH+aesUmu6guG+XyHQV4C5raJj0H1oh
 OO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=gzGtr6Mpm5zUnkt2TT5U/poJOgWa4LbMkJoF8vTjKqQ=;
 b=R3L3HGZnSgningwU3f+JxgXqSfwxAPgDokU7K22A9Xubx4x98fAL8szS5pRaFw1CBO
 XCBqqXQsgmcKkCtIMlVI4AlcMYYfzWJ214mGR9em/oK/F2U2GUft5j3POPZhkx0o9ie9
 MsAi0KmeJdR5zlU9K6V4HLVY1l6ncuhIeyG28xGjBn2KJtJfVC2oG1tmt4v6eG5HlNo+
 KChfu3q1qUQL7DB+9BpQRnwZZysBnfd38JWNSXA9xBwtKL4M/dKD36uX7QjJGmIqkSWy
 QnM6Nin2ovAtV54F+UBUcGlTE3Rk0FN/Mst5Q42+6TnEM3AnClJZbi+xxRa9y8a76luX
 4ezA==
X-Gm-Message-State: AOAM532C2q/GHju55UGOpybH13eXufpLAYs6tLX/L2g53M5A69rS7HZJ
 lZtijmumRSZN+POFUMY0PSpFetrQtsw=
X-Google-Smtp-Source: ABdhPJw9jFZwSvw+hdFOqFxQ6mDEjDotTydyjBRxs2LXI9an+95+xFMAOHjAFGNaEHANmT008m6QOw==
X-Received: by 2002:a0c:eec4:: with SMTP id h4mr8460986qvs.52.1603897694933;
 Wed, 28 Oct 2020 08:08:14 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id s73sm3129480qke.71.2020.10.28.08.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 08:08:14 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: Only apply optimized mclk dpm policy on
 polaris
Date: Wed, 28 Oct 2020 11:08:05 -0400
Message-Id: <20201028150805.2400403-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Leads to improper dpm on older parts.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1353
Fixes: 8d89b96fe797 ("drm/amd/powerplay: optimize the mclk dpm policy settings")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 49db61a89505..d642dc95e9ea 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -1713,18 +1713,24 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	data->current_profile_setting.sclk_down_hyst = 100;
 	data->current_profile_setting.sclk_activity = SMU7_SCLK_TARGETACTIVITY_DFLT;
 	data->current_profile_setting.bupdate_mclk = 1;
-	if (adev->gmc.vram_width == 256) {
-		data->current_profile_setting.mclk_up_hyst = 10;
-		data->current_profile_setting.mclk_down_hyst = 60;
-		data->current_profile_setting.mclk_activity = 25;
-	} else if (adev->gmc.vram_width == 128) {
-		data->current_profile_setting.mclk_up_hyst = 5;
-		data->current_profile_setting.mclk_down_hyst = 16;
-		data->current_profile_setting.mclk_activity = 20;
-	} else if (adev->gmc.vram_width == 64) {
-		data->current_profile_setting.mclk_up_hyst = 3;
-		data->current_profile_setting.mclk_down_hyst = 16;
-		data->current_profile_setting.mclk_activity = 20;
+	if (hwmgr->chip_id >= CHIP_POLARIS10) {
+		if (adev->gmc.vram_width == 256) {
+			data->current_profile_setting.mclk_up_hyst = 10;
+			data->current_profile_setting.mclk_down_hyst = 60;
+			data->current_profile_setting.mclk_activity = 25;
+		} else if (adev->gmc.vram_width == 128) {
+			data->current_profile_setting.mclk_up_hyst = 5;
+			data->current_profile_setting.mclk_down_hyst = 16;
+			data->current_profile_setting.mclk_activity = 20;
+		} else if (adev->gmc.vram_width == 64) {
+			data->current_profile_setting.mclk_up_hyst = 3;
+			data->current_profile_setting.mclk_down_hyst = 16;
+			data->current_profile_setting.mclk_activity = 20;
+		}
+	} else {
+		data->current_profile_setting.mclk_up_hyst = 0;
+		data->current_profile_setting.mclk_down_hyst = 100;
+		data->current_profile_setting.mclk_activity = SMU7_MCLK_TARGETACTIVITY_DFLT;
 	}
 	hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 	hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
