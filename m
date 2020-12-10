Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A15EC4167B
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99E823DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E823DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFA1E6EB73;
	Thu, 10 Dec 2020 21:45:41 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112716EB6F
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:41 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id bd6so3220984qvb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Nmsb9RyCDXcbEXdfXYJFiNY49Xf+30QfPdx+IUDAKEc=;
 b=V5typAYx3pgQ+Xn756miYK5orRIZMc+DbIMm4Fy8+Ns/+sdP5njCW/sEe8qLVjzq3M
 EbDPWTrw287jWVSxDKN31K2rZikue+jpf71Mjo3I8RwGDH7syblnD3IkQGZcH5XDnP6k
 aS9bzrOjVggUUrWJU4KHTMouHu+kUY8JoJAdKROZ6GIaBdjDS1SGmHQIN1MIkfhtmUlV
 vPY9cQU3mNTmKdvkBXzf5D5MEMsH3iKWAxnHl2He4VFolsvwrUxRzuPL9hsbo9Rm5zHx
 v1o+VpEHCQDW3fjvfsSY+FCPSJy+4jy+27SkqLGJGzKL5S1maMR7YP/4RXkGk3PPho24
 a4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Nmsb9RyCDXcbEXdfXYJFiNY49Xf+30QfPdx+IUDAKEc=;
 b=uM92YF5O3+dHK5GBHoxDV7DlPaWXQ/5GG6pqDEhzRLDdISbbs8xLPvUzeqMXQtUbLU
 hFUT8Zfw0c7U1kYN9+bZcJQ7VcSYPiHWKQRbvA95ahbGRwOosa18c2llR41Qrx00KZPV
 /Vgumc4mp+DkWdv8xHcujNfu5kSvQYIOmYbawN/XvqCC2NRJ5IdS5SgN/XuikHS4Qajs
 O5bykfGEDCl+4dj/td8+LGqTjzplN8YyFnBXKts7YlzMg8K76kVix63Gm0a95tYA7RFs
 9wsyzVKnHw4hAu6tGateg0q0LpzWSuiy3B1wX5BIXmbIGiwL/oejrEx2/Lm/fVU+YIq6
 /suw==
X-Gm-Message-State: AOAM533hyETbo/skQyC9L3Le/4T3M5JIHWnSxPMFUeRqPBGuOz13Z92X
 wpirmNk5o4eF3LkY4/O6Uff2me3iejw=
X-Google-Smtp-Source: ABdhPJx2usmtrUpkpDxD1RpMw/EZ9KqPx2+tlVmT/gjW02owWis/sKpiO9ZM0FWQ7IqEwWebWZVK2w==
X-Received: by 2002:a0c:b59a:: with SMTP id g26mr11351899qve.26.1607636740150; 
 Thu, 10 Dec 2020 13:45:40 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:39 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: simplify logic in atpx resume handling
Date: Thu, 10 Dec 2020 16:45:17 -0500
Message-Id: <20201210214518.704305-6-alexander.deucher@amd.com>
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

Simplify the logic in the runtime resume handling for
atpx

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4f97d493eeda..cac2724e7615 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1382,16 +1382,14 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
-		if (amdgpu_is_atpx_hybrid()) {
-			pci_set_master(pdev);
-		} else {
+		if (!amdgpu_is_atpx_hybrid()) {
 			pci_set_power_state(pdev, PCI_D0);
 			amdgpu_device_load_pci_state(pdev);
 			ret = pci_enable_device(pdev);
 			if (ret)
 				return ret;
-			pci_set_master(pdev);
 		}
+		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_boco(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
