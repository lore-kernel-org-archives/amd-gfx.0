Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96033C5518A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B2DD206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Y9ADKn94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B2DD206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268906E9B1;
	Wed, 22 Apr 2020 06:54:56 +0000 (UTC)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B32A389DC0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2020 00:21:49 +0000 (UTC)
Received: by mail-qk1-x742.google.com with SMTP id g74so688835qke.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2020 17:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=nTTGkCmPNBNLfBeKlL5KhUg/wYh+8kbFb/bZ+rQv6GY=;
 b=Y9ADKn94L03XU1WeAr1BxOt1n9SMwpaUA2kh4P9ChqBAdUSD+fcEFuqyvQgMnUBT5K
 TBVzLC1fdZAXyDHYmaR4eSl4pkcikTQ2p6vftD66fKGi3itp/bh+mnTy9HWICDa/87cG
 wSZ7VOj95q27lOa9SkMVfa+qyx0nNQ6ChLwa5xXqahDBS+eX+6110M1DMBZzjfo1G84x
 JdgwQtnf/1Yz0i+eERnmyM0pFCNErIgH65QoZ0wCZzqypVBly7kQn/XCDR6Y0Zo9352H
 0SruN8Hct3GkG5DW69G9uyplLEKr3n/7toee+QwA5bt1D6p96wXvbGK1WSnslJJT5OBW
 lKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nTTGkCmPNBNLfBeKlL5KhUg/wYh+8kbFb/bZ+rQv6GY=;
 b=gxcC7z9allflo0rysGygMhqVGC93l49NFrDWpSHuCETqI90S69qN4NkZ2ouzDML5jt
 7ta9jbvcOduHI8Xz3R54ah9/2jGwt7XTA5V9s+QSS1lTQ2ZqJUV7TOm2Y+jDW3X2PU91
 2uEneAP1J58N9FJbmojn8g6QwAmysRoyrhlVPqpoxIWaESQ0RmgzoUlOIH6iK4Bj/rAr
 0AH8vru2Qx7b3Wp/6hnibAWiyhhUXUs9eZXpFdZI2pq5rovVt11H67DFQmft10KTWIt8
 sVbVR9yW7hizFtoRowYw+Frur/xs5swxrswj9J7oLECBnek5xFpp1nA3sowmHfz6gYDu
 5NpA==
X-Gm-Message-State: AGi0PuafndVEMeiqPe0jto5vDPrIqL3aD8DUrBi6vtbMDw2nB6mZmSO+
 pLeYNoEyU4FdG6oRQ2s9Ij8a9g==
X-Google-Smtp-Source: APiQypLsWIwk2GzyDvAQhKyc5Ai1EdwHafbJ+aT9TsesWr9n3rkGOuvpeUzjUFzVSJOlWwn/eV0NvQ==
X-Received: by 2002:ae9:e8c2:: with SMTP id a185mr23357780qkg.72.1587514908893; 
 Tue, 21 Apr 2020 17:21:48 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.57.212])
 by smtp.gmail.com with ESMTPSA id e8sm2758708qkl.57.2020.04.21.17.21.46
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 21 Apr 2020 17:21:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
 (envelope-from <jgg@ziepe.ca>)
 id 1jR398-0000BR-IN; Tue, 21 Apr 2020 21:21:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: linux-mm@kvack.org,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH hmm 4/5] mm/hmm: remove HMM_PFN_SPECIAL
Date: Tue, 21 Apr 2020 21:21:45 -0300
Message-Id: <4-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
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

This is just an alias for HMM_PFN_ERROR, nothing cares that the error was
because of a special page vs any other error case.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 -
 drivers/gpu/drm/nouveau/nouveau_svm.c   | 1 -
 include/linux/hmm.h                     | 8 --------
 mm/hmm.c                                | 2 +-
 4 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index bff8e64701a547..449083f9f8a2bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -775,7 +775,6 @@ static const uint64_t hmm_range_flags[HMM_PFN_FLAG_MAX] = {
 static const uint64_t hmm_range_values[HMM_PFN_VALUE_MAX] = {
 	0xfffffffffffffffeUL, /* HMM_PFN_ERROR */
 	0, /* HMM_PFN_NONE */
-	0xfffffffffffffffcUL /* HMM_PFN_SPECIAL */
 };
 
 /**
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index c68e9317cf0740..cf0d9bd61bebf9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -379,7 +379,6 @@ static const u64
 nouveau_svm_pfn_values[HMM_PFN_VALUE_MAX] = {
 	[HMM_PFN_ERROR  ] = ~NVIF_VMM_PFNMAP_V0_V,
 	[HMM_PFN_NONE   ] =  NVIF_VMM_PFNMAP_V0_NONE,
-	[HMM_PFN_SPECIAL] = ~NVIF_VMM_PFNMAP_V0_V,
 };
 
 /* Issue fault replay for GPU to retry accesses that faulted previously. */
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 0df27dd03d53d7..81c302c884c0e3 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -44,10 +44,6 @@ enum hmm_pfn_flag_e {
  * Flags:
  * HMM_PFN_ERROR: corresponding CPU page table entry points to poisoned memory
  * HMM_PFN_NONE: corresponding CPU page table entry is pte_none()
- * HMM_PFN_SPECIAL: corresponding CPU page table entry is special; i.e., the
- *      result of vmf_insert_pfn() or vm_insert_page(). Therefore, it should not
- *      be mirrored by a device, because the entry will never have HMM_PFN_VALID
- *      set and the pfn value is undefined.
  *
  * Driver provides values for none entry, error entry, and special entry.
  * Driver can alias (i.e., use same value) error and special, but
@@ -56,12 +52,10 @@ enum hmm_pfn_flag_e {
  * HMM pfn value returned by hmm_vma_get_pfns() or hmm_vma_fault() will be:
  * hmm_range.values[HMM_PFN_ERROR] if CPU page table entry is poisonous,
  * hmm_range.values[HMM_PFN_NONE] if there is no CPU page table entry,
- * hmm_range.values[HMM_PFN_SPECIAL] if CPU page table entry is a special one
  */
 enum hmm_pfn_value_e {
 	HMM_PFN_ERROR,
 	HMM_PFN_NONE,
-	HMM_PFN_SPECIAL,
 	HMM_PFN_VALUE_MAX
 };
 
@@ -110,8 +104,6 @@ static inline struct page *hmm_device_entry_to_page(const struct hmm_range *rang
 		return NULL;
 	if (entry == range->values[HMM_PFN_ERROR])
 		return NULL;
-	if (entry == range->values[HMM_PFN_SPECIAL])
-		return NULL;
 	if (!(entry & range->flags[HMM_PFN_VALID]))
 		return NULL;
 	return pfn_to_page(entry >> range->pfn_shift);
diff --git a/mm/hmm.c b/mm/hmm.c
index 4c7c396655b528..2693393dc14b30 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -301,7 +301,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			pte_unmap(ptep);
 			return -EFAULT;
 		}
-		*pfn = range->values[HMM_PFN_SPECIAL];
+		*pfn = range->values[HMM_PFN_ERROR];
 		return 0;
 	}
 
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
