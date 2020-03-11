Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F34C2BB1D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0761220575
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VUmp9gXg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0761220575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B14FD6E9EA;
	Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AF46E9E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:35:16 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id f198so3074245qke.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uADmryRzUppwT0DoGC+vBgxjUH6ONtG4PbQCGFnnObM=;
 b=VUmp9gXg3gFFyzdp3BYqvtlRiDQuHpwTyPbJtafqR5nqzevoh+CJyh9Tmk0l1rtePV
 BQbOyou6HXXPi0MIBkFBd/nDlZ7zW6oaWhgYkg1746g6vTjLUc4zchtLbTk5u6rlJFcH
 OqI/UsNrU0c1qnzSRe+90EsTnAep6Cxv9sDTgutpePZ2ftbb4+r2vBajlqvQ/FtfH2WQ
 tcRgrS0PSKtpdfnaJFY1e10PVH+8BMdvSdmZ03GeCrZjItWXejdM+25Q9PumbjfaRSBO
 Tl6c+VS+Z2ou82HkY5RIOvzff/ouDGE/WNAnF+hBwzsCmqGcMlKT5IZzkHUBtySUT505
 m+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uADmryRzUppwT0DoGC+vBgxjUH6ONtG4PbQCGFnnObM=;
 b=DGWIzx0B2ZhA4sOgkMh0C3FS1nsk7DGm44Ue8jNnikB8ciW6lcVt2UNhCzxOunwTsU
 9QBbXKqQWN/qN0/lRkXXunbUqFc4EqI+fd24m2Vv0uvvFPfUCD+mJ1rzkiEJt30w2I8Y
 isZMHW6Jo+av7XL96g+gxXnacQwZrz7FyU9mpFWjW4U0geT1FjElwRkwHjcP7BWLHmqm
 qEwwdSpgIt2Hhzcxt0/jAUBRzv2xc9v7Y3E6aOTUFL3p/OFZBU/KOG3QEYrpfLZYiWuN
 fRQokKrezjuttWS5bLL7LJSdFt1vbi34m8SIJ0ueSxy2mC0Fg1+DsDCX/L3f2A3Im66A
 VwKQ==
X-Gm-Message-State: ANhLgQ0NLKFbv6+L1KCQFRv8fPZ+dXNIBftWDupuhPNIICvelvWX6HAj
 6VfuT+Z7/3rqfEariqN0f94QCQ==
X-Google-Smtp-Source: ADFU+vu4pkafRt7ZpiQA2Qo9TSkli2LPgyls9Ykw3IxuaySmx8qfnahDqH8g+HMF46wNbf60JV5d8Q==
X-Received: by 2002:a05:620a:11b3:: with SMTP id
 c19mr4218673qkk.296.1583951715965; 
 Wed, 11 Mar 2020 11:35:15 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id c40sm5273938qtk.18.2020.03.11.11.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 11:35:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jC6CJ-000168-0X; Wed, 11 Mar 2020 15:35:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 1/8] mm/hmm: add missing unmaps of the ptep during
 hmm_vma_handle_pte()
Date: Wed, 11 Mar 2020 15:34:59 -0300
Message-Id: <20200311183506.3997-2-jgg@ziepe.ca>
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

Many of the direct returns of error skipped doing the pte_unmap(). All non
zero exit paths must unmap the pte.

The pte_unmap() is split unnaturally like this because some of the error
exit paths trigger a sleep and must release the lock before sleeping.

Fixes: 992de9a8b751 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
Fixes: 53f5c3f489ec ("mm/hmm: factor out pte and pmd handling to simplify hmm_vma_walk_pmd()")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 72e5a6d9a41756..35f85424176d14 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -325,6 +325,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		}
 
 		/* Report error for everything else */
+		pte_unmap(ptep);
 		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
 	} else {
@@ -339,10 +340,13 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	if (pte_devmap(pte)) {
 		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
 					      hmm_vma_walk->pgmap);
-		if (unlikely(!hmm_vma_walk->pgmap))
+		if (unlikely(!hmm_vma_walk->pgmap)) {
+			pte_unmap(ptep);
 			return -EBUSY;
+		}
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		if (!is_zero_pfn(pte_pfn(pte))) {
+			pte_unmap(ptep);
 			*pfn = range->values[HMM_PFN_SPECIAL];
 			return -EFAULT;
 		}
@@ -437,7 +441,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 
 		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
 		if (r) {
-			/* hmm_vma_handle_pte() did unmap pte directory */
+			/* hmm_vma_handle_pte() did pte_unmap() */
 			hmm_vma_walk->last = addr;
 			return r;
 		}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
