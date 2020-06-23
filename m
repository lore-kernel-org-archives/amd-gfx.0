Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99091C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D31F20780
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 16:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwdGkfKQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D31F20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32EBE6E433;
	Tue, 23 Jun 2020 16:25:10 +0000 (UTC)
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com
 [IPv6:2a00:1450:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AAD76E433
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 16:25:08 +0000 (UTC)
Received: by mail-ej1-x643.google.com with SMTP id a1so8214038ejg.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eY/PFi8pMcazGvnnDrWrlScfNnxXv/DI4amy1GdyV68=;
 b=pwdGkfKQZdSXFmlLsiarX6nrv+P8bRR6HHC9/hkUKboY590lpf0DrJ/fS/3e1pq+bb
 n6gOoJRkRTz6RpLJM6RJPrHFMCwmN85FFxIvOpZVM9nLWgWdQxF6KbhR5LbwpgY0Ek5u
 kGmPEBnTsgfo9Bwe7v4K13gkrd7vdYuacDJSIh9HeOGE2uvmQoEt7UnYImuQiFF8ojwm
 Ex/MdMWHIvJbc+o2UdObK/Z1eG6rZs4+w15DUwSUgeFMewFPy/sUgJFHvNewy42ViZD4
 g4a0W/9Y9+7uiNxtuNF+AoWpNPuBHFwaOwwjlrPvtN90c+sun+0Ot8JSU4rd9LapIR3H
 pDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=eY/PFi8pMcazGvnnDrWrlScfNnxXv/DI4amy1GdyV68=;
 b=ZZs7f32YAWDBLeWpm4dzmxx+Y1FDElxfkCWgvNJIaGcVNQ4z8XOo4XHKvxKZvnokxs
 UDdolH/32EiWjSCALWXNNlif/rcqH7DSIUQW7gOjxzbw/DOP7pPGQuYj31Ukweoez49n
 M/f7UVBkeFCp0tmu2SO/cYJbcm7N1aVE43lO2cpfzdK6O7OFIRkK0w9Yf78DIDo6WXIz
 9oZLpv3qZXZBlNliQv2NPMLmOgxWNEUVzk8cK/EO0dgBxalJCHKJ7+r0SD0g+g0IsQpn
 3o35Yb6BjxTxIO5YB0CG7kMrHeo0ZHaNQjN4A5KzT/feADxP7GD/66cjhEyhIcYvN8Kw
 DMzQ==
X-Gm-Message-State: AOAM530HYAJW96dRzj4BQjB1bYiPolOv5MjHJ8sQHgdrEGqIdUgFp3tR
 ze6yXOGjWP9tKobK7ET57SMlx6M5HZx4hA==
X-Google-Smtp-Source: ABdhPJyiWv7rEAkAjA8LkjiU04VjpZXRf1/QT2Grbadk4evvaOJVIppgMffwF4JTM3QLjNZig26jdQ==
X-Received: by 2002:a17:906:7212:: with SMTP id
 m18mr20961636ejk.29.1592929506223; 
 Tue, 23 Jun 2020 09:25:06 -0700 (PDT)
Received: from brihaspati.fritz.box (pd956781a.dip0.t-ipconnect.de.
 [217.86.120.26])
 by smtp.gmail.com with ESMTPSA id a2sm4281748ejg.76.2020.06.23.09.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 09:25:05 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: call release_firmware() without a NULL check
Date: Tue, 23 Jun 2020 18:26:37 +0200
Message-Id: <20200623162637.26011-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The release_firmware() function is NULL tolerant so we do not need
to check for NULL param before calling it.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  6 ++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c           |  6 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++--------
 6 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2858c09fd8c0..a649e40fd96f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3380,10 +3380,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 		amdgpu_pm_sysfs_fini(adev);
 	amdgpu_fbdev_fini(adev);
 	r = amdgpu_device_ip_fini(adev);
-	if (adev->firmware.gpu_info_fw) {
-		release_firmware(adev->firmware.gpu_info_fw);
-		adev->firmware.gpu_info_fw = NULL;
-	}
+	release_firmware(adev->firmware.gpu_info_fw);
+	adev->firmware.gpu_info_fw = NULL;
 	adev->accel_working = false;
 	/* free i2c buses */
 	if (!amdgpu_device_has_dc_support(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0723dee2958b..9342a9e8cadf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -196,10 +196,8 @@ static int psp_sw_fini(void *handle)
 	adev->psp.sos_fw = NULL;
 	release_firmware(adev->psp.asd_fw);
 	adev->psp.asd_fw = NULL;
-	if (adev->psp.ta_fw) {
-		release_firmware(adev->psp.ta_fw);
-		adev->psp.ta_fw = NULL;
-	}
+	release_firmware(adev->psp.ta_fw);
+	adev->psp.ta_fw = NULL;
 
 	if (adev->asic_type == CHIP_NAVI10)
 		psp_sysfs_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 58382646d962..2985c61bc6a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -559,8 +559,8 @@ static void sdma_v4_0_destroy_inst_ctx(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->sdma.instance[i].fw != NULL)
-			release_firmware(adev->sdma.instance[i].fw);
+		release_firmware(adev->sdma.instance[i].fw);
+		adev->sdma.instance[i].fw = NULL;
 
 		/* arcturus shares the same FW memory across
 		   all SDMA isntances */
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6751ad69ed90..1baeddf2f1e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1300,8 +1300,8 @@ static int sdma_v5_0_sw_fini(void *handle)
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->sdma.instance[i].fw != NULL)
-			release_firmware(adev->sdma.instance[i].fw);
+		release_firmware(adev->sdma.instance[i].fw);
+		adev->sdma.instance[i].fw = NULL;
 
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 95751e7bdfe8..318d32e2bbf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -115,8 +115,8 @@ static void sdma_v5_2_destroy_inst_ctx(struct amdgpu_device *adev)
 	int i;
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (adev->sdma.instance[i].fw != NULL)
-			release_firmware(adev->sdma.instance[i].fw);
+		release_firmware(adev->sdma.instance[i].fw);
+		adev->sdma.instance[i].fw = NULL;
 
 		if (adev->asic_type == CHIP_SIENNA_CICHLID)
 			break;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3badf685338f..4767f9ea0352 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1318,15 +1318,11 @@ static int dm_sw_fini(void *handle)
 		adev->dm.dmub_srv = NULL;
 	}
 
-	if (adev->dm.dmub_fw) {
-		release_firmware(adev->dm.dmub_fw);
-		adev->dm.dmub_fw = NULL;
-	}
+	release_firmware(adev->dm.dmub_fw);
+	adev->dm.dmub_fw = NULL;
 
-	if(adev->dm.fw_dmcu) {
-		release_firmware(adev->dm.fw_dmcu);
-		adev->dm.fw_dmcu = NULL;
-	}
+	release_firmware(adev->dm.fw_dmcu);
+	adev->dm.fw_dmcu = NULL;
 
 	return 0;
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
