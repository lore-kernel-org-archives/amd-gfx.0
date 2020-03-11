Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA3C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1A420575
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Obbz1qB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1A420575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B4F6E9E3;
	Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF8C6E9E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:35:19 +0000 (UTC)
Received: by mail-qt1-x844.google.com with SMTP id l21so2336304qtr.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uygKHmkoF/XJeHmET22wDgQZ4IaJVIkBqpHNgU4CsJM=;
 b=Obbz1qB+tB3LW2qPkKBSaSvBXS0QAxokU4EYzwIOqtm8mh2BUcwkjBK401WkLDG3qN
 maRWjYJWBrWo0yx7uPmbBEL9/OzQfBwoxFIjDiIZ4OOTuIIkTb0vfXIeIFlufr44gvy8
 ozDGUwJ+AScwhg3khplp06oZj8CIkNUNOOOSsNf9UpdHapwBkULUpPjYH90BGR4d5ybZ
 l2D7tGyYQL+lxEibzC81pQq/n5FVYiBCvnO3s8o0YZ74E2FigGT6Ku4BH3nFtHmoRzsv
 Y1UQAMgsdkUeEyDQRU6R2V+PqPmV9Io8KFSEaRkCEdGoEN79gzAbDpSPiBBGoLfSwi6k
 0GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uygKHmkoF/XJeHmET22wDgQZ4IaJVIkBqpHNgU4CsJM=;
 b=c52f4h2yjVVVrnTnO/1mxyFnuQuHxJymlLMnazOvoHLSxvnMQ5ENE1hyoPSr1g/3jD
 KqB/D2tbSdl2enwBgHAQBAOWIr31fktOloeovulvn88gw5wR3LDXnDJOOgvMyHywVTVo
 lYb9gFknQy393ZdZ5+XnBX5g41t0eSWWJe/bVGGWnOh3Jy5CeDJ1gSFztQirMTsorePB
 ogRpAdEQcKFXNFt6jNHIVISimwAWvmg6o+D2fP2pCA7cH5s5nW8OQtWOy+3zlMZkmPJJ
 nEIeSIoOSxQNFh9np8Zfig8Bp+8DJDqWfYPZ7HgLPx1nFJT6hExV9NJjK2uVPqnrWzu+
 tysQ==
X-Gm-Message-State: ANhLgQ0INDbAly7XckoZrqgI1yBpQbW+WzO0DSq06WgbRF2gL36sKKR1
 TUzm5rhKcFlcAgoDzvvBkLQo1A==
X-Google-Smtp-Source: ADFU+vuxi2jwTZNWP7BbaHt9jLf2pO1O8MStIxhR8zwOb6icVa77ppaQhtJcOJ1hj7G1PBtoZXjjag==
X-Received: by 2002:ac8:b43:: with SMTP id m3mr3894888qti.191.1583951718521;
 Wed, 11 Mar 2020 11:35:18 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id g22sm11074847qtp.8.2020.03.11.11.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jC6CJ-00016j-CP; Wed, 11 Mar 2020 15:35:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 7/8] mm/hmm: return -EFAULT when setting HMM_PFN_ERROR on
 requested valid pages
Date: Wed, 11 Mar 2020 15:35:05 -0300
Message-Id: <20200311183506.3997-8-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311183506.3997-1-jgg@ziepe.ca>
References: <20200311183506.3997-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 11 Mar 2020 19:14:38 +0000
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

hmm_range_fault() should never return 0 if the caller requested a valid
page, but the pfns output for that page would be HMM_PFN_ERROR.

hmm_pte_need_fault() must always be called before setting HMM_PFN_ERROR to
detect if the page is in faulting mode or not.

Fix two cases in hmm_vma_walk_pmd() and reorganize some of the duplicated
code.

Fixes: d08faca018c4 ("mm/hmm: properly handle migration pmd")
Fixes: da4c3c735ea4 ("mm/hmm/mirror: helper to snapshot CPU page table")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index bf676cfef3e8ee..f61fddf2ef6505 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -363,8 +363,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	uint64_t *pfns = range->pfns;
-	unsigned long addr = start, i;
+	uint64_t *pfns = &range->pfns[(start - range->start) >> PAGE_SHIFT];
+	unsigned long npages = (end - start) >> PAGE_SHIFT;
+	unsigned long addr = start;
+	bool fault, write_fault;
 	pte_t *ptep;
 	pmd_t pmd;
 
@@ -374,14 +376,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
 	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
-		bool fault, write_fault;
-		unsigned long npages;
-		uint64_t *pfns;
-
-		i = (addr - range->start) >> PAGE_SHIFT;
-		npages = (end - addr) >> PAGE_SHIFT;
-		pfns = &range->pfns[i];
-
 		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
 				     0, &fault, &write_fault);
 		if (fault || write_fault) {
@@ -390,8 +384,15 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 			return -EBUSY;
 		}
 		return hmm_pfns_fill(start, end, range, HMM_PFN_NONE);
-	} else if (!pmd_present(pmd))
+	}
+
+	if (!pmd_present(pmd)) {
+		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
+				     &write_fault);
+		if (fault || write_fault)
+			return -EFAULT;
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+	}
 
 	if (pmd_devmap(pmd) || pmd_trans_huge(pmd)) {
 		/*
@@ -408,8 +409,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
 
-		i = (addr - range->start) >> PAGE_SHIFT;
-		return hmm_vma_handle_pmd(walk, addr, end, &pfns[i], pmd);
+		return hmm_vma_handle_pmd(walk, addr, end, pfns, pmd);
 	}
 
 	/*
@@ -418,15 +418,19 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	 * entry pointing to pte directory or it is a bad pmd that will not
 	 * recover.
 	 */
-	if (pmd_bad(pmd))
+	if (pmd_bad(pmd)) {
+		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
+				     &write_fault);
+		if (fault || write_fault)
+			return -EFAULT;
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
+	}
 
 	ptep = pte_offset_map(pmdp, addr);
-	i = (addr - range->start) >> PAGE_SHIFT;
-	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
+	for (; addr < end; addr += PAGE_SIZE, ptep++, pfns++) {
 		int r;
 
-		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
+		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, pfns);
 		if (r) {
 			/* hmm_vma_handle_pte() did pte_unmap() */
 			hmm_vma_walk->last = addr;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
