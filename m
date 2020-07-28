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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B507DC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C281207E8
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 22:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcRfm1WK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C281207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AB2B6E433;
	Tue, 28 Jul 2020 22:46:44 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60F96E42E
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 22:46:36 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id e13so20427667qkg.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 15:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=R6dmChN1mdozeqWk4djzU8nUstjbCfXUyCWKoO4G8cA=;
 b=WcRfm1WKtxUTjB37CtGm/JW78psuhm44bmeNNONxC8wJhm6JglKvYl6wZSuga4uCG6
 n/cuHfUvMy5dwPoascHZNS95LJBns3WEVqnvRoE7HpxSlsGljbWLItObdTNZWDTCHWCT
 wt41ynp1WZTYnOQzbOi0QwjMDN0ec6e/9N945LKh8+Pbd8huJVBUEqgn2maLTKsCTJla
 DVs0o5KP3lTqevAVvBjClYpTZWIbqCdAII59/CbTlKF6iWCuKqNnXZ3wpDhnF914U0Sy
 /aKDIKvTRaIux/+D5FSYJ2WBBfMTlOgDpmEw5C78Wrge+pBEmj8LUUIsivSEjhrnGFnE
 oUtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=R6dmChN1mdozeqWk4djzU8nUstjbCfXUyCWKoO4G8cA=;
 b=hhlVmmGTHl02j1qmIL8w7K1AbuVBLBl5SHoFtcInScmgXev+/aZqHbIddIsx6aI5zF
 Q252LT+uivTJzGVbGDbT5ptTOVg6zR85DicWzqybpyOGPXU7UDJHQRwTxj1M2hFQRDkM
 iyt1M/fVqDynaPQrJyjQBKoDRB9KDisD1kTFyxo1hP/7LZM4r/K6+JaNQLtG4WI5TW25
 U+frak5dRXjUG5SAGmpsa5gKQSx0naFBl1X4jTSCa5t902QlGWXgfHhOrTCRuS+JCcuS
 WwLV2cQC44/HtjT+aYICP6pL3ik37dKkBJd2wSnhlIbNoIStZMqkf3+sb95j9fE0uVLf
 MPlQ==
X-Gm-Message-State: AOAM530ZUX8t5nvF6Ks1it5X5sRFzaIVMFEKaLSl1NyKwWXEjAvg6E6m
 TgAXAuDm2wjC7B+jr1y7J8lCWhAP
X-Google-Smtp-Source: ABdhPJxmcvQCbX9DeRRe2ksEOqNn8aKWLnvNnE8FvLIoKAZ+JHcDq+tjPp/sfEgt2f/RjhMAq3jC3A==
X-Received: by 2002:a37:9bca:: with SMTP id
 d193mr26117925qke.131.1595976395699; 
 Tue, 28 Jul 2020 15:46:35 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id o17sm189233qtr.13.2020.07.28.15.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2020 15:46:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/14] drm/amdgpu: move stolen vga bo from amdgpu to amdgpu.gmc
Date: Tue, 28 Jul 2020 18:45:55 -0400
Message-Id: <20200728224605.3919-5-alexander.deucher@amd.com>
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

Since that is where we store the other data related to
the stolen vga memory.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 4 ++--
 8 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2a7fbe21619d..899664357015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -767,7 +767,6 @@ struct amdgpu_device {
 	bool				is_atom_fw;
 	uint8_t				*bios;
 	uint32_t			bios_size;
-	struct amdgpu_bo		*stolen_vga_memory;
 	uint32_t			bios_scratch_reg_offset;
 	uint32_t			bios_scratch[AMDGPU_BIOS_NUM_SCRATCH];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 9d58c56f6cfc..ddb64be670c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -213,7 +213,8 @@ struct amdgpu_gmc {
 	uint8_t			vram_vendor;
 	uint32_t                srbm_soft_reset;
 	bool			prt_warning;
-	uint64_t		stolen_size;
+	uint64_t		stolen_vga_size;
+	struct amdgpu_bo	*stolen_vga_memory;
 	uint32_t		sdpif_register;
 	/* apertures */
 	u64			shared_aperture_start;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a188216bccc2..39781127d059 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1979,9 +1979,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
-	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_size,
+	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_vga_size,
 				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->stolen_vga_memory,
+				       &adev->gmc.stolen_vga_memory,
 				       &stolen_vga_buf);
 	if (r)
 		return r;
@@ -2043,7 +2043,7 @@ void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
 	void *stolen_vga_buf;
 	/* return the VGA stolen memory (if any) back to VRAM */
-	amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
+	amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 040220e97cf3..337d70503970 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -812,7 +812,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
+	adev->gmc.stolen_vga_size = gmc_v10_0_get_vbios_fb_size(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 4de996868d32..28ddb41a78c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -862,7 +862,7 @@ static int gmc_v6_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_size = gmc_v6_0_get_vbios_fb_size(adev);
+	adev->gmc.stolen_vga_size = gmc_v6_0_get_vbios_fb_size(adev);
 
 	r = amdgpu_bo_init(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 4113f2d33b75..8b8ecbb99d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1035,7 +1035,7 @@ static int gmc_v7_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_size = gmc_v7_0_get_vbios_fb_size(adev);
+	adev->gmc.stolen_vga_size = gmc_v7_0_get_vbios_fb_size(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index f29ff9afcc10..8e3763ec268f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1160,7 +1160,7 @@ static int gmc_v8_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_size = gmc_v8_0_get_vbios_fb_size(adev);
+	adev->gmc.stolen_vga_size = gmc_v8_0_get_vbios_fb_size(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index ac15d7678d24..b66c60680dba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1243,7 +1243,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->gmc.stolen_size = gmc_v9_0_get_vbios_fb_size(adev);
+	adev->gmc.stolen_vga_size = gmc_v9_0_get_vbios_fb_size(adev);
 
 	/* Memory manager */
 	r = amdgpu_bo_init(adev);
@@ -1282,7 +1282,7 @@ static int gmc_v9_0_sw_fini(void *handle)
 	amdgpu_vm_manager_fini(adev);
 
 	if (gmc_v9_0_keep_stolen_memory(adev))
-		amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
+		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, &stolen_vga_buf);
 
 	amdgpu_gart_table_vram_free(adev);
 	amdgpu_bo_fini(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
