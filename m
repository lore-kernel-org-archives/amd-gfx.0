Return-Path: <SRS0=V/Q8=BI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2294EC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECAC32075F
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2020 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VR+xy2j5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC32075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11C46E5CF;
	Wed, 29 Jul 2020 17:35:09 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34BA26E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 17:35:04 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id ed14so11246066qvb.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2020 10:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h7veDK+5Wux/YxICIY2iWLMk1hh3KUtjDBKFTzk5pgQ=;
 b=VR+xy2j508XMUxQwOpmspQMW2VMGHp0yRbdafoabDxNmKSKJnqCjyNEVqJoMgy/prv
 286DYDY1utALXHf+1mGK+GAcld/EBTG1PeGcvX+1ucwi/wBFtUGFuu9wwt4XDMrMoly6
 oqS/6fyNScRIO8kZmPbZ2UK/Zji2Ku0RDYvQKO1DeglgbY5Ihx+TdM07UihEDU4hNxwq
 MDpo/lcBmSQ3ySUCNXkSqSgle+8KLiACL8L9wvrO32DgaAB3R7H0Br3fx983ice99B/w
 ggeytIz2hcpIH2BJqDHd+jcjG2hSvWziQs1R5QOE82zs/iIF7WZiK0/wsfdDzX7J2TLq
 jq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h7veDK+5Wux/YxICIY2iWLMk1hh3KUtjDBKFTzk5pgQ=;
 b=ViOICVrrGKBjsvGuvBX2d4x+2sKlCauqFE0XkBAG/Kb5HuDWp7Wk9HKpwHfjBTcXHW
 P7XVaSMKCs85l+JvvL669CIAoNGKAUDnZFTyCzo34w7T/5YlNvuVPlK67P7aJivjkMAw
 nZHPyTIEdv7H/cqPOzotwWvjav3YMk5WQjSpDxRAayRNs5V2HfsiMdeRBk763dz7PsaM
 LZPGyILbAME/9JptSr95LqLfvVGALgjt5puqB6asm24QXCrZv9t9npTigPBlJ/10WhBo
 gx5EnwLIMfeoF+k839MFTHzklvM+sk8+P1GX74i+FXLRoIAiu2HnAcY2nts9fybYhc97
 BXfg==
X-Gm-Message-State: AOAM533gnVQx4NePHf+zOxRVg/FhkiWumtWrxvQfquuWXBATB8tHkdzF
 LcfvUb860LxYUryzUtJU513S8nHu
X-Google-Smtp-Source: ABdhPJw0BRSNHAQM9LFBwazczJMV8xVemhx6rr8bjqYnT78nK43YfecH1QXAbs56UxW2aLT/rdJwlw==
X-Received: by 2002:a05:6214:3f3:: with SMTP id
 cf19mr33322327qvb.94.1596044102861; 
 Wed, 29 Jul 2020 10:35:02 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id z72sm2132956qka.107.2020.07.29.10.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2020 10:35:02 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/17] drm/amdgpu: move stolen memory from gmc to mman
Date: Wed, 29 Jul 2020 13:34:37 -0400
Message-Id: <20200729173439.3698-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200729173439.3698-1-alexander.deucher@amd.com>
References: <20200729173439.3698-1-alexander.deucher@amd.com>
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

It's more related to memory management than memory
controller.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  6 ++++++
 4 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 0bd7b3797534..213ef090bb0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -449,10 +449,10 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 	case CHIP_VEGA10:
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
-		adev->gmc.keep_stolen_vga_memory = true;
+		adev->mman.keep_stolen_vga_memory = true;
 		break;
 	default:
-		adev->gmc.keep_stolen_vga_memory = false;
+		adev->mman.keep_stolen_vga_memory = false;
 		break;
 	}
 
@@ -466,10 +466,10 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		size = 0;
 
 	if (size > AMDGPU_VBIOS_VGA_ALLOCATION) {
-		adev->gmc.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
-		adev->gmc.stolen_extended_size = size - adev->gmc.stolen_vga_size;
+		adev->mman.stolen_vga_size = AMDGPU_VBIOS_VGA_ALLOCATION;
+		adev->mman.stolen_extended_size = size - adev->mman.stolen_vga_size;
 	} else {
-		adev->gmc.stolen_vga_size = size;
-		adev->gmc.stolen_extended_size = 0;
+		adev->mman.stolen_vga_size = size;
+		adev->mman.stolen_extended_size = 0;
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c2a85d0b1546..d61bbde4c7d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -215,11 +215,6 @@ struct amdgpu_gmc {
 	uint8_t			vram_vendor;
 	uint32_t                srbm_soft_reset;
 	bool			prt_warning;
-	uint64_t		stolen_vga_size;
-	struct amdgpu_bo	*stolen_vga_memory;
-	uint64_t		stolen_extended_size;
-	struct amdgpu_bo	*stolen_extended_memory;
-	bool			keep_stolen_vga_memory;
 	uint32_t		sdpif_register;
 	/* apertures */
 	u64			shared_aperture_start;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 3df9d5a53741..cc1a5b2876b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1978,16 +1978,16 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * This is used for VGA emulation and pre-OS scanout buffers to
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
-	r = amdgpu_bo_create_kernel_at(adev, 0, adev->gmc.stolen_vga_size,
+	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
 				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->gmc.stolen_vga_memory,
+				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
-	r = amdgpu_bo_create_kernel_at(adev, adev->gmc.stolen_vga_size,
-				       adev->gmc.stolen_extended_size,
+	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
+				       adev->mman.stolen_extended_size,
 				       AMDGPU_GEM_DOMAIN_VRAM,
-				       &adev->gmc.stolen_extended_memory,
+				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
@@ -2048,9 +2048,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 void amdgpu_ttm_late_init(struct amdgpu_device *adev)
 {
 	/* return the VGA stolen memory (if any) back to VRAM */
-	if (!adev->gmc.keep_stolen_vga_memory)
-		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->gmc.stolen_extended_memory, NULL, NULL);
+	if (!adev->mman.keep_stolen_vga_memory)
+		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
 }
 
 /**
@@ -2063,8 +2063,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 
 	amdgpu_ttm_training_reserve_vram_fini(adev);
 	/* return the stolen vga memory back to VRAM */
-	if (adev->gmc.keep_stolen_vga_memory)
-		amdgpu_bo_free_kernel(&adev->gmc.stolen_vga_memory, NULL, NULL);
+	if (adev->mman.keep_stolen_vga_memory)
+		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
 	/* return the IP Discovery TMR memory back to VRAM */
 	amdgpu_bo_free_kernel(&adev->discovery_memory, NULL, NULL);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 17c8d0d7bcc3..98af87f38f3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -59,6 +59,12 @@ struct amdgpu_mman {
 	struct mutex				gtt_window_lock;
 	/* Scheduler entity for buffer moves */
 	struct drm_sched_entity			entity;
+
+	uint64_t		stolen_vga_size;
+	struct amdgpu_bo	*stolen_vga_memory;
+	uint64_t		stolen_extended_size;
+	struct amdgpu_bo	*stolen_extended_memory;
+	bool			keep_stolen_vga_memory;
 };
 
 struct amdgpu_copy_mem {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
