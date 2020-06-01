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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18412C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C0F2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcUGDt0b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C0F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A72126E34A;
	Mon,  1 Jun 2020 18:22:21 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F046E342
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:19 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id w1so10017463qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OmS5yfBHoSzjnGZWt+RPKrW1vQ6Q7m6RzocUDysiCvE=;
 b=OcUGDt0boWGl4nlyIcpschkC4Ah0PBSdl0BRXQuEtPVWhPtsvicZvjdIx/9zgOul7k
 +ceBrAwP2xsAO+icl8ZcvhmnQeKHAL4+5WAO0Ul4xnVwS+e9/9RDPv+tE76vP6pjBLLb
 1SGleG65SY4aktMIFE4vW8KKfwdEQJ0wUEELWjbmp/MRg5EueVEsuDz6+DDTTIE9+Nwz
 f69zrfXpDQPUmi03ZTEnZK4GGzrK6pR47TeBep39dYz1pkR6EvEeSlcAhq+yMMyV6AP/
 QktPQd/jhwFNAp4Ntz1719YxQ1TGmb6r1l201gDUSrQGVvMWo3274L+q/ahJLprzr9YO
 rYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OmS5yfBHoSzjnGZWt+RPKrW1vQ6Q7m6RzocUDysiCvE=;
 b=INsz25Zp6jekNY19/dwCFnEXsrJcdledletP8e+CIlia2721yvyemnA8qdZJUPUrdY
 oy75QV5o/qPoQwabZOKgEgkELd7m34NvRn916WggWung5bK/X+t3cCWIztpmBcMAdN29
 jojCIcq2GHgjdqySyOUvpF9fHPUgK8mPd712l7vndH7eWQkWEXqGpKB3lXuFVoSQ3ZGC
 YpDhZz+tTxxsZZ4ZShF/ECyG+bSf1DSgSVsxqe1ROr4qpyExw6fpXBTQ1PNSSKzBOP+L
 S4wym2w7ErgSW3AkSWds0q8U3osysjCzvhFwrdhZN90VHV2E9BLjm9K3iwyiaWkRl4E1
 gaTA==
X-Gm-Message-State: AOAM53153re4d/DrdrwojZRpw6J8q4zC0jyx2063YcHkiuWRSu+jYoZC
 MdKm7KVWLgyGvNw3vLm0AP/mMqTw
X-Google-Smtp-Source: ABdhPJxf7kRGoFTNVXT0oqkvtBX4xQjwACgYn53YNXTCIM9pbrKz1B3zK2X0IzDzPyOCTqd5K/ithg==
X-Received: by 2002:a37:7d45:: with SMTP id y66mr18321621qkc.484.1591035738707; 
 Mon, 01 Jun 2020 11:22:18 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:18 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 147/207] drm/amdgpu: rename macro for VCN1.0
Date: Mon,  1 Jun 2020 14:19:54 -0400
Message-Id: <20200601182054.1267858-58-alexander.deucher@amd.com>
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

Rename RREG32_SOC15_DPG_MODE and WREG32_SOC15_DPG_MODE for VCN1.0
These two macros are used specifically for VCN1.0, therefore rename
it from general name to VCN1.0 specific name.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 96 ++++++++++++-------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 25a07704cf75..f54e5ccabb42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -67,7 +67,7 @@
 /* 1 second timeout */
 #define VCN_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
-#define RREG32_SOC15_DPG_MODE(ip, inst_idx, reg, mask, sram_sel) 			\
+#define RREG32_SOC15_DPG_MODE_1_0(ip, inst_idx, reg, mask, sram_sel) 			\
 	({	WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
 		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_CTL, 				\
 			UVD_DPG_LMA_CTL__MASK_EN_MASK | 				\
@@ -77,7 +77,7 @@
 		RREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA); 			\
 	})
 
-#define WREG32_SOC15_DPG_MODE(ip, inst_idx, reg, value, mask, sram_sel) 		\
+#define WREG32_SOC15_DPG_MODE_1_0(ip, inst_idx, reg, value, mask, sram_sel) 		\
 	do { 										\
 		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_DATA, value); 			\
 		WREG32_SOC15(ip, inst_idx, mmUVD_DPG_LMA_MASK, mask); 			\
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 1ad79155ed00..b5088b5dd4eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -360,68 +360,68 @@ static void vcn_v1_0_mc_resume_dpg_mode(struct amdgpu_device *adev)
 
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo),
 			     0xFFFFFFFF, 0);
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 			     (adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi),
 			     0xFFFFFFFF, 0);
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0, 0,
 			     0xFFFFFFFF, 0);
 		offset = 0;
 	} else {
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 			lower_32_bits(adev->vcn.inst->gpu_addr), 0xFFFFFFFF, 0);
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 			upper_32_bits(adev->vcn.inst->gpu_addr), 0xFFFFFFFF, 0);
 		offset = size;
-		WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
+		WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_OFFSET0,
 			     AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0xFFFFFFFF, 0);
 	}
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_SIZE0, size, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_SIZE0, size, 0xFFFFFFFF, 0);
 
 	/* cache window 1: stack */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
 		     lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
 		     upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1, 0,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_OFFSET1, 0,
 			     0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE,
 			     0xFFFFFFFF, 0);
 
 	/* cache window 2: context */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
 		     lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE),
 			     0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
 		     upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE),
 			     0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE,
 			     0xFFFFFFFF, 0);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_UDEC_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_UDEC_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_UDEC_DB_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_UDEC_DB_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_UDEC_DBW_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_UDEC_DBW_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_UDEC_DBW_UV_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_UDEC_DBW_UV_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_CURR_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_CURR_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_CURR_UV_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_CURR_UV_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_RECON1_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_RECON1_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_RECON1_UV_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_RECON1_UV_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_REF_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_REF_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MIF_REF_UV_ADDR_CONFIG,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MIF_REF_UV_ADDR_CONFIG,
 		adev->gfx.config.gb_addr_config, 0xFFFFFFFF, 0);
 }
 
@@ -636,9 +636,9 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 		reg_data = 0 << JPEG_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
 	reg_data |= 1 << JPEG_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
 	reg_data |= 4 << JPEG_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmJPEG_CGC_CTRL, reg_data, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmJPEG_CGC_CTRL, reg_data, 0xFFFFFFFF, sram_sel);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmJPEG_CGC_GATE, 0, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmJPEG_CGC_GATE, 0, 0xFFFFFFFF, sram_sel);
 
 	/* enable sw clock gating control */
 	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
@@ -667,16 +667,16 @@ static void vcn_v1_0_clock_gating_dpg_mode(struct amdgpu_device *adev, uint8_t s
 		 UVD_CGC_CTRL__WCB_MODE_MASK |
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__SCPU_MODE_MASK);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_CGC_CTRL, reg_data, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_CGC_CTRL, reg_data, 0xFFFFFFFF, sram_sel);
 
 	/* turn off clock gating */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_CGC_GATE, 0, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_CGC_GATE, 0, 0xFFFFFFFF, sram_sel);
 
 	/* turn on SUVD clock gating */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_SUVD_CGC_GATE, 1, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_GATE, 1, 0xFFFFFFFF, sram_sel);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SUVD_CGC_CTRL, 0, 0xFFFFFFFF, sram_sel);
 }
 
 static void vcn_1_0_disable_static_power_gating(struct amdgpu_device *adev)
@@ -972,14 +972,14 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_VCPU_CNTL, tmp, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_VCPU_CNTL, tmp, 0xFFFFFFFF, 0);
 
 	/* disable interupt */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MASTINT_EN,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			0, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
 	/* initialize VCN memory controller */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_CTRL,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
 		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
@@ -993,48 +993,48 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 	/* swap (8 in 32) RB and IB */
 	lmi_swap_cntl = 0xa;
 #endif
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_SWAP_CNTL, lmi_swap_cntl, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_SWAP_CNTL, lmi_swap_cntl, 0xFFFFFFFF, 0);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MPC_CNTL,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MPC_CNTL,
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0xFFFFFFFF, 0);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MPC_SET_MUXA0,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MPC_SET_MUXA0,
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0xFFFFFFFF, 0);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MPC_SET_MUXB0,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MPC_SET_MUXB0,
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0xFFFFFFFF, 0);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MPC_SET_MUX,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MPC_SET_MUX,
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0xFFFFFFFF, 0);
 
 	vcn_v1_0_mc_resume_dpg_mode(adev);
 
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_REG_XX_MASK, 0x10, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK, 0x3, 0xFFFFFFFF, 0);
 
 	/* boot up the VCPU */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_SOFT_RESET, 0, 0xFFFFFFFF, 0);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SOFT_RESET, 0, 0xFFFFFFFF, 0);
 
 	/* enable UMC */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_CTRL2,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL2,
 		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT,
 		0xFFFFFFFF, 0);
 
 	/* enable master interrupt */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_MASTINT_EN,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_MASTINT_EN,
 			UVD_MASTINT_EN__VCPU_EN_MASK, UVD_MASTINT_EN__VCPU_EN_MASK, 0);
 
 	vcn_v1_0_clock_gating_dpg_mode(adev, 1);
 	/* setup mmUVD_LMI_CTRL */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_LMI_CTRL,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_LMI_CTRL,
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
 		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
@@ -1046,11 +1046,11 @@ static int vcn_v1_0_start_dpg_mode(struct amdgpu_device *adev)
 
 	tmp = adev->gfx.config.gb_addr_config;
 	/* setup VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_JPEG_ADDR_CONFIG, tmp, 0xFFFFFFFF, 1);
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_JPEG_UV_ADDR_CONFIG, tmp, 0xFFFFFFFF, 1);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_JPEG_ADDR_CONFIG, tmp, 0xFFFFFFFF, 1);
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_JPEG_UV_ADDR_CONFIG, tmp, 0xFFFFFFFF, 1);
 
 	/* enable System Interrupt for JRBC */
-	WREG32_SOC15_DPG_MODE(UVD, 0, mmUVD_SYS_INT_EN,
+	WREG32_SOC15_DPG_MODE_1_0(UVD, 0, mmUVD_SYS_INT_EN,
 									UVD_SYS_INT_EN__UVD_JRBC_EN_MASK, 0xFFFFFFFF, 1);
 
 	/* force RBC into idle state */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
