Return-Path: <SRS0=mrdw=6P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E1CC47253
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 19:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD733216FD
	for <amd-gfx@archiver.kernel.org>; Fri,  1 May 2020 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YoPQ7p3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD733216FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83C716ED3E;
	Fri,  1 May 2020 19:08:04 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93456ED29
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 May 2020 18:20:51 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id f83so2698635qke.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 May 2020 11:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LoRnv3MJMcc5R6wMX7ungIenWv5IUWDZm/Clv25vaHM=;
 b=YoPQ7p3DgSN6JbL1dnHTqtWXFzHMMLbQhH8TlbK78XgMlRTwjTbRgMVww0HyP9XQ9x
 BLVwOgDq23eZkLWlrjWjNoGjIpFe7BKs60me3V+ElNn9Tkf0n5KgKKp/Sp/nxYnjNvR/
 KkB2PqnPgEa7uaW2INGkLNDWYN4e+Xpcml6wHXsxisJ31etdCbGgisP6csrT1wLlHLqN
 Dp+UOuUAVFRc1GkoV5i4mdxfeLRMonR52AR/SFZkVxlNrDMEiSDjkU3kDNSqdVLLvaX2
 39eL3p294dxNWnivxacW3r7eU9u+O361CSi4gCysksoU4rJq0qu1HB9cEwBvFXssowZG
 fskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LoRnv3MJMcc5R6wMX7ungIenWv5IUWDZm/Clv25vaHM=;
 b=oOds0dYZd+uBMDF/oDMZhR1xfScc7q7LrcfgaQ6JSlYWMnfm0R8z0AhagbItmpfE2T
 NgWxhTJd/fK8mcXDeftGqerjz7Hh/910hfURRpPJnT9gxbgcGqCTIofe9gG1w+kvcHdl
 OBii72QTx9tFTS8MmMrXAxDg9CD9+P23syX9gZ/Cpdr6SvJoYd9D1M3JJjWNgZTEg0Mt
 7XnZ/KWYpHENFq/KThZ7xrdmA3ZQAgPnh6ATdtw0bgAIEHNWnitZQV4RRGWSK7WWG8PJ
 onlBgVbqwxCv3M8zDrgkHS2rTOmOwntVD3gi0CyuVFbM+oAqkJWI2jbE5Rf6VCrHSDP2
 KpDg==
X-Gm-Message-State: AGi0PubcaXcyQ1iGF667898f2SziCI8oxdStbYVTM1WX36SeDj1hdQgG
 EDG8m9FNnF1YdhjWODHljE9sBA==
X-Google-Smtp-Source: APiQypINrFGKPWJ9LGXxo8qg5utpqCz9CorlKv7gkQ57lFnz/QdRnE9rkygWWec0WwhkNohUM1FdyA==
X-Received: by 2002:ae9:ee0a:: with SMTP id i10mr5057917qkg.367.1588357250872; 
 Fri, 01 May 2020 11:20:50 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id d69sm3197804qke.111.2020.05.01.11.20.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 01 May 2020 11:20:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jUaHI-0006oV-JN; Fri, 01 May 2020 15:20:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm v2 2/5] mm/hmm: make hmm_range_fault return 0 or -1
Date: Fri,  1 May 2020 15:20:45 -0300
Message-Id: <2-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
In-Reply-To: <0-v2-b4e84f444c7d+24f57-hmm_no_flags_jgg@mellanox.com>
References: 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 01 May 2020 19:08:02 +0000
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
 amd-gfx@lists.freedesktop.org, "Yang, Philip" <Philip.Yang@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>,
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

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Tested-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 6309ff72bd7876..7eb745b8acce0f 100644
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
+		if (r == -EBUSY && !time_after(jiffies, timeout))
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
index 280585833adfc1..f06bcac948a79b 100644
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
+ * Returns 0 on success or one of the following error codes:
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
2.26.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
