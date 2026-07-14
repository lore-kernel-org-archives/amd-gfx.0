Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE191C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 02:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6779710E111;
	Wed, 15 Jul 2026 02:42:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="XKXrb9tk";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BED9910E6D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 16:03:46 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7e6b554044fso3813332a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2026 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1784045026; x=1784649826;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9ibXv0ulhUDntCvVj8pMICIxyfabIumCYnSbx8w2FXU=;
 b=XKXrb9tkuu1+UTtrv/JjeAUNE2VSaNf0TtrdZbzcfQDawSZOU/dxTZJp+FmuQYkBH7
 XiKhLG5++/YqAZhtIZe/uJgSNFlahTiWSsh1Of8D+go341i0y7+jYCvouRNBYeHnZ8rf
 v9roLo2kO6lCACrdWTxEIiJoKescYb2eDGSiGtqH1arfOKFhL+h6Np/1vllOJnP2eLYl
 BHpdaeVZZ9Wk6lBccJsA7K+8jopC2fe0IJeG+t4pDPuw+xWqbx4tbBTBvj0melmlo4ZV
 Xk018KyVT/1iwlHV1f8JISH7mGviIkXTKXBXxL4HwyteJ5H/eG/zo3+1ArfrDtobnZyR
 zEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784045026; x=1784649826;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9ibXv0ulhUDntCvVj8pMICIxyfabIumCYnSbx8w2FXU=;
 b=bTcuzg96DavJ0LtNsgg/fgwiff/ouj0etlXRYkLQgIMMfUNdMy2z8rFCZFtNDuHZZL
 WodYqv76e2Z9XcQ5SuMAEUCHQWlTdFIAL6FpyhRoOKWGe5XnNhRmgQoWSJ15l4jn5Wae
 dJr5scJX3P/XNxI0JfCmcDH0fDkYkWQKHGaGf2eSFGaXetd66EB9mN22B8wq5MPPHkHS
 yqX+ytCiLiZMsnJ30A8ecoWKfiOrMJTCkfaX4YNSewQiX9mGSuTXy9oGSiI4MhOPqceg
 unQEvb+OLHBiuI432DNXQkGME1pqJfVM84wlGDCw1WizxSMEeZxAbW5kB0LXtNqapRTp
 7pPQ==
X-Gm-Message-State: AOJu0YwgyJC8kVSCF8bm9E4hxJnN7N/1INBJlkk/ZSEevwZ6vKPafYEN
 ZNScaj8ym+Ihb7/wnEYwo3+ttDmeJcsisuJ9HbaQmnJNcd7lYWID1jIL+4ekHveFm3d0h3NtRBK
 BcOESU5o=
X-Gm-Gg: AfdE7cmkupJgsRAk3tvV2lid68b0zckfwGDxHXwtMuGYj+LVQfAo7ch6Zs57wSSNFcJ
 KzJtlOjP7p0vm4yq86IkNZP93XFYNcwIQi155hzyBHoRRKHgdA3Gct+qM8p+wyJ5fNY2Viwd8kf
 JxgyJP89Rfk1mx7KAtlOfsp8V+ut6rh2mj1ruVFgVwpEYbhUlmhA+qXjRJDAsN+r+S4BbBuwcgh
 nKbv8hpMMGgoh3KAWu+o1AYkv3R6h0jZ4Ko7Qd5VVQP2Zq29zSFEJ0nvKARCus9+oqbTYzMqks0
 vuWDHdoiT1wdgOaoxshlvfbGIDq6WOL12wkN6LEKWIGMt+0cpGsO5ng2YVW9/SBkUgWqxj0lFzF
 csCZyosLFINF3VDjFP1SRcb4DD7dZj3Pvzprjj3THWzjB8jBZB0ETl1ZytbW/mdmfAiv1YUDRiG
 XgGlHJsecuynu8c2ELJLlf6CBpJMk2//vaOaMUimVLXAMz7cV750wOK9Oav5UI0DQ=
X-Received: by 2002:a05:6830:4424:b0:7e9:b4d0:df77 with SMTP id
 46e09a7af769-7ec4ac0b412mr1656858a34.31.1784045025668; 
 Tue, 14 Jul 2026 09:03:45 -0700 (PDT)
Received: from [10.200.24.107] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ebcb2bae7fsm16889735a34.21.2026.07.14.09.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 09:03:44 -0700 (PDT)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Date: Tue, 14 Jul 2026 11:03:26 -0500
Subject: [PATCH] drm/radeon: allocate dummy_page without DMA32 on fail
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-radeon_32bit_fix-v1-1-42a99945f6e0@oss.tenstorrent.com>
X-B4-Tracking: v=1; b=H4sIAM1dVmoC/yXM0QpAMBTG8VfRubbaxpBXkWR2cFyMNqS0dzdc/
 r76/jd4dIQe6uQGhyd5Wm2ESBMY5t5OyMhEg+Sy4KXImesNrrbLpKa9G+lilRZcVbowqhQQb5v
 DOH/Jpv3tD73gsL8dCOEBL+nlxHQAAAA=
X-Change-ID: 20260714-radeon_32bit_fix-8b1058b6d571
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Wed, 15 Jul 2026 02:42:34 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

radeon fails to probe on platforms that have all their memory above the
32-bit range with an -ENOMEM because dummy_page_init calls
alloc_page(GFP_DMA32), which would fail.

Allow this driver to work on such platforms by falling back to
ZONE_NORMAL regions. dma_map_page called subsequently would catch any
issues with the device being unable to DMA into the mapped page.

An equivalent fix was applied to ttm in commit 0a8c1feed387 ("drm/ttm:
allocate dummy_read_page without DMA32 on fail")

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
I had issues getting a R5 430 (Oland) with the radeon driver to probe on
a spacemit K3, which has no 32-bit memory regions. With this patch, the
driver was able to probe. The K3 supports up to 40 bit DMA and also has
an IOMMU, so the card works with the board. I was able to reach a
framebuffer console with this patch.
---
 drivers/gpu/drm/radeon/radeon_device.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 705c012fcf9e0..e8b1fa715a648 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -783,9 +783,15 @@ int radeon_dummy_page_init(struct radeon_device *rdev)
 {
 	if (rdev->dummy_page.page)
 		return 0;
-	rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO);
-	if (rdev->dummy_page.page == NULL)
-		return -ENOMEM;
+	rdev->dummy_page.page = alloc_page(GFP_DMA32 | GFP_KERNEL | __GFP_ZERO |
+				    __GFP_NOWARN);
+	/* Retry without GFP_DMA32 for platforms where DMA32 is not available */
+	if (rdev->dummy_page.page == NULL) {
+		rdev->dummy_page.page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		if (rdev->dummy_page.page == NULL)
+			return -ENOMEM;
+		dev_warn(&rdev->pdev->dev, "Falling back to non-DMA32 dummy page allocation\n");
+	}
 	rdev->dummy_page.addr = dma_map_page(&rdev->pdev->dev, rdev->dummy_page.page,
 					0, PAGE_SIZE, DMA_BIDIRECTIONAL);
 	if (dma_mapping_error(&rdev->pdev->dev, rdev->dummy_page.addr)) {

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260714-radeon_32bit_fix-8b1058b6d571

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>

