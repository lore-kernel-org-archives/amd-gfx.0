Return-Path: <SRS0=8cN+=DO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7220BC41604
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09182064E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2020 16:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9bY9jq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F09182064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F9F76E95D;
	Wed,  7 Oct 2020 16:32:25 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 022136E95D
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2020 16:32:24 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id z6so3494860qkz.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 07 Oct 2020 09:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ooZNZ++oL1sfO/EOdq62rFtCX0s4OPoqWydXr1sV3bw=;
 b=h9bY9jq+pcqbD/R42N7LmkjjD9w9H8U4Yx0J/fsmejB5IGdOrfoRarUj2670JbuStF
 7ACSblbtUfflksU3KOwaGCvZRTF8WVKgqdtYRd6kJwomSjBle6L/M7/JYBasLDgoCydy
 khGzCah78obpEFC8FCACQyta22c5UrNzF+Tnxt1JEYQ96uhK5gnEBwlizszicsUrjxjM
 sZ0rQI5/CBFLqxJZ9Rp/X3jfIHBXs4oeFaPgICda76UVVOwjyt20VqIE7c8k16jYsgso
 38GIy9bHEeEjOHaq3RzlhwB560a6OFJznL0nmRZTEUj/fT/P74RWq8w9uc+yFyF0ofeV
 gXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ooZNZ++oL1sfO/EOdq62rFtCX0s4OPoqWydXr1sV3bw=;
 b=QR1QjwNaXgI70oxZ7qL2HYYs86NLvZQQfH50UMyHBZ3ndVoU5di/hglu89ooWEtJSW
 gCzvp5yDoTnewmQ3IVKLvA2gz28eLz0KdCuuho+h32+Db5bwRetSFaGenDiX0Bap1yAj
 sashDGBKWcPyKW1gjpTtx4rWTyfgQ6cFCPdzP+eJ+0zyczZcu/b09jzO4DRPCZVz3hhB
 9NWJ/BGjC0WBaEzrdtJu+3IiBJLNDmEbdoYWy7cfAdgFjdTkVu8C5Yy5Z9hIRwAuvZBP
 pC4E/dXZ6YOp79vOgVK+TqxJVPl0T0xcgUO16t2ql2M/WjiOz4JqwFzk5e8bWF9T4cCC
 00uQ==
X-Gm-Message-State: AOAM530RZ6CdfpkPo6jwnJUtKaGMck8bSPMIzykNT4W+QPzCofslqbW4
 NdpuRQDpEKRvFxqAm4mFh7AuM96DkLU=
X-Google-Smtp-Source: ABdhPJxSTru/zso0kydkRCzJjZHCBzI47rXvIGiq9O1MNn82L73S0ufUAqMPP2XEv3KC/rOURHMH5A==
X-Received: by 2002:a37:7d87:: with SMTP id y129mr3827275qkc.108.1602088342381; 
 Wed, 07 Oct 2020 09:32:22 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id l19sm1725576qkk.99.2020.10.07.09.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 09:32:21 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 23/50] drm/amdgpu/swsmu: add smu support for
 dimgrey_cavefish(v2)
Date: Wed,  7 Oct 2020 12:31:08 -0400
Message-Id: <20201007163135.1944186-24-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201007163135.1944186-1-alexander.deucher@amd.com>
References: <20201007163135.1944186-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tao Zhou <tao.zhou1@amd.com>

Reuse sienna_cichlid pp table for dimgrey_cavefish.

v2: update related comment.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_v11_0.h         |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  1 +
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c | 17 ++++++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
index 8885bde3ea3d..9351abf99b31 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v11_0.h
@@ -33,6 +33,7 @@
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x39
 #define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x5
 #define SMU11_DRIVER_IF_VERSION_VANGOGH 0x01
+#define SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish 0x1
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index fc482ce4b400..e84b40d9b8c7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -397,6 +397,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		break;
 	case CHIP_SIENNA_CICHLID:
 	case CHIP_NAVY_FLOUNDER:
+	case CHIP_DIMGREY_CAVEFISH:
 		sienna_cichlid_set_ppt_funcs(smu);
 		break;
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 8248e557cd1a..983cee668da1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -62,6 +62,7 @@ MODULE_FIRMWARE("amdgpu/navi14_smc.bin");
 MODULE_FIRMWARE("amdgpu/navi12_smc.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");
 MODULE_FIRMWARE("amdgpu/navy_flounder_smc.bin");
+MODULE_FIRMWARE("amdgpu/dimgrey_cavefish_smc.bin");
 
 #define SMU11_VOLTAGE_SCALE 4
 
@@ -109,6 +110,9 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	case CHIP_NAVY_FLOUNDER:
 		chip_name = "navy_flounder";
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		chip_name = "dimgrey_cavefish";
+		break;
 	default:
 		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
 		return -EINVAL;
@@ -247,6 +251,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case CHIP_VANGOGH:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_VANGOGH;
 		break;
+	case CHIP_DIMGREY_CAVEFISH:
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
@@ -330,7 +337,8 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 		version_major = le16_to_cpu(hdr->header.header_version_major);
 		version_minor = le16_to_cpu(hdr->header.header_version_minor);
 		if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
-			adev->asic_type == CHIP_NAVY_FLOUNDER) {
+		    adev->asic_type == CHIP_NAVY_FLOUNDER ||
+		    adev->asic_type == CHIP_DIMGREY_CAVEFISH) {
 			dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 			switch (version_minor) {
 			case 0:
@@ -702,8 +710,11 @@ int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	struct amdgpu_device *adev = smu->adev;
 
-	/* Navy_Flounder do not support to change display num currently */
-	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
+	/* Navy_Flounder/Dimgrey_Cavefish do not support to change
+	 * display num currently
+	 */
+	if (adev->asic_type >= CHIP_NAVY_FLOUNDER &&
+	    adev->asic_type <= CHIP_DIMGREY_CAVEFISH)
 		return 0;
 
 	return smu_cmn_send_smc_msg_with_param(smu,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
