Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A614D5CC8D
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 09:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD4A010E165;
	Tue, 16 Dec 2025 09:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="y/zxdLR+";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="EonMODgS";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C0DA10E165
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 09:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1765876174;
 bh=7liVY2/PpACX4H8B6uYV83r
 FBZB5/o8+ib51HC80Z8s=; b=y/zxdLR+UZ8kt6h4XElS0OdpZSmoZGzBb3slSeHJZYWT4h9sTd
 uI5vj0Z/p7W3LsxGThwb3YOhS976arZi0/kwBj56l/l3Q67b05f4f5SAmwy7zRV4uXtZ1Abay3I
 2Gt6hC66hSv+2C1yqd4TZBhY/WccICbH8IgT3TW5G34SNzYKGdHpRJVtK9H/AFfONfyxtU/CpKC
 f3V160lNvEBNkafmzrdD9QkT98fsGh5VnWLqzEbf4boSOr20a/L7icr0CcOVhjn25ESXGQJ7SSo
 LLMH2KjuHHx0SJSVQ82pmb+fvpi1o2IGlq6FiwuVvo6j60bH7B3wmu3Qydgb/jA+v9g==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1765876174; bh=7liVY2/PpACX4H8B6uYV83r
 FBZB5/o8+ib51HC80Z8s=; b=EonMODgSYI3iL8Qr0J4z3Hu4t3viVPmf30nEF9IHROQRCN1jii
 KrVXZFoyAiU7qYml59Xf2RM9V5i+xXjadvDw==;
Message-ID: <232d1e94-cfc1-4327-ab61-fbec0fae625b@damsy.net>
Date: Tue, 16 Dec 2025 10:09:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] drm/amdgpu: Add helper to alloc GART entries
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251215165630.1172383-1-Philip.Yang@amd.com>
 <20251215165630.1172383-6-Philip.Yang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20251215165630.1172383-6-Philip.Yang@amd.com>
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


Hi,

Le 15/12/2025 à 17:56, Philip Yang a écrit :
> Add helper amdgpu_gtt_mgr_alloc/free_entries, define GART_ENTRY_WITOUT_BO_COLOR
> color for GART node not allocated with GTT bo, then amdgpu_gtt_mgr_recover skip
> those mm_node.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 48 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  6 +++
>   2 files changed, 54 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..285177070895 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -26,6 +26,8 @@
>   
>   #include "amdgpu.h"
>   
> +#define GART_ENTRY_WITOUT_BO_COLOR	1
> +
>   static inline struct amdgpu_gtt_mgr *
>   to_gtt_mgr(struct ttm_resource_manager *man)
>   {
> @@ -180,6 +182,49 @@ static void amdgpu_gtt_mgr_del(struct ttm_resource_manager *man,
>   	kfree(node);
>   }
>   
> +/**
> + * amdgpu_gtt_mgr_alloc_entries - alloc GART entries without GTT bo
> + *
> + * @mgr: The GTT manager object
> + * @mm_node: The drm mm node to return the new allocation node information
> + * @num_pages: The number of pages for the new allocation
> + * @mode: The new allocation mode
> + *
> + * Helper to dynamic alloc GART entries to map memory not accociated with
> + * GTT BO, for example VRAM BO physical memory, remote physical memory.
> + */
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node,
> +				 u64 num_pages,
> +				 enum drm_mm_insert_mode mode)
> +{
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> +	int r;
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, mm_node, num_pages,
> +					0, GART_ENTRY_WITOUT_BO_COLOR, 0,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +/**
> + * amdgpu_gtt_mgr_free_entries - free GART entries not accocaited with GTT bo
> + *
> + * @mgr: The GTT manager object
> + * @mm_node: The drm mm node to free
> + */
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node)
> +{
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> +
>   /**
>    * amdgpu_gtt_mgr_recover - re-init gart
>    *
> @@ -196,6 +241,9 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>   	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>   	spin_lock(&mgr->lock);
>   	drm_mm_for_each_node(mm_node, &mgr->mm) {
> +		if (mm_node->color == GART_ENTRY_WITOUT_BO_COLOR)
> +			continue;
> +
>   		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
>   		amdgpu_ttm_recover_gart(node->base.bo);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..25640bed7dc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -141,6 +141,12 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>   
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages,
> +				 enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node);
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   
>   u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);


Reviewed-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Thanks!

