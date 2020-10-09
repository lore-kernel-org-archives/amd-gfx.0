Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA11C433E7
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 22:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9365222C3
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 22:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7XXOgvo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9365222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A761E6EE44;
	Fri,  9 Oct 2020 22:49:00 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498756EE44
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 22:48:59 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id c23so9304442qtp.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Oct 2020 15:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o4hOKG7rui7F9XbIbJp0tc6eoSUVARe39VfXwYe4P0E=;
 b=W7XXOgvo9Nk5MBlDEvbWrIQx18DFAr3SMsewnhvXFbbPWVNEIb1lzM0Vkca51Yff6B
 +r21VZ3RVRRp/k0EUyl20IoQJHxRfHX7KYJkUOPHJuseRcJ8h1J753xnvehaK4uNUDTb
 U3gogvZA2CD29ivYm7fthqA5u7QUmk2Mi+6Wj0AMKibH5GG5iwsm2UsGMVZMT10Y6qir
 Mx3jvYT+G5cOSGHkodhdQKYVRjnKNZclO219Y0QYw+smJB1OoT0prdXISjDaXuyPs5mV
 hcZ9ChW6mZ6rSvkxp9agPcHjGPBofREfnxd45pUiomXAs3s6olsfxrN8EsbmMOtr3MoP
 1zKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=o4hOKG7rui7F9XbIbJp0tc6eoSUVARe39VfXwYe4P0E=;
 b=GTKpnv5zJ1u+2TdMKijyMXJh7wW2Z1s2KP79J7Pa5Yia1J3U1knpWaMh0/ffdGFTZF
 URjQDaWPF1OsqnUmWg/UI0p8o4PGuoWIB/+3X6tsmZ7/bOsw2CZpSuYqpfcxdbUYY03Y
 avzH5wYILRUULnYRRLq3csyf0iXTe7hAwId7r4PaVcsotY6W5RauIH3BUbK3dsFNJPJc
 D+Ior1V3vNLudLPc/gCmP2TnutG5jU+apgsmDeBWikKzwd/btKcotdE5Z+bJUyQzXdEe
 p8pFZ9xasRE/KTW7sUYSAwmj8sbrVZl6PsKGtRQtsfSqvPnMLsJo6ISWRnbZtUU2ZLyk
 8qCw==
X-Gm-Message-State: AOAM530ON5hYdt/I5Amw5T8K1rm0vmpfuERCy0vjqIy/0BoVuuY+5FC8
 vEqzDvUhrp1IC6lsgrKDYaUmqqathKc=
X-Google-Smtp-Source: ABdhPJzZz7Yyzyr9TIT5M3abFxlLfmoh3WBpkPzj6mUK5it6YJNLJt8WkA8OfZtW63qsAzOKZsvvZA==
X-Received: by 2002:aed:2983:: with SMTP id o3mr245204qtd.285.1602283737151;
 Fri, 09 Oct 2020 15:48:57 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id t3sm7185482qtq.24.2020.10.09.15.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 15:48:56 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amd/display: Add green_sardine support to DC
Date: Fri,  9 Oct 2020 18:48:46 -0400
Message-Id: <20201009224847.238484-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 Roman Li <Roman.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Roman Li <Roman.Li@amd.com>

Display Core support for green_sardine

Signed-off-by: Roman Li <Roman.Li@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/Kconfig               | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  | 7 +++++++
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 4 ++++
 drivers/gpu/drm/amd/display/include/dal_asic_id.h | 6 ++++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
index 6ff878c8e454..5906778627f0 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -17,6 +17,14 @@ config DRM_AMD_DC_DCN
 	help
 	  Raven, Navi and Renoir family support for display engine
 
+config DRM_AMD_DC_GREEN_SARDINE
+	bool "Green Sardine support"
+	default y
+	depends on DRM_AMD_DC_DCN
+        help
+            Choose this option if you want to have
+            Green Sardine support for display engine
+
 config DRM_AMD_DC_DCN3_0
         bool "DCN 3.0 family"
         depends on DRM_AMD_DC && X86
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 0b0b840a006c..b361dc6c3489 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -169,6 +169,13 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
 			break;
 		}
+
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+		if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev)) {
+			rn_clk_mgr_construct(ctx, clk_mgr, pp_smu, dccg);
+			break;
+		}
+#endif
 		if (ASICREV_IS_RAVEN2(asic_id.hw_internal_rev)) {
 			rv2_clk_mgr_construct(ctx, clk_mgr, pp_smu);
 			break;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 78e0a5e20aba..ab105f26b511 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -126,6 +126,10 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 			dc_version = DCN_VERSION_1_01;
 		if (ASICREV_IS_RENOIR(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_2_1;
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+		if (ASICREV_IS_GREEN_SARDINE(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_2_1;
+#endif
 		break;
 #endif
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_asic_id.h b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
index e4f24dbb2572..b4c3838322af 100644
--- a/drivers/gpu/drm/amd/display/include/dal_asic_id.h
+++ b/drivers/gpu/drm/amd/display/include/dal_asic_id.h
@@ -209,6 +209,12 @@ enum {
 #if defined(CONFIG_DRM_AMD_DC_DCN3_02)
 #define ASICREV_IS_DIMGREY_CAVEFISH_P(eChipRev)        ((eChipRev >= NV_DIMGREY_CAVEFISH_P_A0) && (eChipRev < NV_UNKNOWN))
 #endif
+#if defined(CONFIG_DRM_AMD_DC_GREEN_SARDINE)
+#define GREEN_SARDINE_A0 0xA1
+#ifndef ASICREV_IS_GREEN_SARDINE
+#define ASICREV_IS_GREEN_SARDINE(eChipRev) ((eChipRev >= GREEN_SARDINE_A0) && (eChipRev < 0xFF))
+#endif
+#endif
 #if defined(CONFIG_DRM_AMD_DC_DCN3_01)
 #define FAMILY_VGH 144
 #define DEVICE_ID_VGH_163F 0x163F
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
