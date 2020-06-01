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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A890C433E2
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543DB214D8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2JZV0yE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543DB214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120C26E191;
	Mon,  1 Jun 2020 18:03:24 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D2B989B98
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:22 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id w1so9952770qkw.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=12GKJ/dhuvR5nMdgJ7LaJuoUYfQLEDsmgGhfOf5mkSg=;
 b=P2JZV0yEOCDQJ7CkFh9PLrljBXuUofvu5Jmmj0aGlq34QseYkv2jyqJhO35YY5S9ss
 3ZOUs0eO2AhT6phthG7EmgHi3kuCqdcHOCMlHO17Vy6Z2I3qvPeD16yDyBK8Jjy0AWlO
 21ZxmTh92QzmR2tMx6QPObHolrPugLaHmj3Z2/HOjTcaLGvYVcPbzWGZy3YPq8kj4Fr8
 Vgd3Pn48Zrzp+IEuKiixtxbxtojLwaPlJeZ4hI8yC9ZnuQslD5iHWTLicVXwPIqMzmZF
 bdvZ+dNL1MsWCw2wbx21a05GVuJIBbJD3wIlpUQd7NbvH2mKaLtJmEedbTJydAu6BRSG
 +OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=12GKJ/dhuvR5nMdgJ7LaJuoUYfQLEDsmgGhfOf5mkSg=;
 b=d+dBeStow2fbD3h68RhDH6mjox5jH0jpeUmgFCw6kbaypoNPENHtCW21HELbU+oEzr
 0C6nnIbKJSPdnCeF5bNd1zBszLSo4DX4KGgZ1JEatmgxAwYQkjkYmSztIrExSzyuvIXT
 ZNQ3Ayv+tIlRZ86iLZOy2rUqLYk59R49PnDgKf8Yvx4MBjkgbxeny/RklasnM2OQ1GGv
 Ar1b+8BITlrW9wsUL+R+A5B5mOUyISL4UoS2/O8XjYzoEAI6spwbuu87PGaWyNldet3n
 O9IN1cbzQLLcRDehjJskt5e7TE3tqJiaQDHyhFhAMY4bIWwQjESf1aNpxYX8jnWBhkg5
 fdrQ==
X-Gm-Message-State: AOAM531ElApvl8BhGwEUVW0qqro3LbnIIqU3Db52lOByb40oO7sKZ26U
 ZF2xIzx3OI4NQurgSbLi+kmcR4j3
X-Google-Smtp-Source: ABdhPJwAJdaAWUyVo742vARTDbs5jqQEH02kcGCKG/z70P8Trl+llMCbqeUL5usBabi+6Y98jIr+8g==
X-Received: by 2002:ae9:e703:: with SMTP id m3mr21172117qka.114.1591034600990; 
 Mon, 01 Jun 2020 11:03:20 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:20 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 023/207] drm/amdgpu/gfx10: change register configure for
 sienna_cichlid
Date: Mon,  1 Jun 2020 13:59:35 -0400
Message-Id: <20200601180239.1267430-20-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Update sienna_cichlid register configuration for sienna_cichlid
to match the update of header files.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 369 +++++++++++++++++++------
 1 file changed, 278 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index feedbde0565d..5cbee23d2ff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -66,6 +66,33 @@
 #define GB_ADDR_CONFIG__NUM_PKRS__SHIFT                                                                       0x8
 #define GB_ADDR_CONFIG__NUM_PKRS_MASK                                                                         0x00000700L
 
+#define mmCP_MEC_CNTL_Sienna_Cichlid                      0x0f55
+#define mmCP_MEC_CNTL_Sienna_Cichlid_BASE_IDX             0
+#define mmRLC_SAFE_MODE_Sienna_Cichlid			0x4ca0
+#define mmRLC_SAFE_MODE_Sienna_Cichlid_BASE_IDX		1
+#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid		0x4ca1
+#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid_BASE_IDX	1
+#define mmSPI_CONFIG_CNTL_Sienna_Cichlid			0x11ec
+#define mmSPI_CONFIG_CNTL_Sienna_Cichlid_BASE_IDX		0
+#define mmVGT_ESGS_RING_SIZE_Sienna_Cichlid		0x0fc1
+#define mmVGT_ESGS_RING_SIZE_Sienna_Cichlid_BASE_IDX	0
+#define mmVGT_GSVS_RING_SIZE_Sienna_Cichlid		0x0fc2
+#define mmVGT_GSVS_RING_SIZE_Sienna_Cichlid_BASE_IDX	0
+#define mmVGT_TF_RING_SIZE_Sienna_Cichlid			0x0fc3
+#define mmVGT_TF_RING_SIZE_Sienna_Cichlid_BASE_IDX	0
+#define mmVGT_HS_OFFCHIP_PARAM_Sienna_Cichlid		0x0fc4
+#define mmVGT_HS_OFFCHIP_PARAM_Sienna_Cichlid_BASE_IDX	0
+#define mmVGT_TF_MEMORY_BASE_Sienna_Cichlid		0x0fc5
+#define mmVGT_TF_MEMORY_BASE_Sienna_Cichlid_BASE_IDX	0
+#define mmVGT_TF_MEMORY_BASE_HI_Sienna_Cichlid		0x0fc6
+#define mmVGT_TF_MEMORY_BASE_HI_Sienna_Cichlid_BASE_IDX	0
+#define GRBM_STATUS2__RLC_BUSY_Sienna_Cichlid__SHIFT	0x1a
+#define GRBM_STATUS2__RLC_BUSY_Sienna_Cichlid_MASK	0x04000000L
+#define CP_RB_DOORBELL_RANGE_LOWER__DOORBELL_RANGE_LOWER_Sienna_Cichlid_MASK	0x00000FFCL
+#define CP_RB_DOORBELL_RANGE_LOWER__DOORBELL_RANGE_LOWER_Sienna_Cichlid__SHIFT	0x2
+#define CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_Sienna_Cichlid_MASK	0x00000FFCL
+#define PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_Sienna_Cichlid_MASK	0x00300000L
+
 MODULE_FIRMWARE("amdgpu/navi10_ce.bin");
 MODULE_FIRMWARE("amdgpu/navi10_pfp.bin");
 MODULE_FIRMWARE("amdgpu/navi10_me.bin");
@@ -4396,9 +4423,18 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 	pa_sc_tile_steering_override |=
 		(order_base_2(num_rb_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_RB_PER_SC__SHIFT) &
 		PA_SC_TILE_STEERING_OVERRIDE__NUM_RB_PER_SC_MASK;
-	pa_sc_tile_steering_override |=
-		(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
-		PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_MASK;
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		pa_sc_tile_steering_override |=
+			(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
+			PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_Sienna_Cichlid_MASK;
+		break;
+	default:
+		pa_sc_tile_steering_override |=
+			(order_base_2(num_packer_per_sc) << PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC__SHIFT) &
+			PA_SC_TILE_STEERING_OVERRIDE__NUM_PACKER_PER_SC_MASK;
+		break;
+	}
 
 	return pa_sc_tile_steering_override;
 }
@@ -5578,12 +5614,24 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 				    DOORBELL_EN, 0);
 	}
 	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
-	tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
-			    DOORBELL_RANGE_LOWER, ring->doorbell_index);
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
+				    DOORBELL_RANGE_LOWER_Sienna_Cichlid, ring->doorbell_index);
+		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
+
+		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
+			     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_Sienna_Cichlid_MASK);
+		break;
+	default:
+		tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
+				    DOORBELL_RANGE_LOWER, ring->doorbell_index);
+		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_LOWER, tmp);
 
-	WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
-		     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
+		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_RANGE_UPPER,
+			     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
+		break;
+	}
 }
 
 static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
@@ -5698,11 +5746,27 @@ static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
 static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 {
 	if (enable) {
-		WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid, 0);
+			break;
+		default:
+			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL, 0);
+			break;
+		}
 	} else {
-		WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
-			     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
-			      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
+		switch (adev->asic_type) {
+		case CHIP_SIENNA_CICHLID:
+			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL_Sienna_Cichlid,
+				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
+				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
+			break;
+		default:
+			WREG32_SOC15(GC, 0, mmCP_MEC_CNTL,
+				     (CP_MEC_CNTL__MEC_ME1_HALT_MASK |
+				      CP_MEC_CNTL__MEC_ME2_HALT_MASK));
+			break;
+		}
 		adev->gfx.kiq.ring.sched.ready = false;
 	}
 	udelay(50);
@@ -5784,12 +5848,24 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	/* tell RLC which is KIQ queue */
-	tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
-	tmp &= 0xffffff00;
-	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
-	WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
-	tmp |= 0x80;
-	WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
+		tmp &= 0xffffff00;
+		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		tmp |= 0x80;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		break;
+	default:
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp &= 0xffffff00;
+		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		tmp |= 0x80;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		break;
+	}
 }
 
 static int gfx_v10_0_gfx_mqd_init(struct amdgpu_ring *ring)
@@ -6475,18 +6551,33 @@ static bool gfx_v10_0_check_grbm_cam_remapping(struct amdgpu_device *adev)
 
 	/* check if mmVGT_ESGS_RING_SIZE_UMD
 	 * has been remapped to mmVGT_ESGS_RING_SIZE */
-	data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
-
-	WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid);
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, 0);
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
 
-	WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
+		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) == pattern) {
+			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD , data);
+			return true;
+		} else {
+			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid, data);
+			return false;
+		}
+		break;
+	default:
+		data = RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE);
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, 0);
+		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, pattern);
 
-	if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
-		return true;
-	} else {
-		WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
-		return false;
+		if (RREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE) == pattern) {
+			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE_UMD, data);
+			return true;
+		} else {
+			WREG32_SOC15(GC, 0, mmVGT_ESGS_RING_SIZE, data);
+			return false;
+		}
+		break;
 	}
 }
 
@@ -6498,59 +6589,119 @@ static void gfx_v10_0_setup_grbm_cam_remapping(struct amdgpu_device *adev)
 	 * index will auto-inc after each data writting */
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_INDEX, 0);
 
-	/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-	/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-	/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-	/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-	/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
-
-	/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
-	data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
-	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
+		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_Sienna_Cichlid) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		break;
+	default:
+		/* mmVGT_TF_RING_SIZE_UMD -> mmVGT_TF_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_RING_SIZE) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_UMD -> mmVGT_TF_MEMORY_BASE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_TF_MEMORY_BASE_HI_UMD -> mmVGT_TF_MEMORY_BASE_HI */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_TF_MEMORY_BASE_HI) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_HS_OFFCHIP_PARAM_UMD -> mmVGT_HS_OFFCHIP_PARAM */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_HS_OFFCHIP_PARAM) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_ESGS_RING_SIZE_UMD -> mmVGT_ESGS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_ESGS_RING_SIZE) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmVGT_GSVS_RING_SIZE_UMD -> mmVGT_GSVS_RING_SIZE */
+		data = (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE_UMD) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmVGT_GSVS_RING_SIZE) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
+		WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
+
+		/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
+		data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
+			GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
+		       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
+			GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
+		break;
+	}
 
-	/* mmSPI_CONFIG_CNTL_REMAP -> mmSPI_CONFIG_CNTL */
-	data = (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL_REMAP) <<
-		GRBM_CAM_DATA__CAM_ADDR__SHIFT) |
-	       (SOC15_REG_OFFSET(GC, 0, mmSPI_CONFIG_CNTL) <<
-		GRBM_CAM_DATA__CAM_REMAPADDR__SHIFT);
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA_UPPER, 0);
 	WREG32_SOC15(GC, 0, mmGRBM_CAM_DATA, data);
 }
@@ -6722,10 +6873,22 @@ static int gfx_v10_0_soft_reset(void *handle)
 
 	/* GRBM_STATUS2 */
 	tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
-	if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY))
-		grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
-						GRBM_SOFT_RESET, SOFT_RESET_RLC,
-						1);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY_Sienna_Cichlid))
+			grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
+							GRBM_SOFT_RESET,
+							SOFT_RESET_RLC,
+							1);
+		break;
+	default:
+		if (REG_GET_FIELD(tmp, GRBM_STATUS2, RLC_BUSY))
+			grbm_soft_reset = REG_SET_FIELD(grbm_soft_reset,
+							GRBM_SOFT_RESET,
+							SOFT_RESET_RLC,
+							1);
+		break;
+	}
 
 	if (grbm_soft_reset) {
 		/* stop the rlc */
@@ -6848,13 +7011,30 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
 
 	data = RLC_SAFE_MODE__CMD_MASK;
 	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
-	WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
 
-	/* wait for RLC_SAFE_MODE */
-	for (i = 0; i < adev->usec_timeout; i++) {
-		if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, mmRLC_SAFE_MODE), RLC_SAFE_MODE, CMD))
-			break;
-		udelay(1);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
+
+		/* wait for RLC_SAFE_MODE */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid),
+					   RLC_SAFE_MODE, CMD))
+				break;
+			udelay(1);
+		}
+		break;
+	default:
+		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
+
+		/* wait for RLC_SAFE_MODE */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, mmRLC_SAFE_MODE),
+					   RLC_SAFE_MODE, CMD))
+				break;
+			udelay(1);
+		}
+		break;
 	}
 }
 
@@ -6863,7 +7043,14 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
 	uint32_t data;
 
 	data = RLC_SAFE_MODE__CMD_MASK;
-	WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
+		break;
+	default:
+		WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE, data);
+		break;
+	}
 }
 
 static void gfx_v10_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
