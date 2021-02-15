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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D67DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70F4601FF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Feb 2021 18:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70F4601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 857FA89F89;
	Mon, 15 Feb 2021 18:32:48 +0000 (UTC)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D34789F89
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 18:32:47 +0000 (UTC)
Received: by mail-qk1-x735.google.com with SMTP id 81so7246306qkf.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Feb 2021 10:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=isuYxfNsk8oGtU+WDDf+1/u1gtADpqTiHiYwDUUnUYg=;
 b=JiPJJGq4iBZgW9AMNXZ9aQBb0cZp+XnW5ccT6oEr5uO7fLNibPjmkhYCLx6Kkabzcg
 jUKppMiDRWyrsCK4wT5vTsYD4F1KS/RRq5p4i16a67ermDkpm8o1GOuX4xo9QhcV33oF
 Y5U0Pq/B1SH1pNe5D05grJ8jYzgG5ALC9PxKdyrd/EKFveNi0wG8rCNrp07ozSlHCRO0
 RHSoY0fGPbbF9h1Jox8AjKpajwjsGQz2O3eEbwtgzTkrxM3ksqJvUEmf6hf0chAJPX/l
 uIJOEaZAJWqWX+oOXUKpUlBbzp7nmUSHL088ViH+KTMjMitiAVPxkpR+f5rzYMs8afzc
 ingg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=isuYxfNsk8oGtU+WDDf+1/u1gtADpqTiHiYwDUUnUYg=;
 b=AUDheJtBV7dqTsVw5bmIf+QGa1O5jDXqe1OueVdHGlygUJBJ7/C8GEmWeZaAFeUWLv
 3We/KwnBWans96cu2kQj+kF8cWZoRqUnv2IJr/ZrCb2zQBAsZxpX2f00SpHkfFgUssQR
 8+m2OueZWgotpdEMi9SpP672wG9iMkhh9p6kDquFeaApA26FGYcWLBYEe/ED4RacWmYH
 2Lc/YWatKzV5JMe9lBWjysxZqKW+dossNrM/wgN4jmEogLu81jx6fgzx9P9DSj7Qu5Gw
 G1gpPyDKxf4AezokRyT6Dk6ZSk5opf7MPLcsBO9J6ujwrb5J4rgTruCpX1YB69VC/fbc
 qviA==
X-Gm-Message-State: AOAM5338FXmYreCChZn538RnTY1M0cMB7XDu+RaDKJqtDKIfJYJWJMpP
 SMiZK4IKV8dUi8FkFgHON8yTowrI8Bo=
X-Google-Smtp-Source: ABdhPJwv1/A7rMiVtRmdGgkxc7bm0RMvqvuGfDPn0ZNRg2nCvgvYhTf93snCEuP63h7S9V4T6ob/bw==
X-Received: by 2002:a37:63c7:: with SMTP id
 x190mr16003810qkb.189.1613413966254; 
 Mon, 15 Feb 2021 10:32:46 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id 76sm12859275qke.95.2021.02.15.10.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Feb 2021 10:32:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu/display: simplify backlight setting
Date: Mon, 15 Feb 2021 13:32:28 -0500
Message-Id: <20210215183230.911939-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

Avoid the extra wrapper function.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 20 ++++---------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a44b6ba8595..92d6577f8f20 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3128,19 +3128,6 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
 #endif
 }
 
-static int set_backlight_via_aux(struct dc_link *link, uint32_t brightness)
-{
-	bool rc;
-
-	if (!link)
-		return 1;
-
-	rc = dc_link_set_backlight_level_nits(link, true, brightness,
-					      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-
-	return rc ? 0 : 1;
-}
-
 static int get_brightness_range(const struct amdgpu_dm_backlight_caps *caps,
 				unsigned *min, unsigned *max)
 {
@@ -3203,9 +3190,10 @@ static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 	brightness = convert_brightness_from_user(&caps, bd->props.brightness);
 	// Change brightness based on AUX property
 	if (caps.aux_support)
-		return set_backlight_via_aux(link, brightness);
-
-	rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
+		rc = dc_link_set_backlight_level_nits(link, true, brightness,
+						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+	else
+		rc = dc_link_set_backlight_level(dm->backlight_link, brightness, 0);
 
 	return rc ? 0 : 1;
 }
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
