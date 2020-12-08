Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC48AC433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A46023AC8
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 16:06:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A46023AC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CA46E964;
	Tue,  8 Dec 2020 16:06:09 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876F36E964
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 16:06:07 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id z11so7187667qkj.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGJ/KUVJqPt0LA1r0bSjoqsG9HDNCMMImEZZTZfBqYM=;
 b=K4wyHt2cgESvh1PGY1oFbX3NGUYM1m8jjAef0912lFghPM4dJa6wkw98Bv4nvnmtXe
 nWV3qg0e/wbmVViBQCOkWvkrVYYk+67P77ppwX9Uger3i061q/q/wzv8/oCyqVgpL4tq
 nvBrZKjnOnx0g15FwEI0NIDL3CDO6HyQ1mA+XLLW+VPmOaiQNG/dTDpyFH1o7ci5UzNN
 crnaWAqW9gsLXCz3i6q9rfBrzYHYVIdJw+pTpapAmjG2+4bOaqd/8OKroDg4275XkPNL
 j0SwKTIvKbnwK3xmVWocCkbACsGfncAsKNXxnHFTDhqem8AkfV+5ZqUyVGU0Ime1xX+o
 RvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=mGJ/KUVJqPt0LA1r0bSjoqsG9HDNCMMImEZZTZfBqYM=;
 b=TZF8aSV0SQwL7rPQTgTYNeDaukPG4nXVxkNPqUt0cNjblAVA93yRRRy2dm/JJWvDrE
 VEpu9DkMb+R9Ys+sBDSimvIjQav7yLLFbG898teyoI6Y1HBt+99dx+HU8qnB+P3BGlwL
 +qGKIW2xz4I9FqrbkoJpalXK7IESqzxVcYwhdUA3gKR8raXUxUv0uqTjGuNhkyVd1BEB
 mWB7TflrApPWF/Rqsr/wkQ/B5xKe4NpjLr+b1sQRgCGeHqyj9HGyH2JZdhIMG5Wr/UiF
 LXJGj2NP/hxH1bZkZ6F/bssC5xX9odHBRMX14ELcqlr8zUcifhttXeA7txZsZISyLoFu
 qbzA==
X-Gm-Message-State: AOAM532Ew7RwKMqXv4OUZMdcDmRpIpgCUKIX6A6rrtuEewCK5XHrUXIY
 zGaWolbvu6AaEe4hfjMbz5U6IJ+4Gbo=
X-Google-Smtp-Source: ABdhPJy1zbxCXgi+YpXdP/Ooqv1Com4hBRYc+Au/NeIHysU4od9iUp4cRHxDvWhvovb1j7ptLhRRLw==
X-Received: by 2002:a05:620a:2088:: with SMTP id
 e8mr30622309qka.339.1607443566566; 
 Tue, 08 Dec 2020 08:06:06 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id u26sm1702482qke.57.2020.12.08.08.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 08:06:06 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: free the pre-OS console framebuffer after the
 first modeset
Date: Tue,  8 Dec 2020 11:05:54 -0500
Message-Id: <20201208160556.39899-1-alexander.deucher@amd.com>
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

Rather than in late_init to avoid race conditions between freeing the
buffers and the initial modeset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           | 8 ++------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e49b519aab80..6be131df21f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2026,10 +2026,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
-	/* return the VGA stolen memory (if any) back to VRAM */
-	if (!adev->mman.keep_stolen_vga_memory)
-		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 }
 
 /*
@@ -2042,8 +2038,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
-	if (adev->mman.keep_stolen_vga_memory)
-		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 	/* return the IP Discovery TMR memory back to VRAM */
 	amdgpu_bo_free_kernel(&adev->mman.discovery_memory, NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 255171b8c434..e64b365d07af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8440,6 +8440,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
+	/* return the stolen vga memory back to VRAM */
+	if (!adev->mman.keep_stolen_vga_memory)
+		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+
 	/*
 	 * Finally, drop a runtime PM reference for each newly disabled CRTC,
 	 * so we can put the GPU into runtime suspend if we're not driving any
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
