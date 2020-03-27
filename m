Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89570C2D0E5
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6376120716
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="B8VIl8Cs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6376120716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8FCE6EA7C;
	Fri, 27 Mar 2020 20:24:51 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 605186E0F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 20:00:29 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id v7so12236729qkc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=l6FSIJA11GUWp0iQEXEKmA47YraWhMsGW7mGBig6TKg=;
 b=B8VIl8CsE0i+yz5ktETkDbP6oCOwB9jFF8uCJ5FsWSqFmwjzIX+ImPVf858PHxOngZ
 ar1UKDakP5k672+PK0UTM50jgjlop3Up/AAzRr6TcXWAf6PymK/aYrFCVX+YRsLSHbWm
 BWMdTTu4lzuUPsSXRrv1YIzdXO6RBckMWW+1LFkz/8bclf6GpGihBt3R+5ir6kcwRwT4
 waTAzWqFFB7r/KeILUCDs+8sdRcwDLOUFMQx+DnVqZcxVqd475UoFYlunnDoT7OUmUWp
 4FXzV+aeAYANqWe0j4RUopm83PCyP3jcmVpMUqI/YhPVOy6WF4QHlKb3XvRoKGBXj7kS
 E7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=l6FSIJA11GUWp0iQEXEKmA47YraWhMsGW7mGBig6TKg=;
 b=VwEMv8zirYY9Si1WRgGL3pwSZ1CmNOQFXI4EypsbqpioTowk4jt0Aeg2ctlwzzoLDK
 3rb9Nk6PUXsHNUdTlew/tnL6IH+XpvRmO5SpwqvnDB0cJik9TbG8+KBkGpDMgAxPMtD7
 O8sgEYcVjTpt4e3NtDCmmnfEDadr81izJFjWGEGY2Inui8Q3UHbrRPdz7JapQTlKdqCW
 YbXDoUKN/NjCbi8cdFnWBwy1jfvM1386pnFV8l47C3TymME21QX4VmQYTTF6Gb3bK5uG
 q6l6CxVz/GPei3oFyWPrghTZgKHTQlIdlmMk7nIGy9tr3k9CxdC12U8OmOak11gWeRBy
 bB8Q==
X-Gm-Message-State: ANhLgQ1/tq8pd54cg46ERAL4qwGllnbHdNdEoO/8ItAZWiNIkZBbogUV
 GvdQB6pPh2vP2SL2ysLpeU9NRg==
X-Google-Smtp-Source: ADFU+vvf5lpmfE6Vv1KUN24OJu+znyEDbu+4t7Aq/PDfqWm3EIcAZ1pXP806ufmPt/PEbjgcavPE0g==
X-Received: by 2002:a37:aec2:: with SMTP id x185mr1076168qke.45.1585339228406; 
 Fri, 27 Mar 2020 13:00:28 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id j6sm4681752qti.25.2020.03.27.13.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 13:00:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jHv9U-0007fT-UC; Fri, 27 Mar 2020 17:00:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 1/9] mm/hmm: remove pgmap checking for devmap pages
Date: Fri, 27 Mar 2020 17:00:13 -0300
Message-Id: <20200327200021.29372-2-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200327200021.29372-1-jgg@ziepe.ca>
References: <20200327200021.29372-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 27 Mar 2020 20:24:43 +0000
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
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
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
