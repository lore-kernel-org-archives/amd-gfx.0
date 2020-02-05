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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43E6C35249
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB652072B
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 03:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noFY08i0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB652072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DA96F460;
	Wed,  5 Feb 2020 03:49:13 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30BD36F45E;
 Wed,  5 Feb 2020 03:49:12 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id j7so301607plt.1;
 Tue, 04 Feb 2020 19:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CDVwG+Zcj9UBGLRE3/MPdG+p0RG+kmWgw3dCJvKALc8=;
 b=noFY08i0+7oaqGY1b+pEf63ZwPmlTx2X5Jjn2y6maV2AeqcFdB/1jIEB+feWm8tatU
 ImjozHDluJi5r4vQOCxjyLO2X8VtT3M23veP5Q9ouhIbwXss1WthNLWRyIxyy8HLS6Ws
 Nxras/GBLHzZUSAuC6IPEBdPCSBEPvtHvn/pE+LbILYjd1XGeOIIGEyuDnTf5icHj5oD
 Mok1LncxWsEXMisQWOIJecg038ibQp+/Y/J+Ro8L1jxegpFD0WHbg1HAG1N40FeNgb5X
 PB+tznCC32lXEFgGClvGM4EtB0k9dJ43Z4HzUE6+K/S6JVyxKWYu8aUlIGSopfnUbDDF
 zgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CDVwG+Zcj9UBGLRE3/MPdG+p0RG+kmWgw3dCJvKALc8=;
 b=IeTAErtGOpLfq4yJeJNftnRRAQm4X8TnfvqeJirHMVyCe+c6ZcaNIa18uKJP/3/GzV
 A1CJixA+IWPG4l8HkaKS1Y44RegvmrYrB6vdVQ/dGiECDa9qn/wSU5D35RFjd3YP6uDK
 O3OhQDsJowpVkGNGxW+PSw/WrfeTp3JllajIKxFxHWpcnjT9M2uyJNhlUOaXv0dycucS
 1BSDo6ajCBOSIDWyJIJ2onlBr1yMTjqqCeQaHgeT/4zs6kag/iJoffUgRrLJTto9h9de
 iWo+u7UClcgCbwPoWyn9FeXUdqLHdoFgSYGLw/1nmFDWiDR/2YlXOeYAN50hbDjcXjGW
 l3Vw==
X-Gm-Message-State: APjAAAX30bYBSsuiSrPxSM8mZRrrleHhg7/c0WZY37J3EYcxR5ZhD00b
 8w/v0cJggLSmp9WUYWL3sTfWdnnp
X-Google-Smtp-Source: APXvYqycyXHbzDBmF40ObmWjnRGxoKm2QmzwGR5cEoB1gy27DTHrFxbEcZWzGIvuX9bxvZv6r0OJ5A==
X-Received: by 2002:a17:90a:d990:: with SMTP id
 d16mr3109650pjv.143.1580874551517; 
 Tue, 04 Feb 2020 19:49:11 -0800 (PST)
Received: from localhost.localdomain ([71.219.59.120])
 by smtp.gmail.com with ESMTPSA id 200sm25320292pfz.121.2020.02.04.19.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 19:49:11 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amdgpu/gem: move debugfs init into core amdgpu
 debugfs
Date: Tue,  4 Feb 2020 22:48:44 -0500
Message-Id: <20200205034852.4157-7-alexander.deucher@amd.com>
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
debugfs file handling.  Do this for gem.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index bcd10daa6e39..cb7db7edfc3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1248,6 +1248,10 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 	if (amdgpu_debugfs_fence_init(adev))
 		dev_err(adev->dev, "fence debugfs file creation failed\n");
 
+	r = amdgpu_debugfs_gem_init(adev);
+	if (r)
+		DRM_ERROR("registering gem debugfs failed (%d).\n", r);
+
 	return amdgpu_debugfs_add_files(adev, amdgpu_debugfs_list,
 					ARRAY_SIZE(amdgpu_debugfs_list));
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3b09897eb1e9..64a275664c72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3091,10 +3091,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	} else
 		adev->ucode_sysfs_en = true;
 
-	r = amdgpu_debugfs_gem_init(adev);
-	if (r)
-		DRM_ERROR("registering gem debugfs failed (%d).\n", r);
-
 	r = amdgpu_debugfs_regs_init(adev);
 	if (r)
 		DRM_ERROR("registering register debugfs failed (%d).\n", r);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
