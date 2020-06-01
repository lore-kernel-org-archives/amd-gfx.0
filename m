Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C4CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FFD2074B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uA+QkShE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FFD2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BAEF6E9DE;
	Mon,  1 Jun 2020 18:30:11 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEFE76E9D9
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:30:08 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id g28so9305647qkl.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3EElRmSzWL77UfsMh/KaQYWTn1St+fSYAgC4o523hp8=;
 b=uA+QkShE3iQz7S/Yan3BEAeLHSupnG9Zaw7WWmwVNjkROaP1nQjBsrHn30V5F/RnvB
 KqOb41Qh9PV5YW5qsSwh7JUqr/K3AUCdBW5gEuJLwG9SNcQToHWPFRY4+DPJBX00q8Nv
 DtQEefyR9xGuglhnRzzLz9HWC45xyMrBpYbU2uzSmaigAEA2cnHTUI3wtg5cSaHftXuj
 irD8nlwtHrWlYx1K/4NqpLdckGgxmup1cGUg/Iqv8Ae52DLFQVRCHGrS15ioStRxipKC
 yUMtFeEllEN5Pj97gO+hlGHZfEl8PJGZ63BY9z28lANExMhQTI0jO29RqAE5qZoPmPA5
 ZjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3EElRmSzWL77UfsMh/KaQYWTn1St+fSYAgC4o523hp8=;
 b=U7uXEPKOd9ks45kuPmEeX5/NjoEfpg+q4IIaNLJqqEH0zV0no6bsR8SSEz760AzFRX
 gl+3Qc9Uptel13yRVpEOE7R4tQiH3G8hAodKMR2ylerU9I5HsdWRKTQcReJo5EpmI/ZD
 jiWarx+Hqa3+ORJnlkC3pQA9lk/zH4vqQMfefBn7Y3itiR3c8ymTCyWfOYzLbq6Rh+ZY
 thec3ImcP63xI9L8MmFO3aJUPNqYWrQLm4RyCvK+js5X6WsIh0OPm6KSR7LQgvzbiaNc
 0X1r39eV5GJz99e+2SF+Ts+7hLHT3FRiE5rHHvMMBKybR56DUXzcBJsjUaUXy1coC/Q7
 vfqQ==
X-Gm-Message-State: AOAM5307/B6atRZOCvma4irRHCE7bJv8U5VJbAyp8oYKGpkmnV6Kn40E
 QBneX0O4gR5/iIEMjJQiQuUGkoc2
X-Google-Smtp-Source: ABdhPJzqrrlEw+/iPpto/mi4PX3yUdW+jgpAgrrHb4KKOUIAe6SI+ihOcb0UmQ3jsTZMQiri+09T+Q==
X-Received: by 2002:a05:620a:950:: with SMTP id
 w16mr21561982qkw.42.1591036207747; 
 Mon, 01 Jun 2020 11:30:07 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id z194sm8592qkb.73.2020.06.01.11.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:30:07 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 196/207] drm/amd/display: Add DCN3 Support in DM (v2)
Date: Mon,  1 Jun 2020 14:29:15 -0400
Message-Id: <20200601182926.1267958-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182926.1267958-1-alexander.deucher@amd.com>
References: <20200601182926.1267958-1-alexander.deucher@amd.com>
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Handle DCN3 in amdgpu_dm

v2: fix num_pkrs handling

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 20 ++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  9 +++++++
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   | 23 ++++++++++++++++
 5 files changed, 80 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index acd4874e0743..f348693217d8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -94,6 +94,10 @@
 
 #define FIRMWARE_RENOIR_DMUB "amdgpu/renoir_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_RENOIR_DMUB);
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+#define FIRMWARE_SIENNA_CICHLID_DMUB "amdgpu/sienna_cichlid_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
+#endif
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1070,6 +1074,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_RENOIR:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case CHIP_SIENNA_CICHLID:
+#endif
 		return 0;
 	case CHIP_NAVI12:
 		fw_name_dmcu = FIRMWARE_NAVI12_DMCU;
@@ -1166,6 +1173,12 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		dmub_asic = DMUB_ASIC_DCN21;
 		fw_name_dmub = FIRMWARE_RENOIR_DMUB;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case CHIP_SIENNA_CICHLID:
+		dmub_asic = DMUB_ASIC_DCN30;
+		fw_name_dmub = FIRMWARE_SIENNA_CICHLID_DMUB;
+		break;
+#endif
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -3205,6 +3218,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_NAVI10:
 	case CHIP_NAVI14:
 	case CHIP_RENOIR:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case CHIP_SIENNA_CICHLID:
+#endif
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -3432,6 +3448,9 @@ static int dm_early_init(void *handle)
 #endif
 	case CHIP_NAVI10:
 	case CHIP_NAVI12:
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+	case CHIP_SIENNA_CICHLID:
+#endif
 		adev->mode_info.num_crtc = 6;
 		adev->mode_info.num_hpd = 6;
 		adev->mode_info.num_dig = 6;
@@ -3752,6 +3771,9 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 	    adev->asic_type == CHIP_NAVI10 ||
 	    adev->asic_type == CHIP_NAVI14 ||
 	    adev->asic_type == CHIP_NAVI12 ||
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+		adev->asic_type == CHIP_SIENNA_CICHLID ||
+#endif
 	    adev->asic_type == CHIP_RENOIR ||
 	    adev->asic_type == CHIP_RAVEN) {
 		/* Fill GFX9 params */
@@ -3771,6 +3793,11 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			AMDGPU_TILING_GET(tiling_flags, SWIZZLE_MODE);
 		tiling_info->gfx9.shaderEnable = 1;
 
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+			tiling_info->gfx9.num_pkrs = adev->gfx.config.gb_addr_config_fields.num_pkrs;
+
+#endif
 		ret = fill_plane_dcc_attributes(adev, afb, format, rotation,
 						plane_size, tiling_info,
 						tiling_flags, dcc, address,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b086d5c906e0..d839eb14e3f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -627,3 +627,23 @@ void dm_set_dcn_clocks(struct dc_context *ctx, struct dc_clocks *clks)
 {
 	/* TODO: something */
 }
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+
+void *dm_helpers_allocate_gpu_mem(
+		struct dc_context *ctx,
+		enum dc_gpu_mem_alloc_type type,
+		size_t size,
+		long long *addr)
+{
+	// TODO
+	return NULL;
+}
+
+void dm_helpers_free_gpu_mem(
+		struct dc_context *ctx,
+		enum dc_gpu_mem_alloc_type type,
+		void *pvMem)
+{
+	// TODO
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 95175471e48d..b7a8c71e3e39 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -390,6 +390,7 @@ union dc_tiling_info {
 		bool meta_linear;
 		bool rb_aligned;
 		bool pipe_aligned;
+		unsigned int num_pkrs;
 	} gfx9;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index c726fb0695da..d7b9d311d9e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -887,6 +887,15 @@ struct dsc_dec_dpcd_caps {
 	uint32_t branch_max_line_width;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_DCN3_0)
+enum dc_gpu_mem_alloc_type {
+	DC_MEM_ALLOC_TYPE_GART,
+	DC_MEM_ALLOC_TYPE_FRAME_BUFFER,
+	DC_MEM_ALLOC_TYPE_INVISIBLE_FRAME_BUFFER,
+	DC_MEM_ALLOC_TYPE_AGP
+};
+
+#endif
 enum dc_psr_version {
 	DC_PSR_VERSION_1			= 0,
 	DC_PSR_VERSION_UNSUPPORTED		= 0xFFFFFFFF,
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 8bde1d688f2e..b2cc2bf95712 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -35,6 +35,29 @@
 
 struct dp_mst_stream_allocation_table;
 
+#ifdef CONFIG_DRM_AMD_DC_DCN3_0
+/*
+ * Allocate memory accessible by the GPU
+ *
+ * frame buffer allocations must be aligned to a 4096-byte boundary
+ *
+ * Returns virtual address, sets addr to physical address
+ */
+void *dm_helpers_allocate_gpu_mem(
+		struct dc_context *ctx,
+		enum dc_gpu_mem_alloc_type type,
+		size_t size,
+		long long *addr);
+
+/*
+ * Free the GPU-accessible memory at the virtual address pvMem
+ */
+void dm_helpers_free_gpu_mem(
+		struct dc_context *ctx,
+		enum dc_gpu_mem_alloc_type type,
+		void *pvMem);
+
+#endif
 enum dc_edid_status dm_helpers_parse_edid_caps(
 	struct dc_context *ctx,
 	const struct dc_edid *edid,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
