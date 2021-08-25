Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EACCC432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2EB1610E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 12:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2EB1610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5266E20A;
	Wed, 25 Aug 2021 12:34:31 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E6866E160;
 Wed, 25 Aug 2021 07:40:33 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2F4E067357; Wed, 25 Aug 2021 09:40:30 +0200 (CEST)
Date: Wed, 25 Aug 2021 09:40:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alex Sierra <alex.sierra@amd.com>
Cc: akpm@linux-foundation.org, Felix.Kuehling@amd.com, linux-mm@kvack.org,
 rcampbell@nvidia.com, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, hch@lst.de, jgg@nvidia.com,
 jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory migration
Message-ID: <20210825074029.GC29433@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com>
 <20210825034828.12927-4-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825034828.12927-4-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Mailman-Approved-At: Wed, 25 Aug 2021 12:34:20 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Aug 24, 2021 at 10:48:17PM -0500, Alex Sierra wrote:
> In this case, this is used to migrate pages from device memory, back to
> system memory. This particular device memory type should be accessible
> by the CPU, through IOMEM access. Typically, zone device public type
> memory falls into this category.
> 
> Signed-off-by: Alex Sierra <alex.sierra@amd.com>
> ---
>  include/linux/migrate.h | 1 +
>  mm/migrate.c            | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 4bb4e519e3f5..6b16f417384f 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -156,6 +156,7 @@ static inline unsigned long migrate_pfn(unsigned long pfn)
>  enum migrate_vma_direction {
>  	MIGRATE_VMA_SELECT_SYSTEM = 1 << 0,
>  	MIGRATE_VMA_SELECT_DEVICE_PRIVATE = 1 << 1,
> +	MIGRATE_VMA_SELECT_IOMEM = 1 << 2,
>  };
>  
>  struct migrate_vma {
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e3a10e2a1bb3..d4ae2da99607 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2406,7 +2406,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>  			if (is_write_device_private_entry(entry))
>  				mpfn |= MIGRATE_PFN_WRITE;
>  		} else {
> -			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM))
> +			if (!(migrate->flags & MIGRATE_VMA_SELECT_SYSTEM) &&
> +			    !(migrate->flags & MIGRATE_VMA_SELECT_IOMEM))

This makes the MIGRATE_VMA_SELECT_SYSTEM and MIGRATE_VMA_SELECT_IOMEM
behave entirely identifical, that is redundant.  I think we need to
distinguish between the dfferent cases here.  I think the right check
would be pfn_valid(), which should be true for system memory, and
false for iomem.

Also shouldn't this be called DEVICE_PUBLIC instead of IOMEM?
