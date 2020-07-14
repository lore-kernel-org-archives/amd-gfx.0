Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A7C433FB
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20B69225AA
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jk/qNNwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20B69225AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F1A6E843;
	Tue, 14 Jul 2020 18:24:32 +0000 (UTC)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88846E82C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:30 +0000 (UTC)
Received: by mail-qv1-xf43.google.com with SMTP id t11so7955697qvk.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kTo85V23ViDtJq3b0Ru2VcdpaOF+GoN8Ymzee8Rfqv4=;
 b=Jk/qNNwOlZf9GBwV7GkL6KHR23utLB2N9BexOLS2gzJfCq3xcpThNcd/I6d7MEPnVT
 p+0ts09kXX/H3OlNdAUtSi4JeYE71TPy2QdtIDieFZoiOPtFXZ9SMEQb3h5WkGngmcDR
 da4t7rNbctSwWcpaScr64dAajM7Crm0uuuKdGNKAb1EG69WMsUUXelKo/jZSwBND+XyG
 GtKwtj/hhwLmOXqibYlX83j3fMUiU72K2fhNIwWERtH+/4YCoqUtFEDT4/cOw2myyaaP
 aMIQKTYHtOq7hMIFk/bQ8VHP1B8J8gSMZ67Wc0jr7nqMmmYewnJ/jrzE8uUKuVFlmQlU
 0fow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kTo85V23ViDtJq3b0Ru2VcdpaOF+GoN8Ymzee8Rfqv4=;
 b=XwO9qOy3bJvCCrlS84+fBZny+oGhk77dgGo6NK9xTnbvKLR+VFA5tRDcHa3imyLxhX
 s7wdEnb164zphAjUosTRcDykNTDKor6WEcCrkOSgLFhbVRiLM6O2jElJCqq7Ilh9x4AZ
 hSHitkfKu8KHXz3mLz5e/EKhpAzWSuiixR0okxTthqCpBTcnaoblOCYrZccaUlE3Is4b
 ia2dV+z/ylHF82BdQwdNWcQwVhEra02hpzc35xr1PA+sgN912ojea98q+AeOra0t3oBn
 spGRmkbvrz/gsg1K3lX1TQZHe44122yAruYajg9Se2qOIuhZo907DafKdH1D2qHbR/1D
 W1bA==
X-Gm-Message-State: AOAM533zgmCSEqkKmcFku+SW/8u9pOcU44JyFIUaI66ejkHo+93CvKVG
 gBKc4dMOhDa7pgLk5bhRorekJcDa
X-Google-Smtp-Source: ABdhPJz146+V5lCCgYo7M0PSutoErCNaObRNPayhw+2me6WkTTHDSN0p8LlYCU8ReU22REre2GMWDQ==
X-Received: by 2002:a0c:b61d:: with SMTP id f29mr5726599qve.249.1594751069791; 
 Tue, 14 Jul 2020 11:24:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:29 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 16/42] drm/amdgpu: add sdma ip block for navy_flounder
Date: Tue, 14 Jul 2020 14:23:27 -0400
Message-Id: <20200714182353.2164930-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200714182353.2164930-1-alexander.deucher@amd.com>
References: <20200714182353.2164930-1-alexander.deucher@amd.com>
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
 Jiansong Chen <Jiansong.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jiansong Chen <Jiansong.Chen@amd.com>

Navy_Flounder has the same sdma IP version with
sienna_cichlid, and it has 2 sdma controllers.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 20 ++++++++++++++++++--
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 693eab81f1d8..2f5a3e924a39 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -513,6 +513,7 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v10_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &navi10_ih_ip_block);
 		amdgpu_device_ip_block_add(adev, &gfx_v10_0_ip_block);
+		amdgpu_device_ip_block_add(adev, &sdma_v5_2_ip_block);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index de8342283fdb..46a9617fee5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -45,6 +45,7 @@
 #include "sdma_v5_2.h"
 
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_sdma.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA3_REG_OFFSET 0x400
@@ -85,6 +86,7 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		break;
 	default:
 		break;
@@ -152,6 +154,9 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	case CHIP_SIENNA_CICHLID:
 		chip_name = "sienna_cichlid";
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		chip_name = "navy_flounder";
+		break;
 	default:
 		BUG();
 	}
@@ -167,7 +172,8 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		goto out;
 
 	for (i = 1; i < adev->sdma.num_instances; i++) {
-		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		if (adev->asic_type == CHIP_SIENNA_CICHLID ||
+		    adev->asic_type == CHIP_NAVY_FLOUNDER) {
 			memcpy((void*)&adev->sdma.instance[i],
 			       (void*)&adev->sdma.instance[0],
 			       sizeof(struct amdgpu_sdma_instance));
@@ -1155,7 +1161,16 @@ static int sdma_v5_2_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	adev->sdma.num_instances = 4;
+	switch (adev->asic_type) {
+	case CHIP_SIENNA_CICHLID:
+		adev->sdma.num_instances = 4;
+		break;
+	case CHIP_NAVY_FLOUNDER:
+		adev->sdma.num_instances = 2;
+		break;
+	default:
+		break;
+	}
 
 	sdma_v5_2_set_ring_funcs(adev);
 	sdma_v5_2_set_buffer_funcs(adev);
@@ -1548,6 +1563,7 @@ static int sdma_v5_2_set_clockgating_state(void *handle,
 
 	switch (adev->asic_type) {
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		sdma_v5_2_update_medium_grain_clock_gating(adev,
 				state == AMD_CG_STATE_GATE ? true : false);
 		sdma_v5_2_update_medium_grain_light_sleep(adev,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
