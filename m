Return-Path: <SRS0=jB5Z=EB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BD7C4363A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46F7D207DE
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2020 21:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+O+lr2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F7D207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC02F6EA71;
	Mon, 26 Oct 2020 21:43:37 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A79AD6EA78
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 21:43:36 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id b69so9881901qkg.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2020 14:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lIKXoE1tBjhquBGwt2oCJNzv57wjsSm1PHGEl7RzdEA=;
 b=m+O+lr2ecL1NMvtKTJ4coXyzA/IYCWXM3L2eWVg3BwWTSZI5bWEX3WjpoPujtP+kAi
 g69wsxeWxFjuHT1NZXz9DVoa748qu2YlrrCjKxcedho0iAtb8l7Tj2v71XxiO9nSqz7A
 OUuoi8jYAWP6jrTXj2vjXBgveC+xt5NwPw0YI7upBAw5GEpNpafCkbqtX34drbz2wSYN
 2sMSXCaZ/0mLjwCmGhSKEYArkI0/AL0zy8yrzes17WkuuF6MR9u7u37kaaB8zJ+ePb8E
 XzaLmLTGqFlmOzO/3KDpbhE8/JBs5mvd+N8cXGJE2EGu8dS6PYRmxYkA0lWIYsM2HBbm
 anrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lIKXoE1tBjhquBGwt2oCJNzv57wjsSm1PHGEl7RzdEA=;
 b=fW1xvaor/y6VDbKaN2Hh5q9bnpCHJZDT7JHtnMUOarXN9awE76yt9MhULgQAK16h0O
 CEHPY6d7ilJhv2leLsXsFZarhxxwZdNrAPowbG9umE5YIUsVPD2AgyY4H++jzRckONce
 o0FbgBe9x3FYlQLPdKHI9oNuzvcuBbPYk+lMr02AkP5moyZn1zoyjKMBqTDiVA2rVma1
 jM28JmTUNbdLEWJ9r/W5+W0sfHSXIgS3cX+3zWVoXPFA27zXKHsanMv/l0h/J8KSpeWM
 rnSsO8YDRKgADdkDpuJaWkb3OkZ1KyPrkgnuUhlmliAD0euHWnSCqJiflU6aynhIreID
 tdpw==
X-Gm-Message-State: AOAM532Tis+2sec/ON5VT63Qigug0l7kjHsXtIov0owJDTXfp9Mj4m9r
 BdYz2KjV9cCk85B7YeLjzSbIe/z+BNA=
X-Google-Smtp-Source: ABdhPJxyUtMnyXn6WiytMfS9Pwpokic0IXUUs/Bk1ooi9DZVthsNSUU544lJjyUUq/XtiacQLBjyJw==
X-Received: by 2002:a37:988:: with SMTP id 130mr3279628qkj.313.1603748615621; 
 Mon, 26 Oct 2020 14:43:35 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id f22sm7434573qkl.99.2020.10.26.14.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 14:43:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/pm: fix the fan speed in fan1_input in manual mode
 for navi1x
Date: Mon, 26 Oct 2020 17:43:26 -0400
Message-Id: <20201026214326.1694539-1-alexander.deucher@amd.com>
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

It has been confirmed that the SMU metrics table should always reflect
the current fan speed even in manual mode.

Fixes: 3033e9f1c2de ("drm/amdgpu/swsmu: handle manual fan readback on SMU11")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 9cf97744b67e..ef1a62e86a0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1361,14 +1361,9 @@ static int navi10_get_fan_speed_rpm(struct smu_context *smu,
 	if (!speed)
 		return -EINVAL;
 
-	switch (smu_v11_0_get_fan_control_mode(smu)) {
-	case AMD_FAN_CTRL_AUTO:
-		return navi10_get_smu_metrics_data(smu,
-						   METRICS_CURR_FANSPEED,
-						   speed);
-	default:
-		return smu_v11_0_get_fan_speed_rpm(smu, speed);
-	}
+	return navi10_get_smu_metrics_data(smu,
+					   METRICS_CURR_FANSPEED,
+					   speed);
 }
 
 static int navi10_get_fan_parameters(struct smu_context *smu)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
