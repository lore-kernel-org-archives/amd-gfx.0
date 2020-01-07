Return-Path: <SRS0=EvZE=24=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F6BC33C9E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5917120848
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jan 2020 19:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="RBjyUZwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5917120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0F786E083;
	Tue,  7 Jan 2020 19:41:31 +0000 (UTC)
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com
 [IPv6:2607:f8b0:4864:20::c44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A9C6E83B
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jan 2020 19:26:05 +0000 (UTC)
Received: by mail-yw1-xc44.google.com with SMTP id 10so221197ywv.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jan 2020 11:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=digitalocean.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=tQjRs3gNjU2oRCRkkGnPvWhg7epwoT3OSGkU89AkxDQ=;
 b=RBjyUZwp3oCaYSH4lBnXhf98sJuriMFFB8O7XKfK7ldWb6ngmv2f9qtFr6pCkkxgGw
 7CXrDYukjNwKP67z0Lw1byh8GcFRee92q4Li3sqQ/YUX/yWYSTzzPS0CWi7nplUTz0tb
 Jc7R/IvQnQExyScOkuyYIt2H8ViWXed3K25ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=tQjRs3gNjU2oRCRkkGnPvWhg7epwoT3OSGkU89AkxDQ=;
 b=FsrAwyg/Uc4nDncpkdyfKqsZW4LkAI9ayYgPkBbqW5Rlv63VMk52XZtDHNwLvaFK2Z
 U8EQ2MFyOgp2GIcNvL/+TF2Os+lH/qG317Q6ynECedU4N4gBvIwH+j0bja23q85LcZsj
 32wSVRiWALdZ3QKY+qxKtolvc37MGKpyGBwTryloMTberQ9URnvqNIbwEkjFD2zZZg5a
 rx9/jTEZmvvarJAroEJsfKDXt2OqbrrDe7+9+uSrCwTiJc3OWahMLknm0FpJCz2XpGe+
 t3ozy8OUYdEUAbZgUHASQu3l8tu3TEj6DU9GNYNfjVXptHLQYkBsAIOSpa1UmhWCXHuY
 6D3w==
X-Gm-Message-State: APjAAAURZviP9xnzMzbaNFROEKAqGXY8DGqk5RPDG94hxw3zKbrlEBO3
 etfW/y4xAvTLxwYxE5efn1Rm
X-Google-Smtp-Source: APXvYqxUxZ+QGpsSnWO2wfDZLiBGzqQSyJZLkZZl9iPaevdfkH2M+Sp/oQ3CIezE7wg13+qNsbCYpQ==
X-Received: by 2002:a81:9c14:: with SMTP id m20mr702845ywa.143.1578425164670; 
 Tue, 07 Jan 2020 11:26:04 -0800 (PST)
Received: from tina-kpatch ([162.243.188.76])
 by smtp.gmail.com with ESMTPSA id e131sm229025ywb.81.2020.01.07.11.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2020 11:26:04 -0800 (PST)
From: Tianlin Li <tli@digitalocean.com>
To: kernel-hardening@lists.openwall.com,
	keescook@chromium.org
Subject: [PATCH 1/2] drm/radeon: have the callers of set_memory_*() check the
 return value
Date: Tue,  7 Jan 2020 13:25:54 -0600
Message-Id: <20200107192555.20606-2-tli@digitalocean.com>
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

Have the callers of set_memory_*() in drm/radeon check the return value.
Change the return type of the callers properly. 

Signed-off-by: Tianlin Li <tli@digitalocean.com>
---
 drivers/gpu/drm/radeon/radeon.h      |  2 +-
 drivers/gpu/drm/radeon/radeon_gart.c | 22 ++++++++++++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 30e32adc1fc6..a23e58397293 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -661,7 +661,7 @@ struct radeon_gart {
 };
 
 int radeon_gart_table_ram_alloc(struct radeon_device *rdev);
-void radeon_gart_table_ram_free(struct radeon_device *rdev);
+int radeon_gart_table_ram_free(struct radeon_device *rdev);
 int radeon_gart_table_vram_alloc(struct radeon_device *rdev);
 void radeon_gart_table_vram_free(struct radeon_device *rdev);
 int radeon_gart_table_vram_pin(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_gart.c b/drivers/gpu/drm/radeon/radeon_gart.c
index d4d3778d0a98..59039ab602e8 100644
--- a/drivers/gpu/drm/radeon/radeon_gart.c
+++ b/drivers/gpu/drm/radeon/radeon_gart.c
@@ -71,6 +71,7 @@
 int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 {
 	void *ptr;
+	int ret;
 
 	ptr = pci_alloc_consistent(rdev->pdev, rdev->gart.table_size,
 				   &rdev->gart.table_addr);
@@ -80,8 +81,16 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_uc((unsigned long)ptr,
+		ret = set_memory_uc((unsigned long)ptr,
 			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (ret) {
+			pci_free_consistent(rdev->pdev, rdev->gart.table_size,
+						(void *)rdev->gart.ptr,
+						rdev->gart.table_addr);
+			rdev->gart.ptr = NULL;
+			rdev->gart.table_addr = 0;
+			return ret;
+		}
 	}
 #endif
 	rdev->gart.ptr = ptr;
@@ -98,16 +107,20 @@ int radeon_gart_table_ram_alloc(struct radeon_device *rdev)
  * (r1xx-r3xx, non-pcie r4xx, rs400).  These asics require the
  * gart table to be in system memory.
  */
-void radeon_gart_table_ram_free(struct radeon_device *rdev)
+int radeon_gart_table_ram_free(struct radeon_device *rdev)
 {
+	int ret;
+
 	if (rdev->gart.ptr == NULL) {
-		return;
+		return 0;
 	}
 #ifdef CONFIG_X86
 	if (rdev->family == CHIP_RS400 || rdev->family == CHIP_RS480 ||
 	    rdev->family == CHIP_RS690 || rdev->family == CHIP_RS740) {
-		set_memory_wb((unsigned long)rdev->gart.ptr,
+		ret = set_memory_wb((unsigned long)rdev->gart.ptr,
 			      rdev->gart.table_size >> PAGE_SHIFT);
+		if (ret)
+			return ret;
 	}
 #endif
 	pci_free_consistent(rdev->pdev, rdev->gart.table_size,
@@ -115,6 +128,7 @@ void radeon_gart_table_ram_free(struct radeon_device *rdev)
 			    rdev->gart.table_addr);
 	rdev->gart.ptr = NULL;
 	rdev->gart.table_addr = 0;
+	return 0;
 }
 
 /**
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
