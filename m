Return-Path: <SRS0=wWp/=3X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFDBC35247
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 16:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D709D20838
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2020 16:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="eINJVtQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D709D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 563BD6EC79;
	Mon,  3 Feb 2020 16:19:17 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 478FB6EC7A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2020 16:18:40 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id k6so14749063qki.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Feb 2020 08:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=ptdL8j4y4Nu0slWC9GMlqw2vupDc3jE8cCzq/d6QOxo=;
 b=eINJVtQOFasRcQUUhrRypp1cvIgGSB2uv66wDqp4LEqIw+IxE8nZFh8zR1m5xpcBNs
 asYRxtDshmiHoSfr1mRX75C2UKBJu2rdW11q9+Bv/5yr2fbQHpAax5CNnqgsso8HZU0v
 UyOp9uDe8Q5dKeQmicM7GjESp/71ZeaA3EeFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ptdL8j4y4Nu0slWC9GMlqw2vupDc3jE8cCzq/d6QOxo=;
 b=S0YSMPQLXPREd60b2EcWPVkHudJpTzN033QhzWDOeW4FrizVkwU4qbV28txONCJcaB
 J0ZZdlmXKJH3pqLXXiIaC/uTYbjhGhsoL9RSw6pAt74WmnYyB4uBqO4TIZY+2WLBU9az
 ly8kOG0bSHOl/Y7ECzMSkfX2dFbsCT/DX5vnOi6nIui6MfSFNPsYs0GxfKEgri7MAdUG
 zSLevwSUV7RpLHxFjoUj38ROzAOZPwqj7Xsikou72Nn1A8ZlqVtH2X3qCk/BRM7yOxM6
 JF5cG7sngdvla3r8JXtKiFP5Soq1q2dB9gI+L0dO2bNHMOVuq7jrdJSyW/q2497JbRfT
 4EKQ==
X-Gm-Message-State: APjAAAXnGTa7IJU8Cxxd3BDMx+ERBmyhjrMMqJgsdyIsWl+NQOFb/jF3
 reS6SiOqQRNZ5q+2oUnbJGeT
X-Google-Smtp-Source: APXvYqxDPyKmX7Xb7xJg3h+x7fg95e7oQwGe6vGn9t+4Xg/mY5Q8WpzfOarZKicAK8elQfsAEGxyDw==
X-Received: by 2002:a05:620a:306:: with SMTP id
 s6mr22664268qkm.469.1580746719156; 
 Mon, 03 Feb 2020 08:18:39 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
 by smtp.gmail.com with ESMTPSA id 8sm9530476qkm.92.2020.02.03.08.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 08:18:38 -0800 (PST)
From: Tianlin Li <tli@digitalocean.com>
To: kernel-hardening@lists.openwall.com
Subject: [PATCH v2] drm/radeon: have the callers of set_memory_*() check the
 return value
Date: Mon,  3 Feb 2020 10:18:27 -0600
Message-Id: <20200203161827.768-1-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 03 Feb 2020 16:19:16 +0000
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
Cc: David1.Zhou@amd.com, keescook@chromium.org, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Tianlin Li <tli@digitalocean.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Right now several architectures allow their set_memory_*() family of  
functions to fail, but callers may not be checking the return values.
If set_memory_*() returns with an error, call-site assumptions may be
infact wrong to assume that it would either succeed or not succeed at  
all. Ideally, the failure of set_memory_*() should be passed up the 
call stack, and callers should examine the failure and deal with it. 

Need to fix the callers and add the __must_check attribute. They also 
may not provide any level of atomicity, in the sense that the memory 
protections may be left incomplete on failure. This issue likely has a 
few steps on effects architectures:
1)Have all callers of set_memory_*() helpers check the return value.
2)Add __must_check to all set_memory_*() helpers so that new uses do  
not ignore the return value.
3)Add atomicity to the calls so that the memory protections aren't left 
in a partial state.

This series is part of step 1. Make drm/radeon check the return value of  
set_memory_*().

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
v2:
The hardware is too old to be tested on and the code cannot be simply
removed from the kernel, so this is the solution for the short term. 
- Just print an error when something goes wrong
- Remove patch 2.  
v1:
https://lore.kernel.org/lkml/20200107192555.20606-1-tli@digitalocean.com/
---
 drivers/gpu/drm/radeon/radeon_gart.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index f178ba321715..a2cc864aa08d 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -80,8 +80,9 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_uc((unsigned long)ptr,
-			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (set_memory_uc((unsigned long)ptr,
+			      rdev->gart.table_size >> PAGE_SHIFT))
+			DRM_ERROR("set_memory_uc failed.\n");
 	}
 #endif
 	rdev->gart.ptr = ptr;
@@ -106,8 +107,9 @@ void radeon_gart_table_ram_free(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_wb((unsigned long)rdev->gart.ptr,
-			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (set_memory_wb((unsigned long)rdev->gart.ptr,
+			      rdev->gart.table_size >> PAGE_SHIFT))
+			DRM_ERROR("set_memory_wb failed.\n");
 	}
 #endif
 	pci_free_consistent(rdev->pdev, rdev->gart.table_size,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
