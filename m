Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C1DC3524B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477E62072B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5X740cb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477E62072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93506F44F;
	Wed,  5 Feb 2020 03:49:08 +0000 (UTC)
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com
 [IPv6:2607:f8b0:4864:20::1043])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5A136F44F;
 Wed,  5 Feb 2020 03:49:07 +0000 (UTC)
Received: by mail-pj1-x1043.google.com with SMTP id fa20so363910pjb.1;
 Tue, 04 Feb 2020 19:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1TDC92U8nuAvyygLVjc9oE1rL/0mGLYWnCBFIoGGCdc=;
 b=F5X740cbWbt3Jh3WXWZXGlEAzPDW7Tm/WDF/FryCntIUiD16+ruQhX4TBBDBmQHytE
 KpmaNNRjwngMm/2R0PWVG6CRYrCbS2NuCNhR9hxnqtxZrFCN6BGUV3WLuSSwtkrdLAUP
 Pc57GcfWKDRNI/ZlG0Z6Jbw3QiAlDznna1PfFpTg7mIInCCybt5dH4warZ5ef1Cq7lUp
 WEo/cZtJmC9LTo/gYQGz+kY+YqTuL/U2IMCw20ufx1dQXonYapi3r1/CFYQXoIq17mG7
 lfoSiuCLTT83FSXK4rVJJwYlvcf64WwG5yPso6z15eR3Sc7tNyq2eTUpXpnVcHgfRFoW
 bCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1TDC92U8nuAvyygLVjc9oE1rL/0mGLYWnCBFIoGGCdc=;
 b=AEA9qH8JQXssV1abI8xhYzqjNuFRg5PhNA11Rs1J2E8OrwZBf7vurQSBUdo+rGEOW+
 Wd75J8f1qQDujQ8x4Hs1mL2cx5FusCcG5GEt9ILtUoKWF9igGLXFLNTlJB+/xXGmIBD6
 /PaQU47ZKreHSJ7XWnW5l4PnSF0oHr4LIT+6h2OCb/epXJb9E5dlmdNUdOf7Fn4K7wW6
 zFDfCux+bo06vQ1F8w++0EQQM2nq0AC+lRWtwwEkrlFMLIx89KZK99xZtXVTe/Iy71iQ
 8bRytXvtrstrd34H7hZbBCfkhkirQJXD9YvifbYQ7Ww3CAIbUHpatx5GWy5qvI3AI7sI
 q9ig==
X-Gm-Message-State: APjAAAUpJn3+vig2boYOaBhVGRF9ORszYW3ndt1LOQmGoi5Vxg+gDpc4
 jGmvdCzwpUbZ7rerQx2T6CDUCha7
X-Google-Smtp-Source: APXvYqxcptPshSePK/jrShaTAIVb2kU4kV7jFS00rFK9MGneEl5ME1EjAKKIxA110dzLiGfJFyrtAQ==
X-Received: by 2002:a17:90b:46cf:: with SMTP id
 jx15mr3300071pjb.2.1580874547151; 
 Tue, 04 Feb 2020 19:49:07 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm25320292pfz.121.2020.02.04.19.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 19:49:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 03/14] drm/amdgpu/pm: move debugfs init into core amdgpu
 debugfs
Date: Tue,  4 Feb 2020 22:48:41 -0500
Message-Id: <20200205034852.4157-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205034852.4157-1-alexander.deucher@amd.com>
References: <20200205034852.4157-1-alexander.deucher@amd.com>
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

In order to remove the load and unload drm callbacks,
we need to reorder the init sequence to move all the drm
debugfs file handling.  Do this for pm.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c      | 9 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h      | 2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index f49604c0d0b8..c1d66cc6e6d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -31,6 +31,7 @@
 #include <drm/drm_debugfs.h>
 
 #include "amdgpu.h"
+#include "amdgpu_pm.h"
 
 /**
  * amdgpu_debugfs_add_files - Add simple debugfs entries
@@ -1234,6 +1235,12 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_debugfs_pm_init(adev);
+	if (r) {
+		DRM_ERROR("Failed to register debugfs file for dpm!\n");
+		return r;
+	}
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index b03b1eb7ba04..bc3cf04a1a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -41,8 +41,6 @@
 #include "hwmgr.h"
 #define WIDTH_4K 3840
 
-static int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
-
 static const struct cg_flag_name clocks[] = {
 	{AMD_CG_SUPPORT_GFX_MGCG, "Graphics Medium Grain Clock Gating"},
 	{AMD_CG_SUPPORT_GFX_MGLS, "Graphics Medium Grain memory Light Sleep"},
@@ -3398,11 +3396,6 @@ int amdgpu_pm_sysfs_init(struct amdgpu_device *adev)
 		DRM_ERROR("failed to create device file unique_id\n");
 		return ret;
 	}
-	ret = amdgpu_debugfs_pm_init(adev);
-	if (ret) {
-		DRM_ERROR("Failed to register debugfs file for dpm!\n");
-		return ret;
-	}
 
 	if ((adev->asic_type >= CHIP_VEGA10) &&
 	    !(adev->flags & AMD_IS_APU)) {
@@ -3669,7 +3662,7 @@ static const struct drm_info_list amdgpu_pm_info_list[] = {
 };
 #endif
 
-static int amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
+int amdgpu_debugfs_pm_init(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_DEBUG_FS)
 	return amdgpu_debugfs_add_files(adev, amdgpu_pm_info_list, ARRAY_SIZE(amdgpu_pm_info_list));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
index 3da1da277805..5db0ef86e84c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.h
@@ -43,4 +43,6 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 
+int amdgpu_debugfs_pm_init(struct amdgpu_device *adev);
+
 #endif
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
