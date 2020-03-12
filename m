Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC991C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:32:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2E620663
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZnSBL2bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2E620663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 661426EADE;
	Thu, 12 Mar 2020 14:32:44 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 526096EAD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 14:27:51 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id e16so6452143qkl.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 07:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=shRWHqs3Ts2qBzMB/5rL3DjA67/CpxM/q+E+CLvtZCE=;
 b=ZnSBL2bCCP1DUi5JZ6itWwX0/LjmmIWz5msvQDRPn4+ACgobkUcU3+1tBcnk67QPLm
 +wPJ7l1W8rwNFrfYMTS9XHgWsiZfXR8E+Dcud6RbQ8+ipHGZItAza0Y69Ab54R+DvI1K
 iEeJ6hnU1FLyxFtH2oKziGx0r7qS0pQ6/dTNuUdSmWTncqoZYTJC27kb7tbCKCDRtvlD
 qg3cpSjrqHQgIoEhXthaqvUuLgqDjsPgAKoanR+6wMHXlaJO9C+dVWpovs4DXflBUkGS
 49vvu+V2F4ZTONoJNcaxzLwndPbcjE/9gSSySRVyu1fHdeED4odW9RB+sWtNuRAgcp9c
 h8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=shRWHqs3Ts2qBzMB/5rL3DjA67/CpxM/q+E+CLvtZCE=;
 b=tMY1gygiH3tpXrBoAfqa2Wli2d8qqQ20+D5UBp+j55rqm5cFxVDw6d6kQIJJN7dEbw
 EVzPPq8y4TB5O1Xkd90VvFrMjfcr3YPNW99FOS5XlO3gZ3zvgT1DeXgjMKefjQYfEA0F
 CVhKKnCTaYR3RW+FIaTBjtW3lEaR2RrFvr1iXbVjjXvTbhg0p/9c2kICu5w4Hl0+P3dd
 CZ031h2IZCm372XLMlkAvfdxF+0DGAcXRMzx81bb3sW/mnp3mPJwoAU1LmVDDrU1bklT
 UzCw2pJDA1V8PHQ2cdQRrKiCv1va0djmRD/iKJaKlSOr23eSe4HctA40fwzqa2ioYYpx
 hZMw==
X-Gm-Message-State: ANhLgQ1FE2R6arhOKeR9bglGXdLFDuvWG/3v2shPq6s42fBMRss9qHlT
 jxWgMhddl2Q2EvWXkeUr/xWeBg==
X-Google-Smtp-Source: ADFU+vtmGnz7Df/Lq8bjKyIpX/Lw1bKk1mSMVmS71keV3l9f13WdimMkf7ZbhjXd3ag3VOfi7iAUwg==
X-Received: by 2002:a37:2cc6:: with SMTP id s189mr8228780qkh.223.1584023270456; 
 Thu, 12 Mar 2020 07:27:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id x22sm6012019qki.54.2020.03.12.07.27.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 12 Mar 2020 07:27:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jCOoP-0006Z0-Fx; Thu, 12 Mar 2020 11:27:49 -0300
Date: Thu, 12 Mar 2020 11:27:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] mm/hmm: Simplify hmm_vma_walk_pud slightly
Message-ID: <20200312142749.GM31668@ziepe.ca>
References: <5bd778fa-51e5-3e0c-d9bb-b38539b03c8d@arm.com>
 <20200312102813.56699-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200312102813.56699-1-steven.price@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailman-Approved-At: Thu, 12 Mar 2020 14:32:43 +0000
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
Cc: Philip Yang <Philip.Yang@amd.com>, Ralph Campbell <rcampbell@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix.Kuehling@amd.com,
 amd-gfx@lists.freedesktop.org, linux-mm@kvack.org,
 Jerome Glisse <jglisse@redhat.com>, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 12, 2020 at 10:28:13AM +0000, Steven Price wrote:
> By refactoring to deal with the !pud_huge(pud) || !pud_devmap(pud)
> condition early it's possible to remove the 'ret' variable and remove a
> level of indentation from half the function making the code easier to
> read.
> 
> No functional change.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Thanks to Jason's changes there were only two code paths left using
> the out_unlock label so it seemed like a good opportunity to
> refactor.

Yes, I made something very similar, what do you think of this:

https://github.com/jgunthorpe/linux/commit/93f0ed42ab3f9ceb27b58fb7c7c3ecaf60f16b36

From 93f0ed42ab3f9ceb27b58fb7c7c3ecaf60f16b36 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Wed, 4 Mar 2020 17:11:10 -0400
Subject: [PATCH] mm/hmm: rework hmm_vma_walk_pud()

At least since commit 3afc423632a1 ("mm: pagewalk: add p4d_entry() and
pgd_entry()") this code has developed a number of strange control flows.

The purpose of the routine is to copy the pfns of a huge devmap PUD into
the pfns output array, without splitting the PUD. Everything that is not a
huge devmap PUD should go back to the walker for splitting.

Rework the logic to show this goal and remove redundant stuff:

- If pud_trans_huge_lock returns !NULL then this is already
  'pud_trans_huge() || pud_devmap()' and 'pud_huge() || pud_devmap()'
  so some of the logic is redundant.

- Hitting pud_none() is a race, treat it as such and return back to the
  walker using ACTION_AGAIN

- !pud_present() gives 0 cpu_flags, so the extra checks are redundant

- Once the *pudp is read there is no need to continue holding the pud
  lock, so drop it. The only thing the following code cares about is the
  pfn from the devmap, and if there is racing then the notifiers will
  resolve everything. Perhaps the unlocked READ_ONCE in an ealier version
  was correct

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 79 +++++++++++++++++++++++---------------------------------
 1 file changed, 33 insertions(+), 46 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 8fec801a33c9e2..87a376659b5ad4 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -455,66 +455,53 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	unsigned long addr = start;
+	unsigned long i, npages, pfn;
+	unsigned int required_fault;
+	uint64_t cpu_flags;
+	uint64_t *pfns;
+	spinlock_t *ptl;
 	pud_t pud;
-	int ret = 0;
-	spinlock_t *ptl = pud_trans_huge_lock(pudp, walk->vma);
 
+	/*
+	 * This only handles huge devmap pages, the default return is
+	 * ACTION_SUBTREE, so everything else is split by the walker and passed
+	 * to the other routines.
+	 */
+	ptl = pud_trans_huge_lock(pudp, walk->vma);
 	if (!ptl)
 		return 0;
+	pud = *pudp;
+	spin_unlock(ptl);
 
-	/* Normally we don't want to split the huge page */
-	walk->action = ACTION_CONTINUE;
-
-	pud = READ_ONCE(*pudp);
 	if (pud_none(pud)) {
-		spin_unlock(ptl);
-		return hmm_vma_walk_hole(start, end, -1, walk);
+		walk->action = ACTION_AGAIN;
+		return 0;
 	}
 
-	if (pud_huge(pud) && pud_devmap(pud)) {
-		unsigned long i, npages, pfn;
-		unsigned int required_flags;
-		uint64_t *pfns, cpu_flags;
-
-		if (!pud_present(pud)) {
-			spin_unlock(ptl);
-			return hmm_vma_walk_hole(start, end, -1, walk);
-		}
-
-		i = (addr - range->start) >> PAGE_SHIFT;
-		npages = (end - addr) >> PAGE_SHIFT;
-		pfns = &range->pfns[i];
+	if (!pud_devmap(pud))
+		return 0;
 
-		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
+	pfns = &range->pfns[(start - range->start) >> PAGE_SHIFT];
+	cpu_flags = pud_to_hmm_pfn_flags(range, pud);
+	required_fault =
 		hmm_range_need_fault(hmm_vma_walk, pfns, npages, cpu_flags);
-		if (required_flags) {
-			spin_unlock(ptl);
-			return hmm_vma_walk_hole_(addr, end, required_flags,
-						  walk);
-		}
+	if (required_fault)
+		return hmm_vma_walk_hole_(start, end, required_fault, walk);
 
-		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
-		for (i = 0; i < npages; ++i, ++pfn) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap)) {
-				ret = -EBUSY;
-				goto out_unlock;
-			}
-			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
-				  cpu_flags;
-		}
-		hmm_vma_walk->last = end;
-		goto out_unlock;
+	pfn = pud_pfn(pud) + ((start & ~PUD_MASK) >> PAGE_SHIFT);
+	npages = (end - start) >> PAGE_SHIFT;
+	for (i = 0; i < npages; ++i, ++pfn) {
+		hmm_vma_walk->pgmap = get_dev_pagemap(pfn, hmm_vma_walk->pgmap);
+		if (unlikely(!hmm_vma_walk->pgmap))
+			return -EBUSY;
+		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
 
-	/* Ask for the PUD to be split */
-	walk->action = ACTION_SUBTREE;
+	hmm_vma_walk->last = end;
 
-out_unlock:
-	spin_unlock(ptl);
-	return ret;
+	/* Do not split the pud */
+	walk->action = ACTION_CONTINUE;
+	return 0;
 }
 #else
 #define hmm_vma_walk_pud	NULL
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
