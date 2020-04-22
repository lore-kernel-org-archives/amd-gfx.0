Return-Path: <SRS0=Hoyj=6G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962F2C55181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7116D206D9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2020 06:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7116D206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8AD6E9B9;
	Wed, 22 Apr 2020 06:54:58 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 707BD6E21D;
 Wed, 22 Apr 2020 05:52:31 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8C51968C4E; Wed, 22 Apr 2020 07:52:29 +0200 (CEST)
Date: Wed, 22 Apr 2020 07:52:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH hmm 2/5] mm/hmm: make hmm_range_fault return 0 or -1
Message-ID: <20200422055229.GB22366@lst.de>
References: <0-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
 <2-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2-v1-4eb72686de3c+5062-hmm_no_flags_jgg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 Ralph Campbell <rcampbell@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@lst.de>,
 linux-mm@kvack.org, =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>,
 Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
 intel-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 21, 2020 at 09:21:43PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
> 
> hmm_vma_walk->last is supposed to be updated after every write to the
> pfns, so that it can be returned by hmm_range_fault(). However, this is
> not done consistently. Fortunately nothing checks the return code of
> hmm_range_fault() for anything other than error.
> 
> More importantly last must be set before returning -EBUSY as it is used to
> prevent reading an output pfn as an input flags when the loop restarts.
> 
> For clarity and simplicity make hmm_range_fault() return 0 or -ERRNO. Only
> set last when returning -EBUSY.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  Documentation/vm/hmm.rst                |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  4 ++--
>  drivers/gpu/drm/nouveau/nouveau_svm.c   |  6 +++---
>  include/linux/hmm.h                     |  2 +-
>  mm/hmm.c                                | 25 +++++++++----------------
>  5 files changed, 16 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
> index 4e3e9362afeb10..9924f2caa0184c 100644
> --- a/Documentation/vm/hmm.rst
> +++ b/Documentation/vm/hmm.rst
> @@ -161,7 +161,7 @@ device must complete the update before the driver callback returns.
>  When the device driver wants to populate a range of virtual addresses, it can
>  use::
>  
> -  long hmm_range_fault(struct hmm_range *range);
> +  int hmm_range_fault(struct hmm_range *range);
>  
>  It will trigger a page fault on missing or read-only entries if write access is
>  requested (see below). Page faults use the generic mm page fault code path just
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 6309ff72bd7876..efc1329a019127 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -852,12 +852,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>  	down_read(&mm->mmap_sem);
>  	r = hmm_range_fault(range);
>  	up_read(&mm->mmap_sem);
> -	if (unlikely(r <= 0)) {
> +	if (unlikely(r)) {
>  		/*
>  		 * FIXME: This timeout should encompass the retry from
>  		 * mmu_interval_read_retry() as well.
>  		 */
> -		if ((r == 0 || r == -EBUSY) && !time_after(jiffies, timeout))
> +		if ((r == -EBUSY) && !time_after(jiffies, timeout))

Please also kill the superflous inner braces here.

> + * Return: 0 or -ERRNO with one of the following status codes:

Maybe say something like:

    * Returns 0 on success or one of the following error codes:

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
