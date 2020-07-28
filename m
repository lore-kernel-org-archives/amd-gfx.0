Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99A0C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DFB2207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJu/N876"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DFB2207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56E8F6E430;
	Tue, 28 Jul 2020 22:46:41 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695C86E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:38 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id d27so16215316qtg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FhjDiYVVaSIOL5rayY1DItgurpwSEV49gj4brvF5B+8=;
 b=LJu/N876aulv1VFU1W/sE8BCjm5y2IbHRVGTWnGAN0PjBBPDbT1H2EhJGfK4nYOCa7
 X/gb9dMS3OR58gpRpJpcLN75e0zpwiEGAHvT0S6mBs58e/sPj65U4E/S51lzZL20HS4n
 yksF+/fgBXMOxI0D6vQVZQ9tkc/Pa+KuLelO6d3Sf6AjBgicDEgcxvn4UTgz8IRcvQ0f
 HzhwhfDYG+rgd+V4fAdwLoX9dTS7RdtOH2Q9Hq3Z2DPYUJ5Y8Z/jvz7gowmHBsUZJmOZ
 jCdO8meu4gQtSiAr4jox5gJfZ/IZl8SBR7WjA96Udqg9s1utCUO6C+6uywC+jh4NUq7C
 zulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FhjDiYVVaSIOL5rayY1DItgurpwSEV49gj4brvF5B+8=;
 b=CwgAXFO2ZKYgrpsDca3p3gwsyQF0Es/+tojwuVEBts1rFqBh5eycVGLKAXtPLni6ZH
 6KmmYhiMjzmSW6dd6lnSmPLc79c8kdrdirRCv8rAMdGN0qvuqRxjMAjsNBiszYDK5PRh
 CAi+2+DrOhl0F6JOdt+bWtjIeVyICwL1yzL5raCpnRE4roO9JyT0+5yZH93saHtuqU/m
 nDWzyTn3O598u90dBdMSQ6WtHWmUWj58+wvCDw3hP/iDbcRJAb2pBZpxDKHjteqGUsy4
 pqiLWfad8wZuMID/fVynMdRJ/OeK/6YN7BvxRK2ZsLrmBtcEk1DTUL14yPD+DrOw+AVg
 Px4Q==
X-Gm-Message-State: AOAM531/a/WjzuSYuP+AFI6nq4zy6+xxYWHG8mG5Vv8WfL3OKZDKWX4m
 +l/G9tQW2I9P86KekZQ2VfHUwcxM
X-Google-Smtp-Source: ABdhPJxK7Lo3TcqpgtRxOKV4mcGS5cCzdpqreEfi90djKO9y/P4xGeC0PjoFKlII96mk7VOgnTPp4A==
X-Received: by 2002:ac8:75c8:: with SMTP id z8mr16004605qtq.327.1595976397420; 
 Tue, 28 Jul 2020 15:46:37 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:36 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/14] drm/amdgpu: add support for extended stolen vga memory
Date: Tue, 28 Jul 2020 18:45:57 -0400
Message-Id: <20200728224605.3919-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200728224605.3919-1-alexander.deucher@amd.com>
References: <20200728224605.3919-1-alexander.deucher@amd.com>
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

This will allow us to split the allocation for systems
where we have to keep the stolen memory around to avoid
S3 issues.  This way we don't waste as much memory and
still avoid any screen artifacts during the bios to
driver transition.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 0cf18f01e67a..8f4af955d72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -215,6 +215,8 @@ struct amdgpu_gmc {
 	bool			prt_warning;
 	uint64_t		stolen_vga_size;
 	struct amdgpu_bo	*stolen_vga_memory;
+	uint64_t		stolen_extended_size;
+	struct amdgpu_bo	*stolen_extended_memory;
 	bool			keep_stolen_vga_memory;
 	uint32_t		sdpif_register;
 	/* apertures */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fd61769202b3..ec975251b171 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1915,7 +1915,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	uint64_t gtt_size;
 	int r;
 	u64 vis_vram_limit;
-	void *stolen_vga_buf;
+	void *stolen_vga_buf, *stolen_extended_buf;
 
 	mutex_init(&adev->mman.gtt_window_lock);
 
@@ -1985,6 +1985,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 				       &stolen_vga_buf);
 	if (r)
 		return r;
+	r = amdgpu_bo_create_kernel_at(adev, adev->gmc.stolen_vga_size,
+				       adev->gmc.stolen_extended_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
+				       &adev->gmc.stolen_extended_memory,
+				       &stolen_extended_buf);
+	if (r)
+		return r;
 
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
@@ -2041,11 +2048,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
  */
 void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
-	void *stolen_vga_buf;
+	void *stolen_vga_buf, *stolen_extended_buf;
 
 	/* return the VGA stolen memory (if any) back to VRAM */
 	if (!adev->gmc.keep_stolen_vga_memory)
 		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
+	amdgpu_bo_free_kernel(&adev->gmc.stolen_extended_memory, NULL,
+			      &stolen_extended_buf);
 }
 
 /**
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
