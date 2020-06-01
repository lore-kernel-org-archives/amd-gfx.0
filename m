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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97801C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C992073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUyMYaNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C992073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4586E33F;
	Mon,  1 Jun 2020 18:22:14 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A8716E334
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:13 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id s1so9989489qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=/nO5CyH8oTi/kgf86I2ZrXZdIN6/I3J9DJUvyJCC2qE=;
 b=eUyMYaNIBWEdI4WizGQ9eAO8av665eD1r4IgXZhFk70A/EEWeNmNS+445qZVPmIulo
 JpbSufy9m0uS0wjEC3V/CuTo/BexqT/BnwdG1p2TqStTRBpEYGn1KXRcpkabnB0sET98
 HdLqj4tuukUVAiCctvi25tGiavLrZi+hFveq0563d5Gu9RupcgVRrCryrQcdkCjqzLg6
 LAjvv4rGhZP2h4Zf7MPnUUVDvNs7/9GZ+dEErNuDXpnKFTlqfYF122Qm9JXMyNCahbqS
 3kaoRSmc35Vijj3dDx4tql/gRMV53SOdngeW21HJJBPHCrd30OR9R/lLfVKFzO8kYCKV
 otkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/nO5CyH8oTi/kgf86I2ZrXZdIN6/I3J9DJUvyJCC2qE=;
 b=T+wpA8UPMKRGLo2U6dxWU3OnDd9GBwuBFea0Z4Hfw7HkgDv4dfqivGLRxkBrRRLURP
 gZzTUkckrtbZP0x+ykNYxF/KbniwbXyazAZhKK7BkvVbx7d9cLCwxnsUMWANUXTSLuOo
 iJfztupTUVA2VErEXHMFHOCvdzPSfviJkUWJDaz2OsLoDyJJstVRMo17kdosfN6gaGIn
 OvgE+Gh99v2ZesAT2Ceb2Qkt6GqM6U2NXhrgmvva60Esi4lMX5QmalrAPT18v8DKt7dT
 w6enXqxtV+R3nOlA5FOCswSK3TcUH1+hxXga7a76RnVDt/Y8Yp9atGrlGUFJmzmrvnzJ
 qMaQ==
X-Gm-Message-State: AOAM533Bdwv6hri7NoOUQPCSB5V3foP5jawAb6Mv/dtg8xiQwg4mRp3j
 FMiALZjweSpTBEcG9FO+0jOq7iad
X-Google-Smtp-Source: ABdhPJxFY3zh5KLLkf1UNH0XN7eld4lbLzlNqw8Ez+uhIm9Vx9yjIeiiqGa0+DjbaBFTPfsaLsbDNA==
X-Received: by 2002:a37:8d85:: with SMTP id p127mr19654070qkd.35.1591035732021; 
 Mon, 01 Jun 2020 11:22:12 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 142/207] drm/amdgpu: add start DPG mode for VCN3.0
Date: Mon,  1 Jun 2020 14:19:49 -0400
Message-Id: <20200601182054.1267858-53-alexander.deucher@amd.com>
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

Add vcn_v3_0_start_dpg_mode to setup and start VCN block in DPG mode for VCN3.0

V2: Separate from previous patch-0002, and update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 141 ++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 86db36537371..5578af5cb399 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -818,6 +818,142 @@ static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
+static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	struct amdgpu_ring *ring;
+	uint32_t rb_bufsz, tmp;
+
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 1,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	/* enable dynamic power gating mode */
+	tmp = RREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS);
+	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
+	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
+	WREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS, tmp);
+
+	if (indirect)
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+
+	/* enable clock gating */
+	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+
+	/* enable VCPU clock */
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interupt */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		UVD_LMI_CTRL__REQ_MODE_MASK |
+		UVD_LMI_CTRL__CRC_RESET_MASK |
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
+		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
+		0x00100000L);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MPC_CNTL),
+		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MPC_SET_MUXA0),
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MPC_SET_MUXB0),
+		 ((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MPC_SET_MUX),
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
+
+	vcn_v3_0_mc_resume_dpg_mode(adev, inst_idx, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
+
+	/* unblock VCPU register access */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
+
+	/* add nop to workaround PSP size check */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	if (indirect)
+		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+			(uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
+				(uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+
+	ring = &adev->vcn.inst[inst_idx].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_CNTL, tmp);
+
+	/* set the write pointer delay */
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
+
+	/* set the wb address */
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR_ADDR,
+		(upper_32_bits(ring->gpu_addr) >> 2));
+
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(VCN, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(VCN, inst_idx, mmUVD_SCRATCH2, 0);
+
+	ring->wptr = RREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
+		lower_32_bits(ring->wptr));
+
+	return 0;
+}
+
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -831,6 +967,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG){
+			r = vcn_v3_0_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
+			continue;
+		}
+
 		/* disable VCN power gating */
 		vcn_v3_0_disable_static_power_gating(adev, i);
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
