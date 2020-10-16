Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF79C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDA3620848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 16:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtwoN1Ka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDA3620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B7D66E153;
	Fri, 16 Oct 2020 16:50:15 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19FBD6E153
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 16:50:13 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id b69so2419704qkg.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 09:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ala7D/794Tmh9nRO2h4Ogz9MpfRJ9NiDLndpP8NqNj4=;
 b=qtwoN1Ka6Qu8QlFY/wGGTYkGoBzn9Ryh3ANNrK41rV3JQT5V6M1VYKOxcVskptpsWp
 wpwDAR00OuNn6kpcTOWyJ7jZqfuLCOwEnXglLqj0D+jUVqptOE2Mzof0dCUO3T4FdNDo
 WReG2YihbI26v4ZlhhdmeNzXxGP02Ts6YQVVyp2XNPny5HyxPBStWA9pU6fC5VQCK+rY
 tT2RiuXceqMcFIGcQMlHJia7HJR+GtLIHDfbyoHhNyTtVQh+LjtXSMXs62lrAo122WnV
 49DpxJWQ9uSVRz25T/5+7oWiUaLk6+Xj4HNzg8hrdRK4bJLydzX4d1xQ0hWHQowHvc7/
 e5dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ala7D/794Tmh9nRO2h4Ogz9MpfRJ9NiDLndpP8NqNj4=;
 b=Ytg//Fb+G+5FFfOABabWHYVl/hPFnLiWxCSQC7uIOwMQTHgUzB4vKBtq5TbumGPWfn
 YRGPklNSh23QDLD4O5wwyzaJJkS1iZK3JYaZ2yxuegLwXgSZJNh7TairedQv5qWS3tYb
 e+bT9BnisUdnXdQYaNqRYqTo9gJ/uDDxIfKwNl7o9HSFKQvPza4Ystm6+6/vBYGakW1K
 2uta2ZOlaQmAbRr2Fi3Qd3wIPY8xNy+jkhx6hShPsNvpEz5biFyw8T8e+f4ZNiNFZGC2
 T5UErNQUa6mV4V2EPCni+BfM2Cw1n43dh5v3S66qbpqiZ+XuhHnq5066p4xhpIOyFEeg
 Z/ow==
X-Gm-Message-State: AOAM533gH6J91HLsZl6mxPwp8pSs4OedGeRechlqBoCOE1iThGdZm6rM
 a5cOrj3pBQYCtOqoEDO37rB9BXiyOiA=
X-Google-Smtp-Source: ABdhPJzPeUHj/VMmdQ4oHrvBN8LimkL6bn1AuXQr+cAHLyu9hhp0+dyz6Kc6/uxpD0datvMx2XpLhg==
X-Received: by 2002:a05:620a:13c4:: with SMTP id
 g4mr4630706qkl.400.1602867011889; 
 Fri, 16 Oct 2020 09:50:11 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id q9sm1193726qta.70.2020.10.16.09.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 09:50:11 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu/display: remove DRM_AMD_DC_GREEN_SARDINE
Date: Fri, 16 Oct 2020 12:50:01 -0400
Message-Id: <20201016165004.1218352-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No need for a separate config option at this point.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig               | 8 --------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 ------
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 2 --
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 --
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 2 --
 5 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 93cdcd1ee9ff..cf87133f88e6 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -17,14 +17,6 @@ config DRM_AMD_DC_DCN
 	help
 	  Raven, Navi and Renoir family support for display engine
 
-config DRM_AMD_DC_GREEN_SARDINE
-	bool "Green Sardine support"
-	default y
-	depends on DRM_AMD_DC_DCN
-        help
-            Choose this option if you want to have
-            Green Sardine support for display engine
-
 config DRM_AMD_DC_DCN3_0
         bool "DCN 3.0 family"
         depends on DRM_AMD_DC && X86
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a90063ac08a..2aa810d3554b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -100,10 +100,8 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
 #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
 #endif
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 #define FIRMWARE_GREEN_SARDINE_DMUB "amdgpu/green_sardine_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_GREEN_SARDINE_DMUB);
-#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 #define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
@@ -985,10 +983,8 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	case CHIP_RAVEN:
 	case CHIP_RENOIR:
 		init_data.flags.gpu_vm_support = true;
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 			init_data.flags.disable_dmcu = true;
-#endif
 		break;
 	default:
 		break;
@@ -1289,10 +1285,8 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case CHIP_RENOIR:
 		dmub_asic = DMUB_ASIC_DCN21;
 		fw_name_dmub = FIRMWARE_RENOIR_DMUB;
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 		if (ASICREV_IS_GREEN_SARDINE(adev->external_rev_id))
 			fw_name_dmub = FIRMWARE_GREEN_SARDINE_DMUB;
-#endif
 		break;
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index b361dc6c3489..19d97ed6beb8 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -170,12 +170,10 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			break;
 		}
 
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 		if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			break;
 		}
-#endif
 		if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
 			rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ab105f26b511..419c0df08602 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -126,10 +126,8 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 			dc_version = DCN_VERSION_1_01;
 		if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_2_1;
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 		if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_2_1;
-#endif
 		break;
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index b4c3838322af..2bf60ac2974f 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -209,12 +209,10 @@ enum {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
 #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
 #endif
-#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
 #define GREEN_SARDINE_A0 0xA1
 #ifndef ASICREV_IS_GREEN_SARDINE
 #define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
 #endif
-#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
