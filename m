Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2739FC33C9B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF442077B
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 21:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKeG6fKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF442077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA6B46E09A;
	Tue,  7 Jan 2020 21:13:48 +0000 (UTC)
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com
 [IPv6:2607:f8b0:4864:20::b43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6970F6E09A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 21:13:48 +0000 (UTC)
Received: by mail-yb1-xb43.google.com with SMTP id z10so581108ybr.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 13:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kowt2Gei/ficGJaAt5csoekpLfoRFnDkupQA9Gq7kU=;
 b=ZKeG6fKIesZdDtFA+GkaTOrzAgSraiceKnV6N1ZgnFKwkCa1E93DqVThtLXNO8K4zo
 wmNsgnPMkzBW5uxZhlDf/0tmJrXhjG9iBoi6j6T8JyME5e+UEVtT/Jqdud7I3HNVF4xw
 CuYKtTG3V9YlJ0f09y1VgQLI7wk5j+JFC16H5YYIg+A3/M+2gqNsVdo45ZmmtMn/NMxA
 3Zcpq/38N9pqPnEVhKRyAMOOOz3lyvZgohkJZZIIeMOPgjzgv8LIPQY4AKLcXv3tAl0S
 woHN5ZOGlNGELudv4ylAfeuIOkPZ8BZkp7DH3YWaOOFyzTiOtJr13mQ7fbqueUQZ9pAY
 vEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9kowt2Gei/ficGJaAt5csoekpLfoRFnDkupQA9Gq7kU=;
 b=S8nEHU3XYD8oefFNrrcucGiviv0rBmO1ivA3/0YcUbtWvkcWr/Xt/XMcIEMiS2t35C
 RAtHkKevofZtvmc3VxAylFBmioTo9WJhf21LF0vGwnBNFMrldLRpqKC8orMrpUx1NV+/
 CXKj1HKc0jhXpCLhqxSY6YMbWk64eYDWTGCT+9fUJGD4Q66OOLDRo3dVhHqlIlcAGbko
 MwaCFJbIKLJMh+w9aMVgXWFsWjpuy6ywlgVrGFhNPLVAA4Ja1q4XCzcrSHemlAN0w621
 L9l/fw3IIEu6CTtMqH3CbeZVTatWotxM9urrrwpnT6yfU4+68oxksW78k1cMHHt3ykAG
 AI+w==
X-Gm-Message-State: APjAAAXd2WMWomQcfDzW7SfBJdmco8Evfk+R63vSlsdKD48DwhFC96h/
 5sCqg++hSCVbxH8SRoR5DIB5+Plp
X-Google-Smtp-Source: APXvYqy0ZdD4j+l8Ox6pGweDml6xa8nE3EToh+QB1iUV7RMFVKtV/qvw42lOsxUkQFINkg2efIkeeg==
X-Received: by 2002:a25:e7c9:: with SMTP id e192mr1409238ybh.253.1578431627376; 
 Tue, 07 Jan 2020 13:13:47 -0800 (PST)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w142sm382229ywa.87.2020.01.07.13.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 13:13:46 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: enable S/G display on PCO and RV2
Date: Tue,  7 Jan 2020 16:13:19 -0500
Message-Id: <20200107211320.1820393-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.24.1
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

It should work on all Raven variants, but some users have
reported issues with original Raven with IOMMU enabled.
So far there have been no issues observed with PCO or RV2.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 22 ++++++++++++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 18 ++++++++++-----
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 4e699071d144..6d520a3eec40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -513,13 +513,23 @@ uint32_t amdgpu_display_supported_domains(struct amdgpu_device *adev,
 	 * will not allow USWC mappings.
 	 * Also, don't allow GTT domain if the BO doens't have USWC falg set.
 	 */
-	if (adev->asic_type >= CHIP_CARRIZO &&
-	    adev->asic_type < CHIP_RAVEN &&
-	    (adev->flags & AMD_IS_APU) &&
-	    (bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
+	if ((bo_flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
 	    amdgpu_bo_support_uswc(bo_flags) &&
-	    amdgpu_device_asic_has_dc_support(adev->asic_type))
-		domain |= AMDGPU_GEM_DOMAIN_GTT;
+	    amdgpu_device_asic_has_dc_support(adev->asic_type)) {
+		switch (adev->asic_type) {
+		case CHIP_CARRIZO:
+		case CHIP_STONEY:
+			domain |= AMDGPU_GEM_DOMAIN_GTT;
+			break;
+		case CHIP_RAVEN:
+			/* enable S/G on PCO and RV2 */
+			if (adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
+				domain |= AMDGPU_GEM_DOMAIN_GTT;
+			break;
+		default:
+			break;
+		}
+	}
 #endif
 
 	return domain;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b998b0382477..05118c8860f9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -906,13 +906,19 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.dce_environment = DCE_ENV_PRODUCTION_DRV;
 
-	/*
-	 * TODO debug why this doesn't work on Raven
-	 */
-	if (adev->flags & AMD_IS_APU &&
-	    adev->asic_type >= CHIP_CARRIZO &&
-	    adev->asic_type < CHIP_RAVEN)
+	switch (adev->asic_type) {
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
 		init_data.flags.gpu_vm_support = true;
+		break;
+	case CHIP_RAVEN:
+		/* enable S/G on PCO and RV2 */
+		if (adev->rev_id >= 0x8 || adev->pdev->device == 0x15d8)
+			init_data.flags.gpu_vm_support = true;
+		break;
+	default:
+		break;
+	}
 
 	if (amdgpu_dc_feature_mask & DC_FBC_MASK)
 		init_data.flags.fbc_support = true;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
