Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E507D3C545
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 12:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D7CC10E6A2;
	Wed, 10 Dec 2025 12:57:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=damsy.net header.i=@damsy.net header.b="Ve8fqGB5";
	dkim=permerror (0-bit key) header.d=damsy.net header.i=@damsy.net header.b="j4rC+lYr";
	dkim-atps=neutral
Received: from jeth.damsy.net (jeth.damsy.net [51.159.152.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C8D810E6A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202408r; d=damsy.net; c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1765371431;
 bh=SYOUZUoN+oZVm44KMZfMSpv
 aQPrA7/TClxBtZ7WnCkU=; b=Ve8fqGB5NDal1uQh/WjUdhOPshQEO41KEANLfQvhXJArclS0Ig
 NijHpyfcrujYKb+ZKRMG2s2otqE4F5IWep6NyH6AhKQrmdlajgzHt5vyrCYd6uki+ohq2vsHaGA
 qmfONy1ZwwvX5YbhrSchzSh99MMWWwvPxf6BLOaPCQ54hyaUvPpOYx85f8k4OzTF3vMwpnK8ixf
 SoniGnh9F1lm4JpG430BwmlEDySxu4tJ7/4lcn5WabcJNCjT6GpFk4izxQd95SVOm5A8Rsk7MtI
 cTjTNQTJp0bhPceqLIaP5cCpnX3xELMByfb7lNFFY3iiFBmZmL0/nyMBxTZugT6xBYg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202408e; d=damsy.net;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1765371431; bh=SYOUZUoN+oZVm44KMZfMSpv
 aQPrA7/TClxBtZ7WnCkU=; b=j4rC+lYrM5kYfyNh5Rufly5g0fyh/BWYmfkqTTjdL2qrWB04SR
 J/n8HTN9chu+1VIEkq1XMI+rKID/V7hIF7DA==;
Message-ID: <f64a5319-35e1-49dc-8cf1-5f609eea42b0@damsy.net>
Date: Wed, 10 Dec 2025 13:57:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] drm/amdgpu: Add helper to alloc GART entries
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, christian.koenig@amd.com, david.yatsin@amd.com,
 pierre-eric.pelloux-prayer@amd.com, kent.russell@amd.com
References: <20251209234328.625670-1-Philip.Yang@amd.com>
 <20251209234328.625670-6-Philip.Yang@amd.com>
Content-Language: en-US
From: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>
In-Reply-To: <20251209234328.625670-6-Philip.Yang@amd.com>
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

Le 10/12/2025 à 00:43, Philip Yang a écrit :
> Add helper amdgpu_gtt_mgr_alloc/free_entries, export the configurable drm_mm
> allocator parameters to caller.
> 
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 27 +++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  7 ++++++
>   2 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 895c1e4c6747..d21c7187e4aa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -321,3 +321,30 @@ void amdgpu_gtt_mgr_fini(struct amdgpu_device *adev)
>   	ttm_resource_manager_cleanup(man);
>   	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_TT, NULL);
>   }
> +
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages, u64 alignment,

I would drop the alignment argument since all users are going to pass 0 for now.

> +				 unsigned long color,

As discussed offline, my version of these helpers also exposed the color arg to 
be able to distinguish between node's with a BO (color = 0) and the ones without 
a BO (color = 1). This is useful in amdgpu_gtt_mgr_recover() because for the 
latter we can't do:

    struct drm_range_mgr_node *node = container_of(mm_node, ...);

To avoid modifying again the same code, I'd suggest to:
1) add a define ("#define GART_ENTRY_WITOUT_BO_COLOR 1" ?) and use it as the 
color inside your helper
2) remove the color argument
3) update amdgpu_gtt_mgr_recover() to skip nodes with this color

Thanks,
Pierre-Eric

> +				 enum drm_mm_insert_mode mode)
> +{
> +	struct amdgpu_device *adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
> +	int r;
> +
> +	spin_lock(&mgr->lock);
> +	r = drm_mm_insert_node_in_range(&mgr->mm, node, num_pages,
> +					alignment, color, 0,
> +					adev->gmc.gart_size >> PAGE_SHIFT,
> +					mode);
> +	spin_unlock(&mgr->lock);
> +	return r;
> +}
> +
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node)
> +{
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(mm_node))
> +		drm_mm_remove_node(mm_node);
> +	spin_unlock(&mgr->lock);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 72488124aa59..28511e66d364 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -141,6 +141,13 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>   bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
>   void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>   
> +int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *node,
> +				 u64 num_pages, u64 alignment,
> +				 unsigned long color,
> +				 enum drm_mm_insert_mode mode);
> +void amdgpu_gtt_mgr_free_entries(struct amdgpu_gtt_mgr *mgr,
> +				 struct drm_mm_node *mm_node);
>   uint64_t amdgpu_preempt_mgr_usage(struct ttm_resource_manager *man);
>   
>   u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
