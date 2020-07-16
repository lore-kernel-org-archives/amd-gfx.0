Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEB2C433E7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E91C20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSzyiaWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E91C20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547316ECF0;
	Thu, 16 Jul 2020 21:23:19 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A836ECE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:18 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id 17so13147796wmo.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uBYlltu69mEUmSLX0oIqezSPL696aqw1pn7S2Nw6xLw=;
 b=nSzyiaWNNkDcvg3IPzB9CIdrByvVnvS3MYY3ULsi5PdEV/EgiZc8wKn5wu5oAXym4V
 QBc3ozcZO9WiGCUO4xXUpyI4C1PQEHkuIgS1cmD1Wd+lVz1HOlGRivxz7zwpXurW/zK/
 /ZUkjh7gPGhjZh/9l23MIYZne/2MDu6rcn4RmljqX40VoCi4OWxcpFnjR6yEPxy828+m
 MkcZTxJ5m68uNrC5zKk4MJBA9QvCJ+/7o46WOMTNTEtij1WHx7srlP6S8TRHhlcwDoax
 QzqVvBfWAq21BKUlNDZdnNetusSU5MKi8wnfUvJ7z6e1uZqtI5VLHgQncgSo7O709uez
 SUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uBYlltu69mEUmSLX0oIqezSPL696aqw1pn7S2Nw6xLw=;
 b=p/bQZHX/JlaYF79JBJvhPJ1JggWjWsFhLLDuMPqnNLK5eB7qjVGxTQsENm5nbEEvow
 p68e2aBTaGBPHNvhvfV5e2epXLd9ESSgqSG0pDtPYc9wL2z33IdmE4if276EkgoNCwSX
 pWKLRe8bdmmVriOdFmoo5uFE7Hn7yhnfJboabLk/U5RcA/Hfw4ciClqiSx2EwuZGYzMY
 J7Z9+33p1pD1YsD4x2PsdkkXT5EKRw2M4FG+ksfT46v8mb6p9+blfnPT8gbcOGmCQWee
 2t1X+I82SV3dw5gk76mSmfbfVeHE8woXkpDc70Z4k7x1sRj8hd7IAXJ4C/McqivlwBGb
 0j5w==
X-Gm-Message-State: AOAM531f1aOiLknzqlT+B08TVySjohXm1RNmm0FE5Wg8YOop2Y8dgY9S
 xw9Fe604pzllOXrlTo/3RyBQsKdukgg=
X-Google-Smtp-Source: ABdhPJyd5Z//ztgTLk9K96Fip6bRUkD9Pcu3jT5yZ53frsW6C6J++9u+VJFANdNNBvwfJqSkVKCOQg==
X-Received: by 2002:a05:600c:241:: with SMTP id
 1mr5984640wmj.119.1594934596529; 
 Thu, 16 Jul 2020 14:23:16 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:16 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 08/27] drm/amd/display: amdgpu_dm: add SI support (v4)
Date: Thu, 16 Jul 2020 23:22:32 +0200
Message-Id: <20200716212251.1539094-9-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
amdgpu_dm.c requires changes for SI chipsets init and irq handlers registration

[How]
SI support: load_dmcu_fw(), amdgpu_dm_initialize_drm_device(), dm_early_init()
Add DCE6 specific dce60_register_irq_handlers() function

(v1) NOTE: As per Kaveri and older amdgpu.dc=1 kernel cmdline is required

(v2) fix for bc011f9 ("drm/amdgpu: Change SI/CI gfx/sdma/smu init sequence")
     remove CHIP_HAINAN support since it does not have physical DCE6 module

(v3) fix vblank irq support for DCE6 using ad hoc dce60_register_irq_handlers()
     replicating for vblank irq the behavior of dce110_register_irq_handlers()
     as per commit b57de80 ("drm/amd/display: Register on VLBLANK ISR.")

(v4) updated due to following kernel 5.2 commit:
     b2fddb13 ("drm/amd/display: Drop underlay plane support")

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 114 ++++++++++++++++++
 1 file changed, 114 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0bc333798cd6..df46cf7cb374 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1064,6 +1064,12 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	const struct dmcu_firmware_header_v1_0 *hdr;
 
 	switch(adev->asic_type) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 	case CHIP_KAVERI:
@@ -2472,6 +2478,89 @@ static void register_hpd_handlers(struct amdgpu_device *adev)
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/* Register IRQ sources and initialize IRQ callbacks */
+static int dce60_register_irq_handlers(struct amdgpu_device *adev)
+{
+	struct dc *dc = adev->dm.dc;
+	struct common_irq_params *c_irq_params;
+	struct dc_interrupt_params int_params = {0};
+	int r;
+	int i;
+	unsigned client_id = AMDGPU_IRQ_CLIENTID_LEGACY;
+
+	int_params.requested_polarity = INTERRUPT_POLARITY_DEFAULT;
+	int_params.current_polarity = INTERRUPT_POLARITY_DEFAULT;
+
+	/*
+	 * Actions of amdgpu_irq_add_id():
+	 * 1. Register a set() function with base driver.
+	 *    Base driver will call set() function to enable/disable an
+	 *    interrupt in DC hardware.
+	 * 2. Register amdgpu_dm_irq_handler().
+	 *    Base driver will call amdgpu_dm_irq_handler() for ALL interrupts
+	 *    coming from DC hardware.
+	 *    amdgpu_dm_irq_handler() will re-direct the interrupt to DC
+	 *    for acknowledging and handling. */
+
+	/* Use VBLANK interrupt */
+	for (i = 0; i < adev->mode_info.num_crtc; i++) {
+		r = amdgpu_irq_add_id(adev, client_id, i+1 , &adev->crtc_irq);
+		if (r) {
+			DRM_ERROR("Failed to add crtc irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i+1 , 0);
+
+		c_irq_params = &adev->dm.vblank_params[int_params.irq_source - DC_IRQ_SOURCE_VBLANK1];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				dm_crtc_high_irq, c_irq_params);
+	}
+
+	/* Use GRPH_PFLIP interrupt */
+	for (i = VISLANDS30_IV_SRCID_D1_GRPH_PFLIP;
+			i <= VISLANDS30_IV_SRCID_D6_GRPH_PFLIP; i += 2) {
+		r = amdgpu_irq_add_id(adev, client_id, i, &adev->pageflip_irq);
+		if (r) {
+			DRM_ERROR("Failed to add page flip irq id!\n");
+			return r;
+		}
+
+		int_params.int_context = INTERRUPT_HIGH_IRQ_CONTEXT;
+		int_params.irq_source =
+			dc_interrupt_to_irq_source(dc, i, 0);
+
+		c_irq_params = &adev->dm.pflip_params[int_params.irq_source - DC_IRQ_SOURCE_PFLIP_FIRST];
+
+		c_irq_params->adev = adev;
+		c_irq_params->irq_src = int_params.irq_source;
+
+		amdgpu_dm_irq_register_interrupt(adev, &int_params,
+				dm_pflip_high_irq, c_irq_params);
+
+	}
+
+	/* HPD */
+	r = amdgpu_irq_add_id(adev, client_id,
+			VISLANDS30_IV_SRCID_HOTPLUG_DETECT_A, &adev->hpd_irq);
+	if (r) {
+		DRM_ERROR("Failed to add hpd irq id!\n");
+		return r;
+	}
+
+	register_hpd_handlers(adev);
+
+	return 0;
+}
+#endif
+
 /* Register IRQ sources and initialize IRQ callbacks */
 static int dce110_register_irq_handlers(struct amdgpu_device *adev)
 {
@@ -3203,6 +3292,17 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 	/* Software is initialized. Now we can register interrupt handlers. */
 	switch (adev->asic_type) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+		if (dce60_register_irq_handlers(dm->adev)) {
+			DRM_ERROR("DM: Failed to initialize IRQ\n");
+			goto fail;
+		}
+		break;
+#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 	case CHIP_KAVERI:
@@ -3400,6 +3500,20 @@ static int dm_early_init(void *handle)
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
 	switch (adev->asic_type) {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+		adev->mode_info.num_crtc = 6;
+		adev->mode_info.num_hpd = 6;
+		adev->mode_info.num_dig = 6;
+		break;
+	case CHIP_OLAND:
+		adev->mode_info.num_crtc = 2;
+		adev->mode_info.num_hpd = 2;
+		adev->mode_info.num_dig = 2;
+		break;
+#endif
 	case CHIP_BONAIRE:
 	case CHIP_HAWAII:
 		adev->mode_info.num_crtc = 6;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
