Return-Path: <SRS0=gUFK=E2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2057C56201
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AE422272
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Nov 2020 14:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uefQ+/Go"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AE422272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCDE06E8C7;
	Fri, 20 Nov 2020 14:55:36 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 028E86E8CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 14:55:34 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id b16so7242101qtb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Nov 2020 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L2sDlbqgj0F7RtSoQw3BhCjspwQogkZB941ZUa+Mb+4=;
 b=uefQ+/Go8JXeGb077AhJGBzuLAMJO3KDvemlUcnXJFKxzlHihfXIwYMzSFEDBzsgxv
 JSmmQomGTypq5GGiRs82QhaO4/Q0Tn5Vr+pDqPgpFxTLnpT2O6Vt3pq6Qhni8xKJDxd1
 TAUzKYUwParsyDmc+Aq+oKNx7WP0Rgwc83QhGSHT02WWkUp3klFNAX0o6Wp63Pwfq2Yc
 wu7DR+twWFFOLSUI6FlTAOo5mFtGOpu9OZqa3/EjilpF2o5dm9EypE1B4HLpWAF+MxSy
 mevrr+tYrl+t1qBPyt5Xxz7htC3ZKu8H9fjVJz/BV24iDojWZhxEXc8nyonTpqRm9E0j
 EQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=L2sDlbqgj0F7RtSoQw3BhCjspwQogkZB941ZUa+Mb+4=;
 b=oIQpy08eudUFu/OHG0RMhbevRKrp223XMUvxUETmF+F/GJ9UX05PN0SmmiKISGH4cr
 wt5itKqtS8nuHp1akQn3q8T7QThUtERE1msgeOApg1Vp9jDIelcIbNtlU4oUusnkw6YK
 3+bOymURjAu4PDNc2M7jkRjmxo0Zw0PdpDdNfjQr0roMtFJN0IKmoWnt4apfpzhQahw/
 w7OohQbn+kqZMi+bo3jsJOHFhCBCyLtpYai37M4CD4gUUYGrWC25z0gRSuS/c4lqfMQW
 VYJPCgTjDdTuMrtU83ghtehJqeAQDEq44AVdPUFDqlro54kL6jFpdWOYDe4DZesWN+2H
 3l+Q==
X-Gm-Message-State: AOAM5332VzDgxauDM8GTk+De56wDVWeuxHWM6T1ffW7m1REFB02su+Ng
 zayknhNOA9EwmPlTghKtvzKIseflDDo=
X-Google-Smtp-Source: ABdhPJwoAwPfJHSYYhY2ktd1D2BKX2p0yA4r9IBVmZo2p4FnN+4BayajGF4Vci1x60ElrbefGPlLYA==
X-Received: by 2002:ac8:5653:: with SMTP id 19mr16572211qtt.136.1605884133867; 
 Fri, 20 Nov 2020 06:55:33 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id m5sm2036417qtp.51.2020.11.20.06.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2020 06:55:33 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: only register VGA devices with the VGA arbiter
Date: Fri, 20 Nov 2020 09:55:26 -0500
Message-Id: <20201120145526.305912-1-alexander.deucher@amd.com>
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

We only need to arbitrate VGA access on VGA compatible devices.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2f60b7084f4d..2670fb113ba1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3346,7 +3346,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	/* if we have > 1 VGA cards, then disable the amdgpu VGA resources */
 	/* this will fail for cards that aren't VGA class devices, just
 	 * ignore it */
-	vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
+	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
 	if (amdgpu_device_supports_boco(ddev))
 		boco = true;
@@ -3605,7 +3606,8 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 		vga_switcheroo_unregister_client(adev->pdev);
 	if (amdgpu_device_supports_boco(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
-	vga_client_register(adev->pdev, NULL, NULL, NULL);
+	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
+		vga_client_register(adev->pdev, NULL, NULL, NULL);
 	if (adev->rio_mem)
 		pci_iounmap(adev->pdev, adev->rio_mem);
 	adev->rio_mem = NULL;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
