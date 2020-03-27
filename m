Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04EAC43331
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B781A20716
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CBwtBrf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B781A20716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 838DD6EA7E;
	Fri, 27 Mar 2020 20:24:55 +0000 (UTC)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DFF6EA76
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 20:00:35 +0000 (UTC)
Received: by mail-qk1-x744.google.com with SMTP id u4so12143814qkj.13
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=TDrjscj5VUbtTUg81Gj8EA5DAPIuadUuhV+FJXt/EPU=;
 b=CBwtBrf0j+KndtyNs7QkByd1ivDhH+r1q5a3WPT7JV3TLYd84eFuXNa2pjKTL8rR01
 fA3p/7kp415/LAwD4p4mKcIE3bas9ZhxZsIJyoLJH+hfkHIcJdPy+u+exZl/5J8jDK0m
 oDQomhjKgAoTF1Yp1ZL0iWj90lQAGleiyozXgaTgCoPdHdnpi3iFynvjUkd/iN5cdCLs
 opnE1kFN8Bgi3em7/ZY3yGrQbvWohI5okMJe51Qfr4N93myf/IcQCqmPms9ivBuiGyDH
 g+Rcmc1/kxA/RlbxIu3x8QQJQmnwm+/FkuKvDPbBSX5n058qaQBKousHs+ZmXxlOaPtP
 FDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TDrjscj5VUbtTUg81Gj8EA5DAPIuadUuhV+FJXt/EPU=;
 b=BXbBvc/UnPBUH6RSfppObIkXBXvAPt0G/s5VAGH+HgbfVJPFPPZv5BIPnIFhtosvnE
 kG2XtvsqRrVISWfbwKtPC2lwUUzP0mxax76t0z1ITLxMGb++dj3wu+s/hwzX6hCATId4
 ZqJUFC563GC8lbdXQUhBM/GeOt6C04/N8KMmG5yFuHVFqMLErygIbLTnOEjO1tN7mvcr
 EmcjOoZQltpyizy9ytk2pF6sQjNKYne2F/L5oZZ6FPHwvUSmPsXj2dbrbyADdMgCnHb3
 SxlowqQSTx05NbazNNPyezRxTvmF0XQynYQGSFtRyFohxrISV6p5o0kJsaZzYo+1608a
 f1SQ==
X-Gm-Message-State: ANhLgQ28U/ogyC2wRdL4Qe6lke1SlkV/pHjecwJmMIzMmZ5XCYs8kkXP
 2cDeDg8Dhk4Zdl8tuF+XondKIw==
X-Google-Smtp-Source: ADFU+vtbEMaje0l8Yq/7uiD0ikZWgvPtViAmPYH3kZWMXZUn8JFdaevM0Ixe5LKqy7XPslfAtSA1jw==
X-Received: by 2002:a37:e40d:: with SMTP id y13mr1045203qkf.39.1585339234848; 
 Fri, 27 Mar 2020 13:00:34 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id y127sm4512371qkb.76.2020.03.27.13.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 13:00:28 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jHv9V-0007gA-B2; Fri, 27 Mar 2020 17:00:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 8/9] mm/hmm: do not set pfns when returning an error
 code
Date: Fri, 27 Mar 2020 17:00:20 -0300
Message-Id: <20200327200021.29372-9-jgg@ziepe.ca>
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

Most places that return an error code, like -EFAULT, do not set
HMM_PFN_ERROR, only two places do this.

Resolve this inconsistency by never setting the pfns on an error
exit. This doesn't seem like a worthwhile thing to do anyhow.

If for some reason it becomes important, it makes more sense to directly
return the address of the failing page rather than have the caller scan
for the HMM_PFN_ERROR.

No caller inspects the pnfs output array if hmm_range_fault() fails.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index dc826898979bc5..e875d9ef0968fd 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -77,17 +77,14 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 			 unsigned int required_fault, struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
-	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
-	uint64_t *pfns = range->pfns;
-	unsigned long i = (addr - range->start) >> PAGE_SHIFT;
 	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 
 	WARN_ON_ONCE(!required_fault);
 	hmm_vma_walk->last = addr;
 
 	if (!vma)
-		goto out_error;
+		return -EFAULT;
 
 	if (required_fault & HMM_NEED_WRITE_FAULT) {
 		if (!(vma->vm_flags & VM_WRITE))
@@ -95,15 +92,10 @@ static int hmm_vma_fault(unsigned long addr, unsigned long end,
 		fault_flags |= FAULT_FLAG_WRITE;
 	}
 
-	for (; addr < end; addr += PAGE_SIZE, i++)
+	for (; addr < end; addr += PAGE_SIZE)
 		if (handle_mm_fault(vma, addr, fault_flags) & VM_FAULT_ERROR)
-			goto out_error;
-
+			return -EFAULT;
 	return -EBUSY;
-
-out_error:
-	pfns[i] = range->values[HMM_PFN_ERROR];
-	return -EFAULT;
 }
 
 static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
@@ -286,7 +278,6 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 
 		/* Report error for everything else */
 		pte_unmap(ptep);
-		*pfn = range->values[HMM_PFN_ERROR];
 		return -EFAULT;
 	}
 
@@ -572,9 +563,6 @@ static const struct mm_walk_ops hmm_walk_ops = {
  *
  * This is similar to get_user_pages(), except that it can read the page tables
  * without mutating them (ie causing faults).
- *
- * On error, for one virtual address in the range, the function will mark the
- * corresponding HMM pfn entry with an error flag.
  */
 long hmm_range_fault(struct hmm_range *range)
 {
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
