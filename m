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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4E3C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853A92073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ushfqrH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853A92073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4266E33C;
	Mon,  1 Jun 2020 18:22:11 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 888256E33A
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:10 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id 205so10022027qkg.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MrEuubwWcvlqtduMgphBZDM0ykvoB+A/v9risxdd55o=;
 b=ushfqrH02mZoXUGRxCwFRusOPJiOGk9fDrJn0CzZoJmbvxxXqzcPsZawXiHqZS89kt
 LIoM2+mWptElV5Uv4+DDqdLqYjd0gUi+pzVIUN7pJ9IRaR1gpE4HWTYXXDHra7ybL2/U
 xOwo2qJbj0NFom6uOgmHAknhgJf/1riEUC91tm3PcR5l6GOV8zWdje5/m7Ol6a+9E1Xe
 6lQvsQyhT8e3Y+OhDE46p6/+FHwFTLQ1NRplnL21Vq3mPwP2L2EDyI4NONW+l8dhPA5r
 wy/5Jo1dNoY35Po4rjV7/Nu03vfrxPi6QEi7qKn+BLn0z9pyhQQ987kgihmgWqWnkfbD
 2lDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MrEuubwWcvlqtduMgphBZDM0ykvoB+A/v9risxdd55o=;
 b=LYF3Dylhv+fRbQjQ31W2jPS3e24kS/tBBYrq9nOfc4WAfgVxGKqynKEZXn84zIX49v
 27MolE4AHV0QLqB3spQXhdOYWuvaxuw0nPDvILkBEDTxsDeWvBG3UhqAFBq33tl4ZUzB
 y3xxWF0p1sHUdhLsG+3YOWbw5wvqX88vpsI5u3ez043O4M1n+OJaYjsxSOd3W63n2o8C
 j2VQ5RY7ayKFTrwFR/PBOLaVEYG3zu+7zcLlWps8dkxyeEta9wLj5HiJUoUzLHmQe0+P
 5P8jm1MTysbkrxbEVtH0XCOlNdKuz0i0qyyzIoAVYC+n8tIjNVA7dj/+jCg9SMQIqOB/
 ycEw==
X-Gm-Message-State: AOAM530lnq/q+WcxR9SayCXitTtd/hMgB8rh2GtCXfdW/B8QV+FBtbAt
 lbXSKLjkXWWwPiYRwFTFhJTgyhcT
X-Google-Smtp-Source: ABdhPJxoJoUywR9CUn/dCPQW/iLahWkWTK0RFYLQakg8Zi9h3eyLu4JLIMLvQMgDfyCpL7YxFu/6DQ==
X-Received: by 2002:a37:b444:: with SMTP id d65mr4265863qkf.411.1591035729403; 
 Mon, 01 Jun 2020 11:22:09 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:08 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 140/207] drm/amdgpu: add clock gating DPG mode for VCN3.0
Date: Mon,  1 Jun 2020 14:19:47 -0400
Message-Id: <20200601182054.1267858-51-alexander.deucher@amd.com>
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

Add vcn_v3_0_clock_gating_dpg_mode to enabling clock gating in DPG mode for VCN3.0

V2: Separate from previous patch-0002, and update description.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: James Zhu <james.zhu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 340cb344a35d..b0fc589ac88f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -613,6 +613,54 @@ static void vcn_v3_0_disable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(VCN, inst, mmUVD_SUVD_CGC_CTRL, data);
 }
 
+static void vcn_v3_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
+		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+{
+	uint32_t reg_data = 0;
+
+	/* enable sw clock gating control */
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		reg_data = 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		reg_data = 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	reg_data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	reg_data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	reg_data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_CM_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_IT_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_DB_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_MP_MODE_MASK |
+		 UVD_CGC_CTRL__SYS_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_MODE_MASK |
+		 UVD_CGC_CTRL__MPEG2_MODE_MASK |
+		 UVD_CGC_CTRL__REGS_MODE_MASK |
+		 UVD_CGC_CTRL__RBC_MODE_MASK |
+		 UVD_CGC_CTRL__LMI_MC_MODE_MASK |
+		 UVD_CGC_CTRL__LMI_UMC_MODE_MASK |
+		 UVD_CGC_CTRL__IDCT_MODE_MASK |
+		 UVD_CGC_CTRL__MPRD_MODE_MASK |
+		 UVD_CGC_CTRL__MPC_MODE_MASK |
+		 UVD_CGC_CTRL__LBSI_MODE_MASK |
+		 UVD_CGC_CTRL__LRBBM_MODE_MASK |
+		 UVD_CGC_CTRL__WCB_MODE_MASK |
+		 UVD_CGC_CTRL__VCPU_MODE_MASK |
+		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+
+	/* turn off clock gating */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+
+	/* turn on SUVD clock gating */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+
+	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		VCN, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+}
+
 /**
  * vcn_v3_0_enable_clock_gating - enable VCN clock gating
  *
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
