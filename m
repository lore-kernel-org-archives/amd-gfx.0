Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D9C4361B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF6C23DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF6C23DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE7E36EB75;
	Thu, 10 Dec 2020 21:45:44 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46FB86EB6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:40 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id z3so4970173qtw.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5q7IxEEBVNbhrWNFGVaIunVgQt+SK1wcHAT1QD3GwYE=;
 b=sh126Mca+dMiy4ynAwKft4ta1WPfrv8KPhczqvVpXceUX70qP+Wb140S5CXqM06e+i
 rfngdV8o31t4IIb3gxhGEbYkYll1Bhw7HWyelPjoZc5uKwmOGNjJ8ccocwL1bd12f9fR
 I7vY0KwUOQtpctkHd0LW//OaEV6JUhY1A8aotQZ1HVxDTsdUi6F6aumAMXvwORZaZWLA
 kGeCdajBBDrLHl/JBsDfEkVvf3gR8Swj8soLWGoSTx9fV/bpvKfEbyha+r8Os26sVR57
 pLeEZwMa/viRslqwblwFWG76it94tFSIHmbf51bbtQIlgwxm49Vv9qSur1fNPyGK2MQk
 SDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5q7IxEEBVNbhrWNFGVaIunVgQt+SK1wcHAT1QD3GwYE=;
 b=P2MFmngyIGsZeJrEXUyylSyWcr4fssP2aN4UAY7RX+BFjdlxZdOu9M2kRVSdRj1Khd
 fxg5RQ1CM9xRH7dW7ygCa8mS1QI7CSSCKvQLaWTdiuqDVTeNqTiw7qrZKVatBdaDOYQb
 6EbKX2mDID3sG51YlQBziBwlF3SuzIBJ+iUtjhfTgjQxTNVZ5ng6dpN93+hhSYex+toE
 5ggxphoPd4lu/t48uVPWVc09Q7XVKyQDmGyhgUw+LAFARN/9cdxSSAgrf4UGHcpcsGu9
 TPbMzO972/18MCH7QxXGPcKPdIjR2rpbx/DW7cJwNZRw/Yn3q7zXfb9moexCwTYJQ7ge
 kUPg==
X-Gm-Message-State: AOAM530LB1Uv/Xi9FiCzTlTEvehbkgQ7MnSzu1kAkYwMLlWTMWGzgc54
 Lp1GLm4UlFU5URoE72lN7z2TpsLn1Pw=
X-Google-Smtp-Source: ABdhPJwMc0fkJ9nOXrSOadWBcNfCiWREbwMetB+IQ64FAiZOx2K/Z6odfXDp/dNPhzh+T0noEH7iVA==
X-Received: by 2002:a05:622a:303:: with SMTP id
 q3mr11442105qtw.24.1607636739363; 
 Thu, 10 Dec 2020 13:45:39 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:38 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: no need to call pci_ignore_hotplug for _PR3
Date: Thu, 10 Dec 2020 16:45:16 -0500
Message-Id: <20201210214518.704305-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201210214518.704305-1-alexander.deucher@amd.com>
References: <20201210214518.704305-1-alexander.deucher@amd.com>
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

The platform knows it's doing d3cold.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 90b8ce762aee..4f97d493eeda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1352,20 +1352,13 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (amdgpu_is_atpx_hybrid()) {
-			pci_ignore_hotplug(pdev);
-		} else {
+		if (!amdgpu_is_atpx_hybrid()) {
 			amdgpu_device_cache_pci_state(pdev);
 			pci_disable_device(pdev);
 			pci_ignore_hotplug(pdev);
 			pci_set_power_state(pdev, PCI_D3cold);
 		}
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
-	} else if (amdgpu_device_supports_boco(drm_dev)) {
-		/* Only need to handle PCI state in the driver for ATPX
-		 * PCI core handles it for _PR3.
-		 */
-		pci_ignore_hotplug(pdev);
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
