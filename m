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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DBFC43446
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAF3223C6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 18:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ36qcht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAF3223C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183036E84B;
	Tue, 14 Jul 2020 18:24:39 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B9E6E849
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 18:24:37 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id b4so16492556qkn.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 11:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ij0ol1AEeRlHj6KCpbokDk+QzSBUfvN6FlrZ3U8Rg+U=;
 b=bZ36qchtf9lN/SWQT1j/QsK7cztHcPkUlTf4Ox/x7u3IlyM2WG4wwJ343obtcgIlKe
 d90nEsgxaEVnH1WJQDmyfDsDTWH9wGyTebWylyP6+Zj6Y9MqrfdVUC/TvPlP1TuTPumq
 eiy6J/411Da435gsFX08EWv9Eaztbhf0P+bPxCtWrLKiowtV50UfRpE1T8iiJWGxqTBH
 3praiAO1hx0U9ZLmXKC4QwTt29Eddmrx9H9A5/MoA9reAA+H8nBOh0KGllqM4Tqg6p3N
 SELsAkdUdx15itFlivnQIKQNjnIIXwiumTRPstgdf4qU19RH/oCYA5SgJbL4tTSxNgLo
 Ac6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ij0ol1AEeRlHj6KCpbokDk+QzSBUfvN6FlrZ3U8Rg+U=;
 b=obtjSBiAIsApjW37ezh3fQ7rqwG1lRPc0SxgvLZF+xm2NkCAHBQYli21sUIhoSHgjk
 Ea5oYj+lkjKPKbrUpRb7cj0ftbLMhlXESgDdnfAsqV1izDqzlN33L5M+goekIDrtkJjz
 OtAzwg9YDSklWTgDUR0Vj/RhM/3sVIHWbUjnz/UB/zXjByLcINl1kO6Eg++8RzMH3Nlb
 Ii1Fck3fACAQpqNt+o7LfbfzeywlG+d6bq/Zd1tWjEmnBfOFHQO2cQx6WQIjBZdHpnRi
 JJ8cgBczFCgWhCq7SEFfKb6TDybp/MdpRZkfOZ+jDn7dMxnZ9XHc+ZG63v7AOB1rcVJG
 gg2A==
X-Gm-Message-State: AOAM531khjRJ5KE2RMbvJ0b47cOaNxRCNdJAiqP89N8QHVxM7hmadWq/
 5IfqGyPGSKSQvfVnAj87yWrL740k
X-Google-Smtp-Source: ABdhPJyvHLOA8fle0lU+FjZB6yD99tBbpXnq8d1vB+wuyEsum1twG4BYUg4jdoDwIqY/GTXLVlUTyg==
X-Received: by 2002:a37:6411:: with SMTP id y17mr5892549qkb.288.1594751076014; 
 Tue, 14 Jul 2020 11:24:36 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id d53sm26046456qtc.47.2020.07.14.11.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 11:24:35 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 21/42] drm/amdgpu/powerplay: add smu support for navy_flounder
Date: Tue, 14 Jul 2020 14:23:32 -0400
Message-Id: <20200714182353.2164930-22-alexander.deucher@amd.com>
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

Now navy_flounder will reuse the smu11 driver_if header and ppt
functions for sienna_cichlid. Later navy_flounder can maintain
its own version if the compatibility is broken.

Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/amdgpu_smu.c    |  1 +
 drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h |  1 +
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c     | 15 ++++++++++++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
index 6839faaab611..b0c2b52e0e2b 100644
--- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
@@ -601,6 +601,7 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 		smu->od_enabled =false;
 		break;
 	case CHIP_SIENNA_CICHLID:
+	case CHIP_NAVY_FLOUNDER:
 		sienna_cichlid_set_ppt_funcs(smu);
 		break;
 	case CHIP_RENOIR:
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
index 1da92f137bdb..95417e35df43 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v11_0.h
@@ -31,6 +31,7 @@
 #define SMU11_DRIVER_IF_VERSION_NV12 0x33
 #define SMU11_DRIVER_IF_VERSION_NV14 0x36
 #define SMU11_DRIVER_IF_VERSION_Sienna_Cichlid 0x33
+#define SMU11_DRIVER_IF_VERSION_Navy_Flounder 0x2B
 
 /* MP Apertures */
 #define MP0_Public			0x03800000
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 03be59492af1..d7c34f269452 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -60,6 +60,7 @@ MODULE_FIRMWARE("amdgpu/navi10_smc.bin");
 MODULE_FIRMWARE("amdgpu/navi14_smc.bin");
 MODULE_FIRMWARE("amdgpu/navi12_smc.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_smc.bin");
+MODULE_FIRMWARE("amdgpu/navy_flounder_smc.bin");
 
 #define SMU11_VOLTAGE_SCALE 4
 
@@ -172,6 +173,9 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 	case CHIP_SIENNA_CICHLID:
 		chip_name = "sienna_cichlid";
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		chip_name = "navy_flounder";
+		break;
 	default:
 		dev_err(adev->dev, "Unsupported ASIC type %d\n", adev->asic_type);
 		return -EINVAL;
@@ -304,6 +308,9 @@ int smu_v11_0_check_fw_version(struct smu_context *smu)
 	case CHIP_SIENNA_CICHLID:
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
 		break;
+	case CHIP_NAVY_FLOUNDER:
+		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_Navy_Flounder;
+		break;
 	default:
 		dev_err(smu->adev->dev, "smu unsupported asic type:%d.\n", smu->adev->asic_type);
 		smu->smc_driver_if_version = SMU11_DRIVER_IF_VERSION_INV;
@@ -385,7 +392,8 @@ int smu_v11_0_setup_pptable(struct smu_context *smu)
 	hdr = (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
 	version_major = le16_to_cpu(hdr->header.header_version_major);
 	version_minor = le16_to_cpu(hdr->header.header_version_minor);
-	if (version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) {
+	if ((version_major == 2 && smu->smu_table.boot_values.pp_table_id > 0) ||
+	    adev->asic_type == CHIP_NAVY_FLOUNDER) {
 		dev_info(adev->dev, "use driver provided pptable %d\n", smu->smu_table.boot_values.pp_table_id);
 		switch (version_minor) {
 		case 0:
@@ -817,6 +825,11 @@ int smu_v11_0_set_tool_table_location(struct smu_context *smu)
 int smu_v11_0_init_display_count(struct smu_context *smu, uint32_t count)
 {
 	int ret = 0;
+	struct amdgpu_device *adev = smu->adev;
+
+	/* Navy_Flounder do not support to change display num currently */
+	if (adev->asic_type == CHIP_NAVY_FLOUNDER)
+		return 0;
 
 	if (!smu->pm_enabled)
 		return ret;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
