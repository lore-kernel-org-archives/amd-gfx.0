Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C183AC77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 13:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5CA10E510;
	Thu, 18 May 2023 13:52:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1022810E510;
 Thu, 18 May 2023 13:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=tmSC+u5VhzmfTNx+ADgm1WGVdMNl+yJUyISb/dtcmj4=; b=pShZIdXcD+iYYQ8v6jjfq8NKIZ
 +2RC86gVIq0u0eQJzQdC4zGivqEw70m2sqN3XwRgiw+494udon3xzZUut9CgTkei9ozZy9QXpUruq
 pZOQM4Ehqlanb0MqDPVMz0B/Em7/KL4QhpeSCgYzmhP4/Y2OuPJ3ZpHE2WabYrgyZpbbuuD1UsjwJ
 dIAV4TdfZXPifQNzsLP8RqyQSSuXad33lHd/niaLdLgBfW8zA4ybOaiXU7CGhqoE0kV9BXTzehm1J
 YHwLXBRovXQGiSLUKk9xYm7lJv7VFwj3+igwQbpz5T6B4E4M1lfFhOuOijaHQUzb64JcPb7v3Gqhc
 w56GMrpA==;
Received: from [2001:4bb8:188:3dd5:1149:8081:5f51:3e54] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1pze38-00D7V7-1C; Thu, 18 May 2023 13:52:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com
Subject: [PATCH] drm/radeon: stop including swiotlb.h
Date: Thu, 18 May 2023 15:52:08 +0200
Message-Id: <20230518135208.996214-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 18 May 2023 13:52:22 +0000
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

radeon does not need swiotlb.h, so stop including it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 2220cdf6a3f680..04df08356d553f 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -36,7 +36,6 @@
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/swap.h>
-#include <linux/swiotlb.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
-- 
2.39.2

