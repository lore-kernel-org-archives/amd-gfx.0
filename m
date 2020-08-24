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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3CC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8EB20738
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2020 16:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw6d25q6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8EB20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F35F6E30C;
	Mon, 24 Aug 2020 16:15:58 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112DA895E7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 16:15:58 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id s16so6548401qtn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2020 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5vvo0N4SS//73AF8Wqlh2L8mW4gR0UDB7inaBxBnobQ=;
 b=Qw6d25q68RTHhHnDqlNJwfG/F/HJXkzniuYH2mM/cia5Ah/2GI5v52TTQJVEm11Ueq
 n2j3ksyisRKInW8lXy1esSztqTbCriEHqNpNz69x7KKhuHcrAjga5/W2RVUqe8jNnxYk
 lX6Ubmayeo/jGstQef3Oxbe12heOnc3z9c60T2ZG5xqqCc8Uu4Be3qt6pj5X9l2IaBdK
 etwCJOnYbdTPSqRulHxW1vDPm3zCpMlK+J0eR5Ct4hKTAuXp7XgPGjleWQAd3N0abrQm
 Bsf2L+ldoX80GOh7SmR8K6keJzvxiOQZ/LNlmepvF/4uyDCWJcjA+ZexA6p9hp83XRn7
 JRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5vvo0N4SS//73AF8Wqlh2L8mW4gR0UDB7inaBxBnobQ=;
 b=mr31FmWopW52mJxDdHQVohhfAN5xfdm2Mhg9wd4g8nmvoDM9wpKAJPVqXQE6ZEvsCZ
 JGHZtFgAIPa+uOxyi9Qszc5nju0B/N37TTfZLGxQUhvQR5ZkXNYNGb+BhT3EyDuXxsD0
 wpixrS48Bkf5IS+stnRj+WWwHfQQhMLo3xvhqzsb8AzhYTQjhitjSG4gg5NCi1onfSIS
 LeyYmrHNK4wnl+Yv85RtHBWC8H1NI1ZGkFeWoxVR6nyEi/FK8jIzFkVQ3ejxwLMl+O4K
 Qgn2hPwu/H2TchawoOogKOKhsH+ijnYLPu+5bkilbkinA/MtE8Ll06dLAa7rLE0ZwzPo
 zd+g==
X-Gm-Message-State: AOAM5310ryZ5FflGNBnV1Ypvj/5bIDn/8Jcdb4zsCb1Yj7tz9HaFherB
 Bf3x9XYliU7HerMrkyZxFXpivnHRm/4=
X-Google-Smtp-Source: ABdhPJwOTZ4Dz7ZK7LHus6lBLdCxIjCtP0LrFyxgeT7Xo9bRZG0n7sCGmN6MUxWLyNIvclYS+RqDqw==
X-Received: by 2002:aed:3ead:: with SMTP id n42mr5630666qtf.5.1598285752942;
 Mon, 24 Aug 2020 09:15:52 -0700 (PDT)
Received: from localhost.localdomain ([71.219.66.138])
 by smtp.gmail.com with ESMTPSA id q7sm9654097qkf.35.2020.08.24.09.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 09:15:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: add pre_asic_init callback for SOC15
Date: Mon, 24 Aug 2020 12:15:25 -0400
Message-Id: <20200824161527.2001591-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200824161527.2001591-1-alexander.deucher@amd.com>
References: <20200824161527.2001591-1-alexander.deucher@amd.com>
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

We need to restore some registers prior to running asic
init to work around a firmware bug.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 35 +++++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h |  2 ++
 drivers/gpu/drm/amd/amdgpu/soc15.c    |  7 ++++++
 3 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 624f7fcf5eba..bcd201926bf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1075,6 +1075,20 @@ static int gmc_v9_0_gart_init(struct amdgpu_device *adev)
 	return amdgpu_gart_table_vram_alloc(adev);
 }
 
+/**
+ * gmc_v9_0_save_registers - saves regs
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This saves potential register values that should be
+ * restored upon resume
+ */
+static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
+{
+	if (adev->asic_type == CHIP_RAVEN)
+		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
+}
+
 static int gmc_v9_0_sw_init(void *handle)
 {
 	int r, vram_width = 0, vram_type = 0, vram_vendor = 0;
@@ -1229,6 +1243,8 @@ static int gmc_v9_0_sw_init(void *handle)
 
 	amdgpu_vm_manager_init(adev);
 
+	gmc_v9_0_save_registers(adev);
+
 	return 0;
 }
 
@@ -1282,7 +1298,7 @@ static void gmc_v9_0_init_golden_registers(struct amdgpu_device *adev)
  *
  * This restores register values, saved at suspend.
  */
-static void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
+void gmc_v9_0_restore_registers(struct amdgpu_device *adev)
 {
 	if (adev->asic_type == CHIP_RAVEN)
 		WREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0, adev->gmc.sdpif_register);
@@ -1386,20 +1402,6 @@ static int gmc_v9_0_hw_init(void *handle)
 	return r;
 }
 
-/**
- * gmc_v9_0_save_registers - saves regs
- *
- * @adev: amdgpu_device pointer
- *
- * This saves potential register values that should be
- * restored upon resume
- */
-static void gmc_v9_0_save_registers(struct amdgpu_device *adev)
-{
-	if (adev->asic_type == CHIP_RAVEN)
-		adev->gmc.sdpif_register = RREG32_SOC15(DCE, 0, mmDCHUBBUB_SDPIF_MMIO_CNTRL_0);
-}
-
 /**
  * gmc_v9_0_gart_disable - gart disable
  *
@@ -1440,8 +1442,6 @@ static int gmc_v9_0_suspend(void *handle)
 	if (r)
 		return r;
 
-	gmc_v9_0_save_registers(adev);
-
 	return 0;
 }
 
@@ -1450,7 +1450,6 @@ static int gmc_v9_0_resume(void *handle)
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	gmc_v9_0_restore_registers(adev);
 	r = gmc_v9_0_hw_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
index e0585e8c6c1b..c415c439f690 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.h
@@ -26,4 +26,6 @@
 
 extern const struct amd_ip_funcs gmc_v9_0_ip_funcs;
 extern const struct amdgpu_ip_block_version gmc_v9_0_ip_block;
+
+void gmc_v9_0_restore_registers(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 3cd98c144bc6..a239261e4990 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1029,6 +1029,11 @@ static uint64_t soc15_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+static void soc15_pre_asic_init(struct amdgpu_device *adev)
+{
+	gmc_v9_0_restore_registers(adev);
+}
+
 static const struct amdgpu_asic_funcs soc15_asic_funcs =
 {
 	.read_disabled_bios = &soc15_read_disabled_bios,
@@ -1049,6 +1054,7 @@ static const struct amdgpu_asic_funcs soc15_asic_funcs =
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
+	.pre_asic_init = &soc15_pre_asic_init,
 };
 
 static const struct amdgpu_asic_funcs vega20_asic_funcs =
@@ -1072,6 +1078,7 @@ static const struct amdgpu_asic_funcs vega20_asic_funcs =
 	.need_reset_on_init = &soc15_need_reset_on_init,
 	.get_pcie_replay_count = &soc15_get_pcie_replay_count,
 	.supports_baco = &soc15_supports_baco,
+	.pre_asic_init = &soc15_pre_asic_init,
 };
 
 static int soc15_common_early_init(void *handle)
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
