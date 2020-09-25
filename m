Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B456C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991872399A
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDuSPX2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991872399A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A6966ED5F;
	Fri, 25 Sep 2020 20:11:16 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6F6F6ED5F
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:14 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id b2so3058797qtp.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IGElWQMRcbQ46wVJmZ/A3PYAiKdxbDWR7mVzBOODs6U=;
 b=mDuSPX2t0Zm5c/4OWoDsipKJrNGcvR51fQXeXQKtn3cVfpHHGHYwzEDClZIbg4hrvj
 ZbnMX7ofUNbiYBbLbdoUXnKCYsffQzCMKIgygZsyDa8Nt0nrR/pKMLGnNpn/ryxYS7vZ
 u9gB9VpTzwexiEaFEmQZZtra0BcSNCghzQs2u6jwU0LRVA7ci0RpCWgWbywSpc5NTAqN
 wfiqRxVw4e6Q/VBmJgy2+AHP5+8Y5iKu9A/yb8vB4bdl3QtvqzUYj/FscYoOtMtccJcI
 iJkw5/nG5QA5+m4znC48V4nMU3Cb5MKRFBNkWRUd5Qg56zH5ABdoBDrVatgNlcyPIdu/
 EvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IGElWQMRcbQ46wVJmZ/A3PYAiKdxbDWR7mVzBOODs6U=;
 b=RWKylpNtNo9DUhNu5cVo/YUB6kLwRRKCWvJTufuF1LDpWQdD/na49+jHjcyGj3d3Mo
 FNGQqT6RFRtsoZXcqF7ElNjLAx+xv4+wCH5WTx3diAkbYaGZA2mAI4XsnZfitRugaqri
 b92p2dSOgkAn6Lo26EgEqaq6K9GVFWfxgNZigeMHh0I7yQO0NBJ4KHTebXguvOSgPH2s
 XC3A5H6rMSnxIVP3pumB8sCBw0N3CzL1Rpg2kJJnMzK9ATkEPVQeCghpoDOTgc4egetE
 XIkmBhQiI+1fC9I9DRKNkOGBKlhRw0/3J/ZqvPUniTI9qqgrvdXaQwJukQDdvIeKh92K
 nyhw==
X-Gm-Message-State: AOAM5339q6DLEBibSMKgeHNId5X6a3g115gFq+SCx9Kgs+rKXqHG6vMk
 zrDXJ9s5nqQvxuYUboPteeSekSk85S4=
X-Google-Smtp-Source: ABdhPJyixHjcw3su4U+NVr7gQyXQKZjsX3dYwjfsa83nE/Or9V8DWriHjPk9mPZQNZrgYdWNG5Krjw==
X-Received: by 2002:ac8:581:: with SMTP id a1mr1375444qth.161.1601064673673;
 Fri, 25 Sep 2020 13:11:13 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:13 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/45] drm/amdgpu: add gmc v10 supports for van gogh (v3)
Date: Fri, 25 Sep 2020 16:09:58 -0400
Message-Id: <20200925201029.1738724-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

Add gfx memory controller support for van gogh.

v2: don't use dynamic invalidate eng allocation for van gogh.
v3: squash in other fixes

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 33 ++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 31359e519d69..fa0a0c8a6b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -677,7 +677,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 	u64 base = 0;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		base = gfxhub_v2_1_get_fb_location(adev);
 	else
 		base = gfxhub_v2_0_get_fb_location(adev);
@@ -690,7 +691,8 @@ static void gmc_v10_0_vram_gtt_location(struct amdgpu_device *adev,
 
 	/* base offset of vram pages */
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		adev->vm_manager.vram_base_offset = gfxhub_v2_1_get_mc_fb_offset(adev);
 	else
 		adev->vm_manager.vram_base_offset = gfxhub_v2_0_get_mc_fb_offset(adev);
@@ -726,6 +728,13 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 
+#ifdef CONFIG_X86_64
+	if (adev->flags & AMD_IS_APU) {
+		adev->gmc.aper_base = gfxhub_v2_1_get_mc_fb_offset(adev);
+		adev->gmc.aper_size = adev->gmc.real_vram_size;
+	}
+#endif
+
 	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
 	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
@@ -739,6 +748,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 		case CHIP_NAVI12:
 		case CHIP_SIENNA_CICHLID:
 		case CHIP_NAVY_FLOUNDER:
+		case CHIP_VANGOGH:
 		default:
 			adev->gmc.gart_size = 512ULL << 20;
 			break;
@@ -778,7 +788,8 @@ static int gmc_v10_0_sw_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		gfxhub_v2_1_init(adev);
 	else
 		gfxhub_v2_0_init(adev);
@@ -787,7 +798,10 @@ static int gmc_v10_0_sw_init(void *handle)
 
 	spin_lock_init(&adev->gmc.invalidate_lock);
 
-	if (adev->asic_type == CHIP_SIENNA_CICHLID && amdgpu_emu_mode == 1) {
+	if ((adev->flags & AMD_IS_APU) && amdgpu_emu_mode == 1) {
+		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_DDR4;
+		adev->gmc.vram_width = 64;
+	} else if (amdgpu_emu_mode == 1) {
 		adev->gmc.vram_type = AMDGPU_VRAM_TYPE_GDDR6;
 		adev->gmc.vram_width = 1 * 128; /* numchan * chansize */
 	} else {
@@ -805,6 +819,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		adev->num_vmhubs = 2;
 		/*
 		 * To fulfill 4-level page support,
@@ -918,6 +933,7 @@ static void gmc_v10_0_init_golden_registers(struct amdgpu_device *adev)
 	case CHIP_NAVI12:
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_VANGOGH:
 		break;
 	default:
 		break;
@@ -945,7 +961,8 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		return r;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		r = gfxhub_v2_1_gart_enable(adev);
 	else
 		r = gfxhub_v2_0_gart_enable(adev);
@@ -970,7 +987,8 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
 		false : true;
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		gfxhub_v2_1_set_fault_enable_default(adev, value);
 	else
 		gfxhub_v2_0_set_fault_enable_default(adev, value);
@@ -1015,7 +1033,8 @@ static int gmc_v10_0_hw_init(void *handle)
 static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_SIENNA_CICHLID ||
-	    adev->asic_type == CHIP_NAVY_FLOUNDER)
+	    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+	    adev->asic_type == CHIP_VANGOGH)
 		gfxhub_v2_1_gart_disable(adev);
 	else
 		gfxhub_v2_0_gart_disable(adev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
