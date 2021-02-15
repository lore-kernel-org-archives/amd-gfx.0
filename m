Return-Path: <SRS0=jhpT=HR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BECC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F7264E13
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F7264E13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC06389FD3;
	Mon, 15 Feb 2021 18:32:49 +0000 (UTC)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4477F89F89
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 18:32:48 +0000 (UTC)
Received: by mail-qt1-x82c.google.com with SMTP id x3so5463162qti.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LRrOwpeO//GhEGlud54XrTr+C8eEcl3usUMtjyJMGTI=;
 b=SJ/MxxZawltqijn0QTDwsalRifOK+irSO8hPbIYC7pNO9xZ795QrZb/7Ll9cZBdNKo
 yq5fHVjC+GXTws4u3bMzIU6ajaISOPQyTs5x95mmc4O2HaoBgquwWpHHCT38N+8v5qO9
 sqlbkq/+SWeiMeAQ7bm+q1buAUszHFl4o4eE9dQqsoG4J4PdqeZhXfs9Rlkppi1rVQPA
 BnKWIJYJEvFYli8JxjJ6Zk4Y0VKR8qc7s89V6pdVY6r5iZHRTqjESz7GrbWDvO9UW/OZ
 gGJPYkn66g95Q4OJ98DctEaxXPiE6aHZ8X/d8+/Y/u4i7PFsDzzwMIbS0dUo5xbIXXXp
 B0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LRrOwpeO//GhEGlud54XrTr+C8eEcl3usUMtjyJMGTI=;
 b=FjJD5bSa++LbcahLl76O3vlEPPc4lkTP7xIgwEOXA6ZsDkHcIYMGGK7rzIV6pEKVQx
 /klMMP9BFr0hWoB0+1mq1dx6Q2fyqQeg4of2PH46SrA6nCGrioxJnm7357wyKMWeuTTH
 R5NhijCd8X/WBgXRZAEZkb84VC8nq1S+u8P380CmDJShrWtIwgArfO0Up8dFH86LQKRD
 zdJ/H1qatvTPBsmAqe+x/DdkVVTJHo9N1zqW2xlnZ5WPBV383dzfwafHgbbrEAT7HHDv
 77ty/AWWRUbZk5hgpIBd9KoZmTqwtqg2qIofLHyDGGl1/LXPASg26U/GB0z9wsrh7WlJ
 xDGg==
X-Gm-Message-State: AOAM533SmXeUbsVYOYnArgPpzsEF1kZfiNCTVzROQLIeDqCFX68MVWSK
 MpxpFBwLQBrVVjZ9vxvWhgZ+UAmdwZY=
X-Google-Smtp-Source: ABdhPJw8wgsH9mHO+q3LJ/CoHjSFN8weFXGLcX/FJiwMer9L/iz1feGCVR6DhJeemPP8n2hCy7Zchg==
X-Received: by 2002:ac8:745a:: with SMTP id h26mr14745437qtr.278.1613413967386; 
 Mon, 15 Feb 2021 10:32:47 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id 76sm12859275qke.95.2021.02.15.10.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 10:32:47 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu/display: handle aux backlight in
 backlight_get_brightness
Date: Mon, 15 Feb 2021 13:32:30 -0500
Message-Id: <20210215183230.911939-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210215183230.911939-1-alexander.deucher@amd.com>
References: <20210215183230.911939-1-alexander.deucher@amd.com>
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

Need to fetch it via aux.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 92d6577f8f20..16020ff4b52f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3201,11 +3201,27 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
-	int ret = dc_link_get_backlight_level(dm->backlight_link);
+	struct amdgpu_dm_backlight_caps caps;
+
+	amdgpu_dm_update_backlight_caps(dm);
+	caps = dm->backlight_caps;
 
-	if (ret == DC_ERROR_UNEXPECTED)
-		return bd->props.brightness;
-	return convert_brightness_to_user(&dm->backlight_caps, ret);
+	if (caps.aux_support) {
+		struct dc_link *link = (struct dc_link *)dm->backlight_link;
+		u32 avg, peak;
+		bool rc;
+
+		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
+		if (!rc)
+			return bd->props.brightness;
+		return convert_brightness_to_user(&caps, avg);
+	} else {
+		int ret = dc_link_get_backlight_level(dm->backlight_link);
+
+		if (ret == DC_ERROR_UNEXPECTED)
+			return bd->props.brightness;
+		return convert_brightness_to_user(&caps, ret);
+	}
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
