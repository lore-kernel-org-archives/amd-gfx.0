Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9D2F4BB65
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 17:35:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE39F10E601;
	Tue, 24 Feb 2026 17:35:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JCOdYrY4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C701910E5FD;
 Tue, 24 Feb 2026 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771954520; x=1803490520;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fnV3r4YK1Ig0XxD2ADAkkc5HjoyaC8z3j4q1npYtEO4=;
 b=JCOdYrY4WRZPVb1Co7GO07WOQK9wpvy1Uvq2Uo1pG+Ii5qEPaqU9eZsE
 7RvVeQk30pDrQZ+N+zo6gS7oBapEZkApjTVg2Za1qCv54/MsSMEmpx1Nh
 fVE2GmCktXNSQMDgFIlNf7hIAJ7NiERzTkKfhgKlz0yNhnuHyIkobLkwp
 MaKqfz0dWsZa3nsdd3V9kJXEQ2NXnTrvpSLT6ka6bgohevQhpdMNxU5PC
 Z4prWI8Wymk7d7gdRYLb1L2ccluigfvothaS2PJjsNdzhHTWBfAHtuXlv
 TfLDCSRhXe57qldWq584oA13CmrR9OuFoZlcS1jPb1ajHZvGIqv+y0Pgp g==;
X-CSE-ConnectionGUID: 4qcb5MT4Tyed27sWiD8ljg==
X-CSE-MsgGUID: CcR2/608Q3aIK98DIEN7OQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="73020625"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="73020625"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 09:35:19 -0800
X-CSE-ConnectionGUID: 2YIkFaFySR+pvVypz8kiPA==
X-CSE-MsgGUID: hUNFEdcjSDu9+L48VEgDpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; d="scan'208";a="214182552"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO [10.245.244.173])
 ([10.245.244.173])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 09:35:17 -0800
Message-ID: <76588674-affb-478e-8a4a-35e7cf94f58f@intel.com>
Date: Tue, 24 Feb 2026 17:35:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] drm/buddy: Improve offset-aligned allocation
 handling
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260217113900.10675-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260217113900.10675-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 17/02/2026 11:38, Arunpravin Paneer Selvam wrote:
> Large alignment requests previously forced the buddy allocator to search by
> alignment order, which often caused higher-order free blocks to be split even
> when a suitably aligned smaller region already existed within them. This led
> to excessive fragmentation, especially for workloads requesting small sizes
> with large alignment constraints.
> 
> This change prioritizes the requested allocation size during the search and
> uses an augmented RB-tree field (subtree_max_alignment) to efficiently locate
> free blocks that satisfy both size and offset-alignment requirements. As a
> result, the allocator can directly select an aligned sub-region without
> splitting larger blocks unnecessarily.
> 
> A practical example is the VKCTS test
> dEQP-VK.memory.allocation.basic.size_8KiB.reverse.count_4000, which repeatedly
> allocates 8 KiB buffers with a 256 KiB alignment. Previously, such allocations
> caused large blocks to be split aggressively, despite smaller aligned regions
> being sufficient. With this change, those aligned regions are reused directly,
> significantly reducing fragmentation.
> 
> This improvement is visible in the amdgpu VRAM buddy allocator state
> (/sys/kernel/debug/dri/1/amdgpu_vram_mm). After the change, higher-order blocks
> are preserved and the number of low-order fragments is substantially reduced.
> 
> Before:
>    order- 5 free: 1936 MiB, blocks: 15490
>    order- 4 free:  967 MiB, blocks: 15486
>    order- 3 free:  483 MiB, blocks: 15485
>    order- 2 free:  241 MiB, blocks: 15486
>    order- 1 free:  241 MiB, blocks: 30948
> 
> After:
>    order- 5 free:  493 MiB, blocks:  3941
>    order- 4 free:  246 MiB, blocks:  3943
>    order- 3 free:  123 MiB, blocks:  4101
>    order- 2 free:   61 MiB, blocks:  4101
>    order- 1 free:   61 MiB, blocks:  8018
> 
> By avoiding unnecessary splits, this change improves allocator efficiency and
> helps maintain larger contiguous free regions under heavy offset-aligned
> allocation workloads.
> 
> v2:(Matthew)
>    - Update augmented information along the path to the inserted node.
> 
> v3:
>    - Move the patch to gpu/buddy.c file.
> 
> v4:(Matthew)
>    - Use the helper instead of calling _ffs directly
>    - Remove gpu_buddy_block_order(block) >= order check and drop order
>    - Drop !node check as all callers handle this already
>    - Return larger than any other possible alignment for __ffs64(0)
>    - Replace __ffs with __ffs64
> 
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/buddy.c       | 275 +++++++++++++++++++++++++++++++-------
>   include/linux/gpu_buddy.h |   2 +
>   2 files changed, 232 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 603c59a2013a..542131992763 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -14,6 +14,25 @@
>   
>   static struct kmem_cache *slab_blocks;
>   
> +static unsigned int gpu_buddy_block_offset_alignment(struct gpu_buddy_block *block)
> +{
> +	u64 offset = gpu_buddy_block_offset(block);
> +
> +	if (!offset)
> +		/*
> +		 * __ffs64(0) is undefined; offset 0 is maximally aligned, so return
> +		 * a value greater than any possible alignment.
> +		 */
> +		return 64 + 1;
> +
> +	return __ffs64(offset);
> +}
> +
> +RB_DECLARE_CALLBACKS_MAX(static, gpu_buddy_augment_cb,
> +			 struct gpu_buddy_block, rb,
> +			 unsigned int, subtree_max_alignment,
> +			 gpu_buddy_block_offset_alignment);
> +
>   static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   					       struct gpu_buddy_block *parent,
>   					       unsigned int order,
> @@ -31,6 +50,9 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   	block->header |= order;
>   	block->parent = parent;
>   
> +	block->subtree_max_alignment =
> +		gpu_buddy_block_offset_alignment(block);
> +

I think we can drop this now?

