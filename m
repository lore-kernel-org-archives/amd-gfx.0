Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0385C4727E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470D923A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDwgm7en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470D923A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08146ED83;
	Fri, 25 Sep 2020 20:12:09 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1253F6ED83
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:12:09 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id c2so4088393qkf.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sE10f2M45jSbpJtP8uxkOEI2K+J3D1kPP5KOGn1r+/k=;
 b=YDwgm7enKAYY0x8dKGOfifl4UGOIfmT3vLEGflN45vKZJMxooQs4RbEI8+MVVcK+c+
 ouaovlyRBQOVG3EHEBIXy/Pd2FrOboxaJKvZK2rFjxX/Mj0nDWRmZWPDlpDAYuTWs9wP
 pOftW4EZ+SATTonZgqrtc7NX46fX5WGmmp0DTg6E/vFYozC4Bs2Q3Ve2u3TVZKJrMJ50
 XtgwWmGQT/FcpoFn2UACRDSVXz/5SXpDlplpDvzfskUCt86XfO4MKCadBZdN7Nwm2yU/
 QECIQoE5cf9GgQnKx16HxtEpCuJLQtpOZG46sSLMcY91DJYBmnCBfJR1nUu3tuin9KB2
 Xg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sE10f2M45jSbpJtP8uxkOEI2K+J3D1kPP5KOGn1r+/k=;
 b=ulicuczV9YJUVR94OcG3QZKGtdPwWUsryLU3kgZlstTNF1GPAjy2DmADYuhw2c9iQf
 zJnv531eu8Huwbt9orcU/GRPMS8cJudrb+C2C3LK0T1+bUInYoaX9lMbO2nGdVSAryFd
 Vm/NpkMT/UQjbG7DaA47Er07Ic3qFQxQo3KmC7x4VCSGptSUXfTXDsOryGRDeuyeNHLf
 oGDzdT6QBx3I7iWDw81FHGLamvo7eUSaIi2C8hoYwbqc6xwJQIm7BJK8guvp6vXpsyp+
 gfoNk41cOmL0SmUON3FoqsKqx207oRzgq83y10dn8Lz5f+FEcPuY2FsQ9XUzRYDaP1B0
 ljyA==
X-Gm-Message-State: AOAM530XsRZTDVXzafw1f+W8HqbhHDshtu0PKr83CFjCEEw15yqD3qrF
 qrQ0QaTuZuRSBMgbHw5eRuNPQj92V4w=
X-Google-Smtp-Source: ABdhPJzH8tRqrgZwbeOoiM9uDTQVT5nCMwRq1+sVvUW40Ytvr2rS0daxHX7COTVlNJClKIv3dMQxJw==
X-Received: by 2002:a37:7242:: with SMTP id n63mr1639499qkc.470.1601064719848; 
 Fri, 25 Sep 2020 13:11:59 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 44/45] drm/amd/display: Add dcn3.01 support to DM
Date: Fri, 25 Sep 2020 16:10:28 -0400
Message-Id: <20200925201029.1738724-44-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

Update dm for vangogh support.

Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e8177656e083..3cf4e08931bb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -100,6 +100,10 @@ MODULE_FIRMWARE(FIRMWARE_SIENNA_CICHLID_DMUB);
 #define FIRMWARE_NAVY_FLOUNDER_DMUB "amdgpu/navy_flounder_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_NAVY_FLOUNDER_DMUB);
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+#define FIRMWARE_VANGOGH_DMUB "amdgpu/vangogh_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_VANGOGH_DMUB);
+#endif
 
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 MODULE_FIRMWARE(FIRMWARE_RAVEN_DMCU);
@@ -1135,6 +1139,9 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+#endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+	case CHIP_VANGOGH:
 #endif
 		return 0;
 	case CHIP_NAVI12:
@@ -1242,6 +1249,12 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		fw_name_dmub = FIRMWARE_NAVY_FLOUNDER_DMUB;
 		break;
 #endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+	case CHIP_VANGOGH:
+		dmub_asic = DMUB_ASIC_DCN301;
+		fw_name_dmub = FIRMWARE_VANGOGH_DMUB;
+		break;
+#endif
 
 	default:
 		/* ASIC doesn't support DMUB. */
@@ -3362,6 +3375,9 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+#endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+	case CHIP_VANGOGH:
 #endif
 		if (dcn10_register_irq_handlers(dm->adev)) {
 			DRM_ERROR("DM: Failed to initialize IRQ\n");
@@ -3609,6 +3625,13 @@ static int dm_early_init(void *handle)
 		adev->mode_info.num_hpd = 6;
 		adev->mode_info.num_dig = 6;
 		break;
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+	case CHIP_VANGOGH:
+		adev->mode_info.num_crtc = 4;
+		adev->mode_info.num_hpd = 4;
+		adev->mode_info.num_dig = 4;
+		break;
+#endif
 	case CHIP_NAVI14:
 		adev->mode_info.num_crtc = 5;
 		adev->mode_info.num_hpd = 5;
@@ -3928,6 +3951,9 @@ fill_plane_buffer_attributes(struct amdgpu_device *adev,
 #if defined(CONFIG_DRM_AMD_DC_DCN3_0)
 		adev->asic_type == CHIP_SIENNA_CICHLID ||
 		adev->asic_type == CHIP_NAVY_FLOUNDER ||
+#endif
+#if defined(CONFIG_DRM_AMD_DC_DCN3_01)
+		adev->asic_type == CHIP_VANGOGH ||
 #endif
 	    adev->asic_type == CHIP_RENOIR ||
 	    adev->asic_type == CHIP_RAVEN) {
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
