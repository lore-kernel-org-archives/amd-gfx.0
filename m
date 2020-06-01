Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB551C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9459D2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNLQLJYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9459D2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDB46E179;
	Mon,  1 Jun 2020 18:03:09 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A2C76E155
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:08 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 205so9958116qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BY+pA27TGXXqPGY431syLqyHk0qrig3kLOPdwTfq7nQ=;
 b=FNLQLJYp2ejbcqj2x8KzsTWAcHgHu5/b0duPZIND6ZGpMcNcBZR5V9bQIcKjbPBpNV
 vlwagUX+LG9P4BW7QsQZbDcVcVnBXbuG/6TcaJwnOcPR+Vmxge9M00tUsrD7OURL+3a4
 5bhX0g0jss4vWKiinoXwo8ir9IHBvU7tp2cUWivGPP5gMtpGnkd5MYbxi06H8G72mNYN
 PgQQYLAzkCcvd7w46WOddr0YQxSVyOdoGIEv1HCnlz35dPJo7BYKKsSkAl5EX9hXUoNw
 2RVF1Kp88LKxjHZG5iM2nHiIwxTKFBnXCRBkAJ/JHVwa4T5/iNwyE6IlOK4TXT7k86Dq
 IHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BY+pA27TGXXqPGY431syLqyHk0qrig3kLOPdwTfq7nQ=;
 b=XvxMuoSA0WvAUjRBgQ0DWHCzUX8YNcZhcPIFupdUoM3kOzwKFI/RAB56CSIyb3FDXO
 fDWPihHPPhXta8DRzw/sHLGqIQR7PpKLKtwKCmaCJJJcYICUmSk/ifVojQmjhCqeYRWL
 +qbCbmo/cR94t8utdQYJiMXsLkBBlinVP8LIceoaWiYaWCJvrzVS+lEhSZJK9t3eqWLq
 HRL32XiOzdqQdCe5Hc6MtIo5dBRbfH/YvZs+/y9SPedsdDSr60HfIsx+VwF9ToZihwsW
 uLmvO3CpYh0JQt3zHgGzsE4SpfqfLGAf3bg0vVcaKzLYAtA0PnIi903836pqoj1uKpOj
 Q/xQ==
X-Gm-Message-State: AOAM531buYFf/HdFDGusowrse9dkxgT6A4ttFw99Py14aGPHtRBQM12A
 R75hdz7WE5uw3+aKVzPsMKrUUoNX
X-Google-Smtp-Source: ABdhPJwieuZvVxD8DdMig6y/f8N5dP5EULqfsS8O6vAbaBgZXjrn2VLgrQ3GJHoeBh2ic1CTu/QUQw==
X-Received: by 2002:a37:a7c5:: with SMTP id
 q188mr20432236qke.384.1591034587308; 
 Mon, 01 Jun 2020 11:03:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:06 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 017/207] drm/amdgpu: add gmc ip block for sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:29 -0400
Message-Id: <20200601180239.1267430-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 49 +++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/nv.c        |  1 +
 2 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fb8030cf65cd..afca175a092c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -45,6 +45,7 @@
 #include "nbio_v2_3.h"
 
 #include "gfxhub_v2_0.h"
+#include "gfxhub_v2_1.h"
 #include "mmhub_v2_0.h"
 #include "athub_v2_0.h"
 /* XXX Move this macro to navi10 header file, which is like vid.h for VI.*/
@@ -666,13 +667,19 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 {
 	u64 base = 0;
 
-	base = gfxhub_v2_0_get_fb_location(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		base = gfxhub_v2_1_get_fb_location(adev);
+	else
+		base = gfxhub_v2_0_get_fb_location(adev);
 
 	amdgpu_gmc_vram_location(adev, &adev->gmc, base);
 	amdgpu_gmc_gart_location(adev, mc);
 
 	/* base offset of vram pages */
-	adev->vm_manager.vram_base_offset = gfxhub_v2_0_get_mc_fb_offset(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		adev->vm_manager.vram_base_offset = gfxhub_v2_1_get_mc_fb_offset(adev);
+	else
+		adev->vm_manager.vram_base_offset = gfxhub_v2_0_get_mc_fb_offset(adev);
 }
 
 /**
@@ -781,20 +788,27 @@ static int gmc_v10_0_sw_init(void *handle)
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gfxhub_v2_0_init(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		gfxhub_v2_1_init(adev);
+	else
+		gfxhub_v2_0_init(adev);
+
 	mmhub_v2_0_init(adev);
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	r = amdgpu_atomfirmware_get_vram_info(adev,
-		&vram_width, &vram_type, &vram_vendor);
-	if (!amdgpu_emu_mode)
-		adev->gmc.vram_width = vram_width;
-	else
+	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_emu_mode == 1) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
 		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
+	} else {
+		r = amdgpu_atomfirmware_get_vram_info(adev,
+				&vram_width, &vram_type, &vram_vendor);
+		adev->gmc.vram_width = vram_width;
+
+		adev->gmc.vram_type = vram_type;
+		adev->gmc.vram_vendor = vram_vendor;
+	}
 
-	adev->gmc.vram_type = vram_type;
-	adev->gmc.vram_vendor = vram_vendor;
 	switch (adev->asic_type) {
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
@@ -925,7 +939,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	r = gfxhub_v2_0_gart_enable(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		r = gfxhub_v2_1_gart_enable(adev);
+	else
+		r = gfxhub_v2_0_gart_enable(adev);
 	if (r)
 		return r;
 
@@ -946,7 +963,10 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
 		false : true;
 
-	gfxhub_v2_0_set_fault_enable_default(adev, value);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		gfxhub_v2_1_set_fault_enable_default(adev, value);
+	else
+		gfxhub_v2_0_set_fault_enable_default(adev, value);
 	mmhub_v2_0_set_fault_enable_default(adev, value);
 	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_MMHUB_0, 0);
 	gmc_v10_0_flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB_0, 0);
@@ -984,7 +1004,10 @@ static int gmc_v10_0_hw_init(void *handle)
  */
 static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
-	gfxhub_v2_0_gart_disable(adev);
+	if (adev->asic_type == CHIP_SIENNA_CICHLID)
+		gfxhub_v2_1_gart_disable(adev);
+	else
+		gfxhub_v2_0_gart_disable(adev);
 	mmhub_v2_0_gart_disable(adev);
 	amdgpu_gart_table_vram_unpin(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index fd250e46cca2..e6fc244d42aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -485,6 +485,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		break;
 	case CHIP_SIENNA_CICHLID:
 		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
