Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE940C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56AED10E9A1;
	Mon, 13 Jul 2026 13:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ljMmz3F0";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7730E10E9A1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:07:40 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so22102105e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783948059; x=1784552859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AyseptCXDRBomNO9DlDLTXfqTkFLqtyHyiP999B/pJA=;
 b=ljMmz3F0rA90vcTKEJopuxLsMRdHAMoshtfyuSnXlwvcrPb2wr7nt+Wh3r5ErqMZEs
 xmEQaziGKO/8sOIMghKGIO/7GdPDilyHFh6+v5t4/ubQp7Z4Ysp5tZGHzAqmL1DiQEvN
 dlnjms7hEuAhk4NI2an6SCwT/tzBUh91nTXTHAlw9OKJYO0Pv6wjwYSs1m2xu7fXvEo/
 pgvf3WGkpktHZmJJEZzyEiHxTv5rxJlaBpOLBxaBhbpcYSE6Aqedur92EAt0O6TRjiwV
 LOZfZQoFOPTjguRZq+1PJRFN8H2WcfcsCg0ofyBH55qZSHvP+IxQ+So+J4pLFwf7WLHd
 fFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783948059; x=1784552859;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AyseptCXDRBomNO9DlDLTXfqTkFLqtyHyiP999B/pJA=;
 b=LxjvrV5nHkQLPzy1HM4oo/SRtGP0It9GaqIRWAwd1ru+JYcZznqLmsR7UcVJpTzAqZ
 qF8G5FoVAEVb/Rvmk6qKvvBBOidk0GgK5PAr2vZkLl7OflRVw0T250E0jT7LnKFbQMqu
 87mSqkqGr/EkDeVFMNPUZrRMUbyJPcdRFXvMa018KP9mdj9alNeNPYidCRsmASntkmoV
 iFrlBVp2x4CWdJqkcQSuGxYW8xF8JsnFaB7uLEpMj/Qjv9UbVUyi30JIAi0FokWb5H/4
 C3NEI/r9PerpQIUYf7lbDW/F28vLJMlWu0OlN/z9x0+vDS+42bEWvw93a87B+LtNNC1d
 MsEQ==
X-Gm-Message-State: AOJu0Yxj+kiP+LNOACDO+iyML4KLnLlli9vS7Y95Y0xgya1zKrDjwa+H
 NRYHayfIA1KVRxyXQAaNyPY34s5wHN3shjhon5IPDW6L8YqQWzLQ3MfoUCssWg==
X-Gm-Gg: AfdE7cmnBTw3pVOO4/nUqC6KsNs8Sd7y+/vFmdwABOvekgn02GxH4vSB1BZjzczrPC9
 5+ZDMqlG6sdlByXzswBskqnxFj1on0I6i96FOXYSsnDpW0O+/tYEIeflwZSHHqb5ZT/1JgteUOx
 WjJp/aGQdBgMbhKj2zB6pnQdk4T1IYTY4l+AJbl88OGkZwKoRO7ElA/eYLMU8HtE2xD+EPg4fYu
 vIR1mydcvMWprGyLix1RbkU6yXky2xZmiX6HJ45TG+y3LJg9FacCtinPrUturUtxq804SPZOXgL
 SXsN3BrTph5ETfatnlUnNHF1x10NmOx120M5imJiR/jEpe3pnENuvFnkpvY0yDYlsbd4J9U9120
 WAzdqLKN+s6c0QwRTE+eTLANDOwOrNq/ISVM/goeWC4/u2lHmn/kv8tIKextPPtT1rShufloCSz
 WXxR+pXpIxm8mOC3Cg8/PDQzuqxcnBUwYq1oLdGXBuHCEPs97vJKid4g==
X-Received: by 2002:a05:600c:608f:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-493f87d5d28mr96418555e9.7.1783948058554; 
 Mon, 13 Jul 2026 06:07:38 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df417sm387974995e9.8.2026.07.13.06.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:07:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/11] drm/amdgpu/gfx6: Add IP block soft reset implementation
Date: Mon, 13 Jul 2026 15:07:08 +0200
Message-ID: <20260713130709.34262-11-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713130709.34262-1-timur.kristof@gmail.com>
References: <20260713130709.34262-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the register definition for GRBM_SOFT_RESET
to match what was in the old radeon driver and use
these bits in the soft reset implementation.

Use basically the same implementation as GFX8,
except GFX6 doesn't have MQD/HQD.

Reset every block using the GRBM, then proceed
to reset the GRBM and SEM blocks using the SRBM.

The soft reset also calls the clock and powergating
functions of the IP block. This is necessary for
correct operation, otherwise the GPU might fall
off the PCIe bus.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 94 +++++++++++++++++++
 .../include/asic_reg/gca/gfx_6_0_sh_mask.h    | 32 +++++--
 2 files changed, 118 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 7f7b81c3919a..a033da5fc307 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3326,6 +3326,99 @@ static int gfx_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
 	return -ETIMEDOUT;
 }
 
+static int gfx_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	u32 grbm_soft_reset = 0, srbm_soft_reset = 0;
+	u32 tmp;
+	int r;
+
+	grbm_soft_reset =
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CP, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_CB, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_DB, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_GDS, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_PA, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_SC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_BCI, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_SPI, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_SX, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_TC, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_TA, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_VGT, 1) |
+		REG_SET_FIELD(0, GRBM_SOFT_RESET, SOFT_RESET_IA, 1);
+
+	srbm_soft_reset =
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_GRBM, 1) |
+		REG_SET_FIELD(0, SRBM_SOFT_RESET, SOFT_RESET_SEM, 1);
+
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_UNGATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
+	ip_block->version->funcs->suspend(ip_block);
+
+	if (grbm_soft_reset || srbm_soft_reset) {
+		tmp = RREG32(mmGMCON_DEBUG);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 1);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 1);
+		WREG32(mmGMCON_DEBUG, tmp);
+
+		udelay(100);
+	}
+
+	if (grbm_soft_reset) {
+		tmp = RREG32(mmGRBM_SOFT_RESET);
+		tmp |= grbm_soft_reset;
+		dev_info(adev->dev, "GRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmGRBM_SOFT_RESET);
+
+		udelay(100);
+
+		tmp &= ~grbm_soft_reset;
+		WREG32(mmGRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmGRBM_SOFT_RESET);
+
+		udelay(100);
+	}
+
+	if (srbm_soft_reset) {
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+		tmp |= srbm_soft_reset;
+		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		udelay(100);
+
+		tmp &= ~srbm_soft_reset;
+		WREG32(mmSRBM_SOFT_RESET, tmp);
+		tmp = RREG32(mmSRBM_SOFT_RESET);
+
+		udelay(100);
+	}
+
+	if (grbm_soft_reset || srbm_soft_reset) {
+		tmp = RREG32(mmGMCON_DEBUG);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_STALL, 0);
+		tmp = REG_SET_FIELD(tmp, GMCON_DEBUG, GFX_CLEAR, 0);
+		WREG32(mmGMCON_DEBUG, tmp);
+	}
+
+	/* Wait a little for things to settle down */
+	udelay(100);
+
+	r = ip_block->version->funcs->resume(ip_block);
+	r |= ip_block->version->funcs->late_init(ip_block);
+	if (r)
+		return r;
+
+	ip_block->version->funcs->set_clockgating_state(ip_block, AMD_CG_STATE_GATE);
+	ip_block->version->funcs->set_powergating_state(ip_block, AMD_PG_STATE_GATE);
+
+	return 0;
+}
+
 static void gfx_v6_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
 						 enum amdgpu_interrupt_state state)
 {
@@ -3584,6 +3677,7 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.resume = gfx_v6_0_resume,
 	.is_idle = gfx_v6_0_is_idle,
 	.wait_for_idle = gfx_v6_0_wait_for_idle,
+	.soft_reset = gfx_v6_0_soft_reset,
 	.set_clockgating_state = gfx_v6_0_set_clockgating_state,
 	.set_powergating_state = gfx_v6_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h
index b5e634749665..0434fc2ba710 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gca/gfx_6_0_sh_mask.h
@@ -4877,18 +4877,34 @@
 #define GRBM_SKEW_CNTL__SKEW_COUNT__SHIFT 0x00000006
 #define GRBM_SKEW_CNTL__SKEW_TOP_THRESHOLD_MASK 0x0000003fL
 #define GRBM_SKEW_CNTL__SKEW_TOP_THRESHOLD__SHIFT 0x00000000
-#define GRBM_SOFT_RESET__SOFT_RESET_CPC_MASK 0x00040000L
-#define GRBM_SOFT_RESET__SOFT_RESET_CPC__SHIFT 0x00000012
-#define GRBM_SOFT_RESET__SOFT_RESET_CPF_MASK 0x00020000L
-#define GRBM_SOFT_RESET__SOFT_RESET_CPF__SHIFT 0x00000011
-#define GRBM_SOFT_RESET__SOFT_RESET_CPG_MASK 0x00080000L
-#define GRBM_SOFT_RESET__SOFT_RESET_CPG__SHIFT 0x00000013
 #define GRBM_SOFT_RESET__SOFT_RESET_CP_MASK 0x00000001L
 #define GRBM_SOFT_RESET__SOFT_RESET_CP__SHIFT 0x00000000
-#define GRBM_SOFT_RESET__SOFT_RESET_GFX_MASK 0x00010000L
-#define GRBM_SOFT_RESET__SOFT_RESET_GFX__SHIFT 0x00000010
+#define GRBM_SOFT_RESET__SOFT_RESET_CB_MASK 0x00000002L
+#define GRBM_SOFT_RESET__SOFT_RESET_CB__SHIFT 0x00000001
 #define GRBM_SOFT_RESET__SOFT_RESET_RLC_MASK 0x00000004L
 #define GRBM_SOFT_RESET__SOFT_RESET_RLC__SHIFT 0x00000002
+#define GRBM_SOFT_RESET__SOFT_RESET_DB_MASK 0x00000008L
+#define GRBM_SOFT_RESET__SOFT_RESET_DB__SHIFT 0x00000003
+#define GRBM_SOFT_RESET__SOFT_RESET_GDS_MASK 0x00000010L
+#define GRBM_SOFT_RESET__SOFT_RESET_GDS__SHIFT 0x00000004
+#define GRBM_SOFT_RESET__SOFT_RESET_PA_MASK 0x00000020L
+#define GRBM_SOFT_RESET__SOFT_RESET_PA__SHIFT 0x00000005
+#define GRBM_SOFT_RESET__SOFT_RESET_SC_MASK 0x00000040L
+#define GRBM_SOFT_RESET__SOFT_RESET_SC__SHIFT 0x00000006
+#define GRBM_SOFT_RESET__SOFT_RESET_BCI_MASK 0x00000080L
+#define GRBM_SOFT_RESET__SOFT_RESET_BCI__SHIFT 0x00000007
+#define GRBM_SOFT_RESET__SOFT_RESET_SPI_MASK 0x00000100L
+#define GRBM_SOFT_RESET__SOFT_RESET_SPI__SHIFT 0x00000008
+#define GRBM_SOFT_RESET__SOFT_RESET_SX_MASK 0x00000400L
+#define GRBM_SOFT_RESET__SOFT_RESET_SX__SHIFT 0x0000000a
+#define GRBM_SOFT_RESET__SOFT_RESET_TC_MASK 0x00000800L
+#define GRBM_SOFT_RESET__SOFT_RESET_TC__SHIFT 0x0000000b
+#define GRBM_SOFT_RESET__SOFT_RESET_TA_MASK 0x00001000L
+#define GRBM_SOFT_RESET__SOFT_RESET_TA__SHIFT 0x0000000c
+#define GRBM_SOFT_RESET__SOFT_RESET_VGT_MASK 0x00004000L
+#define GRBM_SOFT_RESET__SOFT_RESET_VGT__SHIFT 0x0000000e
+#define GRBM_SOFT_RESET__SOFT_RESET_IA_MASK 0x00008000L
+#define GRBM_SOFT_RESET__SOFT_RESET_IA__SHIFT 0x0000000f
 #define GRBM_STATUS2__CPC_BUSY_MASK 0x20000000L
 #define GRBM_STATUS2__CPC_BUSY__SHIFT 0x0000001d
 #define GRBM_STATUS2__CPF_BUSY_MASK 0x10000000L
-- 
2.55.0

