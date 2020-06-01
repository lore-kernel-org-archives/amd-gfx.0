Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB26C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463BC20878
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nrxC195X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463BC20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8076E29B;
	Mon,  1 Jun 2020 18:03:58 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B31C66E29B
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:03:56 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id s1so9927231qkf.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z+BzQEZgZdHyHJZBXXI//GywQOm/zMh/Q8aoI+yN7Ak=;
 b=nrxC195XGJ+/JUaCUbNPrqMwf2X1v+fBL1SKL3z5ZWV4sZx6MkdBvOjNyGIpgDjMCb
 xqeyTy+cPfT8rKBxXC7MRmXX5QKO56FNJE6zQ2aEqOkSAc5Xx2aY7bUH8BIvVt1zDeuq
 s1/dk+oeazcMXtZGuo7pHhcwlrwwsYqYtg7QHQK+7+z/ayD4Mkm+u+u5qUstj3ZYmV5e
 iqn00ekh8p3zv7nC+FhwgZQ1zPx32Y7KwD/bHW1P+5cSJh9WRvISFo0xdvKl5Ov6rhrb
 LYfOMqraUQzhsQho58oaJAxDzSoBlB1gGCWbEwUzHpsZIAA/FdKG9RrV25UldcalPGmF
 mOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z+BzQEZgZdHyHJZBXXI//GywQOm/zMh/Q8aoI+yN7Ak=;
 b=LkHlQ0nMFPcmiTrCtW6YM869Dt+E9JwVZhuYqiJmeQ+/pdAm1XVlrDJ0w3hLIjK/b5
 v1k96AeuE/a3GhI/rBOFbxWG+lXJE2Lik8hJPq3/9iZ1LjmDeTAe+Xm+FN4z50L1/Zue
 uidFeeqDF4m+yaqsPP1wXZM+9+JS9Uiu+Z653em29EvC1/DbH9N75KA3ZjDdVq3NAnL/
 Um1U7/StZh3rQ6RAbqExwJzYxKP6y2dzcjElb3iEIvwco7lbVFkiGl895TI3vR0O+BoK
 BFxCbQyYDrCS3q944nJMW9RxwT3RhYk+RdO0v2JTg+z4HAyKfC08k0GglvXhgyr5aU40
 f51w==
X-Gm-Message-State: AOAM532R14srTclP/LjOv14kLQsi4Oehb9DFEwoRwrB8i2yz3c9VPnuV
 +p/2/TSZXE8EvFDzRlLQWvv5g9V5
X-Google-Smtp-Source: ABdhPJzGqb8T8QLStD2h1+3YibMyzQTKm6hmZ8L7geqNcWq+1DzyRMAbOfgckjn4c0D4eYviwdZl5A==
X-Received: by 2002:a37:e85:: with SMTP id 127mr20872166qko.178.1591034635589; 
 Mon, 01 Jun 2020 11:03:55 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:03:55 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 049/207] drm/amdgpu: update SDMA 5.2 microcode init
Date: Mon,  1 Jun 2020 14:00:01 -0400
Message-Id: <20200601180239.1267430-46-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 John Clements <john.clements@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Removed loading duplicate instances of SDMA FW for Sienna_Cichlid,
As sienna_cichlid only use a single image for all instances.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: John Clements <john.clements@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 99 ++++++++++++++++++--------
 1 file changed, 69 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 5a47f105cd14..82145572e5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -45,9 +45,6 @@
 #include "sdma_v5_2.h"
 
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma.bin");
-MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma1.bin");
-MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma2.bin");
-MODULE_FIRMWARE("amdgpu/sienna_cichlid_sdma3.bin");
 
 #define SDMA1_REG_OFFSET 0x600
 #define SDMA3_REG_OFFSET 0x400
@@ -94,6 +91,41 @@ static void sdma_v5_2_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
+static int sdma_v5_2_init_inst_ctx(struct amdgpu_sdma_instance *sdma_inst)
+{
+	int err = 0;
+	const struct sdma_firmware_header_v1_0 *hdr;
+
+	err = amdgpu_ucode_validate(sdma_inst->fw);
+	if (err)
+		return err;
+
+	hdr = (const struct sdma_firmware_header_v1_0 *)sdma_inst->fw->data;
+	sdma_inst->fw_version = le32_to_cpu(hdr->header.ucode_version);
+	sdma_inst->feature_version = le32_to_cpu(hdr->ucode_feature_version);
+
+	if (sdma_inst->feature_version >= 20)
+		sdma_inst->burst_nop = true;
+
+	return 0;
+}
+
+static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (adev->sdma.instance[i].fw != NULL)
+			release_firmware(adev->sdma.instance[i].fw);
+
+		if (adev->asic_type == CHIP_SIENNA_CICHLID)
+			break;
+	}
+
+	memset((void*)adev->sdma.instance, 0,
+	       sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INSTANCES);
+}
+
 /**
  * sdma_v5_2_init_microcode - load ucode images from disk
  *
@@ -113,7 +145,6 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 	int err = 0, i;
 	struct amdgpu_firmware_info *info = NULL;
 	const struct common_firmware_header *header = NULL;
-	const struct sdma_firmware_header_v1_0 *hdr;
 
 	DRM_DEBUG("\n");
 
@@ -125,26 +156,38 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 		BUG();
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (i == 0)
-			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
-		else
+	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma.bin", chip_name);
+
+	err = request_firmware(&adev->sdma.instance[0].fw, fw_name, adev->dev);
+	if (err)
+		goto out;
+
+	err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[0]);
+	if (err)
+		goto out;
+
+	for (i = 1; i < adev->sdma.num_instances; i++) {
+		if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+			memcpy((void*)&adev->sdma.instance[i],
+			       (void*)&adev->sdma.instance[0],
+			       sizeof(struct amdgpu_sdma_instance));
+		} else {
 			snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sdma%d.bin", chip_name, i);
-		err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
-		if (err)
-			goto out;
-		err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
-		if (err)
-			goto out;
-		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		adev->sdma.instance[i].fw_version = le32_to_cpu(hdr->header.ucode_version);
-		adev->sdma.instance[i].feature_version = le32_to_cpu(hdr->ucode_feature_version);
-		if (adev->sdma.instance[i].feature_version >= 20)
-			adev->sdma.instance[i].burst_nop = true;
-		DRM_DEBUG("psp_load == '%s'\n",
-				adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
-
-		if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+			err = request_firmware(&adev->sdma.instance[i].fw, fw_name, adev->dev);
+			if (err)
+				goto out;
+
+			err = sdma_v5_2_init_inst_ctx(&adev->sdma.instance[0]);
+			if (err)
+				goto out;
+		}
+	}
+
+	DRM_DEBUG("psp_load == '%s'\n",
+		  adev->firmware.load_type == AMDGPU_FW_LOAD_PSP ? "true" : "false");
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		for (i = 0; i < adev->sdma.num_instances; i++) {
 			info = &adev->firmware.ucode[AMDGPU_UCODE_ID_SDMA0 + i];
 			info->ucode_id = AMDGPU_UCODE_ID_SDMA0 + i;
 			info->fw = adev->sdma.instance[i].fw;
@@ -153,13 +196,11 @@ static int sdma_v5_2_init_microcode(struct amdgpu_device *adev)
 				ALIGN(le32_to_cpu(header->ucode_size_bytes), PAGE_SIZE);
 		}
 	}
+
 out:
 	if (err) {
 		DRM_ERROR("sdma_v5_2: Failed to load firmware \"%s\"\n", fw_name);
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			release_firmware(adev->sdma.instance[i].fw);
-			adev->sdma.instance[i].fw = NULL;
-		}
+		sdma_v5_2_destroy_inst_ctx(adev);
 	}
 	return err;
 }
@@ -1204,10 +1245,8 @@ static int sdma_v5_2_sw_init(void *handle)
 static int sdma_v5_2_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++)
-		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
+	sdma_v5_2_destroy_inst_ctx(adev);
 
 	return 0;
 }
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
