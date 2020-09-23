Return-Path: <SRS0=BIvg=DA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D475EC4363D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:18:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6553C21D43
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2020 14:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JK8wZavP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6553C21D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09AC26E199;
	Wed, 23 Sep 2020 14:18:42 +0000 (UTC)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED886E199
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 14:18:30 +0000 (UTC)
Received: by mail-qt1-x842.google.com with SMTP id z2so18727787qtv.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2020 07:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z/bPHqjqOHGhdCglvMpP/H7Rf5EMZ4DJXK2MbEMJ4eo=;
 b=JK8wZavP1yeGlZ5gfR9ksfwrpBTJx6vdop+TJGDEj5aNkG2uFSY2JxFzYnQp9bIrOW
 KX07wG5viIjR8RUU8yKb7RhUGQsve3NuTsEkf6wJslKZktf1pYrMPmeJYmQ3/a9eBF1W
 oP3TzX/G9TkGd+KvYLiZOHCq4BdHi2MAdsQKI/JrCP1m2Y3S1JSiF9aDOM4hegVpkg2P
 fR92Z4I8zILcrBz/1kcqf1hRGKwMDtDubgyBa/O001BdOO4DPMGQYhyRsc0Cr7ZC3KWs
 x959nKOtuB/YUzidWQSxxZBVrkk+nvYbscy+7fEIjqHD9258ZufDMsRUwcH5FrhRBO3f
 daSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=z/bPHqjqOHGhdCglvMpP/H7Rf5EMZ4DJXK2MbEMJ4eo=;
 b=QHPldhrLWUqs0uD4E4qK10DaoaHTbLBHrsp5OgSyXZiRKEl2rOq+6A7w/7U0ZObnE3
 fxV05OG80M4sz0Ql57eVh9J/Q+FarriD/au15a30hOomPvOtGFYLfX6+0NO8NYZv19AO
 MhRR/ynebcJrhgwPRT7KML7ebL2rUBWX7gZ85lpiJkMsKgNViPzaS+f6HOX76fdg7JtT
 u5trIA/X1luAOVcGTUp943ixjybGJsclNfLlfoqNkcOgU5oNTRrXcNNLPWYnOPAP9vH8
 VBdl+hmB1h+yYcw8Tka0qbL3zpSrCir7bAxiVeAiB4U98QBr1oRBaQKekkGtKTuQfifj
 OBhA==
X-Gm-Message-State: AOAM533vsNP4OZcozvdfhX/+6p3px7RXuYRnanMLsuVwMR9hbYbHDLWO
 BP7b2CQYGt3O258a9dppGNDNNcKalcQ=
X-Google-Smtp-Source: ABdhPJy6WFa5nkux9aPex+Ftk20qq+0wcaK15hFlwPzJD46tiCmrZJGp9R/qveNA9Rb19HdtGk3h1A==
X-Received: by 2002:aed:24b8:: with SMTP id t53mr220436qtc.46.1600870149254;
 Wed, 23 Sep 2020 07:09:09 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w128sm59033qkb.6.2020.09.23.07.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2020 07:09:08 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: add an auto setting to the noretry parameter
Date: Wed, 23 Sep 2020 10:08:58 -0400
Message-Id: <20200923140858.1193427-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200923140858.1193427-1-alexander.deucher@amd.com>
References: <20200923140858.1193427-1-alexander.deucher@amd.com>
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

This allows us to set different defaults on a per asic basis.  This
way we can enable noretry on dGPUs where it can increase performance
in certain cases and disable it on chips where it can be problematic.

For now the default is 0 for all asics, but we may want to try and
enable it again for newer dGPUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 26 ++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a4b518211b1f..f3e2fbcfadfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -147,7 +147,7 @@ int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = 0;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
-int amdgpu_noretry;
+int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
 int amdgpu_tmz = 0;
 int amdgpu_reset_method = -1; /* auto */
@@ -596,8 +596,13 @@ MODULE_PARM_DESC(mes,
 	"Enable Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
 module_param_named(mes, amdgpu_mes, int, 0444);
 
+/**
+ * DOC: noretry (int)
+ * Disable retry faults in the GPU memory controller.
+ * (0 = retry enabled, 1 = retry disabled, -1 auto (default))
+ */
 MODULE_PARM_DESC(noretry,
-	"Disable retry faults (0 = retry enabled (default), 1 = retry disabled)");
+	"Disable retry faults (0 = retry enabled, 1 = retry disabled, -1 auto (default))");
 module_param_named(noretry, amdgpu_noretry, int, 0644);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3572629fef0a..36604d751d62 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -424,7 +424,31 @@ void amdgpu_gmc_noretry_set(struct amdgpu_device *adev)
 {
 	struct amdgpu_gmc *gmc = &adev->gmc;
 
-	gmc->noretry = amdgpu_noretry;
+	switch (adev->asic_type) {
+	case CHIP_RAVEN:
+		/* Raven currently has issues with noretry
+		 * regardless of what we decide for other
+		 * asics, we should leave raven with
+		 * noretry = 0 until we root cause the
+		 * issues.
+		 */
+		if (amdgpu_noretry == -1)
+			gmc->noretry = 0;
+		else
+			gmc->noretry = amdgpu_noretry;
+		break;
+	default:
+		/* default this to 0 for now, but we may want
+		 * to change this in the future for certain
+		 * GPUs as it can increase performance in
+		 * certain cases.
+		 */
+		if (amdgpu_noretry == -1)
+			gmc->noretry = 0;
+		else
+			gmc->noretry = amdgpu_noretry;
+		break;
+	}
 }
 
 void amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
