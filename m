Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD68C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 08:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE28A10E765;
	Thu, 10 Feb 2022 08:30:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AB2510E767;
 Thu, 10 Feb 2022 07:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=nwQK8rTzBeKvGcrtCRWh1dh2jjlfr7yyGwSU0Am+w+s=; b=HpIhsMcgR2ml6ZX6xWqvoyf1/O
 JYbbjkJeGj+Vr2y7NNas0msPbsv7XIDfhYm/ASJ2vOYm9xc+NnDrDB5b9TDYBwhApZnQ8388w+VMC
 oV4R477KDNIdE8Lctpl7xV0S2GA4ZImCbTINY00BJFrJRL2sZxyRSw/y+xxkn1mK9yZh5vDkDDfJ7
 yE7oQ92FoD5PiopPrvkomGyl+xLc+e56mzByFPCIS0GaxRV2G2ppPSXe8bJsNC+nc+AlDD7noP8qw
 9ZyBl+/C/fiuzpkjde64hfsOYBI43MFjAHA922mCys8kjTfXl5CJIxWQRspbVqIlB6t/25F45NZLI
 YoiVjs8w==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI3su-002rtD-Me; Thu, 10 Feb 2022 07:28:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 09/27] mm: generalize the pgmap based page_free infrastructure
Date: Thu, 10 Feb 2022 08:28:10 +0100
Message-Id: <20220210072828.2930359-10-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 10 Feb 2022 08:30:06 +0000
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
Cc: nvdimm@lists.linux.dev, Ralph Campbell <rcampbell@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, dri-devel@lists.freedesktop.org,
 Karol Herbst <kherbst@redhat.com>, linux-mm@kvack.org,
 nouveau@lists.freedesktop.org, Felix Kuehling <Felix.Kuehling@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Ben Skeggs <bskeggs@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Key off on the existence of ->page_free to prepare for adding support for
more pgmap types that are device managed and thus need the free callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index fef5734d5e4933..e00ffcdba7b632 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_page(struct page *page)
 {
-	if (WARN_ON_ONCE(!is_device_private_page(page)))
+	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
 		return;
 
 	__ClearPageWaiters(page);
@@ -460,7 +460,7 @@ void free_zone_device_page(struct page *page)
 	mem_cgroup_uncharge(page_folio(page));
 
 	/*
-	 * When a device_private page is freed, the page->mapping field
+	 * When a device managed page is freed, the page->mapping field
 	 * may still contain a (stale) mapping value. For example, the
 	 * lower bits of page->mapping may still identify the page as an
 	 * anonymous page. Ultimately, this entire field is just stale
-- 
2.30.2

