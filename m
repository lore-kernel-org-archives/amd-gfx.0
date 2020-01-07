Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D643C282DD
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1AD20848
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="a3skjP/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1AD20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25B86E12F;
	Tue,  7 Jan 2020 19:41:31 +0000 (UTC)
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71FD56E83A
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 19:26:07 +0000 (UTC)
Received: by mail-yw1-xc42.google.com with SMTP id u139so196512ywf.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 11:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=maOi+ccdSCJ33tytaZ2VQyWTlm9roQsB2CYyKUcC3tE=;
 b=a3skjP/AmaWwBHZeZWluAghlXwxiT7Cj7kdIwSY35YoouSaTAle6gkkF+gWSQ43i5K
 B0GbiFcbbFVZraT3GERgOABL8Uc68kYFZIreZ/RiZRxaBPKz51UcdeY8c9TkW4rBxplO
 +ma4KhzsrQj/BcgUSva7gsUmK8tJO0k2NfeH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=maOi+ccdSCJ33tytaZ2VQyWTlm9roQsB2CYyKUcC3tE=;
 b=KsmzDdeLiIOgkJ5pRmOPfH4XdQx2wSyiMDt4UWuXoyJnN8pSLVTbbLIbyMEbYfVFA8
 odW+bpy1z+g6FfH0GCBm9x+XfcyEwuqA3XLmvRlk7w/9VYn5r+YWY2uwvdWmzz8aDMIm
 KBQq/BAnK3T3IR/ODh0wo5dafMYg+BULFemXvdemCsAaTqfu14HDTcBkpgXwDRgcbr4d
 0Am9EGSYx9LHuFPjYIsHeodV27xGALawQtVLZMJ1f1lzJZRnWSwXciTXK3SfJgDtAqMV
 iKVht/LfUGQiMuFVbggVVnxtlyJBjryTu1on4SXLO7XtqbC/kiynYDi7UQgcGWWgeuEw
 r2TQ==
X-Gm-Message-State: APjAAAWISgL9ESEPrLR9uJ24u4yhQ65vCDLVFLFQqe6oYp+4jb8kSD/5
 9V0DAZsg0vPtEJq5xFYIXRcO
X-Google-Smtp-Source: APXvYqwCwkS16hDGTInMHpIbsWfaGLyz0bdtQUZqjjL2wAm7ADS3K2eO1OR9tckNRyznHTSO/nu0Yg==
X-Received: by 2002:a81:ec01:: with SMTP id j1mr738569ywm.274.1578425166700;
 Tue, 07 Jan 2020 11:26:06 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
 by smtp.gmail.com with ESMTPSA id q124sm228047ywb.93.2020.01.07.11.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 11:26:06 -0800 (PST)
From: Tianlin Li <tli@digitalocean.com>
To: kernel-hardening@lists.openwall.com,
	keescook@chromium.org
Subject: [PATCH 2/2] drm/radeon: change call sites to handle return value
 properly.
Date: Tue,  7 Jan 2020 13:25:55 -0600
Message-Id: <20200107192555.20606-3-tli@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200107192555.20606-1-tli@digitalocean.com>
References: <20200107192555.20606-1-tli@digitalocean.com>
X-Mailman-Approved-At: Tue, 07 Jan 2020 19:41:31 +0000
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
Cc: David1.Zhou@amd.com, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Tianlin Li <tli@digitalocean.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ideally, the failure of set_memory_*() should be passed up the call stack,
and callers should examine the failure and deal with it. Fix those call 
sites in drm/radeon to handle retval properly. 
Since fini functions are always void, print errors for the failures.

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
 drivers/gpu/drm/radeon/r100.c  | 3 ++-
 drivers/gpu/drm/radeon/rs400.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 110fb38004b1..7eafe15ba124 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -706,7 +706,8 @@ void r100_pci_gart_fini(struct radeon_device *rdev)
 {
 	radeon_gart_fini(rdev);
 	r100_pci_gart_disable(rdev);
-	radeon_gart_table_ram_free(rdev);
+	if (radeon_gart_table_ram_free(rdev))
+		DRM_ERROR("radeon: failed free system ram for GART page table.\n");
 }
 
 int r100_irq_set(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/rs400.c b/drivers/gpu/drm/radeon/rs400.c
index 117f60af1ee4..de3674f5fe23 100644
--- a/drivers/gpu/drm/radeon/rs400.c
+++ b/drivers/gpu/drm/radeon/rs400.c
@@ -210,7 +210,8 @@ void rs400_gart_fini(struct radeon_device *rdev)
 {
 	radeon_gart_fini(rdev);
 	rs400_gart_disable(rdev);
-	radeon_gart_table_ram_free(rdev);
+	if (radeon_gart_table_ram_free(rdev))
+		DRM_ERROR("radeon: failed free system ram for GART page table.\n");
 }
 
 #define RS400_PTE_UNSNOOPED (1 << 0)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
