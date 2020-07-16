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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF37C43445
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F5320787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJi1299C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F5320787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3359D6ECFB;
	Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0586ECFE
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:36 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z13so8640197wrw.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aXY0929hnEyjy9oHOGYfW9PzPd1flXaXrUHyHSIX6Zc=;
 b=cJi1299CkLNFjsyjqbNDu4jyxRB08acQsJm65T3pB1jAvaFUsFzFwgO/vzSHHrGXz/
 FIFgPRlRFfajKXPTMDqjTvdVURtMf14XCJghqfamAJOucK7gt+jcjLBu5D4TIVCJxRK4
 8zjeJ4J814nYUyOZjgWiVBmCm2jfx9c6aGI7rddllWP9hekDdIq+1u1vfkIGXPmFqY3A
 ddsFesj+mKlTJNaV/TNUdFZ6A/mf5kKPkEcrEnNzkKcbQSj7FRiFXFb+GqN+3uLn/azu
 t/7hUYgvzmg1mPD8qwyI/5///esJtOY/2/e2tQAkz55BfOxhIZ3tSjCrVRsgwS2aCfpB
 JAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aXY0929hnEyjy9oHOGYfW9PzPd1flXaXrUHyHSIX6Zc=;
 b=I4/4wDgc0/yV60aoJi6UwYuBpaNyCwYc8g6wChRkuRZLa4ebP47RxtOqXnsDfY7wp6
 R6Ij9kli9I82bSy8tJHiHB1IhBPmOxPsVA/UEQxLrRuRDS+V+u7BGDK6NU11UPwoFmmZ
 K0a8HSQf15qxfbGzfwwEqYNMBvnFNGB4NpxtfPSaqajZBK7ti8PJ7dcNUVOtZQ3Z/1xS
 te0ojRD5wVKwjH1o778pfZzEawPztCfzJmetLwy6bPuBmyNRQgl++CVi2ImyBX8Rh6lL
 aLE1DH4KTsv+l0HVeNBeJCp25Fykv3Sbn8asPVMAcCraVAuks4cxG1zeMDOpVc9WGrgS
 b4Pw==
X-Gm-Message-State: AOAM531FhlWyfDBB4K/Wz8+XlqYy9AeTuffImqDfkxkB7rGdIicShb9q
 VbpwNmz85kZmL0sQ1nq8ysTek7o1T7s=
X-Google-Smtp-Source: ABdhPJzA5JnAFux2S/yyQArXrpxp535lyPPhwcC4uFb4ZUgOO+99awKuCkLmt3N2f5vF4bxrDQu0Gg==
X-Received: by 2002:a05:6000:86:: with SMTP id
 m6mr6737790wrx.173.1594934614618; 
 Thu, 16 Jul 2020 14:23:34 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:34 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 26/27] drm/amdgpu: enable DC support for SI parts (v2)
Date: Thu, 16 Jul 2020 23:22:50 +0200
Message-Id: <20200716212251.1539094-27-issor.oruam@gmail.com>
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
amdgpu_device.c requires changes for SI chipsets support
si.c require changes for Display Manager IP block enabling

[How]
amdgpu_device.c: add SI families in amdgpu_device_asic_has_dc_support()
si.c: changes in si_set_ip_blocks() for Display Manager IP blocks enablement

(v1) NOTE: As per Kaveri and older amdgpu.dc=1 kernel cmdline is required

(v2) fix for bc011f9350 ("drm/amdgpu: Change SI/CI gfx/sdma/smu init sequence")
     remove CHIP_HAINAN support since it does not have physical DCE6 module

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/si.c            | 10 ++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aa5b54e5a1d7..cd5efa6c1c18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2775,6 +2775,12 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
 {
 	switch (asic_type) {
 #if defined(CONFIG_DRM_AMD_DC)
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+#endif
 	case CHIP_BONAIRE:
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index 1b449291f068..5a112c7a35ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -52,6 +52,8 @@
 #include "bif/bif_3_0_d.h"
 #include "bif/bif_3_0_sh_mask.h"
 
+#include "amdgpu_dm.h"
+
 static const u32 tahiti_golden_registers[] =
 {
 	mmAZALIA_SCLK_CONTROL, 0x00000030, 0x00000011,
@@ -2546,6 +2548,10 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &si_smu_ip_block);
 		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC) && defined(CONFIG_DRM_AMD_DC_SI)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
@@ -2560,6 +2566,10 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &si_smu_ip_block);
 		if (adev->enable_virtual_display)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
+#if defined(CONFIG_DRM_AMD_DC) && defined(CONFIG_DRM_AMD_DC_SI)
+		else if (amdgpu_device_has_dc_support(adev))
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
+#endif
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
