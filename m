Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33511C6369E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 20:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A326D21527
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 20:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A326D21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1955B6EABB;
	Wed,  2 Dec 2020 20:17:58 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35EB66EABB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 20:17:56 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id p12so1333476qvj.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Dec 2020 12:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Myq7dc3icBA9AVlzP1TjqAkNnnG0uAE79YA/3EVhavE=;
 b=aub71TMofLVIf4aSf3S/G2tO4Ln2FTYmhJ0GfkrMTwseuJJ50sd/UBiMw85RnAlVNH
 lXL69Q5qZKbp15pSEq2R044sQqDiMSgohZvFRUYgUIGVK7ZLlgc4Xiy7v/9t9IgLwPay
 pu+2uCu8vJF9adkozE+YJZQJufSXbywP3N5ojOSSKHpy/6EMc0lSsCrLqZRp5R8QerXf
 rX2xqUWfgwJFuxQpuxQCHn/a0KvqSAhvo0zOui7qtR56nuq7vlmBsZuTxG/86GT3/rb0
 Jwa5YtXrltAj1BsgcPW36RXYC+LASDKQpIqSnKuVjGkqp2YafEA2DlHDMPaKF2Yeb3eb
 Pdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Myq7dc3icBA9AVlzP1TjqAkNnnG0uAE79YA/3EVhavE=;
 b=jS/vrOml67m/i1NurZn3kxkfyiD3rk21dOBsoMTzNLxb97WdC+tiKP+YNeEM6RRfCl
 d8m8628Qy+q3eV1z0SeZUZDavPp2DgmH5685JvbkkcxBYqgFw+N+QZzL81PgC0yRaJJk
 VaDEEGlCcdWFjCZlmkDKEHwpAbwaidsgDQdd0zc19NVr2cVofEnPUG5CgiTEMCZRPJOt
 HTIO50VGPoKm30vBKUJyQMv4BLXFesFDKwOIH7U9nA4wH7cAaZ1t8P4YMHYAcOz0EXzm
 sDSU8+ekY3orWLtK55BU14Ppa7P+HlqtkyDg6TygrWFa0xUCzS92FmAnGOLf549NPnYH
 Dfug==
X-Gm-Message-State: AOAM532sH9qkLuvLCE+G3MUBpIm1gyVBq+2YrQcwNt2QkTiz/WrtUKiy
 GuVYVWtFZ+x1AGnwQn7DW0/Zf1P/Ojk=
X-Google-Smtp-Source: ABdhPJyZaNTQ3M4W1Qd2PgTUmIHYVlC7lP0Pjik6sojtfljwff+UnRyXzabc2iReq/HC47b6ykOtjw==
X-Received: by 2002:ad4:522a:: with SMTP id r10mr4539294qvq.23.1606940275116; 
 Wed, 02 Dec 2020 12:17:55 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id c10sm2805280qkm.71.2020.12.02.12.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 12:17:54 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu/powerplay: parse fan table for CI asics
Date: Wed,  2 Dec 2020 15:17:47 -0500
Message-Id: <20201202201747.1433842-1-alexander.deucher@amd.com>
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

Set up all the parameters required for SMU fan control if supported.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=201539
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../amd/pm/powerplay/hwmgr/processpptables.c  | 103 +++++++++++++++++-
 1 file changed, 102 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
index 48d550d26c6a..182118e3fd5f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/processpptables.c
@@ -24,6 +24,8 @@
 #include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
+
 #include <drm/amdgpu_drm.h>
 #include "processpptables.h"
 #include <atom-types.h>
@@ -980,6 +982,8 @@ static int init_thermal_controller(
 			struct pp_hwmgr *hwmgr,
 			const ATOM_PPLIB_POWERPLAYTABLE *powerplay_table)
 {
+	struct amdgpu_device *adev = hwmgr->adev;
+
 	hwmgr->thermal_controller.ucType =
 			powerplay_table->sThermalController.ucType;
 	hwmgr->thermal_controller.ucI2cLine =
@@ -1004,7 +1008,104 @@ static int init_thermal_controller(
 		   ATOM_PP_THERMALCONTROLLER_NONE != hwmgr->thermal_controller.ucType,
 		   PHM_PlatformCaps_ThermalController);
 
-	hwmgr->thermal_controller.use_hw_fan_control = 1;
+        if (powerplay_table->usTableSize >= sizeof(ATOM_PPLIB_POWERPLAYTABLE3)) {
+		const ATOM_PPLIB_POWERPLAYTABLE3 *powerplay_table3 =
+			(const ATOM_PPLIB_POWERPLAYTABLE3 *)powerplay_table;
+
+		if (0 == le16_to_cpu(powerplay_table3->usFanTableOffset)) {
+			hwmgr->thermal_controller.use_hw_fan_control = 1;
+			return 0;
+		} else {
+			const ATOM_PPLIB_FANTABLE *fan_table =
+				(const ATOM_PPLIB_FANTABLE *)(((unsigned long)powerplay_table) +
+							      le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+			if (1 <= fan_table->ucFanTableFormat) {
+				hwmgr->thermal_controller.advanceFanControlParameters.ucTHyst =
+					fan_table->ucTHyst;
+				hwmgr->thermal_controller.advanceFanControlParameters.usTMin =
+					le16_to_cpu(fan_table->usTMin);
+				hwmgr->thermal_controller.advanceFanControlParameters.usTMed =
+					le16_to_cpu(fan_table->usTMed);
+				hwmgr->thermal_controller.advanceFanControlParameters.usTHigh =
+					le16_to_cpu(fan_table->usTHigh);
+				hwmgr->thermal_controller.advanceFanControlParameters.usPWMMin =
+					le16_to_cpu(fan_table->usPWMMin);
+				hwmgr->thermal_controller.advanceFanControlParameters.usPWMMed =
+					le16_to_cpu(fan_table->usPWMMed);
+				hwmgr->thermal_controller.advanceFanControlParameters.usPWMHigh =
+					le16_to_cpu(fan_table->usPWMHigh);
+				hwmgr->thermal_controller.advanceFanControlParameters.usTMax = 10900;
+				hwmgr->thermal_controller.advanceFanControlParameters.ulCycleDelay = 100000;
+
+				phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+					    PHM_PlatformCaps_MicrocodeFanControl);
+			}
+
+			if (2 <= fan_table->ucFanTableFormat) {
+				const ATOM_PPLIB_FANTABLE2 *fan_table2 =
+					(const ATOM_PPLIB_FANTABLE2 *)(((unsigned long)powerplay_table) +
+								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+				hwmgr->thermal_controller.advanceFanControlParameters.usTMax =
+					le16_to_cpu(fan_table2->usTMax);
+			}
+
+			if (3 <= fan_table->ucFanTableFormat) {
+				const ATOM_PPLIB_FANTABLE3 *fan_table3 =
+					(const ATOM_PPLIB_FANTABLE3 *) (((unsigned long)powerplay_table) +
+									le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+				hwmgr->thermal_controller.advanceFanControlParameters.ucFanControlMode =
+					fan_table3->ucFanControlMode;
+
+				if ((3 == fan_table->ucFanTableFormat) &&
+				    (0x67B1 == adev->pdev->device))
+					hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanPWM =
+						47;
+				else
+					hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanPWM =
+						le16_to_cpu(fan_table3->usFanPWMMax);
+
+				hwmgr->thermal_controller.advanceFanControlParameters.usDefaultFanOutputSensitivity =
+					4836;
+				hwmgr->thermal_controller.advanceFanControlParameters.usFanOutputSensitivity =
+					le16_to_cpu(fan_table3->usFanOutputSensitivity);
+			}
+
+			if (6 <= fan_table->ucFanTableFormat) {
+				const ATOM_PPLIB_FANTABLE4 *fan_table4 =
+					(const ATOM_PPLIB_FANTABLE4 *)(((unsigned long)powerplay_table) +
+								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+				phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+					    PHM_PlatformCaps_FanSpeedInTableIsRPM);
+
+				hwmgr->thermal_controller.advanceFanControlParameters.usDefaultMaxFanRPM =
+					le16_to_cpu(fan_table4->usFanRPMMax);
+			}
+
+			if (7 <= fan_table->ucFanTableFormat) {
+				const ATOM_PPLIB_FANTABLE5 *fan_table5 =
+					(const ATOM_PPLIB_FANTABLE5 *)(((unsigned long)powerplay_table) +
+								       le16_to_cpu(powerplay_table3->usFanTableOffset));
+
+				if (0x67A2 == adev->pdev->device ||
+				    0x67A9 == adev->pdev->device ||
+				    0x67B9 == adev->pdev->device) {
+					phm_cap_set(hwmgr->platform_descriptor.platformCaps,
+						    PHM_PlatformCaps_GeminiRegulatorFanControlSupport);
+					hwmgr->thermal_controller.advanceFanControlParameters.usFanCurrentLow =
+						le16_to_cpu(fan_table5->usFanCurrentLow);
+					hwmgr->thermal_controller.advanceFanControlParameters.usFanCurrentHigh =
+						le16_to_cpu(fan_table5->usFanCurrentHigh);
+					hwmgr->thermal_controller.advanceFanControlParameters.usFanRPMLow =
+						le16_to_cpu(fan_table5->usFanRPMLow);
+					hwmgr->thermal_controller.advanceFanControlParameters.usFanRPMHigh =
+						le16_to_cpu(fan_table5->usFanRPMHigh);
+				}
+			}
+		}
+	}
 
 	return 0;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
