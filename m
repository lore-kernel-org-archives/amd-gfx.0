Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DB6C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 17:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5426864E2E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 17:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5426864E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90D46E852;
	Thu, 18 Feb 2021 17:11:05 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E17076E852
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 17:11:04 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id z190so2767551qka.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 09:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yCKdbkcTKNO+gDB1ssfmnCdreq1PxHNvaE3wXT+fi+4=;
 b=CzNHEmqrI0Ki5mcdXqrTS1eUOKC6nARePJDiM7KjhmgFvMDWsL3IJ9UM++L9RVnbpc
 q+QD06ETFTO5sJ3kzPYOcNBnSO6ym64HgDZ/u6xIOrvIETy0iNPnR40ZwgC4im6eo1ts
 lUe4moFw03XaY1pUznI7QXdpcC5AHplujJVn8lRWaC1OUkIySTtZozl9rAlcPRQRHUIb
 8vbptBN69vu36zM7UtN3vCmLP+ylKNA46U+Tn/zAvz4q7VUxlbQSfF4bVxQcVEHINbsh
 Nbn2rlxHbv4aqeBaSvbfctj/CAvHqezzU7p4nWCbBFTgtopxAobIenV3X/zoftjJeIOh
 Jtog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yCKdbkcTKNO+gDB1ssfmnCdreq1PxHNvaE3wXT+fi+4=;
 b=BuNulkKt3r/XBhVTt34XF1hNwrohk+LllsUmudhGLlcpvOPKyp9uY+ugX4hygTXx9W
 S2kJnPVBlk6JO6Fea+Edi1TEif5VZnNqq9+s9LGZBl6effD1f8Nv7McoTyoGyvPc3ySL
 z9CqmqAs3dC4Z55MHiHWSSYHpRjna9sMjsjjdjIb/tj4MN0dgCq2+C7gxH8jplBiVaQZ
 CFk/CoPLaCe7yEuoIf706H1GJPa0YkIoBRxE86gzyjAoVVdwVSBZ+J3pSXHatHLKNL5/
 Y2hKuNx6+MrSsUW9JDS2U+TXHO/VEk9L748iXMMxgmjCdL85jIv0ISHm8eoxmhSwwd5h
 Xdnw==
X-Gm-Message-State: AOAM530bFqzdFzQpOXhXlQ1lHXH7paIptrXXXQmkQnD5NprPc2YfBi81
 sIkgXY9mO4bUz0gn0KMGPp4Jh6Gg0Vc=
X-Google-Smtp-Source: ABdhPJwRwSCbN68NuGQQCDcBKqSgmBRkFVK89THkuTcVTlxnM8pbpt1G/iTUVR7onmX2v7W2aPVrew==
X-Received: by 2002:a37:7204:: with SMTP id n4mr5104789qkc.480.1613668263905; 
 Thu, 18 Feb 2021 09:11:03 -0800 (PST)
Received: from localhost.localdomain ([192.161.79.229])
 by smtp.gmail.com with ESMTPSA id f8sm3672568qth.6.2021.02.18.09.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Feb 2021 09:11:03 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix shutdown with s0ix
Date: Thu, 18 Feb 2021 12:10:54 -0500
Message-Id: <20210218171054.3039369-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For shutdown needs to be handled differently and s0ix.  Add
a new flag to shutdown and use it to adjust behavior appropriately.

Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1499
Fixes: 628c36d7b238e2 ("drm/amdgpu: update amdgpu device suspend/resume sequence for s0i3 support")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 ++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index da258331e86b..7f5500d8e8f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1018,6 +1018,7 @@ struct amdgpu_device {
 	/* s3/s4 mask */
 	bool                            in_suspend;
 	bool				in_hibernate;
+	bool				in_shutdown;
 
 	atomic_t 			in_gpu_reset;
 	enum pp_mp1_state               mp1_state;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7052dc35d278..ecd0201050ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2678,7 +2678,8 @@ static int amdgpu_device_ip_suspend_phase1(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
+	if (adev->in_shutdown ||
+	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev)) {
 		amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
 		amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 	}
@@ -3741,7 +3742,8 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 
 	amdgpu_fence_driver_suspend(adev);
 
-	if (!amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
+	if (adev->in_shutdown ||
+	    !amdgpu_acpi_is_s0ix_supported(adev) || amdgpu_in_reset(adev))
 		r = amdgpu_device_ip_suspend_phase2(adev);
 	else
 		amdgpu_gfx_state_change_set(adev, sGpuChangeState_D3Entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 2ddaa72437e3..b44358e8dc5b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1265,6 +1265,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 	if (amdgpu_ras_intr_triggered())
 		return;
 
+	adev->in_shutdown = true;
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown.
 	 * unfortunately we can't detect certain
@@ -1274,6 +1275,7 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 		adev->mp1_state = PP_MP1_STATE_UNLOAD;
 	amdgpu_device_ip_suspend(adev);
 	adev->mp1_state = PP_MP1_STATE_NONE;
+	adev->in_shutdown = false;
 }
 
 static int amdgpu_pmops_prepare(struct device *dev)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
