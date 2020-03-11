Return-Path: <SRS0=Izb8=44=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A4BC0044D
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 747AA20575
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W2QcOA29"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 747AA20575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13AD16E4E8;
	Wed, 11 Mar 2020 19:14:39 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D9AF6E9E4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 18:35:20 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id u25so3122150qkk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2020 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8lEcVZbpC6FaqZy+Eys87JwANFXrjLZWV2hXSwo7DsY=;
 b=W2QcOA29+2hWCo5dDy/jbUb7GhqQlmsnMJZk/cECcBgqjRYGVtdV2RyzDV9agkzEDY
 kdGVL25lhvr2y1TCNOvtamw6p7HliGBbQOlw5wyKr5k01cZPcqO3bX8bYmGwGbdVbjzZ
 Qw2Q7wpYrxD4X6zOi2KLFKH5EiBC1WW9a0e7B7cX60TfFbRpaDvpECRZsYahA2FgOPcC
 l8evX/8XNukV9x7I9e6WmEE8SxUhCDwQ8vktxGPhdfd+O1KaOqLDUEEevOUGpLT1R1G+
 iwi43ZEr6GqkZtDpl7jhMmGOTb/j9MRuywyNP2Pf72IzWStQ2oSvqU+oCwVTGUwoilMP
 KaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8lEcVZbpC6FaqZy+Eys87JwANFXrjLZWV2hXSwo7DsY=;
 b=mBjhXP4rg1QTBuDUnb0leyr9IZEkgGoofr4epJbjXcWMHQbm35FM/L2vtoGFyW3Z8S
 hSCyhZxs0YNLvL95e8+VLt8vA+ZYZhkHKKqPXAOrXljFvpcMPTWZI9agmcaZfBEHmMHW
 QVNMaNdFjliZulAgskcxXOFfzCxkjQ4Mbv5Jn0gK0jxO1MYniP90VNi/pySVY0CGRGkf
 cnWxaCAt/sDWd0sEbwwoltcObmWcd/4FII1gUAnTcWDM4VY7Zk26tm1e6DVPPb9t6r4T
 Uthfl0l7hDr9q06KrCyHL4C546bjPy0wG/HbxqkaauQa5DYF1gagqvO6ENBC9/sSLYF2
 7VDg==
X-Gm-Message-State: ANhLgQ1oXw1rOIEr/8IsEs3LqsyBdiROuuNqIM58xZf6LKE16xx5rO2+
 na+XjFMPE+QGxEnsZRBLodgCmQ==
X-Google-Smtp-Source: ADFU+vv42iIVOVgQYb8TOc186/XWa+snYITfoBWnXSMFRcjaqugUYatuGxkE3I0VXu08rjERKTHgkg==
X-Received: by 2002:a05:620a:134a:: with SMTP id
 c10mr4076890qkl.188.1583951719448; 
 Wed, 11 Mar 2020 11:35:19 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id d73sm7995274qkg.113.2020.03.11.11.35.15
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 11:35:16 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jC6CJ-00016F-3B; Wed, 11 Mar 2020 15:35:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH  hmm 2/8] mm/hmm: don't free the cached pgmap while scanning
Date: Wed, 11 Mar 2020 15:35:00 -0300
Message-Id: <20200311183506.3997-3-jgg@ziepe.ca>
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

The pgmap is held in the hmm_vma_walk variable in hope of speeding up
future get_dev_pagemap() calls by hitting the same pointer. The algorithm
doesn't actually care about how long the pgmap is held for.

Move the put of the cached pgmap to after the walk is completed and delete
all the other now redundant puts.

This solves a possible leak of the reference in hmm_vma_walk_pmd() if a
hmm_vma_handle_pte() fails while looping.

Fixes: 992de9a8b751 ("mm/hmm: allow to mirror vma of a file on a DAX backed filesystem")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 31 +++++++++----------------------
 1 file changed, 9 insertions(+), 22 deletions(-)

We talked about just deleting this stuff, but I think it makes alot sense for
hmm_range_fault() to trigger fault on devmap pages that are not compatible
with the caller - so lets just fix the leak on error path for now.

diff --git a/mm/hmm.c b/mm/hmm.c
index 35f85424176d14..9e8f68eb83287a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -239,10 +239,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 		}
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
 	hmm_vma_walk->last = end;
 	return 0;
 }
@@ -360,10 +356,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -446,16 +438,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
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
@@ -529,10 +511,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap = NULL;
-		}
 		hmm_vma_walk->last = end;
 		goto out_unlock;
 	}
@@ -694,6 +672,15 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		/*
+		 * A pgmap is kept cached in the hmm_vma_walk to avoid expensive
+		 * searching in the probably common case that the pgmap is the
+		 * same for the entire requested range.
+		 */
+		if (hmm_vma_walk.pgmap) {
+			put_dev_pagemap(hmm_vma_walk.pgmap);
+			hmm_vma_walk.pgmap = NULL;
+		}
 	} while (ret == -EBUSY);
 
 	if (ret)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
