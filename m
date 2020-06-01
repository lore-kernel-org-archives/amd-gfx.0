Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D5C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDCA2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dg6IWaHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADDCA2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654E16E347;
	Mon,  1 Jun 2020 18:22:23 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F38D6E34B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:22 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id e20so504195qvu.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ihEdYuoUn7+preyh5el2mAuRBmGQQjY9Wlba5Trca48=;
 b=Dg6IWaHvhBWsP3hR71qIosFMcLzRttd7XXGnm8LvnFbS++LZIji5xi/yp9oUpQ/YxR
 7/btz14/2NLnfQMRlR4K56vZWFGcVKUdCmYTRsdPxViy2cYHOAtDxQ9bAj0st7eROXBO
 9eoJlJ08BxtaOV2AoiCt9tjRMPSIoimjTDuoppRk0SwKyNc8BccJvzwXYVuqOCFvTYd6
 XpIN+FXg1J1g6d7YvBnxBecFDP3B2AbTLqoq92CBXn8f5gh0L9kpizxPNrrXDZdDZL9J
 bX+qOcTQdHwkU35CsH6B0MDU5T0aG8Q3qGVAwsDisB8kcH8iiC3aKeRV9PZPa+d4d4X0
 WSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ihEdYuoUn7+preyh5el2mAuRBmGQQjY9Wlba5Trca48=;
 b=TjD1iDE1voBiQRR9Nemv8giDsHJM00qrozJoA4oowbCmwYTdAFM3MdKkZ5ohJp5u8D
 fT6hbVJqflWIOjyxW30OfQ/sz9Xgekw47Nu9NrX97B5crhXBZxoOC0kIY1Fv/4RomoaF
 VlBJmxHoSIaZHXhNFsKkxahKvGDIZ/WiLOCMCs5Uf8wp31W9jelPQNP+MpzmOroO5hv8
 dgTncQsR8EMGk2JmQUePM2LTyoWOODBo8CiyF+PeCTG0I4cGMQkNfnTzNr8xmiAGTdqK
 DimONqkE/1fAkOi5wT0poCnOAfiQ2rSKtOEFvs09iraB+33zlaRLz3J5sgmufTB/HcrD
 qsNw==
X-Gm-Message-State: AOAM5329kJ7L27Zv4UQ7US0Ts/XPJ2TmrlNMJ5BUyqMl9Q+ZsCXh5Dop
 yMUkB4KGT7OIMH30lM/gNOOHw+di
X-Google-Smtp-Source: ABdhPJwXV2lKVKILkEiraqUoS3UyPRRpZfM8hBE7ZbJL15ZoA+kiVbaWh9CrUX4vDN1vwkrIey6U9Q==
X-Received: by 2002:a0c:e941:: with SMTP id n1mr5855504qvo.105.1591035740414; 
 Mon, 01 Jun 2020 11:22:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:19 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 148/207] drm/amdgpu: rename macro for VCN2.0 2.5 and 3.0
Date: Mon,  1 Jun 2020 14:19:55 -0400
Message-Id: <20200601182054.1267858-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Rename SOC15_DPG_MODE_OFFSET_2_0, RREG32_SOC15_DPG_MODE_2_0 and
WREG32_SOC15_DPG_MODE_2_0 for VCN2.0, VCN2.5 and VCN3.0.
These three macros are used VCN2.0, VCN2.5 and VCN3.0, therefore rename
it to be a general name.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  6 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 86 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 94 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 88 +++++++++++------------
 4 files changed, 137 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index f54e5ccabb42..e125e8bfac54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -88,7 +88,7 @@
 			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
 	} while (0)
 
-#define SOC15_DPG_MODE_OFFSET_2_0(ip, inst_idx, reg) 						\
+#define SOC15_DPG_MODE_OFFSET(ip, inst_idx, reg) 						\
 	({											\
 		uint32_t internal_reg_offset, addr;						\
 		bool video_range, video1_range, aon_range, aon1_range;				\
@@ -121,7 +121,7 @@
 		internal_reg_offset >>= 2;							\
 	})
 
-#define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
+#define RREG32_SOC15_DPG_MODE(inst_idx, offset, mask_en) 					\
 	({											\
 		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 					\
 			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
@@ -130,7 +130,7 @@
 		RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA);				\
 	})
 
-#define WREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, value, mask_en, indirect)			\
+#define WREG32_SOC15_DPG_MODE(inst_idx, offset, value, mask_en, indirect)			\
 	do {											\
 		if (!indirect) {								\
 			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 90ed773695ea..060d133db55d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -382,91 +382,91 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
 		offset = size;
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0),
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
@@ -615,19 +615,19 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__WCB_MODE_MASK |
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__SCPU_MODE_MASK);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
@@ -810,11 +810,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
@@ -826,28 +826,28 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
@@ -855,22 +855,22 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 
 	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* release VCPU reset to boot */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_SOFT_RESET), 0, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_LMI_CTRL2),
 		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT, 0, indirect);
 
 	/* enable master interrupt */
-	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 		UVD, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3c6eafb62ee6..261afbb504bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -443,7 +443,7 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
 {
 	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 	uint32_t offset;
@@ -451,91 +451,91 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		offset = size;
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_NONCACHE_SIZE0),
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
@@ -657,7 +657,7 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
 	}
 }
 
-static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
+void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		uint8_t sram_sel, int inst_idx, uint8_t indirect)
 {
 	uint32_t reg_data = 0;
@@ -689,19 +689,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__WCB_MODE_MASK |
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
@@ -792,11 +792,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
@@ -808,28 +808,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
@@ -837,26 +837,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
 	/* unblock VCPU register access */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* enable master interrupt */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
@@ -1300,7 +1300,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }
 
-static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 {
 	int ret_code = 0;
 	uint32_t tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index f47136d9bfe8..c9b5d5a3e239 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -391,84 +391,84 @@ static void vcn_v3_0_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 				VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		offset = size;
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 			VCN, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
 }
 
@@ -739,19 +739,19 @@ static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__WCB_MODE_MASK |
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
@@ -847,11 +847,11 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
@@ -863,28 +863,28 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MPC_SET_MUXB0),
 		 ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
@@ -892,31 +892,31 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 
 	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
 	/* unblock VCPU register access */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* enable master interrupt */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	/* add nop to workaround PSP size check */
-	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE(inst_idx, SOC15_DPG_MODE_OFFSET(
 		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	if (indirect)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
