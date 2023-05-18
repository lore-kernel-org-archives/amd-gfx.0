Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8527C77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 13:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C43510E530;
	Thu, 18 May 2023 13:52:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5922910E0C0;
 Thu, 18 May 2023 13:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=EmRQGfHeg8vRHN+PK9lCLigpVOuY8ckpsdAJv1GA8Zw=; b=avc6nBv78DH1AuuPjp7z7GnBt5
 RwmtC4IpzJ8oCkAnJTUBmALmvWKKNn62OZmrgCtOK5yUINsUyfEr968N2GC83dF+/VqP5Wtnyh2Ux
 OPMQDBX48WKDD3svbbGLbMHfYv5DpmCL4gtBtFUcbqHN289MOTWdVJNmDTJ0crkGVUgkidfqAUB1m
 nEDt0sdfDpSrIIk+qlPcdjd+zQ2inPUhaVRhADNrQz2dzKzPWBWR6sGQjNz3Yfv5WvkUTRnVcvoTo
 gicM59uNSE7gXnA/K7PWgD+0/ynisIuYFvp76iuA07rVQQS789fcLCNU8qBoztq9qL/qxJ7QjqZZE
 iCnQNDmg==;
Received: from [2001:4bb8:188:3dd5:1149:8081:5f51:3e54] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pze2e-00D7RB-1j; Thu, 18 May 2023 13:51:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Subject: [PATCH] drm/amdgpu: stop including swiotlb.h
Date: Thu, 18 May 2023 15:51:38 +0200
Message-Id: <20230518135138.990475-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 18 May 2023 13:52:17 +0000
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
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu does not need swiotlb.h, so stop including it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2cd081cbf70621..385e04612e4e9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -38,7 +38,6 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
-#include <linux/swiotlb.h>
 #include <linux/dma-buf.h>
 #include <linux/sizes.h>
 #include <linux/module.h>
-- 
2.39.2

