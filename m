Return-Path: <SRS0=S2wj=5F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9639C4332B
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC65320709
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2020 17:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="o7rS5S0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC65320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98BDD6E1CD;
	Fri, 20 Mar 2020 17:21:23 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 210166E1A3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 16:59:15 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id 10so5517885qtp.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2020 09:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BDvip0TEDdRy6Qebq3Jjm9q8IZushhhH41Cv5CSPsYg=;
 b=o7rS5S0AsnboKmeY0i8V6l4XrqKbMaIDN+dRT8M7ae7SN5uO0Y9cf5ue5fxCfIsNeK
 7iTs5hK3BaB1JxF52ajkDDYSXgSFTdwuf6/PJzrPkUaNZxdW7j8GIbNnfDfPpx1JJ8QR
 iY9Bk8KNLT8H/jvnvDRYe8hfY4b8PFCjJv7Vojrcmd7ScA1lwNOpAK6ov2UvK4BihL52
 DimyOsT04Yb3PYKXwsmVS/zgNQ1PtTiqXJ5fUO09wpABkfc6R/kKXb5kLhMWR0NNU65q
 5pNmHCVQek+18grxw250tHfu3iPlEwtGlaO69s+IBK7W2mA6w+hcVKc1j0uQBi9jwJ37
 RInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BDvip0TEDdRy6Qebq3Jjm9q8IZushhhH41Cv5CSPsYg=;
 b=fgQgPNIE85BCF/Wxq+4wmlsnSm5sEBt3z7eK0iOi8C/OJ5i+3zbh33PXHo/zqMxdjf
 fqxTvcRNjPfb9T/g6QGgVbnTE417v8OiMf49LaQWzuxfYFgXZbcsrUaJ7VCaFj3eECH6
 Exol6UR5iU8LTelV0JX/Im3EDnY7DPq3u5J2PO/u/osYOe7J1t/WnGU07dnA/D/yOcDI
 i+AFQzaYuw6XqLk1XgmznMwiEiEER59z69Lt3CZwH+2yuCMCIIWCWtIq1YBuEuQDLVBy
 QTjK3MyV1R9/d3ZTlzMpQn4YQ7hEvMaGTud8HHorxCxHOd+3Fg5+4tu3bphJKHvrXPQf
 wmxA==
X-Gm-Message-State: ANhLgQ0OPT5uiClBedDh9osCMaaIR0PulSxp4GELTSOO7MRjVEkwKuLr
 h61CtaqxId7b3Pvh3wU/NvdkT6urjsY9Mw==
X-Google-Smtp-Source: ADFU+vs0SluEmhvLyLkrqPiv0NLdzSfR4fL3A9Pz7jSUSruFagO/rzdeFOruZ31ExN9mYVZmWbzX6Q==
X-Received: by 2002:a37:9b51:: with SMTP id d78mr9261623qke.65.1584723024806; 
 Fri, 20 Mar 2020 09:50:24 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id g3sm4393051qke.89.2020.03.20.09.50.23
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 09:50:23 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jFKql-0005k6-8B; Fri, 20 Mar 2020 13:50:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH hmm 2/6] mm/hmm: return the fault type from
 hmm_pte_need_fault()
Date: Fri, 20 Mar 2020 13:49:01 -0300
Message-Id: <20200320164905.21722-3-jgg@ziepe.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320164905.21722-1-jgg@ziepe.ca>
References: <20200320164905.21722-1-jgg@ziepe.ca>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 20 Mar 2020 17:21:22 +0000
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

Using two bools instead of flags return is not necessary and leads to
bugs. Returning a value is easier for the compiler to check and easier to
pass around the code flow.

Convert the two bools into flags and push the change to all callers.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 153 ++++++++++++++++++++++++-------------------------------
 1 file changed, 67 insertions(+), 86 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 3a2610e0713329..b4f662eadb7a7c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -32,6 +32,11 @@ struct hmm_vma_walk {
 	unsigned int		flags;
 };
 
+enum {
+	NEED_FAULT = 1 << 0,
+	NEED_WRITE_FAULT = 1 << 1,
+};
+
 static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 		struct hmm_range *range, enum hmm_pfn_value_e value)
 {
@@ -49,8 +54,7 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
  * hmm_vma_fault() - fault in a range lacking valid pmd or pte(s)
  * @addr: range virtual start address (inclusive)
  * @end: range virtual end address (exclusive)
- * @fault: should we fault or not ?
- * @write_fault: write fault ?
+ * @required_fault: NEED_FAULT_* flags
  * @walk: mm_walk structure
  * Return: -EBUSY after page fault, or page fault error
  *
@@ -58,8 +62,7 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
  * or whenever there is no page directory covering the virtual address range.
  */
 static int hmm_vma_fault(unsigned long addr, unsigned long end,
-			      bool fault, bool write_fault,
-			      struct mm_walk *walk)
+			 unsigned int required_fault, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -68,13 +71,13 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 
-	WARN_ON_ONCE(!fault && !write_fault);
+	WARN_ON_ONCE(!required_fault);
 	hmm_vma_walk->last = addr;
 
 	if (!vma)
 		goto out_error;
 
-	if (write_fault) {
+	if (required_fault & NEED_WRITE_FAULT) {
 		if (!(vma->vm_flags & VM_WRITE))
 			return -EPERM;
 		fault_flags |= FAULT_FLAG_WRITE;
@@ -91,14 +94,13 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 	return -EFAULT;
 }
 
-static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
-				      uint64_t pfns, uint64_t cpu_flags,
-				      bool *fault, bool *write_fault)
+static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
+				       uint64_t pfns, uint64_t cpu_flags)
 {
 	struct hmm_range *range = hmm_vma_walk->range;
 
 	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT)
-		return;
+		return 0;
 
 	/*
 	 * So we not only consider the individual per page request we also
@@ -114,37 +116,37 @@ static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 
 	/* We aren't ask to do anything ... */
 	if (!(pfns & range->flags[HMM_PFN_VALID]))
-		return;
+		return 0;
 
-	/* If CPU page table is not valid then we need to fault */
-	*fault = !(cpu_flags & range->flags[HMM_PFN_VALID]);
 	/* Need to write fault ? */
 	if ((pfns & range->flags[HMM_PFN_WRITE]) &&
-	    !(cpu_flags & range->flags[HMM_PFN_WRITE])) {
-		*write_fault = true;
-		*fault = true;
-	}
+	    !(cpu_flags & range->flags[HMM_PFN_WRITE]))
+		return NEED_FAULT | NEED_WRITE_FAULT;
+
+	/* If CPU page table is not valid then we need to fault */
+	if (!(cpu_flags & range->flags[HMM_PFN_VALID]))
+		return NEED_FAULT;
+	return 0;
 }
 
-static void hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
-				 const uint64_t *pfns, unsigned long npages,
-				 uint64_t cpu_flags, bool *fault,
-				 bool *write_fault)
+static unsigned int
+hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
+		     const uint64_t *pfns, unsigned long npages,
+		     uint64_t cpu_flags)
 {
+	unsigned int required_fault = 0;
 	unsigned long i;
 
-	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT) {
-		*fault = *write_fault = false;
-		return;
-	}
+	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT)
+		return 0;
 
-	*fault = *write_fault = false;
 	for (i = 0; i < npages; ++i) {
-		hmm_pte_need_fault(hmm_vma_walk, pfns[i], cpu_flags,
-				   fault, write_fault);
-		if ((*write_fault))
-			return;
+		required_fault |=
+			hmm_pte_need_fault(hmm_vma_walk, pfns[i], cpu_flags);
+		if (required_fault == (NEED_FAULT | NEED_WRITE_FAULT))
+			return required_fault;
 	}
+	return required_fault;
 }
 
 static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
@@ -152,17 +154,16 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	bool fault, write_fault;
+	unsigned int required_fault;
 	unsigned long i, npages;
 	uint64_t *pfns;
 
 	i = (addr - range->start) >> PAGE_SHIFT;
 	npages = (end - addr) >> PAGE_SHIFT;
 	pfns = &range->pfns[i];
-	hmm_range_need_fault(hmm_vma_walk, pfns, npages,
-			     0, &fault, &write_fault);
-	if (fault || write_fault)
-		return hmm_vma_fault(addr, end, fault, write_fault, walk);
+	required_fault = hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0);
+	if (required_fault)
+		return hmm_vma_fault(addr, end, required_fault, walk);
 	hmm_vma_walk->last = addr;
 	return hmm_pfns_fill(addr, end, range, HMM_PFN_NONE);
 }
@@ -183,16 +184,15 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long pfn, npages, i;
-	bool fault, write_fault;
+	unsigned int required_fault;
 	uint64_t cpu_flags;
 
 	npages = (end - addr) >> PAGE_SHIFT;
 	cpu_flags = pmd_to_hmm_pfn_flags(range, pmd);
-	hmm_range_need_fault(hmm_vma_walk, pfns, npages, cpu_flags,
-			     &fault, &write_fault);
-
-	if (fault || write_fault)
-		return hmm_vma_fault(addr, end, fault, write_fault, walk);
+	required_fault =
+		hmm_range_need_fault(hmm_vma_walk, pfns, npages, cpu_flags);
+	if (required_fault)
+		return hmm_vma_fault(addr, end, required_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++)
@@ -229,18 +229,15 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
-	bool fault, write_fault;
+	unsigned int required_fault;
 	uint64_t cpu_flags;
 	pte_t pte = *ptep;
 	uint64_t orig_pfn = *pfn;
 
 	*pfn = range->values[HMM_PFN_NONE];
-	fault = write_fault = false;
-
 	if (pte_none(pte)) {
-		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0,
-				   &fault, &write_fault);
-		if (fault || write_fault)
+		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
+		if (required_fault)
 			goto fault;
 		return 0;
 	}
@@ -261,9 +258,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			return 0;
 		}
 
-		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0, &fault,
-				   &write_fault);
-		if (!fault && !write_fault)
+		required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0);
+		if (!required_fault)
 			return 0;
 
 		if (!non_swap_entry(entry))
@@ -283,9 +279,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	}
 
 	cpu_flags = pte_to_hmm_pfn_flags(range, pte);
-	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags, &fault,
-			   &write_fault);
-	if (fault || write_fault)
+	required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags);
+	if (required_fault)
 		goto fault;
 
 	/*
@@ -293,9 +288,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	 * fall through and treat it like a normal page.
 	 */
 	if (pte_special(pte) && !is_zero_pfn(pte_pfn(pte))) {
-		hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0, &fault,
-				   &write_fault);
-		if (fault || write_fault) {
+		if (hmm_pte_need_fault(hmm_vma_walk, orig_pfn, 0)) {
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
@@ -309,7 +302,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 fault:
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
-	return hmm_vma_fault(addr, end, fault, write_fault, walk);
+	return hmm_vma_fault(addr, end, required_fault, walk);
 }
 
 static int hmm_vma_walk_pmd(pmd_t *pmdp,
@@ -322,7 +315,6 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	uint64_t *pfns = &range->pfns[(start - range->start) >> PAGE_SHIFT];
 	unsigned long npages = (end - start) >> PAGE_SHIFT;
 	unsigned long addr = start;
-	bool fault, write_fault;
 	pte_t *ptep;
 	pmd_t pmd;
 
@@ -332,9 +324,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		return hmm_vma_walk_hole(start, end, -1, walk);
 
 	if (thp_migration_supported() && is_pmd_migration_entry(pmd)) {
-		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
-				     0, &fault, &write_fault);
-		if (fault || write_fault) {
+		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0)) {
 			hmm_vma_walk->last = addr;
 			pmd_migration_entry_wait(walk->mm, pmdp);
 			return -EBUSY;
@@ -343,9 +333,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	}
 
 	if (!pmd_present(pmd)) {
-		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
-				     &write_fault);
-		if (fault || write_fault)
+		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0))
 			return -EFAULT;
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
@@ -375,9 +363,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	 * recover.
 	 */
 	if (pmd_bad(pmd)) {
-		hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0, &fault,
-				     &write_fault);
-		if (fault || write_fault)
+		if (hmm_range_need_fault(hmm_vma_walk, pfns, npages, 0))
 			return -EFAULT;
 		return hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
 	}
@@ -434,8 +420,8 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 
 	if (pud_huge(pud) && pud_devmap(pud)) {
 		unsigned long i, npages, pfn;
+		unsigned int required_fault;
 		uint64_t *pfns, cpu_flags;
-		bool fault, write_fault;
 
 		if (!pud_present(pud)) {
 			spin_unlock(ptl);
@@ -447,12 +433,11 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 		pfns = &range->pfns[i];
 
 		cpu_flags = pud_to_hmm_pfn_flags(range, pud);
-		hmm_range_need_fault(hmm_vma_walk, pfns, npages,
-				     cpu_flags, &fault, &write_fault);
-		if (fault || write_fault) {
+		required_fault = hmm_range_need_fault(hmm_vma_walk, pfns,
+						      npages, cpu_flags);
+		if (required_fault) {
 			spin_unlock(ptl);
-			return hmm_vma_fault(addr, end, fault, write_fault,
-						  walk);
+			return hmm_vma_fault(addr, end, required_fault, walk);
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
@@ -484,7 +469,7 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
 	uint64_t orig_pfn, cpu_flags;
-	bool fault, write_fault;
+	unsigned int required_fault;
 	spinlock_t *ptl;
 	pte_t entry;
 
@@ -495,12 +480,10 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	orig_pfn = range->pfns[i];
 	range->pfns[i] = range->values[HMM_PFN_NONE];
 	cpu_flags = pte_to_hmm_pfn_flags(range, entry);
-	fault = write_fault = false;
-	hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags,
-			   &fault, &write_fault);
-	if (fault || write_fault) {
+	required_fault = hmm_pte_need_fault(hmm_vma_walk, orig_pfn, cpu_flags);
+	if (required_fault) {
 		spin_unlock(ptl);
-		return hmm_vma_fault(addr, end, fault, write_fault, walk);
+		return hmm_vma_fault(addr, end, required_fault, walk);
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
@@ -532,17 +515,15 @@ static int hmm_vma_walk_test(unsigned long start, unsigned long end,
 	 */
 	if ((vma->vm_flags & (VM_IO | VM_PFNMAP | VM_MIXEDMAP)) ||
 	    !(vma->vm_flags & VM_READ)) {
-		bool fault, write_fault;
-
 		/*
 		 * Check to see if a fault is requested for any page in the
 		 * range.
 		 */
-		hmm_range_need_fault(hmm_vma_walk, range->pfns +
-					((start - range->start) >> PAGE_SHIFT),
-					(end - start) >> PAGE_SHIFT,
-					0, &fault, &write_fault);
-		if (fault || write_fault)
+		if (hmm_range_need_fault(hmm_vma_walk,
+					 range->pfns +
+						 ((start - range->start) >>
+						  PAGE_SHIFT),
+					 (end - start) >> PAGE_SHIFT, 0))
 			return -EFAULT;
 
 		hmm_pfns_fill(start, end, range, HMM_PFN_ERROR);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
