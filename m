Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6077C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D6F564F42
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D6F564F42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 329446ED95;
	Thu,  4 Feb 2021 14:43:53 +0000 (UTC)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF7026ED95
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 14:43:51 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id 19so3496094qkh.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k/jq3u5pryQAh0FbWyA3E5PXywOXFP85ge8eXWpoZs0=;
 b=kMDoo5NRcA1t96O4DxXnoyx2JBz12kjnkPrEbAG9VrnUfjHgaY/tu1X/rOHEk1W7RS
 UksczNeNfvInHn4JBf2BksJVSodsG69dGymrgOP2xCbifXmif1tLqmGcaG+i23qc0Uxo
 MaLeUF/9K9Sr2IgK0OS5ZRKg+aqLWiuALgdnPMXFjC2B0CHYE55XM4BwIwlxVwt2z/+m
 n2NBQ9zs9MXzfMBx6qpvcK8M5wiXTQPuHySMykGKY7lb2zDoE2TZ7rCKaI1n3vfUnE2l
 L6Kgol5CEASWNtPiyMXH6vHm7Rncu/cdV4r0nLUhsb1I+Ud8OgoztYbx8LenR26ryuGj
 3EHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=k/jq3u5pryQAh0FbWyA3E5PXywOXFP85ge8eXWpoZs0=;
 b=oHLn3VBOfShNd1cuVe2iQtUhrUE1wh8vfYMwhpYplMwfBLuh4+pfvmmwKwXcphGc0j
 gQGPEOerX8Ki9rHtW7s6RWFcywNufjwwsCNndlWqkGoQll9s8Is9GPrjiaJ2A2Z+XvRI
 JFYCdrrgRg2EJ/n8KbCt34mG4y4bZZB1IpyD3p9uojOoNDb3E5sik9yi5syMlTvoaS2T
 FKCADx6JB+7BVAowhKWbVzokAXLdNcmD08ZVslINWSwXmbnnjkZSkH0+tfBTd/uBGsEW
 rpP0hQYEI4ekpl5MsDbkJbowvrjxMYOz/1n2mNsiijihVxMhmKF/A46Ddf9gAuL1ujmU
 IwEA==
X-Gm-Message-State: AOAM533wz/bFSIoiWLsB97ZiJsrgu112RrDPG35scfcNIAZRXxG9MK40
 wGjS0ea+ns3WEqHyxKaENB9H/v0Mho0=
X-Google-Smtp-Source: ABdhPJxlcW3hVHMEUuRZBH1T6gpg2xdh57Y9CxFbqi4FMAY7qYI8kTELu/481nHOjvT8RLFd1OttVA==
X-Received: by 2002:a05:620a:cf5:: with SMTP id
 c21mr7991067qkj.207.1612449830687; 
 Thu, 04 Feb 2021 06:43:50 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.237])
 by smtp.gmail.com with ESMTPSA id q18sm4735488qtr.74.2021.02.04.06.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 06:43:49 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: drop extra drm_kms_helper_poll_enable/disable
 calls
Date: Thu,  4 Feb 2021 09:43:27 -0500
Message-Id: <20210204144329.52506-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
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

These are already called in amdgpu_device_suspend/resume which
are already called in the same functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 51bea409e513..151c649e4d11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1433,10 +1433,8 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 		amdgpu_device_resume(dev, true);
 
 		dev->switch_power_state = DRM_SWITCH_POWER_ON;
-		drm_kms_helper_poll_enable(dev);
 	} else {
 		pr_info("switched off\n");
-		drm_kms_helper_poll_disable(dev);
 		dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 		amdgpu_device_suspend(dev, true);
 		amdgpu_device_cache_pci_state(pdev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 05ed82e4d805..c9821f1dc357 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1367,7 +1367,6 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	adev->in_runpm = true;
 	if (amdgpu_device_supports_atpx(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
-	drm_kms_helper_poll_disable(drm_dev);
 
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret)
@@ -1424,7 +1423,6 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
-	drm_kms_helper_poll_enable(drm_dev);
 	if (amdgpu_device_supports_atpx(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
