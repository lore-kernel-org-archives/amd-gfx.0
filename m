Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62BDCA5FE5
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 17:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 482A210E2E5;
	Sun, 18 Jan 2026 17:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bHovKOMq";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B3F68995F
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:32:00 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b872b588774so533463666b.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 09:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768757518; x=1769362318; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5fMTQXiqQoE68vgI1XMJO7fjHH4VbcWpczRKZnzWz4=;
 b=bHovKOMqeazrwkbf0xeNwmByognMSNKjeMA3DldQR2KIeblBtel95Ucx/OESu6Msbt
 wJ9YTXStZT+uzNSxzGAw3zj7PZXWYWfOAhZc91RBwr6JI5Z4m493ASTUqovLtk+P60LP
 DfaPCKS6MU7VF6JlM8A8ZbTTTSvfNHeRI0BFqF5RkyAGKKm7AtT7OnzNQdaMr/Dtdg4k
 lgL7kDlBztLSjeCisgQBFJ5CL+GbSLl1O6ho3Y1qwrCIJ6PN0tMoKMjPeefBcHPPSrXJ
 oRBAf9omtZmloJTCx7ClyHZEcpJIuvpEVVcDeyGZe0GPUzWY8i+SKSGDuC0J31PJ0Y/x
 ag2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768757518; x=1769362318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p5fMTQXiqQoE68vgI1XMJO7fjHH4VbcWpczRKZnzWz4=;
 b=RRGRL9RDowebPkNGitpTJ/fq6WIzmcUdveQNnE7N3ec88DZzpDLPi8W9HCaBqYDG82
 x7vUFju0X/GPuVJsZ86ThBOBHrN/3miPUvqi28SxmaZVmOvL/rrmPzzhAA7shsuqHB9E
 W5kM6JDJjYv+wncHXFs/1t6PoUp8IG+0cn0G2x+o47yYVb/lHCmL9i2xPlvdDt9KwSTI
 uZ/XQI9FV0yNxhYDzjvYX/OdOMyauFkiFFzwMwbVwAx8AHBClmQ/+MIgxsup1+BJz9aQ
 tMivLPQ0J56ieb7Zb1KHpxuYLX5FlDxrcZ/GnGGSQyYCh79WB+GA8tC6wJjakhpPSevs
 cmyw==
X-Gm-Message-State: AOJu0Yz+fbH3eS6tXdCQrDFEhxMtJToSZI9JHDWKU5ekBOO7slmOTWRr
 l+Tc70FutGDrSeSvmcQCtI/ZUiPdzEt5iYRK8jLuPdMzLPHV8hryPFLpP2xewQ==
X-Gm-Gg: AY/fxX7shN24zS47ecTLRaW77t8QdrghZi/ee06piTZqSt01ReBX6GM2+FZVhBUwazh
 kuEgaxLWluh65bDh1zXBDUmScNTIPGu1m4TfiCX8+9Rg2Gx7+w4tFaGx/JAoLoxQJUKHmcdmM1k
 o3KyQnrbTlD6dZ2EC6sm9VmHA1gpgMeaOdEykYCjgE3ck7rc0fGSBAulC925tiqv9FzuYricpxd
 pBbRI0GqZzTJ0J0IrnGTYcnn+kj02X6QrnNprmGNE1tW7etldBTdedIbod9o/T4LqTdnjA3TIRq
 gVSguoWwVmenUK0AskRAaI91lMmAFODQg07XRyR/2y46zZmHDGjTgwtCqBA5svQHAsPFqQdlQ2R
 JAaB5YRibOo52bj+M/cuqroEnyxV/skaiR3RXakllOPWXMHNVHDsQThHa4qZUsu+pRlvv0crLpY
 wN/L4jEE1Rzk/hxUSIHKR8rc5+Bl3z3KMQFt7glJ8rLfnKQV/d4gYUNG3VTyEoykMzggCUUCFVM
 tMTghRvSUUJ
X-Received: by 2002:a17:907:6d15:b0:b87:5433:9067 with SMTP id
 a640c23a62f3a-b8792e10d28mr839316966b.29.1768757518112; 
 Sun, 18 Jan 2026 09:31:58 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm876868466b.13.2026.01.18.09.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:31:57 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amd/display: Handle DCE 6 in
 dce110_register_irq_handlers
Date: Sun, 18 Jan 2026 18:31:50 +0100
Message-ID: <20260118173150.19790-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118173150.19790-1-timur.kristof@gmail.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
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

The dce60_register_irq_handlers function was basically identical
to dce110_register_irq_handlers. They can use the same function,
reducing duplicated code and easing the maintenance burden for
old DCE versions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 165 ++++--------------
 1 file changed, 35 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 655c9fcb078a..ca6aea1b0e35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4354,105 +4354,6 @@ static int register_hpd_handlers(struct amdgpu_device *adev)
 	return 0;
 }
 
-#if defined(CONFIG_DRM_AMD_DC_SI)
-/* Register IRQ sources and initialize IRQ callbacks */
-static int dce60_register_irq_handlers(struct amdgpu_device *adev)
-{
-	struct dc *dc = adev->dm.dc;
-	struct common_irq_params *c_irq_params;
-	struct dc_interrupt_params int_params = {0};
-	int r;
-	int i;
-	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
-
-	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
-	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
-
-	/*
-	 * Actions of amdgpu_irq_add_id():
-	 * 1. Register a set() function with base driver.
-	 *    Base driver will call set() function to enable/disable an
-	 *    interrupt in DC hardware.
-	 * 2. Register amdgpu_dm_irq_handler().
-	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
-	 *    coming from DC hardware.
-	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
-	 *    for acknowledging and handling.
-	 */
-
-	/* Use VBLANK interrupt */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		r = amdgpu_irq_add_id(adev, client_id, i + 1, &adev->crtc_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i + 1, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VBLANK6) {
-			drm_err(adev_to_drm(adev), "Failed to register vblank irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_crtc_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* Use GRPH_PFLIP interrupt */
-	for (i = VISLANDS30_IV_SRCID_D1_GRPH_PFLIP;
-			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
-		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add page flip irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
-
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_PFLIP_FIRST ||
-			int_params.irq_source  > DC_IRQ_SOURCE_PFLIP_LAST) {
-			drm_err(adev_to_drm(adev), "Failed to register pflip irq!\n");
-			return -EINVAL;
-		}
-
-		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
-
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
-
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_pflip_high_irq, c_irq_params))
-			return -ENOMEM;
-	}
-
-	/* HPD */
-	r = amdgpu_irq_add_id(adev, client_id,
-			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
-	if (r) {
-		drm_err(adev_to_drm(adev), "Failed to add hpd irq id!\n");
-		return r;
-	}
-
-	r = register_hpd_handlers(adev);
-
-	return r;
-}
-#endif
-
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -4461,7 +4362,12 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	struct dc_interrupt_params int_params = {0};
 	int r;
 	int i;
+	unsigned int src_id;
 	unsigned int client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+	/* Use different interrupts for VBLANK on DCE 6 vs. newer. */
+	const unsigned int vblank_d1 =
+		adev->dm.dc->ctx->dce_version >= DCE_VERSION_8_0
+		? VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0 : 1;
 
 	if (adev->family >= AMDGPU_FAMILY_AI)
 		client_id = SOC15_IH_CLIENTID_DCE;
@@ -4482,8 +4388,9 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 	 */
 
 	/* Use VBLANK interrupt */
-	for (i = VISLANDS30_IV_SRCID_D1_VERTICAL_INTERRUPT0; i <= VISLANDS30_IV_SRCID_D6_VERTICAL_INTERRUPT0; i++) {
-		r = amdgpu_irq_add_id(adev, client_id, i, &adev->crtc_irq);
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		src_id = vblank_d1 + i;
+		r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->crtc_irq);
 		if (r) {
 			drm_err(adev_to_drm(adev), "Failed to add crtc irq id!\n");
 			return r;
@@ -4491,7 +4398,7 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 
 		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
 		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
+			dc_interrupt_to_irq_source(dc, src_id, 0);
 
 		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
 			int_params.irq_source  < DC_IRQ_SOURCE_VBLANK1 ||
@@ -4510,33 +4417,36 @@ static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 			return -ENOMEM;
 	}
 
-	/* Use VUPDATE interrupt */
-	for (i = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT; i <= VISLANDS30_IV_SRCID_D6_V_UPDATE_INT; i += 2) {
-		r = amdgpu_irq_add_id(adev, client_id, i, &adev->vupdate_irq);
-		if (r) {
-			drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
-			return r;
-		}
-
-		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
-		int_params.irq_source =
-			dc_interrupt_to_irq_source(dc, i, 0);
+	if (dc_supports_vrr(adev->dm.dc->ctx->dce_version)) {
+		/* Use VUPDATE interrupt */
+		for (i = 0; i < adev->mode_info.num_crtc; i++) {
+			src_id = VISLANDS30_IV_SRCID_D1_V_UPDATE_INT + i * 2;
+			r = amdgpu_irq_add_id(adev, client_id, src_id, &adev->vupdate_irq);
+			if (r) {
+				drm_err(adev_to_drm(adev), "Failed to add vupdate irq id!\n");
+				return r;
+			}
 
-		if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
-			int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
-			int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
-			drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
-			return -EINVAL;
-		}
+			int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+			int_params.irq_source =
+				dc_interrupt_to_irq_source(dc, src_id, 0);
 
-		c_irq_params = &adev->dm.vupdate_params[int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
+			if (int_params.irq_source == DC_IRQ_SOURCE_INVALID ||
+				int_params.irq_source  < DC_IRQ_SOURCE_VUPDATE1 ||
+				int_params.irq_source  > DC_IRQ_SOURCE_VUPDATE6) {
+				drm_err(adev_to_drm(adev), "Failed to register vupdate irq!\n");
+				return -EINVAL;
+			}
 
-		c_irq_params->adev = adev;
-		c_irq_params->irq_src = int_params.irq_source;
+			c_irq_params = &adev->dm.vupdate_params[
+				int_params.irq_source - DC_IRQ_SOURCE_VUPDATE1];
+			c_irq_params->adev = adev;
+			c_irq_params->irq_src = int_params.irq_source;
 
-		if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
-			dm_vupdate_high_irq, c_irq_params))
-			return -ENOMEM;
+			if (!amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				dm_vupdate_high_irq, c_irq_params))
+				return -ENOMEM;
+		}
 	}
 
 	/* Use GRPH_PFLIP interrupt */
@@ -5660,11 +5570,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case CHIP_PITCAIRN:
 	case CHIP_VERDE:
 	case CHIP_OLAND:
-		if (dce60_register_irq_handlers(dm->adev)) {
-			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
-			goto fail;
-		}
-		break;
 #endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
-- 
2.52.0

