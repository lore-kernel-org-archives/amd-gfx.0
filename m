Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E4AD6D220
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94D410E7BB;
	Thu, 18 Dec 2025 13:38:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBcBI2nC";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E79E10EE12
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 10:46:06 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so6781815ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 02:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766054766; x=1766659566; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6IWwV37obkeTNwRLtikEMk+ZnED99GBbg/P6oJvfXDY=;
 b=BBcBI2nCs5HJQ4IbV3XKZ1FkIomCgRqJk50OtrMxUdOjiCnaoIx0ZF+O8tEio2nldb
 KSsRRcusd6woZO/P3k7mJMnJVI0Tn/fDiiz7NY+J7ctt6AgMSCZy2L19WDs2Sy8t903y
 q2TLbwcnXbsl2PwJBrpUrwsnKlRUP182C1iRO3llblt7+GtUOGpx2iFypIriPt6VpqK/
 zCYyj7oU1CTGJZITqx82IZxhCB902X38P8wTTOn1K+peX8CDstyvC4SbkQMe310OHgya
 gfc4FW+Ck2UMczAGwB13zy9SAikLhSQyCof4Rk5uRLNrfASjC6Rj80/NDPgXLndMAH6z
 zRlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766054766; x=1766659566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6IWwV37obkeTNwRLtikEMk+ZnED99GBbg/P6oJvfXDY=;
 b=rgjhuZ4/aWpf0bfChExDOf21MsM6st4SeTJRRlHT0P2kFgaSTH8mFv4Y+//QDr9X6V
 6EifgPe97l++325sYVK9Cg0kWJhgRTL4WmaFqjLlVmC4J5rGScSfxjsf5EYSu4pD7iU8
 sV84Y46a8xdJ1EdrpUK1EMH4DtaUDtxIQPbabCslwLvl7HfT5eT/g1cZz0E8B0VhZEVl
 cDWAtC5S4G8W2os4+93XsmxLPnybdVVc8ZlBzfzcKt8UOSOUtRNCjT5O6cjn4CCFfuYg
 gD+MhgUNuGj4ovT5G+RIr/AqUGAb97D7tMoOe7jEHRii9Is5cr7g9V/BQiqIg0IBZ5Ji
 4A8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCdJZjFym6T5VJ2uZZxdjiDQDElR58seQFgjh6HlPBVlzbfe/aGNUTHSdgU3s5LBcXoSwPZqKA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxNrCUtNUtSF2Eh2aLAauBSe2Y3eeJZ4/4QdVTYJwNFP13jgSm0
 g1ww7hGs4u/NfG2RlX6ivpQusEUjArbx4SC2/gGcu5Et7emlfYF1VByg
X-Gm-Gg: AY/fxX4cx6JNOzBrLhmfoVY8MNGB1B2Pu+Of2GQC4moGnExfILE8R2L244v6gM9bR5P
 6P2jmoSFu4aVGFsplqum+W51lBtzAmGwA1CT+eFAP4OQ1IgrokejN4t6V4kHK2xuKGi4/ZxTn+d
 ccr2TzFU5j9WzZUDlIXu5vRqsZC4mw7yvgukp146MzV3l6eeWteNV3oKcBVC31VX4OINwDdDvof
 EXeTIQfN5Y/b7uAfz0x7Ay6VvXgvbzkQq7aWON50r2zMjNtwU2XA6R7bGynXfM+rpSIHjjyDBo2
 UkKmUcUduF3nwKYJE9KA+OuVvxeSQ1BBp6VZbvdO93y3yOhjPtH7iOYWw4EaOhZKkvUVp16s1QW
 aVhI6nRYOved4VZQnhcG7Jr/tnI9YP2EPcTa7TCoAm28BJARmEpe8YwMCYijQ+QVtcE1VXnvAHh
 XtGHlItmHJrfk9YGBRqGG5bgXFjI6GfckO
X-Google-Smtp-Source: AGHT+IGYqG4oHEa6FdY8jOkOX6Rg7hkcvaZznQh7jAqoK3JmX9MEirAXLKIqNrsxA/G8fgQU6xoWQg==
X-Received: by 2002:a05:7022:7e84:b0:11f:2c69:32 with SMTP id
 a92af1059eb24-11f34bd9069mr14658428c88.7.1766054765669; 
 Thu, 18 Dec 2025 02:46:05 -0800 (PST)
Received: from titanite-d300.amd.com ([165.204.154.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061ef3383sm7410594c88.0.2025.12.18.02.46.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 02:46:05 -0800 (PST)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org
Cc: siqueira@igalia.com, mario.limonciello@amd.com, wayne.lin@amd.com,
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH v4] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
Date: Thu, 18 Dec 2025 18:45:33 +0800
Message-ID: <20251218104533.1551352-1-suryasaimadhu369@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Dec 2025 13:38:39 +0000
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

Replace DRM_ERROR(), DRM_WARN(), and DRM_INFO() usage in
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c with the
corresponding drm_err(), drm_warn(), and drm_info() helpers.

The drm_* logging helpers take a struct drm_device * as their first
argument, allowing the DRM core to prefix log messages with the
specific device name and instance. This is required to correctly
differentiate log messages when multiple AMD GPUs are present.

This aligns amdgpu_dm with the DRM TODO item to convert legacy DRM
logging macros to the device-scoped drm_* helpers while keeping
debug logging unchanged.

v2:
- Keep validation helpers DRM-agnostic
- Move drm_* logging to AMDGPU DM callers
- Use adev_to_drm() for drm_* logging

v3:
- Pass struct amdgpu_device to helpers instead of struct drm_device
- Compact drm_* logging statements

v4:
- Drop newly added parameter validation logs

Signed-off-by: suryasaimadhu <suryasaimadhu369@gmail.com>

diff --git a/Makefile b/Makefile
index 2f545ec1690f..e404e4767944 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
-PATCHLEVEL = 18
+PATCHLEVEL = 19
 SUBLEVEL = 0
-EXTRAVERSION =
+EXTRAVERSION = -rc1
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 0a2a3f233a0e..07d1d3b9d49a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -242,35 +242,29 @@ validate_irq_registration_params(struct dc_interrupt_params *int_params,
 				 void (*ih)(void *))
 {
 	if (NULL == int_params || NULL == ih) {
-		DRM_ERROR("DM_IRQ: invalid input!\n");
 		return false;
 	}
 
 	if (int_params->int_context >= INTERRUPT_CONTEXT_NUMBER) {
-		DRM_ERROR("DM_IRQ: invalid context: %d!\n",
-				int_params->int_context);
 		return false;
 	}
 
 	if (!DAL_VALID_IRQ_SRC_NUM(int_params->irq_source)) {
-		DRM_ERROR("DM_IRQ: invalid irq_source: %d!\n",
-				int_params->irq_source);
 		return false;
 	}
 
 	return true;
 }
 
-static bool validate_irq_unregistration_params(enum dc_irq_source irq_source,
-					       irq_handler_idx handler_idx)
+static bool validate_irq_unregistration_params(
+	enum dc_irq_source irq_source,
+	irq_handler_idx handler_idx)
 {
 	if (handler_idx == DAL_INVALID_IRQ_HANDLER_IDX) {
-		DRM_ERROR("DM_IRQ: invalid handler_idx==NULL!\n");
 		return false;
 	}
 
 	if (!DAL_VALID_IRQ_SRC_NUM(irq_source)) {
-		DRM_ERROR("DM_IRQ: invalid irq_source:%d!\n", irq_source);
 		return false;
 	}
 
@@ -315,7 +309,7 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 
 	handler_data = kzalloc(sizeof(*handler_data), GFP_KERNEL);
 	if (!handler_data) {
-		DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
+		drm_err(adev_to_drm(adev), "DM_IRQ: failed to allocate irq handler!\n");
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 	}
 
@@ -396,8 +390,8 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 		/* If we got here, it means we searched all irq contexts
 		 * for this irq source, but the handler was not found.
 		 */
-		DRM_ERROR(
-		"DM_IRQ: failed to find irq handler:%p for irq_source:%d!\n",
+		drm_err(adev_to_drm(adev),
+			"DM_IRQ: failed to find irq handler:%p for irq_source:%d\n",
 			ih, irq_source);
 	}
 }
@@ -596,7 +590,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		/*allocate a new amdgpu_dm_irq_handler_data*/
 		handler_data_add = kzalloc(sizeof(*handler_data), GFP_ATOMIC);
 		if (!handler_data_add) {
-			DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
+			drm_err(adev_to_drm(adev), "DM_IRQ: failed to allocate irq handler!\n");
 			return;
 		}
 
@@ -611,11 +605,11 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		INIT_WORK(&handler_data_add->work, dm_irq_work_func);
 
 		if (queue_work(system_highpri_wq, &handler_data_add->work))
-			DRM_DEBUG("Queued work for handling interrupt from "
+			drm_dbg(adev_to_drm(adev), "Queued work for handling interrupt from "
 				  "display for IRQ source %d\n",
 				  irq_source);
 		else
-			DRM_ERROR("Failed to queue work for handling interrupt "
+			drm_err(adev_to_drm(adev), "Failed to queue work for handling interrupt "
 				  "from display for IRQ source %d\n",
 				  irq_source);
 	}
@@ -720,10 +714,9 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	struct amdgpu_crtc *acrtc = adev->mode_info.crtcs[crtc_id];
 
 	if (!acrtc) {
-		DRM_ERROR(
+		drm_err(adev_to_drm(adev),
 			"%s: crtc is NULL at id :%d\n",
-			func,
-			crtc_id);
+			func, crtc_id);
 		return 0;
 	}
 
-- 
2.43.0

