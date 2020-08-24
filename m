Return-Path: <SRS0=//M4=CC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C408FC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A42620738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9cp4BaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A42620738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 602446E2F2;
	Mon, 24 Aug 2020 16:15:45 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5154E6E2E6
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:43 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id p25so7899252qkp.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D7MefWcWRUFop04BGEC7af/E8wIjGxBYnY8ujhS1xR8=;
 b=X9cp4BaNrbray8zC2LL5T7rbLhrvHWd3p9P1h7mzvDGYA1O9yw4b+6d63rNyZy3yfX
 aRhcqdxBUT07OvIpavV+fd1zem8CkmcDEE96Lw8PyuyMDsP5zAFGtD+zr6h3Ue8t5uQT
 U1avnJPglJO1qVcJrb/XuHz0/NRDoiE/6yJaLxE5QQd5aHuMS2dqsz1cIk/LXGRZXh4o
 lXMmivc5gbeyb8TJc3NmNEkQgd4P/+/XGmKcGszPtmK764Mk1L/RgYKCFmm66Oukp28m
 PWlOwD6ThJjTA20YtqD9VndL03jvxVhNN2cSQO5fWDqnGUxFRnHKNUT7WGcl9uINX2XB
 uRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=D7MefWcWRUFop04BGEC7af/E8wIjGxBYnY8ujhS1xR8=;
 b=ukNYextu/LDAt3uk3IHgQ8e2jxC7fCJEinhzFPQTxmu/AtbVYQe5NZ+uE4qejYghPh
 ImPEZVkXxEcKcVRUb4DNM/OeJyNfZ312/uVLAku0MitiImmLvVuEakYxJorhi8wjHTKK
 AyYLPaYT0DTi18ftGg7vWL9W73Gq4IhHyd8SsrZ4WsmiUCjPW92SZUlkKbgz9RhVSwj/
 1NqiDyNHrvz94CtDNb/3Q/Ct4MYwJG8b3k8DsSos75H0ZGkWsWSjYh8jpd2OuVG3j4MB
 5xd+EE8j8SLaF1M1rwdz8L7UwALylgnMS9bKqzw9h1Xm1vBGx8vcxu1bGMnuYzbRTkxd
 6xGQ==
X-Gm-Message-State: AOAM532FaDm61+LZ2Nl+k5Ocapw1arjztByHaX+EDUoRKRM7GeqMK9+D
 YYX1Q6XBYqe5isEGVY+nDzGSuRHnw/A=
X-Google-Smtp-Source: ABdhPJxAS5yY7BUWDH+MTmR6POD08a9zz0AV/U6NtaYp3Ot+yjJ7CQ5wYwwdM0Y/3rAAn5yfiOYBmQ==
X-Received: by 2002:a37:b847:: with SMTP id i68mr4868122qkf.427.1598285738055; 
 Mon, 24 Aug 2020 09:15:38 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:37 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/8] drm/amdgpu: fix up DCHUBBUB_SDPIF_MMIO_CNTRL_0 handling
Date: Mon, 24 Aug 2020 12:15:20 -0400
Message-Id: <20200824161527.2001591-1-alexander.deucher@amd.com>
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
