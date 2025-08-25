Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32543C8303F
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 22:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C69EB10E288;
	Mon, 25 Aug 2025 22:07:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwRh5mmM";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5BA010E288
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 22:07:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-45a1b0c82eeso42086565e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159657; x=1756764457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OpNO0YxTN4yVqNUXcE2VWRanoBomodwxodxAtr3nxPA=;
 b=RwRh5mmMgj+LvO0YwXB0cbZw5fcwxmp8Oq3TquWW5mnFf36O/JZ3G/+NU6lwKOWiUV
 3NyCQFTa2Oe3dLGqq5REIH9nlwGAQc3yN0JfLw1HwKONkhl/obdlqL/flmuIkWN2TtmM
 uSzcnJGo1BB8dRqR8uqSiKRzRRqsiIfqp9G1sKA29LkVV1dA58K1fDsjnGkMLhxWNW03
 lDG8C5X8V8XW6yZWZk3avZ2PR1h5cThCq+o917kHCoAnVXm1MMuNBEVXAvbF234O9RFX
 gOU5Dcb703FGlOusPZHglxEbx2X/HdfzNiz5bcIAFwXH7umW7AZIyo/slNbgJNxdC/S1
 tcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159657; x=1756764457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpNO0YxTN4yVqNUXcE2VWRanoBomodwxodxAtr3nxPA=;
 b=cbKhFouTreovnFPgAPdapq7/PtIjE2LYdaKK9Tvr04/syNaY4nCYtuFlfE/sPN0iU3
 DPSmkqJqjm6a7xSGJ7CRT9iMg9/djL0iGrpZREhHa8AnB+yz7GTC7xis9M/xxQiG49YA
 KUu4QuVBzmacczqt/0CsQ8B/G2bghUjPLNO+8QLp6yTS6E4facm1TE/tDzhHxJiZMT06
 /Qrpz8uG4I/jLlPj99iclZJ1p57Bdsv/y6HHYwG6m/3GMVz/TA93H+WhDdrSCf6qFcn6
 ngHmvLCgOKsjotftENBMdeE01VjF+7iwT2q9j+CYGvxWRWYDf6Zg1t6fhmlLKGHJidVa
 cCsA==
X-Gm-Message-State: AOJu0Yz6f39AulZs2GNZOpRMz4J49CwGs5Xd82DBG/Jdg/4jUG7EIGKf
 j2+ccTS92LQul3sJ4K1iwu3e2IWdYCz7sIoI3RZFkpbppDVDhhVOqMue4v7Evg==
X-Gm-Gg: ASbGncsdipMHZ//F0+/D5DIB1ct18Nf0N4JQEHWrVfIEiPVQnmYize7la7dFdjvWAxr
 u3/GACWB+5GaVe77/NDo7thXTna5NpOfaZPXZtqTjrIsL/uYB9+jSTs4U5obzS8SgN1T5GXh+y4
 z+YnoWO6WtkAh98TSy1wc/HHP0EShcrzTut5Vsj5SlLICeTG2Md0pwc1546xzkCH4Z4TLDpxST2
 B/WX1fwiK/tFKFcfRRcYYFsQEhZVbm2tpRoP5rR2HNno4RVMKRmKdxMa2VxqvQTt7TuJ+Nk1Jhv
 nMFaJXJEOTsrz4aTvGgV5pZMpj0+XFpmZd0EEs192mDjPqXRmvuYAvUENKF/Bobg/DMxzVJ6DbY
 PhRRlxObpiv5qENpIAuDU6lfwh5I1e+Aby33fldTamIAseg84VyOVRuqN7zb3qQKd2QWwAs7d6G
 nZlUEHvBgNfEfTVkdT/dVyeAmcL4+bSdb0sA8U
X-Google-Smtp-Source: AGHT+IHrpmpcxR45uLus2CU4L4rGcI4jmULKSpNOpiSxdX2o9MSaDzXL6/DZG9I7ktivia8Bfzk0GA==
X-Received: by 2002:a05:600c:45d4:b0:459:e3a1:a0c4 with SMTP id
 5b1f17b1804b1-45b517d27b2mr134356025e9.30.1756159657149; 
 Mon, 25 Aug 2025 15:07:37 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66a64023sm1296395e9.1.2025.08.25.15.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:07:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Add pixel_clock to
 amd_pp_display_configuration
Date: Tue, 26 Aug 2025 00:07:30 +0200
Message-ID: <20250825220732.636810-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825220732.636810-1-timur.kristof@gmail.com>
References: <20250825220732.636810-1-timur.kristof@gmail.com>
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

This commit adds the pixel_clock field to the display config
struct so that power management (DPM) can use it.

We currently don't have a proper bandwidth calculation on old
GPUs with DCE 6-10 because dce_calcs only supports DCE 11+.
So the power management (DPM) on these GPUs may need to make
ad-hoc decisions for display based on the pixel clock.

Also rename sym_clock to pixel_clock in dm_pp_single_disp_config
to avoid confusion with other code where the sym_clock refers to
the DisplayPort symbol clock.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c       | 1 +
 drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services_types.h             | 2 +-
 drivers/gpu/drm/amd/include/dm_pp_interface.h                  | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index e5771f490f2e..11b2ea6edf95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -98,6 +98,7 @@ bool dm_pp_apply_display_requirements(
 			const struct dm_pp_single_disp_config *dc_cfg =
 						&pp_display_cfg->disp_configs[i];
 			adev->pm.pm_display_cfg.displays[i].controller_id = dc_cfg->pipe_idx + 1;
+			adev->pm.pm_display_cfg.displays[i].pixel_clock = dc_cfg->pixel_clock;
 		}
 
 		amdgpu_dpm_display_configuration_change(adev, &adev->pm.pm_display_cfg);
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index 13cf415e38e5..d50b9440210e 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -164,7 +164,7 @@ void dce110_fill_display_configs(
 			stream->link->cur_link_settings.link_rate;
 		cfg->link_settings.link_spread =
 			stream->link->cur_link_settings.link_spread;
-		cfg->sym_clock = stream->phy_pix_clk;
+		cfg->pixel_clock = stream->phy_pix_clk;
 		/* Round v_refresh*/
 		cfg->v_refresh = stream->timing.pix_clk_100hz * 100;
 		cfg->v_refresh /= stream->timing.h_total;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index bf63da266a18..3b093b8699ab 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -127,7 +127,7 @@ struct dm_pp_single_disp_config {
 	uint32_t src_height;
 	uint32_t src_width;
 	uint32_t v_refresh;
-	uint32_t sym_clock; /* HDMI only */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 	struct dc_link_settings link_settings; /* DP only */
 };
 
diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index acd1cef61b7c..349544504c93 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -65,6 +65,7 @@ struct single_display_configuration {
 	uint32_t view_resolution_cy;
 	enum amd_pp_display_config_type displayconfigtype;
 	uint32_t vertical_refresh; /* for active display */
+	uint32_t pixel_clock; /* Pixel clock in KHz (for HDMI only: normalized) */
 };
 
 #define MAX_NUM_DISPLAY 32
-- 
2.50.1

