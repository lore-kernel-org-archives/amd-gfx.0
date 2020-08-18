Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A56BC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECD22075E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 23:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAeD2TQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECD22075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2290A6E193;
	Tue, 18 Aug 2020 23:28:48 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFC806E193
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 23:28:46 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id s16so16501015qtn.7
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 16:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D7MefWcWRUFop04BGEC7af/E8wIjGxBYnY8ujhS1xR8=;
 b=eAeD2TQSLSqyZEPVtyoVVn/O+OCXBKCM9W9Uvl1gzphMr7uN0mOjpI8IMjRIWBkEjl
 +kWcIgArW+BRbZhuTitbfx/URW6guCM3r+cHZ3VqLvJqtBCWy1JCtJR7cZya0lAolTVS
 eglxYMfkaMD/PHTMXez/DOtUN+EbpzJMqOjs0GBImTKjQixeLAvjUKfdh3krNlpJPw9E
 +hmzpVHulqxBlajj8vT93lKxBkeIuZkY72i0PzGpZ/DfgXuRZYtb0FtlK4/ihdVBEUF4
 tK0G9I3uLMC4sjlldMQbI4pk1QKH2VN4hojjFGB7WnLTfsMsyF/4zlu3ctywDDlzkgI+
 M/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D7MefWcWRUFop04BGEC7af/E8wIjGxBYnY8ujhS1xR8=;
 b=oeDBR/jdMdmXhLPv/yx1blj4Y6hA9G+rmmTn7tkr1dbGWs/6gY5aILxNKTTKsOdVCc
 n5rVEqAaxJFm/Z0W3duqIqq+qtHNViCu0fk+btsOLmwSnX8MhtRBdwONmUJiA75dYho3
 QGLkXlnf9svdGoBAtATNC21hXpKMwInwjC2okgZ76xCCKSe4SWxhsEGfwx867Z6823Xa
 qdMb1UsfPmfa8VQqLayDmvkjJtpJ/e2QYmdMaFCOyZCNhcm8fVtCT+YLnkbyGmXx0hTY
 CEDY50PPLo315rX/+Cj7I4IX7q6iJv7OZttx3TsBxOFT3a3Q0X9oiEGuJ4cA62MyTCTW
 BSOg==
X-Gm-Message-State: AOAM530RkmvApfghw249R5vwNixGar4q3UWHLqyJnIPqhe8+eyCl8h2c
 631+7yVKR59y5Tkbnfsj9IWY9Xp/+Vk=
X-Google-Smtp-Source: ABdhPJxX56BnVqo8KY/H3sTPy4Qr6iXjw/J3T62RB/zhTJy64CcJ0U91AydvhdXfp2QAoDfKE0OulQ==
X-Received: by 2002:ac8:44da:: with SMTP id b26mr19062184qto.216.1597793325657; 
 Tue, 18 Aug 2020 16:28:45 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id s184sm22804990qkf.50.2020.08.18.16.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 16:28:45 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix up DCHUBBUB_SDPIF_MMIO_CNTRL_0 handling
Date: Tue, 18 Aug 2020 19:28:38 -0400
Message-Id: <20200818232838.2902175-1-alexander.deucher@amd.com>
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

Properly define this register using a relative offset rather
than an absolute offset and use the proper SOC15 macros to
access it.  It's also DCN, not DCE, so remove it from the
DCE12 header.

No functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c                      | 7 +++++--
 drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h | 2 --
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 6a780b674018..624f7fcf5eba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -67,6 +67,9 @@
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT__SHIFT                                       0x10
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH_MASK                                          0x00003FFFL
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT_MASK                                         0x3FFF0000L
+#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x049d
+#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
+
 
 static const u32 golden_settings_vega10_hdp[] =
 {
@@ -1282,7 +1285,7 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
 static void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_RAVEN)
-		WREG32(mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
+		WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
 }
 
 /**
@@ -1394,7 +1397,7 @@ static int gmc_v9_0_hw_init(void *handle)
 static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_RAVEN)
-		adev->gmc.sdpif_register = RREG32(mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
+		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
index 27bb8c1ab858..b6f74bf4af02 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_12_0_offset.h
@@ -7376,8 +7376,6 @@
 #define mmCRTC4_CRTC_DRR_CONTROL                                                                       0x0f3e
 #define mmCRTC4_CRTC_DRR_CONTROL_BASE_IDX                                                              2
 
-#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0                                                                  0x395d
-#define mmDCHUBBUB_SDPIF_MMIO_CNTRL_0_BASE_IDX                                                         2
 
 // addressBlock: dce_dc_fmt4_dispdec
 // base address: 0x2000
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
