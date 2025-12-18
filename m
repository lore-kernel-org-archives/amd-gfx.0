Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F05CD6D221
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 13:38:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1086E10E565;
	Thu, 18 Dec 2025 13:38:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EyLDPB9I";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E44E910E964
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 10:07:15 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2a07fac8aa1so4676565ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 02:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766052435; x=1766657235; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kpRXf+CybyafgKkHmN7F6FAf7wCDCV9P2YSBozxEg1w=;
 b=EyLDPB9IW8HiDWfFUIjmwfTqQrxP/6kR8zt8BDqDhAKkirfdt8YulfcfFkHrG2y+c+
 AI2xkZi9PVpFmeac+nBX1ZSUhilCrRbnWL+js/whqCuq4YLuwjVQLba5sfwW0FvtmNkl
 GIO9fdeZ7aPq76G1i1t0wJlr+kqNAyQtI4dleSJ5ux0GHSg9hjX4ojiu9PJEWB2BVr7g
 gJiiWR3KQStN/UCl7oaFYe6ymcu7z9dcQvQLgv85usaGlrR4x2yhu5wlRNpskBfw6CYd
 dpQzaIXbVtG3aKEYLpFmfsTUs6Q4hgDsLnQL7m5K/7zAdQX88NqBF9QVfFdzhYByk0Tw
 jdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766052435; x=1766657235;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kpRXf+CybyafgKkHmN7F6FAf7wCDCV9P2YSBozxEg1w=;
 b=OY7bYtarUHeK0K6hqH2CQKPx0UTKOlmvaLVzIKXYTsAXZcVu+Ku5f5sQ9cIkQCzLy0
 r7qAo4cv4sm16VTmiDmYwQstarX/Kd54ZdRxP6bDnPDBJQsYEJjlvc6aTHxSJOfwq6ns
 zV8jS6S0I8EU5WftJbQQJ+j3/1cy3aHTzd8bG1swFi0NWLlboszgyhg+sBk+/eleApav
 q19KfzeBzNOEEc/Lxpl9fE53506aP+GEdQLdT4YZwuObneR1MnjWiwm4kPLtxLIIdxH2
 ahYwZfCkGTKsVq0odse9oKwr9IuHgbsDCIV9mYkS8ZQbZjh2KbOoMGAGP1cbA/CaSzNi
 bngg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFvbzX0SKfYXp2hSmy4OL70EVyBrTGZDz5BYkRRoLOKWSTG7WcdrOiO/LauOFcFMPMF1M92GZB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTC7FE2hnJOABWm7kuwDfo81t9MWjrBQZSbPZgAJfW0o+Y7w3G
 8IzrzneOp7D1agWq3gMxJEXgakxAulu38o3QWN0gAS9KZbrxPBw9G8WZ
X-Gm-Gg: AY/fxX59MQSdOziCPVyq4VgxpPIPuR2fKTciqT9FsEwihkoH1FFgFq60Q+NoZhKAnKc
 +Q9BUAk4vvasIo3axGarQ24Gb7Vt0WVgiHtTLdcedLjabQe4MEHG/Hp2Cyosk/DGfNADYp5fRi/
 zQrmdL79kVx1Wh5GTyeeBXdrfdf4ltJP8ahy2HW7fTW+uBpp0H1QWYDHtmY5pcJfwili0afjK4G
 LSYAL/SpmOCmYOzHccV97PVKZmqyhhR1N0Ce7a/m8CeJEugvxZYpvMPKp5JsX6ncfo6Y75rMVfR
 nCett2de0Dbb9B8ga+i1Z18JcVdbc1qhr1pTdky4a2rswVJKCHMdidVCa+a4bwFQSldcotrEqq/
 gVswEBr0JHEbSHu4c0hdaN+yw1t5NG0/T+atAPfw7Isc/9S1Ynt9iqzoVlfCOzoA2mU34wDvm84
 tkTp8vYsfrCI0vED3DWsgEgOnVDxNlMLCjT4POF2xh0As=
X-Google-Smtp-Source: AGHT+IFz4Ugh0GME20ZYSCAsS5FdVOlyjab3uGMpWvUWX/4LmvR2z1wq9wJZY1s7sCcmSZ17Xl5o/w==
X-Received: by 2002:a05:7022:458d:b0:11c:ec20:ea1f with SMTP id
 a92af1059eb24-11f34c57b69mr16886528c88.33.1766052435108; 
 Thu, 18 Dec 2025 02:07:15 -0800 (PST)
Received: from titanite-d300.amd.com ([165.204.154.57])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12061fceec2sm5973650c88.13.2025.12.18.02.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 02:07:14 -0800 (PST)
From: suryasaimadhu <suryasaimadhu369@gmail.com>
To: harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org
Cc: siqueira@igalia.com, mario.limonciello@amd.com, wayne.lin@amd.com,
 roman.li@amd.com, timur.kristof@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, suryasaimadhu <suryasaimadhu369@gmail.com>
Subject: [PATCH] drm/amdgpu/dm: Convert IRQ logging to drm_* helpers
Date: Thu, 18 Dec 2025 18:05:07 +0800
Message-ID: <20251218100507.1529908-1-suryasaimadhu369@gmail.com>
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
index 0a2a3f233a0e..82ea217e8195 100644
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
 
@@ -311,11 +305,12 @@ void *amdgpu_dm_irq_register_interrupt(struct amdgpu_device *adev,
 	enum dc_irq_source irq_source;
 
 	if (false == validate_irq_registration_params(int_params, ih))
+		drm_err(adev_to_drm(adev), "DM_IRQ: invalid registration parameters\n");
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 
 	handler_data = kzalloc(sizeof(*handler_data), GFP_KERNEL);
 	if (!handler_data) {
-		DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
+		drm_err(adev_to_drm(adev), "DM_IRQ: failed to allocate irq handler!\n");
 		return DAL_INVALID_IRQ_HANDLER_IDX;
 	}
 
@@ -376,6 +371,7 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
 	int i;
 
 	if (false == validate_irq_unregistration_params(irq_source, ih))
+		drm_err(adev_to_drm(adev), "DM_IRQ: invalid unregistration parameters\n");
 		return;
 
 	memset(&int_params, 0, sizeof(int_params));
@@ -396,8 +392,8 @@ void amdgpu_dm_irq_unregister_interrupt(struct amdgpu_device *adev,
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
@@ -596,7 +592,7 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
 		/*allocate a new amdgpu_dm_irq_handler_data*/
 		handler_data_add = kzalloc(sizeof(*handler_data), GFP_ATOMIC);
 		if (!handler_data_add) {
-			DRM_ERROR("DM_IRQ: failed to allocate irq handler!\n");
+			drm_err(adev_to_drm(adev), "DM_IRQ: failed to allocate irq handler!\n");
 			return;
 		}
 
@@ -611,11 +607,11 @@ static void amdgpu_dm_irq_schedule_work(struct amdgpu_device *adev,
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
@@ -720,10 +716,9 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
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

