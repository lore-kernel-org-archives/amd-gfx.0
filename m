Return-Path: <SRS0=fixR=6O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89719C4724C
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D3A820787
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2020 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/QEKG1z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3A820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19AF86E955;
	Thu, 30 Apr 2020 18:37:33 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD916E955
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 18:37:32 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id g74so6762578qke.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2020 11:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lUfd0UG/6Z+yQkwGXvMrjIYWGoHBiy+iPgXO0SFPQ6I=;
 b=Q/QEKG1zbaXKRNUXUNweYWJBea+E028ccen7gHEPiYHnkKXEZ+/0Q6N7ggdx3PDkvG
 gVNP8pM/GF3CcfFZw2sHrsoVOXSnJwD0XV1/Gw/e2shCTCXtKXGWufl7iQ8Hz+SoT1Mc
 TRUs7H8v+SJ8akgLL0MIfAZmR/WIC+myjFJhxGMk0rFZRc29omWx2vfJO0QrUckgNOMX
 aMuscb4pNe/wL1+A8nuoc6/qFNPvaxtyJ5oA7vxF0zYBd9/vw6HDSf1jSVriFmse6ysf
 9I9CWQmZ6eltc9qe3ROJcsTJlAd2ziFXwADbtjF37TF8WRYC+AYCNmNYV1t1AXSVa8hZ
 Yzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lUfd0UG/6Z+yQkwGXvMrjIYWGoHBiy+iPgXO0SFPQ6I=;
 b=CShigCOPk+n7zrrxrmQstvhRKgKkmdwv+ttPxU/TyRdqk5Zj08b0IbLjIWP66ECztB
 tPhvuZsrQmGQ2xhDbdL2ObBE0DXiNPd/8GvCt16AtcYfQJq0exj5zq0QH90iJc1xR31z
 m3HSNF+PtxCXySozBFL2E/Knsk0Wss/anFawM0Em/EXf1/T07Ir4ZsQLsZ0KP00icgHr
 yS3rhKvKnVD9njoUAGd+OAkPoEvh3nIPi+Iz0s5lRvqNDswGd5Dj7sOqQgc8yke2ZpXS
 4smZQLH758YP4+L//qGdSchOvQLjJWuzAS6RMwJZmaulElL0eUPMrozw4PguBDqcs605
 Zxig==
X-Gm-Message-State: AGi0PuajlMlqN2csMzcayI9I4E47qMY5jgCGRmJ0AnrmAeEQnkp6oPTf
 mBcjAtm9PlgrVEHXRrl/guBVrFpw
X-Google-Smtp-Source: APiQypKhkuyFg7RovUj4DT3HUmYKqwAaOYM3f4b/IcilwqI/ffXZCWRpGs0ykH+TS/iekkctln10gQ==
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr4590465qkg.447.1588271849955; 
 Thu, 30 Apr 2020 11:37:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id c139sm693510qkg.8.2020.04.30.11.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:37:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: change HWIP from UVD to VCN for VCN2.5
Date: Thu, 30 Apr 2020 14:37:12 -0400
Message-Id: <20200430183719.419549-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Boyuan Zhang <boyuan.zhang@amd.com>, James Zhu <james.zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Boyuan Zhang <boyuan.zhang@amd.com>

Rename hardware IP name from UVD to VCN to reduce confusion.
Hardware IP name UVD and VCN are equivalent for VCN2.5 asics.
Use name VCN for future VCN based asics.

V2: update description
V3: rebase

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 392 +++++++++++++-------------
 1 file changed, 196 insertions(+), 196 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 5c1b9ed76534..34ed906645c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -86,7 +86,7 @@ static int vcn_v2_5_early_init(void *handle)
 
 			adev->vcn.num_vcn_inst = VCN25_MAX_HW_INSTANCES_ARCTURUS;
 			for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
-				harvest = RREG32_SOC15(UVD, i, mmCC_UVD_HARVESTING);
+				harvest = RREG32_SOC15(VCN, i, mmCC_UVD_HARVESTING);
 				if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
 					adev->vcn.harvest_config |= 1 << i;
 			}
@@ -177,15 +177,15 @@ static int vcn_v2_5_sw_init(void *handle)
 		adev->vcn.internal.gp_scratch8 = mmUVD_GP_SCRATCH8_INTERNAL_OFFSET;
 
 		adev->vcn.internal.scratch9 = mmUVD_SCRATCH9_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(UVD, j, mmUVD_SCRATCH9);
+		adev->vcn.inst[j].external.scratch9 = SOC15_REG_OFFSET(VCN, j, mmUVD_SCRATCH9);
 		adev->vcn.internal.data0 = mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(UVD, j, mmUVD_GPCOM_VCPU_DATA0);
+		adev->vcn.inst[j].external.data0 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA0);
 		adev->vcn.internal.data1 = mmUVD_GPCOM_VCPU_DATA1_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(UVD, j, mmUVD_GPCOM_VCPU_DATA1);
+		adev->vcn.inst[j].external.data1 = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_DATA1);
 		adev->vcn.internal.cmd = mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(UVD, j, mmUVD_GPCOM_VCPU_CMD);
+		adev->vcn.inst[j].external.cmd = SOC15_REG_OFFSET(VCN, j, mmUVD_GPCOM_VCPU_CMD);
 		adev->vcn.internal.nop = mmUVD_NO_OP_INTERNAL_OFFSET;
-		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(UVD, j, mmUVD_NO_OP);
+		adev->vcn.inst[j].external.nop = SOC15_REG_OFFSET(VCN, j, mmUVD_NO_OP);
 
 		ring = &adev->vcn.inst[j].ring_dec;
 		ring->use_doorbell = true;
@@ -399,46 +399,46 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 			continue;
 		/* cache window 0: fw */
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo));
-			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi));
-			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
+			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0, 0);
 			offset = 0;
 		} else {
-			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
+			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW,
 				lower_32_bits(adev->vcn.inst[i].gpu_addr));
-			WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
+			WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH,
 				upper_32_bits(adev->vcn.inst[i].gpu_addr));
 			offset = size;
-			WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET0,
+			WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET0,
 				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
 		}
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_SIZE0, size);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE0, size);
 
 		/* cache window 1: stack */
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW,
 			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH,
 			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET1, 0);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE1, AMDGPU_VCN_STACK_SIZE);
 
 		/* cache window 2: context */
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW,
 			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH,
 			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE));
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_OFFSET2, 0);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
 
 		/* non-cache window */
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
 			lower_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
-		WREG32_SOC15(UVD, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
 			upper_32_bits(adev->vcn.inst[i].fw_shared_gpu_addr));
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
-		WREG32_SOC15(UVD, i, mmUVD_VCPU_NONCACHE_SIZE0,
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+		WREG32_SOC15(VCN, i, mmUVD_VCPU_NONCACHE_SIZE0,
 			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
 	}
 }
@@ -452,91 +452,91 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				VCN, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+				VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				VCN, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			VCN, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		offset = size;
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
+			VCN, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+			VCN, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+			VCN, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			VCN, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+			VCN, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			VCN, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+		VCN, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		VCN, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+		VCN, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+		VCN, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		VCN, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+		VCN, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0),
+		VCN, 0, mmUVD_VCPU_NONCACHE_SIZE0),
 		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		VCN, 0, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
@@ -690,19 +690,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+		VCN, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+		VCN, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+		VCN, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+		VCN, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
 /**
@@ -774,13 +774,13 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	uint32_t rb_bufsz, tmp;
 
 	/* disable register anti-hang mechanism */
-	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 1,
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 1,
 		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	/* enable dynamic power gating mode */
-	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_POWER_STATUS);
+	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS);
 	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
 	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
-	WREG32_SOC15(UVD, inst_idx, mmUVD_POWER_STATUS, tmp);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
 		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
@@ -793,11 +793,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		VCN, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
+		VCN, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
 	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
@@ -809,28 +809,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
+		VCN, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_CNTL),
+		VCN, 0, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUXA0),
+		VCN, 0, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUXB0),
+		VCN, 0, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUX),
+		VCN, 0, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
@@ -838,26 +838,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+		VCN, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+		VCN, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
+		VCN, 0, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+		VCN, 0, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		VCN, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MASTINT_EN),
+		VCN, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
@@ -873,39 +873,39 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_CNTL, tmp);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_CNTL, tmp);
 
 	/* Stall DPG before WPTR/RPTR reset */
-	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 	fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
 
 	/* set the write pointer delay */
-	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
 
 	/* set the wb address */
-	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR_ADDR,
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR_ADDR,
 		(upper_32_bits(ring->gpu_addr) >> 2));
 
 	/* programm the RB_BASE for ring buffer */
-	WREG32_SOC15(UVD, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+	WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 		lower_32_bits(ring->gpu_addr));
-	WREG32_SOC15(UVD, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+	WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
 		upper_32_bits(ring->gpu_addr));
 
 	/* Initialize the ring buffer's read and write pointers */
-	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR, 0);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR, 0);
 
-	WREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2, 0);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2, 0);
 
-	ring->wptr = RREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR);
-	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
+	ring->wptr = RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
 	fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 	/* Unstall DPG */
-	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
 	return 0;
@@ -929,12 +929,12 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		}
 
 		/* disable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
 		/* set uvd status busy */
-		tmp = RREG32_SOC15(UVD, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
-		WREG32_SOC15(UVD, i, mmUVD_STATUS, tmp);
+		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
+		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 	}
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
@@ -947,44 +947,44 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		/* enable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL),
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
 			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
 
 		/* disable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_MASTINT_EN), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN), 0,
 			~UVD_MASTINT_EN__VCPU_EN_MASK);
 
 		/* setup mmUVD_LMI_CTRL */
-		tmp = RREG32_SOC15(UVD, i, mmUVD_LMI_CTRL);
+		tmp = RREG32_SOC15(VCN, i, mmUVD_LMI_CTRL);
 		tmp &= ~0xff;
-		WREG32_SOC15(UVD, i, mmUVD_LMI_CTRL, tmp | 0x8|
+		WREG32_SOC15(VCN, i, mmUVD_LMI_CTRL, tmp | 0x8|
 			UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK	|
 			UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
 			UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
 			UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK);
 
 		/* setup mmUVD_MPC_CNTL */
-		tmp = RREG32_SOC15(UVD, i, mmUVD_MPC_CNTL);
+		tmp = RREG32_SOC15(VCN, i, mmUVD_MPC_CNTL);
 		tmp &= ~UVD_MPC_CNTL__REPLACEMENT_MODE_MASK;
 		tmp |= 0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT;
 		WREG32_SOC15(VCN, i, mmUVD_MPC_CNTL, tmp);
 
 		/* setup UVD_MPC_SET_MUXA0 */
-		WREG32_SOC15(UVD, i, mmUVD_MPC_SET_MUXA0,
+		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXA0,
 			((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 			(0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 			(0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 			(0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)));
 
 		/* setup UVD_MPC_SET_MUXB0 */
-		WREG32_SOC15(UVD, i, mmUVD_MPC_SET_MUXB0,
+		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUXB0,
 			((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 			(0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 			(0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 			(0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)));
 
 		/* setup mmUVD_MPC_SET_MUX */
-		WREG32_SOC15(UVD, i, mmUVD_MPC_SET_MUX,
+		WREG32_SOC15(VCN, i, mmUVD_MPC_SET_MUX,
 			((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 			(0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 			(0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)));
@@ -997,27 +997,27 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		/* VCN global tiling registers */
-		WREG32_SOC15(UVD, i, mmUVD_GFX8_ADDR_CONFIG,
+		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(UVD, i, mmUVD_GFX8_ADDR_CONFIG,
+		WREG32_SOC15(VCN, i, mmUVD_GFX8_ADDR_CONFIG,
 			adev->gfx.config.gb_addr_config);
 
 		/* enable LMI MC and UMC channels */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_LMI_CTRL2), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_LMI_CTRL2), 0,
 			~UVD_LMI_CTRL2__STALL_ARB_UMC_MASK);
 
 		/* unblock VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_RB_ARB_CTRL), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL), 0,
 			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
 			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
 		for (k = 0; k < 10; ++k) {
 			uint32_t status;
 
 			for (j = 0; j < 100; ++j) {
-				status = RREG32_SOC15(UVD, i, mmUVD_STATUS);
+				status = RREG32_SOC15(VCN, i, mmUVD_STATUS);
 				if (status & 2)
 					break;
 				if (amdgpu_emu_mode == 1)
@@ -1030,11 +1030,11 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 				break;
 
 			DRM_ERROR("VCN decode not responding, trying to reset the VCPU!!!\n");
-			WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL),
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
 				UVD_VCPU_CNTL__BLK_RST_MASK,
 				~UVD_VCPU_CNTL__BLK_RST_MASK);
 			mdelay(10);
-			WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL), 0,
+			WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
 				~UVD_VCPU_CNTL__BLK_RST_MASK);
 
 			mdelay(10);
@@ -1047,15 +1047,15 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		}
 
 		/* enable master interrupt */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_MASTINT_EN),
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_MASTINT_EN),
 			UVD_MASTINT_EN__VCPU_EN_MASK,
 			~UVD_MASTINT_EN__VCPU_EN_MASK);
 
 		/* clear the busy bit of VCN_STATUS */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS), 0,
 			~(2 << UVD_STATUS__VCPU_REPORT__SHIFT));
 
-		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_VMID, 0);
+		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_VMID, 0);
 
 		ring = &adev->vcn.inst[i].ring_dec;
 		/* force RBC into idle state */
@@ -1065,39 +1065,39 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
-		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_CNTL, tmp);
+		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_CNTL, tmp);
 
 		fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
 		/* programm the RB_BASE for ring buffer */
-		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(UVD, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		WREG32_SOC15(VCN, i, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
 			upper_32_bits(ring->gpu_addr));
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_RPTR, 0);
+		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);
 
-		ring->wptr = RREG32_SOC15(UVD, i, mmUVD_RBC_RB_RPTR);
-		WREG32_SOC15(UVD, i, mmUVD_RBC_RB_WPTR,
+		ring->wptr = RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
+		WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
 				lower_32_bits(ring->wptr));
 		fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 		fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &adev->vcn.inst[i].ring_enc[0];
-		WREG32_SOC15(UVD, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
-		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE, ring->ring_size / 4);
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE, ring->ring_size / 4);
 		fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 		fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 		ring = &adev->vcn.inst[i].ring_enc[1];
-		WREG32_SOC15(UVD, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-		WREG32_SOC15(UVD, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(UVD, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
+		WREG32_SOC15(VCN, i, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+		WREG32_SOC15(VCN, i, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+		WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
 		fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 	}
 
@@ -1118,33 +1118,33 @@ static int vcn_v2_5_mmsch_start(struct amdgpu_device *adev,
 	 * 1, write to vce_mmsch_vf_ctx_addr_lo/hi register with GPU mc addr of
 	 *  memory descriptor location
 	 */
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(addr));
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(addr));
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_LO, lower_32_bits(addr));
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_ADDR_HI, upper_32_bits(addr));
 
 	/* 2, update vmid of descriptor */
-	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID);
+	data = RREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID);
 	data &= ~MMSCH_VF_VMID__VF_CTX_VMID_MASK;
 	/* use domain0 for MM scheduler */
 	data |= (0 << MMSCH_VF_VMID__VF_CTX_VMID__SHIFT);
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_VMID, data);
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_VMID, data);
 
 	/* 3, notify mmsch about the size of this descriptor */
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_CTX_SIZE, size);
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_CTX_SIZE, size);
 
 	/* 4, set resp to zero */
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP, 0);
 
 	/*
 	 * 5, kick off the initialization and wait until
 	 * VCE_MMSCH_VF_MAILBOX_RESP becomes non-zero
 	 */
-	WREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_HOST, 0x10000001);
+	WREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_HOST, 0x10000001);
 
-	data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+	data = RREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP);
 	loop = 10;
 	while ((data & 0x10000002) != 0x10000002) {
 		udelay(100);
-		data = RREG32_SOC15(UVD, 0, mmMMSCH_VF_MAILBOX_RESP);
+		data = RREG32_SOC15(VCN, 0, mmMMSCH_VF_MAILBOX_RESP);
 		loop--;
 		if (!loop)
 			break;
@@ -1187,93 +1187,93 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 		table_size = 0;
 
 		MMSCH_V1_0_INSERT_DIRECT_RD_MOD_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_STATUS),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_STATUS),
 			~UVD_STATUS__UVD_BUSY, UVD_STATUS__UVD_BUSY);
 
 		size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
 		/* mc resume*/
 		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(VCN, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_lo);
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(VCN, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + i].tmr_mc_addr_hi);
 			offset = 0;
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0), 0);
+				SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_OFFSET0), 0);
 		} else {
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(VCN, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				lower_32_bits(adev->vcn.inst[i].gpu_addr));
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i,
+				SOC15_REG_OFFSET(VCN, i,
 					mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				upper_32_bits(adev->vcn.inst[i].gpu_addr));
 			offset = size;
 			MMSCH_V1_0_INSERT_DIRECT_WT(
-				SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET0),
+				SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_OFFSET0),
 				AMDGPU_UVD_FIRMWARE_OFFSET >> 3);
 		}
 
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE0),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_SIZE0),
 			size);
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET1),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_OFFSET1),
 			0);
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE1),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_SIZE1),
 			AMDGPU_VCN_STACK_SIZE);
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[i].gpu_addr + offset +
 				AMDGPU_VCN_STACK_SIZE));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[i].gpu_addr + offset +
 				AMDGPU_VCN_STACK_SIZE));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_OFFSET2),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_OFFSET2),
 			0);
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CACHE_SIZE2),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CACHE_SIZE2),
 			AMDGPU_VCN_CONTEXT_SIZE);
 
 		ring = &adev->vcn.inst[i].ring_enc[0];
 		ring->wptr = 0;
 
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_LO),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_RB_BASE_LO),
 			lower_32_bits(ring->gpu_addr));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_RB_BASE_HI),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_RB_BASE_HI),
 			upper_32_bits(ring->gpu_addr));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_RB_SIZE),
+			SOC15_REG_OFFSET(VCN, i, mmUVD_RB_SIZE),
 			ring->ring_size / 4);
 
 		ring = &adev->vcn.inst[i].ring_dec;
 		ring->wptr = 0;
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_RBC_RB_64BIT_BAR_LOW),
 			lower_32_bits(ring->gpu_addr));
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i,
+			SOC15_REG_OFFSET(VCN, i,
 				mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH),
 			upper_32_bits(ring->gpu_addr));
 
@@ -1285,7 +1285,7 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
 		tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 		MMSCH_V1_0_INSERT_DIRECT_WT(
-			SOC15_REG_OFFSET(UVD, i, mmUVD_RBC_RB_CNTL), tmp);
+			SOC15_REG_OFFSET(VCN, i, mmUVD_RBC_RB_CNTL), tmp);
 
 		/* add end packet */
 		memcpy((void *)init_table, &end, sizeof(struct mmsch_v1_0_cmd_end));
@@ -1306,24 +1306,24 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
 	uint32_t tmp;
 
 	/* Wait for power status to be 1 */
-	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 1,
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
 	/* wait for read ptr to be equal to write ptr */
-	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR);
-	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
 
-	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2);
-	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2);
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
 
-	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
-	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
 
-	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 1,
+	SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 1,
 		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
 	/* disable dynamic power gating mode */
-	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 0,
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
 	return 0;
@@ -1367,17 +1367,17 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			return r;
 
 		/* block VCPU register access */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_RB_ARB_CTRL),
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_RB_ARB_CTRL),
 			UVD_RB_ARB_CTRL__VCPU_DIS_MASK,
 			~UVD_RB_ARB_CTRL__VCPU_DIS_MASK);
 
 		/* reset VCPU */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL),
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
 			UVD_VCPU_CNTL__BLK_RST_MASK,
 			~UVD_VCPU_CNTL__BLK_RST_MASK);
 
 		/* disable VCPU clock */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_VCPU_CNTL), 0,
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL), 0,
 			~(UVD_VCPU_CNTL__CLK_EN_MASK));
 
 		/* clear status */
@@ -1386,7 +1386,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 		vcn_v2_5_enable_clock_gating(adev);
 
 		/* enable register anti-hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS),
+		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_POWER_STATUS),
 			UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
@@ -1408,11 +1408,11 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 	if (adev->vcn.inst[inst_idx].pause_state.fw_based != new_state->fw_based) {
 		DRM_DEBUG("dpg pause state changed %d -> %d",
 			adev->vcn.inst[inst_idx].pause_state.fw_based,	new_state->fw_based);
-		reg_data = RREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE) &
+		reg_data = RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE) &
 			(~UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK);
 
 		if (new_state->fw_based == VCN_DPG_STATE__PAUSE) {
-			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
+			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
 			if (!ret_code) {
@@ -1420,15 +1420,15 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
-				WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE, reg_data);
 
 				/* wait for ACK */
-				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_DPG_PAUSE,
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_DPG_PAUSE,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK,
 					   UVD_DPG_PAUSE__NJ_PAUSE_DPG_ACK_MASK, ret_code);
 
 				/* Stall DPG before WPTR/RPTR reset */
-				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
@@ -1436,39 +1436,39 @@ static int vcn_v2_5_pause_dpg_mode(struct amdgpu_device *adev,
 				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[0];
 				ring->wptr = 0;
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO, ring->gpu_addr);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE, ring->ring_size / 4);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 				fw_shared->multi_queue.encode_lowlatency_queue_mode |= FW_QUEUE_RING_RESET;
 				ring = &adev->vcn.inst[inst_idx].ring_enc[1];
 				ring->wptr = 0;
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_LO2, ring->gpu_addr);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_SIZE2, ring->ring_size / 4);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 				fw_shared->multi_queue.decode_queue_mode |= FW_QUEUE_RING_RESET;
-				WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
-					   RREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
+					   RREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2) & 0x7FFFFFFF);
 				fw_shared->multi_queue.decode_queue_mode &= ~FW_QUEUE_RING_RESET;
 
 				/* Unstall DPG */
-				WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS),
+				WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
-				SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS,
+				SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS,
 					   UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON, UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 			}
 		} else {
 			reg_data &= ~UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
-			WREG32_SOC15(UVD, inst_idx, mmUVD_DPG_PAUSE, reg_data);
-			SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 0x1,
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_PAUSE, reg_data);
+			SOC15_WAIT_ON_RREG(VCN, inst_idx, mmUVD_POWER_STATUS, 0x1,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 		}
 		adev->vcn.inst[inst_idx].pause_state.fw_based = new_state->fw_based;
@@ -1488,7 +1488,7 @@ static uint64_t vcn_v2_5_dec_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	return RREG32_SOC15(UVD, ring->me, mmUVD_RBC_RB_RPTR);
+	return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_RPTR);
 }
 
 /**
@@ -1505,7 +1505,7 @@ static uint64_t vcn_v2_5_dec_ring_get_wptr(struct amdgpu_ring *ring)
 	if (ring->use_doorbell)
 		return adev->wb.wb[ring->wptr_offs];
 	else
-		return RREG32_SOC15(UVD, ring->me, mmUVD_RBC_RB_WPTR);
+		return RREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR);
 }
 
 /**
@@ -1520,14 +1520,14 @@ static void vcn_v2_5_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-		WREG32_SOC15(UVD, ring->me, mmUVD_SCRATCH2,
+		WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
 			lower_32_bits(ring->wptr) | 0x80000000);
 
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 	} else {
-		WREG32_SOC15(UVD, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
+		WREG32_SOC15(VCN, ring->me, mmUVD_RBC_RB_WPTR, lower_32_bits(ring->wptr));
 	}
 }
 
@@ -1573,9 +1573,9 @@ static uint64_t vcn_v2_5_enc_ring_get_rptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (ring == &adev->vcn.inst[ring->me].ring_enc[0])
-		return RREG32_SOC15(UVD, ring->me, mmUVD_RB_RPTR);
+		return RREG32_SOC15(VCN, ring->me, mmUVD_RB_RPTR);
 	else
-		return RREG32_SOC15(UVD, ring->me, mmUVD_RB_RPTR2);
+		return RREG32_SOC15(VCN, ring->me, mmUVD_RB_RPTR2);
 }
 
 /**
@@ -1593,12 +1593,12 @@ static uint64_t vcn_v2_5_enc_ring_get_wptr(struct amdgpu_ring *ring)
 		if (ring->use_doorbell)
 			return adev->wb.wb[ring->wptr_offs];
 		else
-			return RREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR);
+			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR);
 	} else {
 		if (ring->use_doorbell)
 			return adev->wb.wb[ring->wptr_offs];
 		else
-			return RREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR2);
+			return RREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2);
 	}
 }
 
@@ -1618,14 +1618,14 @@ static void vcn_v2_5_enc_ring_set_wptr(struct amdgpu_ring *ring)
 			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
-			WREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 		}
 	} else {
 		if (ring->use_doorbell) {
 			adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
 			WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
 		} else {
-			WREG32_SOC15(UVD, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+			WREG32_SOC15(VCN, ring->me, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 		}
 	}
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
