Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B19C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 18:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDBDB20829
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eibr6MVA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDBDB20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8455F6E93C;
	Thu, 30 Jul 2020 18:16:47 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6AFB6E93C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 18:16:46 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id y11so9981495qvl.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 11:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OuZHhf0k75lep7kvleSl1nvat1tq3zI6KvlImBKHbXc=;
 b=Eibr6MVAtNvw2mX418oootxqHOpejuIk0eUaXtRfbOnJbLtZldGtCCMsjgQYEtl+Fa
 HA0fmaZa6vwLvY+6XVsJTd10fAkqURwQ+hPm6JYkEE0/0twCXzCbg62nPe4lHAiC6D2I
 lDTUZI7ltiq0A2kOCkMtKy0BrVl1f0CJUSrhq5U5xO+k69Ml5oVXT+8P4ege7XZIrpys
 ybg96hj/XEvvu4xZqTD6hwzNQpd6M36FTyeQemZVQA2T8mgsP5+iVp4wCcCvHYxv2WB3
 /AbULn14d3X7hJGWa47WztmCb8yhVpcxsApyJBRRcbjiLMjo5RxqUefgyHGaodVA5TE5
 dm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OuZHhf0k75lep7kvleSl1nvat1tq3zI6KvlImBKHbXc=;
 b=TFz43JA+5wbllAxlUvfradKxnOcSPNw8nK6LCHDv4iOA1Ho88Vb4CwSIWgDaSvXMFk
 cujygj6k90w7tmpgm2i6iyBuKpw+RpymENiEswHyt0P53LBcdUKffQZpyN3oNCt7n2Ak
 uUjBKVnIKLhhSCUI9BTIbdTto8vY2CNJ4MFJrZULVtgk1DtMyoxZnKfXdiA1VluP3i2S
 jUvcrs1LIoKRNk2tHqL59nXvDiiKstO/UksUHuoNB5x51jaTORBY8i0LZJvrIY9oYmfT
 AHJKupLxvZc5plq9DSSO9Xt2SeP6hUERxnBO7Kw0KYan3UmE+hCc+vO47wrF2wHnuFcc
 N8Ng==
X-Gm-Message-State: AOAM533eLtnRC8lwvV+uzvVltcRiYdMhFS6h8PXXocXMMzWQAb9N1RcM
 aSm1990krvjvy4lgXJEkdK6/PPZn
X-Google-Smtp-Source: ABdhPJy4itiJNKBBvYL5bReIoKw7vkC0YritqU3rC0882ffeKK8GKbG4nGmObdL8Mvta5SFiaal1ZA==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr380251qvz.216.1596133005560; 
 Thu, 30 Jul 2020 11:16:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id g40sm5247704qtk.30.2020.07.30.11.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2020 11:16:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/powerplay: optimize the mclk dpm policy settings
Date: Thu, 30 Jul 2020 14:16:37 -0400
Message-Id: <20200730181637.677551-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Evan Quan <evan.quan@amd.com>

Different mclk dpm policy will be applied based on the VRAM
width.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index ffe05b7cc1f0..b81719433017 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -1585,9 +1585,19 @@ static void smu7_init_dpm_defaults(struct pp_hwmgr *hwmgr)
 	data->current_profile_setting.sclk_down_hyst = 100;
 	data->current_profile_setting.sclk_activity = SMU7_SCLK_TARGETACTIVITY_DFLT;
 	data->current_profile_setting.bupdate_mclk = 1;
-	data->current_profile_setting.mclk_up_hyst = 0;
-	data->current_profile_setting.mclk_down_hyst = 100;
-	data->current_profile_setting.mclk_activity = SMU7_MCLK_TARGETACTIVITY_DFLT;
+	if (adev->gmc.vram_width == 256) {
+		data->current_profile_setting.mclk_up_hyst = 10;
+		data->current_profile_setting.mclk_down_hyst = 60;
+		data->current_profile_setting.mclk_activity = 25;
+	} else if (adev->gmc.vram_width == 128) {
+		data->current_profile_setting.mclk_up_hyst = 5;
+		data->current_profile_setting.mclk_down_hyst = 16;
+		data->current_profile_setting.mclk_activity = 20;
+	} else if (adev->gmc.vram_width == 64) {
+		data->current_profile_setting.mclk_up_hyst = 3;
+		data->current_profile_setting.mclk_down_hyst = 16;
+		data->current_profile_setting.mclk_activity = 20;
+	}
 	hwmgr->workload_mask = 1 << hwmgr->workload_prority[PP_SMC_POWER_PROFILE_FULLSCREEN3D];
 	hwmgr->power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	hwmgr->default_power_profile_mode = PP_SMC_POWER_PROFILE_FULLSCREEN3D;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
