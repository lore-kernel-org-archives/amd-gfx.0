Return-Path: <SRS0=Hz3R=5M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B20C2D0EE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1056120716
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2020 20:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="mnfkrC9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1056120716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8EBA6EA7B;
	Fri, 27 Mar 2020 20:24:51 +0000 (UTC)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2078A6EA73
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 20:00:30 +0000 (UTC)
Received: by mail-qv1-xf44.google.com with SMTP id v38so5551082qvf.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2020 13:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=0YwvFUjpXmbDvkZKNjbfujorytQMVs2tZT8OA9dQSF8=;
 b=mnfkrC9jyg4WaIQ779ig/zpj/klGfASY58WPazK78dL6/L9j0dM8LoArrmhGY6hNCW
 lPnRXcLdic1Pg+h7moGy18icvpcDp3Vdm0s1rq5HeRIJN9EcdUO/cu+co11JpoLrN4qL
 bBHI8AGZyTfnUTwrsVFc8uctNW7ix9eQCONaIedTp9BNTFhNh1EZyXYoel4HYfcRY8fw
 LQnPSoYQG3lmTytyBJMIt2zxl6duN/WkpaQwOOPuKfTg+pln0nPKRe46xyyeOCl2jNsw
 F64wdb95HRMI5lsN23ls+CRwYXLCXqbVVixTp0hUCTtYyIqfegAdfesSO2XZetjZvnNA
 JZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0YwvFUjpXmbDvkZKNjbfujorytQMVs2tZT8OA9dQSF8=;
 b=VMtWjgzEg0hK7SV5eivi+PVvRFp7d+o3AN5zoQBw+T6C0fUcAOiKWDo9fAtHFIuJ5G
 pKglzcLiJBBP9sLoeSIbhArRPJsSWc8IJgN4qZdkld/Gk6QK2FOTQCHhSHdHT+h1RhMZ
 5YV75ir5Ki+cf37gpvqJY1DIhDv9+FsNL8T/ZXhvBPiYoNNKtxprWXv6QoNAGN2IGE4y
 hanf9P2C6MCUzDRGdjfRBLEYl0zukbMdNpKuIJFpA5O0FApAau55HeyL43RzCqo6JVVC
 by8RpvoxXD8UzviffO46oldlKf7t4LEJMl9su+ENB+9yFamW1rNmpx/I3SfjZn5d4bkj
 /X9w==
X-Gm-Message-State: ANhLgQ2bW/c2QCZ4NvmD3vaPqDaC5vXF7pdf2sRGDkGa1DhbTkNXmVKX
 1gpe7mF3Dc0k64xKycWrI2mXAw==
X-Google-Smtp-Source: ADFU+vt3s0+lgv+iGRoTEkFt1ejwwiJRwUACnIjhsRxuQ+gcOw0zEySY+f1/M+LS9aENWkWVffV11A==
X-Received: by 2002:ad4:4431:: with SMTP id e17mr992254qvt.64.1585339229040;
 Fri, 27 Mar 2020 13:00:29 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id s36sm4794732qtb.28.2020.03.27.13.00.25
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 27 Mar 2020 13:00:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jHv9V-0007fl-32; Fri, 27 Mar 2020 17:00:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jerome Glisse <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>,
 Felix.Kuehling@amd.com
Subject: [PATCH v2 hmm 4/9] mm/hmm: remove HMM_FAULT_SNAPSHOT
Date: Fri, 27 Mar 2020 17:00:16 -0300
Message-Id: <20200327200021.29372-5-jgg@ziepe.ca>
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

Now that flags are handled on a fine-grained per-page basis this global
flag is redundant and has a confusing overlap with the pfn_flags_mask and
default_flags.

Normalize the HMM_FAULT_SNAPSHOT behavior into one place. Callers needing
the SNAPSHOT behavior should set a pfn_flags_mask and default_flags that
always results in a cleared HMM_PFN_VALID. Then no pages will be faulted,
and HMM_FAULT_SNAPSHOT is not a special flow that overrides the masking
mechanism.

As this is the last flag, also remove the flags argument. If future flags
are needed they can be part of the struct hmm_range function arguments.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 Documentation/vm/hmm.rst                | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  2 +-
 include/linux/hmm.h                     |  5 +----
 mm/hmm.c                                | 17 +++++++++--------
 5 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 95fec596836262..4e3e9362afeb10 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -161,13 +161,11 @@ device must complete the update before the driver callback returns.
 When the device driver wants to populate a range of virtual addresses, it can
 use::
 
-  long hmm_range_fault(struct hmm_range *range, unsigned int flags);
+  long hmm_range_fault(struct hmm_range *range);
 
-With the HMM_RANGE_SNAPSHOT flag, it will only fetch present CPU page table
-entries and will not trigger a page fault on missing or non-present entries.
-Without that flag, it does trigger a page fault on missing or read-only entries
-if write access is requested (see below). Page faults use the generic mm page
-fault code path just like a CPU page fault.
+It will trigger a page fault on missing or read-only entries if write access is
+requested (see below). Page faults use the generic mm page fault code path just
+like a CPU page fault.
 
 Both functions copy CPU page table entries into their pfns array argument. Each
 entry in that array corresponds to an address in the virtual range. HMM
@@ -197,7 +195,7 @@ The usage pattern is::
  again:
       range.notifier_seq = mmu_interval_read_begin(&interval_sub);
       down_read(&mm->mmap_sem);
-      ret = hmm_range_fault(&range, HMM_RANGE_SNAPSHOT);
+      ret = hmm_range_fault(&range);
       if (ret) {
           up_read(&mm->mmap_sem);
           if (ret == -EBUSY)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 90821ce5e6cad0..c520290709371b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -856,7 +856,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	range->notifier_seq = mmu_interval_read_begin(&bo->notifier);
 
 	down_read(&mm->mmap_sem);
-	r = hmm_range_fault(range, 0);
+	r = hmm_range_fault(range);
 	up_read(&mm->mmap_sem);
 	if (unlikely(r <= 0)) {
 		/*
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 39c731a99937c6..e3797b2d4d1759 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -540,7 +540,7 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 		range.default_flags = 0;
 		range.pfn_flags_mask = -1UL;
 		down_read(&mm->mmap_sem);
-		ret = hmm_range_fault(&range, 0);
+		ret = hmm_range_fault(&range);
 		up_read(&mm->mmap_sem);
 		if (ret <= 0) {
 			if (ret == 0 || ret == -EBUSY)
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index daee6508a3f609..7475051100c782 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -117,13 +117,10 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
 	return pfn_to_page(entry >> range->pfn_shift);
 }
 
-/* Don't fault in missing PTEs, just snapshot the current state. */
-#define HMM_FAULT_SNAPSHOT		(1 << 1)
-
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-long hmm_range_fault(struct hmm_range *range, unsigned int flags);
+long hmm_range_fault(struct hmm_range *range);
 
 /*
  * HMM_RANGE_DEFAULT_TIMEOUT - default timeout (ms) when waiting for a range
diff --git a/mm/hmm.c b/mm/hmm.c
index 136de474221d77..8dbd9e1d0308b4 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -29,7 +29,6 @@
 struct hmm_vma_walk {
 	struct hmm_range	*range;
 	unsigned long		last;
-	unsigned int		flags;
 };
 
 enum {
@@ -112,9 +111,6 @@ static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 {
 	struct hmm_range *range = hmm_vma_walk->range;
 
-	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT)
-		return 0;
-
 	/*
 	 * So we not only consider the individual per page request we also
 	 * consider the default flags requested for the range. The API can
@@ -147,10 +143,17 @@ hmm_range_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 		     const uint64_t *pfns, unsigned long npages,
 		     uint64_t cpu_flags)
 {
+	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned int required_fault = 0;
 	unsigned long i;
 
-	if (hmm_vma_walk->flags & HMM_FAULT_SNAPSHOT)
+	/*
+	 * If the default flags do not request to fault pages, and the mask does
+	 * not allow for individual pages to be faulted, then
+	 * hmm_pte_need_fault() will always return 0.
+	 */
+	if (!((range->default_flags | range->pfn_flags_mask) &
+	      range->flags[HMM_PFN_VALID]))
 		return 0;
 
 	for (i = 0; i < npages; ++i) {
@@ -557,7 +560,6 @@ static const struct mm_walk_ops hmm_walk_ops = {
 /**
  * hmm_range_fault - try to fault some address in a virtual address range
  * @range:	argument structure
- * @flags:	HMM_FAULT_* flags
  *
  * Return: the number of valid pages in range->pfns[] (from range start
  * address), which may be zero.  On error one of the following status codes
@@ -579,12 +581,11 @@ static const struct mm_walk_ops hmm_walk_ops = {
  * On error, for one virtual address in the range, the function will mark the
  * corresponding HMM pfn entry with an error flag.
  */
-long hmm_range_fault(struct hmm_range *range, unsigned int flags)
+long hmm_range_fault(struct hmm_range *range)
 {
 	struct hmm_vma_walk hmm_vma_walk = {
 		.range = range,
 		.last = range->start,
-		.flags = flags,
 	};
 	struct mm_struct *mm = range->notifier->mm;
 	int ret;
-- 
2.25.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
