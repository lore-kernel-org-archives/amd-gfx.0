Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE56C55181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B473D206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gIWP5ilm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B473D206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80A226E9B0;
	Wed, 22 Apr 2020 06:54:56 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D9D4899A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 00:21:49 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id g74so688824qke.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 17:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dXUNQISf0T88Bj6Lj8KEYM0L0EwolOgRaHpyefYtmUk=;
 b=gIWP5ilmkmnLh/9NQ4YyFacAf5kT+bxEXkMSwIe/v0D2Ic/uYFKO3FaPeBpefOaLjP
 0WP4+VmSjV3Sf/jbcpkqFE+5CiDA2aMMdwfCGoFtIG1TLq3gdTwID80fz7GAZpFzfm+P
 3B1k0kODSc2crx4cbT2UNyZuA8iWvN2EBSF1KyPCpMrVWbJZBAL3QO5rMaD9RaiAiKVx
 MrGa53XEdZgZtT8fmp1PHyQUs81fwhw6ONIUu7XQ9wFZOZ2jNhdPzhvzaK8drXk5SDsm
 WOdpsQlR3Gp50p9NNVM8d1R506OI/BYArmq58KUhXYb1oCPDRv97xODXd3cpwxJr0E5d
 FmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dXUNQISf0T88Bj6Lj8KEYM0L0EwolOgRaHpyefYtmUk=;
 b=pw7rd04ZURVAxOTY4Bgz2aTx97V+j6nuSLZjsq260a/q6b1BvIKBPGyo5zumOVFkBJ
 zScfdA+hIBRkMKnIKPeIaTY16ffGg0RCNY40fAgoq4QIJ5kpqLvBfNZlXsE7ju3IiTsm
 vgcNiaCjVdqfz/BynJoX5qI7OjHNI1KNWJ1vfgFDDVcXIx49wKi5zAb/kqJxgXkHYHD3
 a5PZSKwIT8/B06f1wZRmkuyd2Ovwt0pLIXI5TVW9V7EHtSj9Fy/35H6l/sDekwMoWHzW
 R2oVFig+3MhWOmDlzq1GKRkbw/+0B7rnjh2kmn3XufRDAEqUEX+LcShs5C7BNp8pk/7b
 idbg==
X-Gm-Message-State: AGi0PuaVbt6+WlHIUwKCCgIaa64Hf+RalncmRwdbf5Vwy37wRrsH8tTg
 EBnps6zHTzmdXZo5uXKxCq1fJQ==
X-Google-Smtp-Source: APiQypKXSZmOfI1ovmhCRa4BWx0ruNS7ifeofBzvyBvIZ85CC1GrC+lD+aCIj59iOvBapC96nnzX1A==
X-Received: by 2002:a37:68cd:: with SMTP id
 d196mr23995404qkc.188.1587514908479; 
 Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id p10sm2821195qtu.14.2020.04.21.17.21.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jR398-0000B6-EG; Tue, 21 Apr 2020 21:21:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm 2/5] mm/hmm: make hmm_range_fault return 0 or -1
Date: Tue, 21 Apr 2020 21:21:43 -0300
Message-Id: <2-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 22 Apr 2020 06:54:54 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 amd-gfx@lists.freedesktop.org, John Hubbard <jhubbard@nvidia.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 =?utf-8?b?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jason Gunthorpe <jgg@mellanox.com>

hmm_vma_walk->last is supposed to be updated after every write to the
pfns, so that it can be returned by hmm_range_fault(). However, this is
not done consistently. Fortunately nothing checks the return code of
hmm_range_fault() for anything other than error.

More importantly last must be set before returning -EBUSY as it is used to
prevent reading an output pfn as an input flags when the loop restarts.

For clarity and simplicity make hmm_range_fault() return 0 or -ERRNO. Only
set last when returning -EBUSY.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  6 +++---
 include/linux/hmm.h                     |  2 +-
 mm/hmm.c                                | 25 +++++++++----------------
 5 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 4e3e9362afeb10..9924f2caa0184c 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -161,7 +161,7 @@ device must complete the update before the driver callback returns.
 When the device driver wants to populate a range of virtual addresses, it can
 use::
 
-  long hmm_range_fault(struct hmm_range *range);
+  int hmm_range_fault(struct hmm_range *range);
 
 It will trigger a page fault on missing or read-only entries if write access is
 requested (see below). Page faults use the generic mm page fault code path just
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6309ff72bd7876..efc1329a019127 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -852,12 +852,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	down_read(&mm->mmap_sem);
 	r = hmm_range_fault(range);
 	up_read(&mm->mmap_sem);
-	if (unlikely(r <= 0)) {
+	if (unlikely(r)) {
 		/*
 		 * FIXME: This timeout should encompass the retry from
 		 * mmu_interval_read_retry() as well.
 		 */
-		if ((r == 0 || r == -EBUSY) && !time_after(jiffies, timeout))
+		if ((r == -EBUSY) && !time_after(jiffies, timeout))
 			goto retry;
 		goto out_free_pfns;
 	}
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 645fedd77e21b4..c68e9317cf0740 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -536,7 +536,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 		.pfn_shift = NVIF_VMM_PFNMAP_V0_ADDR_SHIFT,
 	};
 	struct mm_struct *mm = notifier->notifier.mm;
-	long ret;
+	int ret;
 
 	while (true) {
 		if (time_after(jiffies, timeout))
@@ -548,8 +548,8 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 		down_read(&mm->mmap_sem);
 		ret = hmm_range_fault(&range);
 		up_read(&mm->mmap_sem);
-		if (ret <= 0) {
-			if (ret == 0 || ret == -EBUSY)
+		if (ret) {
+			if (ret == -EBUSY)
 				continue;
 			return ret;
 		}
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7475051100c782..0df27dd03d53d7 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -120,7 +120,7 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-long hmm_range_fault(struct hmm_range *range);
+int hmm_range_fault(struct hmm_range *range);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 280585833adfc1..4c7c396655b528 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -174,7 +174,6 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 	}
 	if (required_fault)
 		return hmm_vma_fault(addr, end, required_fault, walk);
-	hmm_vma_walk->last = addr;
 	return hmm_pfns_fill(addr, end, range, HMM_PFN_NONE);
 }
 
@@ -207,7 +206,6 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
-	hmm_vma_walk->last = end;
 	return 0;
 }
 #else /* CONFIG_TRANSPARENT_HUGEPAGE */
@@ -386,13 +384,10 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, pfns);
 		if (r) {
 			/* hmm_vma_handle_pte() did pte_unmap() */
-			hmm_vma_walk->last = addr;
 			return r;
 		}
 	}
 	pte_unmap(ptep - 1);
-
-	hmm_vma_walk->last = addr;
 	return 0;
 }
 
@@ -455,7 +450,6 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		for (i = 0; i < npages; ++i, ++pfn)
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
-		hmm_vma_walk->last = end;
 		goto out_unlock;
 	}
 
@@ -500,7 +494,6 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	for (; addr < end; addr += PAGE_SIZE, i++, pfn++)
 		range->pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				 cpu_flags;
-	hmm_vma_walk->last = end;
 	spin_unlock(ptl);
 	return 0;
 }
@@ -537,7 +530,6 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 		return -EFAULT;
 
 	hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
-	hmm_vma_walk->last = end;
 
 	/* Skip this vma and continue processing the next vma. */
 	return 1;
@@ -555,9 +547,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
  * hmm_range_fault - try to fault some address in a virtual address range
  * @range:	argument structure
  *
- * Return: the number of valid pages in range->pfns[] (from range start
- * address), which may be zero.  On error one of the following status codes
- * can be returned:
+ * Return: 0 or -ERRNO with one of the following status codes:
  *
  * -EINVAL:	Invalid arguments or mm or virtual address is in an invalid vma
  *		(e.g., device file vma).
@@ -572,7 +562,7 @@ static const struct mm_walk_ops hmm_walk_ops = {
  * This is similar to get_user_pages(), except that it can read the page tables
  * without mutating them (ie causing faults).
  */
-long hmm_range_fault(struct hmm_range *range)
+int hmm_range_fault(struct hmm_range *range)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
@@ -590,10 +580,13 @@ long hmm_range_fault(struct hmm_range *range)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		/*
+		 * When -EBUSY is returned the loop restarts with
+		 * hmm_vma_walk.last set to an address that has not been stored
+		 * in pfns. All entries < last in the pfn array are set to their
+		 * output, and all >= are still at their input values.
+		 */
 	} while (ret == -EBUSY);
-
-	if (ret)
-		return ret;
-	return (hmm_vma_walk.last - range->start) >> PAGE_SHIFT;
+	return ret;
 }
 EXPORT_SYMBOL(hmm_range_fault);
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
