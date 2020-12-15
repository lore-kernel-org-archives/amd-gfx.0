Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611BC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 17:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBC092224C
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 17:10:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC092224C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6694A89A4A;
	Tue, 15 Dec 2020 17:10:14 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA06189A4A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 17:10:13 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id 7so15172578qtp.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 09:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lCmQ4bknE+SytTMIhTl3dwA4b/pM6gZ54yRd6b4/HHU=;
 b=FBvb/lhgZsRjd1N1q1ZpGCD0frfrHU9big4ieDSIKTeSGt8Xpb2O1FB1DAXGvIuzuo
 lV+W4OduhKNr+QJ36MVMUmqMrtf47Ao49B47gLu2eNSJT7SJ+ocn8Wf1l7TrXsUA90iE
 af8+urt+lNRCJF4TxjF8r3kWHFMRXwCX+qQQatI9b1nsWM/2iPsNT58IK9sCcGm9O3Mg
 ujJhWXq2UCXB7TJWqLDoaX1xV2JeuzJbKBEYiyjDxsjZ8mUkj3usnyYhLXw9xZPWP+C/
 Nhj/qaczsT8VnWpWBYA7emr+WhApiZ/LoaVDtgXxQuMzmDE1Jk5Hwe61PpzMrJvPIRDG
 +vbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lCmQ4bknE+SytTMIhTl3dwA4b/pM6gZ54yRd6b4/HHU=;
 b=h5wglw/tDdCRy3h3PKRBFESCRMbnl+++rvj1iqDqr95VzFolJK24CyMwkJ1ZGjkWtZ
 xbbKuiQwBdjo+tTEqr+RQ8BOFmx6rtYaB8vlXQQ6H6C/0RDbab2hu8QgfS+xNVx6qAXY
 OIiA5av4mHKWKssx3wt1HOhVf0APA3cAGU94bo1bZHxupL4r8knmnUuKABRV8ysuDGDC
 xwR73Bd1Ex5X8NykTFIXfKQYJr1yt6lHGy+FP5tNABroZtl8cULXCAgrDdfKBV9s4mQT
 voIGg18Lv67pyLFlMmKSNGhkT1R3y+CY/A9lTbUFxFHV3VcHTuRRRu/J3TBg5LuUXolY
 /jeA==
X-Gm-Message-State: AOAM533jOmAHfpJekF/7rKHh3fhoi4eMQqhP28W9LRYgbC7XVBUdjya3
 HsWvur3Vx0qOc9ldLhi7kuD8mRodA2K/0w==
X-Google-Smtp-Source: ABdhPJyrd3cIVS2IrnViWY+k6eJDUAgQyyFbzWOvrnjGGUmBmiMrW74JlIzV/UwYCIsGTy1Ci3ihXg==
X-Received: by 2002:ac8:38f6:: with SMTP id g51mr39152541qtc.79.1608052212948; 
 Tue, 15 Dec 2020 09:10:12 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id i18sm4573896qkg.66.2020.12.15.09.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Dec 2020 09:10:12 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/disply: fix documentation warnings in display
 manager
Date: Tue, 15 Dec 2020 12:10:03 -0500
Message-Id: <20201215171003.1628871-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Wayne Lin <Wayne.Lin@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add documentation for crc window.

Fixes: c920888c604d ("drm/amd/display: Expose new CRC window property")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Wayne Lin <Wayne.Lin@amd.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 0b31779a0485..2ee6edb3df93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -337,10 +337,29 @@ struct amdgpu_display_manager {
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
 
 #ifdef CONFIG_DEBUG_FS
-	/* set the crc calculation window*/
+	/**
+	 * @crc_win_x_start_property:
+	 *
+	 * X start of the crc calculation window
+	 */
 	struct drm_property *crc_win_x_start_property;
+	/**
+	 * @crc_win_y_start_property:
+	 *
+	 * Y start of the crc calculation window
+	 */
 	struct drm_property *crc_win_y_start_property;
+	/**
+	 * @crc_win_x_end_property:
+	 *
+	 * X end of the crc calculation window
+	 */
 	struct drm_property *crc_win_x_end_property;
+	/**
+	 * @crc_win_y_end_property:
+	 *
+	 * Y end of the crc calculation window
+	 */
 	struct drm_property *crc_win_y_end_property;
 #endif
 	/**
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
