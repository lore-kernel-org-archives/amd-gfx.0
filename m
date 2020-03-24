Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB1DC41621
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C53D120722
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TDaQ5NVT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C53D120722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 403356E451;
	Tue, 24 Mar 2020 08:14:14 +0000 (UTC)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F6BC6E43B
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 01:15:12 +0000 (UTC)
Received: by mail-qt1-x843.google.com with SMTP id d12so11252523qtj.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2020 18:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OW36Zq5O+nO4G7kBf9jtFzChA1mg5xP0SMOPJaW+Ny0=;
 b=TDaQ5NVTx16AjeAUiHW1dHB0M8wMkBgVSdm/NgVz28FL1JCJ2xpJScL7jgPwIOvPhb
 wIrSXyL/H/vSncDr5LSFkwUI3wPQuNi0dgonKvZTfr70EsJHxqQESjt6E5tq0ZGmSvTn
 x3mkjDvTpeJM3+/aBTbpmibwghhIIEiRvrfVGk+ftxskuavyEMOtwKi01NJzQzRMvFGV
 AxmWhcKB2gLyomOBTG3dof8s1USnL6cqGHocR/ZRFN2Ugw662kNLm0ujyQybygj5IOwg
 7LYql1qmZK1FVNbv2/1sQVPuB+YnquB31v016ocidkS0z4AKNEbX4QhKde34pDYXCVC1
 /Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OW36Zq5O+nO4G7kBf9jtFzChA1mg5xP0SMOPJaW+Ny0=;
 b=Jc3onTaQGh1A4kwoaEflA22BRRW8C4IASSf3AVYAS0B/8mIjkszFlsKIn4nGN7D7cA
 zT4kjHU7B2G1XZDOEwknCSX13/Nu13AYtT8zc1cJEXzzTEtJgaofVLb2L54UZUpcJqs7
 4/pNHa6F61X+9rcCgHnStZuMlbb9Xl2THCAo6L5Y9mgciL0LI7dDrQAL8l5izRIfWc0k
 9sYKjx2peaJHVQcPy3hxpj+K2KWR/xH0JUwYK+g5USp65RvlIB7RsBlNngC0n9mGeEo1
 7bZ4bGcQYP7TF0J9CXPdgC5JjkjBVk2qg0cBEEj5xNz4Aw0ihePMV3A8L/hpHmX1Kfi6
 UZeg==
X-Gm-Message-State: ANhLgQ2zgH33mbaHgKzKfGhHQXguIGJtdDvR9uvlXxhR6WlI3tYFAu4X
 7KFHN07yeFWvx4aW6q3Y1gejUQ==
X-Google-Smtp-Source: ADFU+vurHQiZGzEk93HjPq+6N40heuGQe7NvOLr4e4QabkbD2CpMkG/mXFOgr7duxLwEVOjRMxTPeA==
X-Received: by 2002:ac8:6c4e:: with SMTP id z14mr19233545qtu.138.1585012511661; 
 Mon, 23 Mar 2020 18:15:11 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id j85sm12549468qke.20.2020.03.23.18.15.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 23 Mar 2020 18:15:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jGY9u-0000qo-2Y; Mon, 23 Mar 2020 22:15:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 1/9] mm/hmm: remove pgmap checking for devmap pages
Date: Mon, 23 Mar 2020 22:14:49 -0300
Message-Id: <20200324011457.2817-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324011457.2817-1-jgg@ziepe.ca>
References: <20200324011457.2817-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 24 Mar 2020 08:14:14 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, John Hubbard <jhubbard@nvidia.com>,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jason Gunthorpe <jgg@mellanox.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

The checking boils down to some racy check if the pagemap is still
available or not. Instead of checking this, rely entirely on the
notifiers, if a pagemap is destroyed then all pages that belong to it must
be removed from the tables and the notifiers triggered.

Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 50 ++------------------------------------------------
 1 file changed, 2 insertions(+), 48 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index a491d9aaafe45d..3a2610e0713329 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -28,7 +28,6 @@
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
-	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	unsigned int		flags;
 };
@@ -196,19 +195,8 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		return hmm_vma_fault(addr, end, fault, write_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
-	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
-		if (pmd_devmap(pmd)) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
-				return -EBUSY;
-		}
+	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
-	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
 	hmm_vma_walk->last = end;
 	return 0;
 }
@@ -300,15 +288,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	if (fault || write_fault)
 		goto fault;
 
-	if (pte_devmap(pte)) {
-		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
-					      hmm_vma_walk->pgmap);
-		if (unlikely(!hmm_vma_walk->pgmap)) {
-			pte_unmap(ptep);
-			return -EBUSY;
-		}
-	}
-
 	/*
 	 * Since each architecture defines a struct page for the zero page, just
 	 * fall through and treat it like a normal page.
@@ -328,10 +307,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_fault(addr, end, fault, write_fault, walk);
@@ -418,16 +393,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
 	pte_unmap(ptep - 1);
 
 	hmm_vma_walk->last = addr;
@@ -491,20 +456,9 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap)) {
-				ret = -EBUSY;
-				goto out_unlock;
-			}
+		for (i = 0; i < npages; ++i, ++pfn)
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
-		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap = NULL;
-		}
 		hmm_vma_walk->last = end;
 		goto out_unlock;
 	}
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
