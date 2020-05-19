Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43280C433E1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2B220657
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 15:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxT1j1ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2B220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC116E36F;
	Tue, 19 May 2020 15:44:49 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4FB96E35D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 15:44:47 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id c24so11505999qtw.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=j11HZeyrkXS5mgFTffk79mSAgeG6JNQ+IXC0kGIVYxI=;
 b=mxT1j1eziKIIr9tU59vQbPEyZpSAjtoK0DRjPv4Hc/SxKgS6uMYZOcZz86BD3gqkue
 K6r1zqR/g4Hf2v7rgma0FI+7GNBll/PTEU2q36HYm7G556UOqHOEwC/hnQsUbEVEJgJs
 XqtJ9RHqV7dUBqg4su9+Ruvvp1f8of0C3bTx99C/0kRx+F8K2zgMeWl3X8k8J2dPOhb2
 SM3HZrK/D+8Td0hvzTKCjBOnUqjTMtlLN1oROsITVaH8o1YdtavyKSKtij0ClHQO7Szs
 tS1kDhbHPb0zSFRsKn81iIc4BKsKQ4ivtcCAywxPcrYkjwh1ivQlakbN+Oq5LY+1k1Fc
 dnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=j11HZeyrkXS5mgFTffk79mSAgeG6JNQ+IXC0kGIVYxI=;
 b=GXcENLAZ22JsGGyBtMWq578agw8dpALD6ZheyM5Fc0Lm9K80C/e0TeNb0Lw8MAvN0D
 s4WNVlodS5i2UPilQT1QYsHcoTjkV1vzcmpHJtPKb/L0O3bHqLT5W8+r6KJ9/FAyP/Lj
 Qfi5DVJxBY+ChKw3O50AqYQXI432GHZWJmC/H3w3dX+CdxjtKjWbUD45AGX04KccLQDk
 i2a6oFoulyzzqDLxzyjqp4Z3yhXessnsnDW9sdfmtzEswfl4jeSZ8cYQij2aiy4nMPZ7
 52OFU5BESI0A6mmhqAK8lsAF8jyGdHHWXm0924qzDGEUYLytCYc4G+aQvaKs3zgKL5x9
 5QrA==
X-Gm-Message-State: AOAM531fsmtbq12oGtq2UQ4J1GpAea3TbVzvXvwuq+04QMMNaSaOvwZP
 gjsM7kW94ZiycomNpuLoqFHGWfi7
X-Google-Smtp-Source: ABdhPJzVGkcY5NQQKCGNy3amoxkrWZxjP/YXxSwpF7IliPiY9sOEONYpcqlxh5MTWUguO0K+h27hig==
X-Received: by 2002:ac8:6c54:: with SMTP id z20mr386789qtu.76.1589903086808;
 Tue, 19 May 2020 08:44:46 -0700 (PDT)
Received: from localhost.localdomain ([71.51.180.250])
 by smtp.gmail.com with ESMTPSA id l133sm10819975qke.105.2020.05.19.08.44.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 08:44:46 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 7/7] drm/amdgpu: put some case statments in family order
Date: Tue, 19 May 2020 11:44:26 -0400
Message-Id: <20200519154426.1752937-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200519154426.1752937-1-alexander.deucher@amd.com>
References: <20200519154426.1752937-1-alexander.deucher@amd.com>
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

SI and CIK came before VI and newer asics.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 54 +++++++++++-----------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 80a6c3156766..2f0e8da7bacf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1534,15 +1534,6 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	adev->firmware.gpu_info_fw = NULL;
 
 	switch (adev->asic_type) {
-	case CHIP_TOPAZ:
-	case CHIP_TONGA:
-	case CHIP_FIJI:
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_VEGAM:
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
 #ifdef CONFIG_DRM_AMDGPU_SI
 	case CHIP_VERDE:
 	case CHIP_TAHITI:
@@ -1557,6 +1548,15 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	case CHIP_KABINI:
 	case CHIP_MULLINS:
 #endif
+	case CHIP_TOPAZ:
+	case CHIP_TONGA:
+	case CHIP_FIJI:
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
 	case CHIP_VEGA20:
 	default:
 		return 0;
@@ -1690,24 +1690,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	switch (adev->asic_type) {
-	case CHIP_TOPAZ:
-	case CHIP_TONGA:
-	case CHIP_FIJI:
-	case CHIP_POLARIS10:
-	case CHIP_POLARIS11:
-	case CHIP_POLARIS12:
-	case CHIP_VEGAM:
-	case CHIP_CARRIZO:
-	case CHIP_STONEY:
-		if (adev->flags & AMD_IS_APU)
-			adev->family = AMDGPU_FAMILY_CZ;
-		else
-			adev->family = AMDGPU_FAMILY_VI;
-
-		r = vi_set_ip_blocks(adev);
-		if (r)
-			return r;
-		break;
 #ifdef CONFIG_DRM_AMDGPU_SI
 	case CHIP_VERDE:
 	case CHIP_TAHITI:
@@ -1736,6 +1718,24 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			return r;
 		break;
 #endif
+	case CHIP_TOPAZ:
+	case CHIP_TONGA:
+	case CHIP_FIJI:
+	case CHIP_POLARIS10:
+	case CHIP_POLARIS11:
+	case CHIP_POLARIS12:
+	case CHIP_VEGAM:
+	case CHIP_CARRIZO:
+	case CHIP_STONEY:
+		if (adev->flags & AMD_IS_APU)
+			adev->family = AMDGPU_FAMILY_CZ;
+		else
+			adev->family = AMDGPU_FAMILY_VI;
+
+		r = vi_set_ip_blocks(adev);
+		if (r)
+			return r;
+		break;
 	case CHIP_VEGA10:
 	case CHIP_VEGA12:
 	case CHIP_VEGA20:
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
