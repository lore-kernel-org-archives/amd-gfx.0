Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7064C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Feb 2022 08:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2789E10E76D;
	Thu, 10 Feb 2022 08:30:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 048C710E73B;
 Thu, 10 Feb 2022 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=7uI2bTfpcOTLTk+KrcJikurcAksqjsw+XRiS8Yawqqk=; b=3Wbqe0umZ6f/LP/Uo4Cm4RDThe
 x/agOqt+JTMpLrw9W3WhW/lp1Ovl1oVBKX05xU9R74tUmeoiZT1ggPXQ0yxos0gi5Nm0SsGWmB09c
 MyZriqCfJF/1SVd0ncloYRT/fR95/NqVIzz9W2z/kzQIptpbQ6Cx9dlg+em/bn7OiXFYRguDlucz1
 8yE5Xn2me1G6fEdCD3IWqZ91+IHq/gwQx/D+1pkNGHCUUuyl3OL6FLYGTqCual0mNnzkwcC99e7QK
 eesoIj2HCuN+UURNXG9bzX4rc/LH72wmtBt4Ue+wcjuhNSQ7NeytibigEQ0pw0Qm7YAeeBGskACf+
 Y12SzM0A==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nI3sg-002rmD-Dz; Thu, 10 Feb 2022 07:28:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>,
 Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 04/27] mm: move free_devmap_managed_page to memremap.c
Date: Thu, 10 Feb 2022 08:28:05 +0100
Message-Id: <20220210072828.2930359-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Thu, 10 Feb 2022 08:30:05 +0000
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
 Ben Skeggs <bskeggs@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Alex Deucher <alexander.deucher@amd.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

free_devmap_managed_page has nothing to do with the code in swap.c,
move it to live with the rest of the code for devmap handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/mm.h |  1 -
 mm/memremap.c      | 21 +++++++++++++++++++++
 mm/swap.c          | 23 -----------------------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7b46174989b086..91dd0bc786a9ec 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1092,7 +1092,6 @@ static inline bool is_zone_movable_page(const struct page *page)
 }
 
 #ifdef CONFIG_DEV_PAGEMAP_OPS
-void free_devmap_managed_page(struct page *page);
 DECLARE_STATIC_KEY_FALSE(devmap_managed_key);
 
 static inline bool page_is_devmap_managed(struct page *page)
diff --git a/mm/memremap.c b/mm/memremap.c
index 5f04a0709e436e..55d23e9f5c04ec 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -501,4 +501,25 @@ void free_devmap_managed_page(struct page *page)
 	page->mapping = NULL;
 	page->pgmap->ops->page_free(page);
 }
+
+void put_devmap_managed_page(struct page *page)
+{
+	int count;
+
+	if (WARN_ON_ONCE(!page_is_devmap_managed(page)))
+		return;
+
+	count = page_ref_dec_return(page);
+
+	/*
+	 * devmap page refcounts are 1-based, rather than 0-based: if
+	 * refcount is 1, then the page is free and the refcount is
+	 * stable because nobody holds a reference on the page.
+	 */
+	if (count == 1)
+		free_devmap_managed_page(page);
+	else if (!count)
+		__put_page(page);
+}
+EXPORT_SYMBOL(put_devmap_managed_page);
 #endif /* CONFIG_DEV_PAGEMAP_OPS */
diff --git a/mm/swap.c b/mm/swap.c
index bcf3ac288b56d5..08058f74cae23e 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1153,26 +1153,3 @@ void __init swap_setup(void)
 	 * _really_ don't want to cluster much more
 	 */
 }
-
-#ifdef CONFIG_DEV_PAGEMAP_OPS
-void put_devmap_managed_page(struct page *page)
-{
-	int count;
-
-	if (WARN_ON_ONCE(!page_is_devmap_managed(page)))
-		return;
-
-	count = page_ref_dec_return(page);
-
-	/*
-	 * devmap page refcounts are 1-based, rather than 0-based: if
-	 * refcount is 1, then the page is free and the refcount is
-	 * stable because nobody holds a reference on the page.
-	 */
-	if (count == 1)
-		free_devmap_managed_page(page);
-	else if (!count)
-		__put_page(page);
-}
-EXPORT_SYMBOL(put_devmap_managed_page);
-#endif
-- 
2.30.2

