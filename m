Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2264DC55184
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F45910E6CA;
	Mon,  3 Aug 2026 13:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VC3n+Z78";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 500D510E6DA
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:23:24 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c1f7666a90bso515479166b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785763403; x=1786368203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gUaVwbwOG6cqgEzRlL3FTaC9FeO91lkiwQVZGqIPiJY=;
 b=VC3n+Z78jRLnP92gTpJu3s1mg4l4KJ7KIUAx9myDkjuUWSCDWZRofzX6HkZEnRxOBt
 Dn33fKHQ8mIcn5yx/eVnBYx/AlWFwnGLLH0/GUZuZmEFdMfSju6mgOSxgoVKSB1+BKLI
 plw+XrnnutumTyNZiyAB4amUocxd2F7aNDhwWNgTv5GyxLtYewaqu1tiMPV0a1Rm4sEP
 zwUGrQHX4r2LJ4TotDbXB1jBBseBAm73UyVymxHEudj5y6LSiriOlsfXAwU2PExwSktc
 HOjezDHBtcB4LHpWNQzjOr5EpDp6il//muMJJ8bbhKR92TIUOS77yst7W4MqYo5j30q0
 +FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763403; x=1786368203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gUaVwbwOG6cqgEzRlL3FTaC9FeO91lkiwQVZGqIPiJY=;
 b=ExgEgFmqlJVnHMO2k5uhFhVUCAIqAUUcIWyHi/D2fwVrmY37O8Ky4SdJPcC/euNR1i
 VlDYscYqPnDBSiVH4wosuk+XlbMw+Y7nektGaM7NnWZ58oAOyLZuCL5pWJotqzoeYZP7
 0IA5uBkjIYUPjFEEzkEp87+3c4snObnzYHop0VoElIMCWd/609ocKmEUkARlvu5ib7eG
 TjOHtqYbTtaR4jenMgS/uEfxiCMPY9pSVQ1wQE0/36vUCwkd48S/x2Nl7tGqekhT7vy8
 xrGYJGWDTokZjtBUS3c6FPCAA6KI4QxfJEh/eh2hs4Y3bB1679hm8TP9y0CbV9G4DNf9
 5R6g==
X-Gm-Message-State: AOJu0Yy8IgBReQLnfK8KVio5j2z8ResI/wtz71sxhs0se0JnDqoz1qtd
 aLCIPnOJSImjUmQiq8j+eQjkIKDfwOn+tJwSOOVJoI3YboM9djbP+CBexrmz23IN
X-Gm-Gg: AR+sD133dAhMyijJ00WM8yBQ/2yrTM0IBKRp0D+Ll1q2MYW4b+FttRNsW4ff74ozBYk
 aqla9Cne3UPaYxE9dSmWF+kUwStsUMqc1Kti1kuZvBRL8BJCOpHdgaMfMEqeDQGrBRyxXNaUp/X
 F6U1hw35B5pW+e/pzAbqpgAy1fPCs+RTcWJDrbuUnvXaZU17ubR03s9inXgaXDSc22v7qoPRU+u
 2jFmovdv6bLLfZ1cZSkGj+POoh9VWUUO8QYcEdtnl3RajADddvGMbYt/fEopsmUJFA3TyPFLaHo
 R34moOPvAbG6wAB0bZxbi/2u9fW38m4dOHV53QPYaEqjrAprEic+S4N/fB1Fhk2TwD2rHuFl8YX
 MAfBzFSRQw1ohNUjPJ+/62qSegN18V/+fzhyo8Oi38uVVHGtGT/p5W7mj0YQlixUgjAXT9wzKDt
 mYDOEjb1UGcFeZRpeeUg+W93miOf6xSctkusIQa/tryq8OQyPC38ambyJNjQDb32+sJwsy2bLrd
 2KI4DQkrZD98Hq06+oZB8RP9z+Qn8Q=
X-Received: by 2002:a17:907:980b:b0:c1f:1520:4de5 with SMTP id
 a640c23a62f3a-c1ff0abd162mr590979366b.1.1785763401631; 
 Mon, 03 Aug 2026 06:23:21 -0700 (PDT)
Received: from Timur-Hyperion.home (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd445432dsm549201266b.41.2026.08.03.06.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:23:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 09/10] drm/amdgpu/gfx6: Add IP block soft reset implementation
Date: Mon,  3 Aug 2026 15:23:08 +0200
Message-ID: <20260803132309.36326-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803132309.36326-1-timur.kristof@gmail.com>
References: <20260803132309.36326-1-timur.kristof@gmail.com>
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

For the soft reset, use basically the same
implementation as GFX7-8, the main difference being
the GRBM_SOFT_RESET bit fields and the fact that
GFX6 doesn't have MQD/HQD. Reset every block using
the GRBM, then proceed to reset the GRBM and SEM blocks
using the SRBM.

The soft reset also calls the clock and powergating
functions of the IP block. This is necessary for
correct operation, otherwise the GPU might fall
off the PCIe bus.

Add a gfx_v6_0_late_init() function for consistency
with other GPU generations. This function will
later serve the same purpose as it does on GFX7+
when we get around to enable more IRQs on GFX6.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         | 100 ++++++++++++++++++
 .../include/asic_reg/gca/gfx_6_0_sh_mask.h    |  32 ++++--
 2 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 2fcd2d70c0ce..6de58e85a3ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3155,6 +3155,11 @@ static int gfx_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
+{
+	return 0;
+}
+
 static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_ring *ring;
@@ -3307,6 +3312,99 @@ static int gfx_v6_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
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
@@ -3555,6 +3653,7 @@ static void gfx_v6_0_emit_mem_sync(struct amdgpu_ring *ring)
 static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 	.name = "gfx_v6_0",
 	.early_init = gfx_v6_0_early_init,
+	.late_init = gfx_v6_0_late_init,
 	.sw_init = gfx_v6_0_sw_init,
 	.sw_fini = gfx_v6_0_sw_fini,
 	.hw_init = gfx_v6_0_hw_init,
@@ -3563,6 +3662,7 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
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

