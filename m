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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC256C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92AEB206E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRmCRnJx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92AEB206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498136E2DA;
	Mon,  1 Jun 2020 18:04:48 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10886E2D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:46 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id c12so9904765qkk.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=boEW1F3UtDzgbDodtBBK9BMlZBFrqySQgfSC8oq4G0Y=;
 b=lRmCRnJx8h9DcBBJCoZLj/jNtXMDFQgadSWzRdOAs1+MPwSPTtmLvCpgx36i3drJg2
 LoYIkg4o0ELlk5J6Q61GC+zgdylGL94VMB8PpujjcMKQbWX7n66x4bqDXFYtaGXHxP7Q
 OxfUqbI55z00kEF3OV5U1PYcIGyocHGfvdo7zMhIr7v360Mg5RSCWJntYTxfqjElRzmT
 ZjCUuyD+wHoAhHkLkuZkJZDseJQeSiAsNkrQAYi9+f3Hq9Xpkhtz2jl7NrvFBlXgzqGP
 sjfmkqvdpR5xj4hy4smV4Lt1LjyHrr95FkgAtvY9/uqYkjVE3yOwE+Qxb8qa/VrTq0G2
 2C+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=boEW1F3UtDzgbDodtBBK9BMlZBFrqySQgfSC8oq4G0Y=;
 b=Y5IoBo/zqnF2sI6dyXfMHmG3xPALluqcl6aoO+ERSRcbwgMv7ocNMCDPnAoZ7qD4XA
 AA2SCgC9zmvCDwJckSMoF9BjwCZoFxQGGiWTql5kU8gB/2STZ5CMy0QSfC4u1eVJZs+4
 8meJ0iI5t2kyNDb+yINRk+JvCSOyKeIERdfJqkYPd0bUTL99A614dfPB2GzUeaYqqoMX
 q1GZ+9g5FXLXGY2UdQcpbacDg7F6WGCQ+Zh5/1+EETrBqvYJSDyJQoTTfFYKHX/2Es+F
 9rpEnJ6WlckJ/2v5nccQnBYvdt+z+Ly/sibUn5uM3043T6bQ0i50pryUO/ZlMANhcMp6
 gk6Q==
X-Gm-Message-State: AOAM5319ZbX/qHuKgfud+VSpq2A548ANNP04ma1ebR0/U7bFGaZWJxeR
 achJDJVn5gb6CWRx5kOp3smJqhfa
X-Google-Smtp-Source: ABdhPJw4zEeloOsXpEqtzt8ZDEcAJxAxkEvcWwgxuwA4sMsUrOB75hOzQc7VWjeIZ9K612BPrptprg==
X-Received: by 2002:a37:b14:: with SMTP id 20mr21164371qkl.401.1591034685486; 
 Mon, 01 Jun 2020 11:04:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:44 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 083/207] drm/amdgpu: add Sienna_Cichlid VCN PG and CG support
 (v2)
Date: Mon,  1 Jun 2020 14:00:35 -0400
Message-Id: <20200601180239.1267430-80-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

This is for static powergating and clockgating

v2: fix registers (Alex)

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 332 ++++++++++++++++++++++++++
 1 file changed, 332 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 2833f06fb4bb..011edbdd4e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -381,6 +381,309 @@ static void vcn_v3_0_mc_resume(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
 }
 
+static void vcn_v3_0_disable_static_power_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data = 0;
+	int ret;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDC_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDIRL_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDATD_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
+
+		WREG32_SOC15(VCN, inst, mmUVD_PGFSM_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS,
+			UVD_PGFSM_STATUS__UVDM_UVDU_UVDLM_PWR_ON_3_0, 0x3F3FFFFF, ret);
+	} else {
+		data = (1 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDC_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDIRL_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDATD_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
+			| 1 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
+		WREG32_SOC15(VCN, inst, mmUVD_PGFSM_CONFIG, data);
+		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, 0,  0x3F3FFFFF, ret);
+	}
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+	data &= ~0x103;
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN)
+		data |= UVD_PGFSM_CONFIG__UVDM_UVDU_PWR_ON |
+			UVD_POWER_STATUS__UVD_PG_EN_MASK;
+
+	WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
+}
+
+static void vcn_v3_0_enable_static_power_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data;
+	int ret;
+
+	if (adev->pg_flags & AMD_PG_SUPPORT_VCN) {
+		/* Before power off, this indicator has to be turned on */
+		data = RREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS);
+		data &= ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK;
+		data |= UVD_POWER_STATUS__UVD_POWER_STATUS_TILES_OFF;
+		WREG32_SOC15(VCN, inst, mmUVD_POWER_STATUS, data);
+
+		data = (2 << UVD_PGFSM_CONFIG__UVDM_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDU_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDF_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDC_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDB_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDIRL_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDLM_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDTD_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDTE_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDE_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDAB_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDATD_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDNA_PWR_CONFIG__SHIFT
+			| 2 << UVD_PGFSM_CONFIG__UVDNB_PWR_CONFIG__SHIFT);
+		WREG32_SOC15(VCN, inst, mmUVD_PGFSM_CONFIG, data);
+
+		data = (2 << UVD_PGFSM_STATUS__UVDM_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDU_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDF_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDC_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDB_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDIRL_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDLM_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDTD_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDTE_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDE_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDAB_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDATD_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDNA_PWR_STATUS__SHIFT
+			| 2 << UVD_PGFSM_STATUS__UVDNB_PWR_STATUS__SHIFT);
+		SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_PGFSM_STATUS, data, 0x3F3FFFFF, ret);
+	}
+}
+
+/**
+ * vcn_v3_0_disable_clock_gating - disable VCN clock gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Disable clock gating for VCN block
+ */
+static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data;
+	int ret = 0;
+
+	/* VCN disable CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data &= ~UVD_CGC_CTRL__DYN_CLOCK_MODE_MASK;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_GATE);
+	data &= ~(UVD_CGC_GATE__SYS_MASK
+		| UVD_CGC_GATE__UDEC_MASK
+		| UVD_CGC_GATE__MPEG2_MASK
+		| UVD_CGC_GATE__REGS_MASK
+		| UVD_CGC_GATE__RBC_MASK
+		| UVD_CGC_GATE__LMI_MC_MASK
+		| UVD_CGC_GATE__LMI_UMC_MASK
+		| UVD_CGC_GATE__IDCT_MASK
+		| UVD_CGC_GATE__MPRD_MASK
+		| UVD_CGC_GATE__MPC_MASK
+		| UVD_CGC_GATE__LBSI_MASK
+		| UVD_CGC_GATE__LRBBM_MASK
+		| UVD_CGC_GATE__UDEC_RE_MASK
+		| UVD_CGC_GATE__UDEC_CM_MASK
+		| UVD_CGC_GATE__UDEC_IT_MASK
+		| UVD_CGC_GATE__UDEC_DB_MASK
+		| UVD_CGC_GATE__UDEC_MP_MASK
+		| UVD_CGC_GATE__WCB_MASK
+		| UVD_CGC_GATE__VCPU_MASK
+		| UVD_CGC_GATE__MMSCH_MASK);
+
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_GATE, data);
+
+	SOC15_WAIT_ON_RREG(VCN, inst, mmUVD_CGC_GATE, 0,  0xFFFFFFFF, ret);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK
+		| UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE);
+	data |= (UVD_SUVD_CGC_GATE__SRE_MASK
+		| UVD_SUVD_CGC_GATE__SIT_MASK
+		| UVD_SUVD_CGC_GATE__SMP_MASK
+		| UVD_SUVD_CGC_GATE__SCM_MASK
+		| UVD_SUVD_CGC_GATE__SDB_MASK
+		| UVD_SUVD_CGC_GATE__SRE_H264_MASK
+		| UVD_SUVD_CGC_GATE__SRE_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_H264_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCM_H264_MASK
+		| UVD_SUVD_CGC_GATE__SCM_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_H264_MASK
+		| UVD_SUVD_CGC_GATE__SDB_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__SCLR_MASK
+		| UVD_SUVD_CGC_GATE__ENT_MASK
+		| UVD_SUVD_CGC_GATE__IME_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SIT_HEVC_ENC_MASK
+		| UVD_SUVD_CGC_GATE__SITE_MASK
+		| UVD_SUVD_CGC_GATE__SRE_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SCM_VP9_MASK
+		| UVD_SUVD_CGC_GATE__SIT_VP9_DEC_MASK
+		| UVD_SUVD_CGC_GATE__SDB_VP9_MASK
+		| UVD_SUVD_CGC_GATE__IME_HEVC_MASK
+		| UVD_SUVD_CGC_GATE__EFC_MASK
+		| UVD_SUVD_CGC_GATE__SAOE_MASK
+		| 0x08000000
+		| UVD_SUVD_CGC_GATE__FBC_PCLK_MASK
+		| UVD_SUVD_CGC_GATE__FBC_CCLK_MASK
+		| 0x40000000
+		| UVD_SUVD_CGC_GATE__SMPA_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2);
+	data |= (UVD_SUVD_CGC_GATE2__MPBE0_MASK
+		| UVD_SUVD_CGC_GATE2__MPBE1_MASK
+		| 0x00000004
+		| 0x00000008
+		| UVD_SUVD_CGC_GATE2__MPC1_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_GATE2, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data &= ~(UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__EFC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SAOE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
+		| 0x00008000
+		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
+		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
+}
+
+/**
+ * vcn_v3_0_enable_clock_gating - enable VCN clock gating
+ *
+ * @adev: amdgpu_device pointer
+ * @inst: instance number
+ *
+ * Enable clock gating for VCN block
+ */
+static void vcn_v3_0_enable_clock_gating(struct amdgpu_device *adev, int inst)
+{
+	uint32_t data;
+
+	/* enable VCN CGC */
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		data |= 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		data |= 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL);
+	data |= (UVD_CGC_CTRL__UDEC_RE_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_CM_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_IT_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_DB_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MP_MODE_MASK
+		| UVD_CGC_CTRL__SYS_MODE_MASK
+		| UVD_CGC_CTRL__UDEC_MODE_MASK
+		| UVD_CGC_CTRL__MPEG2_MODE_MASK
+		| UVD_CGC_CTRL__REGS_MODE_MASK
+		| UVD_CGC_CTRL__RBC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_MC_MODE_MASK
+		| UVD_CGC_CTRL__LMI_UMC_MODE_MASK
+		| UVD_CGC_CTRL__IDCT_MODE_MASK
+		| UVD_CGC_CTRL__MPRD_MODE_MASK
+		| UVD_CGC_CTRL__MPC_MODE_MASK
+		| UVD_CGC_CTRL__LBSI_MODE_MASK
+		| UVD_CGC_CTRL__LRBBM_MODE_MASK
+		| UVD_CGC_CTRL__WCB_MODE_MASK
+		| UVD_CGC_CTRL__VCPU_MODE_MASK
+		| UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_CGC_CTRL, data);
+
+	data = RREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL);
+	data |= (UVD_SUVD_CGC_CTRL__SRE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SIT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMP_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCM_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SDB_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SCLR_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__ENT_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__IME_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SITE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__EFC_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SAOE_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__SMPA_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__MPBE0_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__MPBE1_MODE_MASK
+		| 0x00008000
+		| 0x00010000
+		| UVD_SUVD_CGC_CTRL__MPC1_MODE_MASK
+		| UVD_SUVD_CGC_CTRL__FBC_PCLK_MASK
+		| UVD_SUVD_CGC_CTRL__FBC_CCLK_MASK);
+	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
+}
+
 static int vcn_v3_0_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -394,10 +697,16 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
+		/* disable VCN power gating */
+		vcn_v3_0_disable_static_power_gating(adev, i);
+
 		/* set VCN status busy */
 		tmp = RREG32_SOC15(VCN, i, mmUVD_STATUS) | UVD_STATUS__UVD_BUSY;
 		WREG32_SOC15(VCN, i, mmUVD_STATUS, tmp);
 
+		/*SW clock gating */
+		vcn_v3_0_disable_clock_gating(adev, i);
+
 		/* enable VCPU clock */
 		WREG32_P(SOC15_REG_OFFSET(VCN, i, mmUVD_VCPU_CNTL),
 			UVD_VCPU_CNTL__CLK_EN_MASK, ~UVD_VCPU_CNTL__CLK_EN_MASK);
@@ -600,6 +909,12 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 
 		/* clear status */
 		WREG32_SOC15(VCN, i, mmUVD_STATUS, 0);
+
+		/* apply HW clock gating */
+		vcn_v3_0_enable_clock_gating(adev, i);
+
+		/* enable VCN power gating */
+		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
 	if (adev->pm.dpm_enabled)
@@ -853,6 +1168,23 @@ static int vcn_v3_0_wait_for_idle(void *handle)
 static int vcn_v3_0_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	bool enable = (state == AMD_CG_STATE_GATE) ? true : false;
+	int i;
+
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		if (enable) {
+			if (RREG32_SOC15(VCN, i, mmUVD_STATUS) == UVD_STATUS__IDLE)
+				return -EBUSY;
+			vcn_v3_0_enable_clock_gating(adev, i);
+		} else {
+			vcn_v3_0_disable_clock_gating(adev, i);
+		}
+	}
+
 	return 0;
 }
 
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
