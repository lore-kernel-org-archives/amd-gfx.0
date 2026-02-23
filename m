Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D82AEC110B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 16:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C020210E410;
	Mon, 23 Feb 2026 16:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lmIw2SbI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A709810E412;
 Mon, 23 Feb 2026 16:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771865276; x=1803401276;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=fVntof4DMbaT6F/gG+obTaSH0DPmyluL1tF3c0xftWA=;
 b=lmIw2SbIZdoR/yb2RLbaAQAfKLtK+mxOhkNkJY0kdSyTds17wQOXuWVq
 ebOLT1R/4p9ru28uBHOltx5LOY8GwANy4P1fWsqEG+X1ShZ2TDWjAQoFm
 9uC/KgN1diTxdpqeMXwIUlnkcYE9E9Qjz/hE/9D7cYNfqQtTm82Y1JDDw
 md1UNyI4e5AS2fn3IegKHwBuKhKRY8yCqjK1ZU+Lz3AtczHWKaHjYPsP9
 sfEh4WXNzNCm0mHlnMS+HoP0tJvZtiDwgtVHwEq0RVfxfs3DZzM3BFquZ
 LVeXAP/UQRzz1rWEvpfdtsmzHMjQG9ajfiDyUki8TIwLBzWI7d8FEDogi Q==;
X-CSE-ConnectionGUID: lc5hx0QbT2uNiMxLLTOH+Q==
X-CSE-MsgGUID: v7mEKDceQeuFNJFl4C/27w==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="71890903"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="71890903"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 08:47:56 -0800
X-CSE-ConnectionGUID: /p80mIpFRH+rfRUI5PmzSg==
X-CSE-MsgGUID: uXtCVaS3SYOckeJgSUIQhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; d="scan'208";a="220126637"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.11])
 ([10.245.244.11])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Feb 2026 08:47:54 -0800
Message-ID: <a34a04bf-9f4e-4331-8275-93f21f27a19d@intel.com>
Date: Mon, 23 Feb 2026 16:47:52 +0000
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

Reviewed-by: Matthew Auld <matthew.auld@intel.com>
