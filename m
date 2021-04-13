Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB2C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54408613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 13:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54408613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0144289C51;
	Tue, 13 Apr 2021 13:25:41 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFFC489C21
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 13:25:39 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id a21so3892222oib.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LiWS38A3THYpXOen6RXlftk1ExUrQQy+tFnKxWssi6A=;
 b=ZyDapzBGmIQJnp8U180OxmyrIcGqe8Sqh3UpfBEGKcN+c+IM2kst4XRHxaylJq1e/W
 kdPm+ft1E9/LsGFxKhaW4nwBmZj8hcVrkYxoOXxiEmQW/CeKg5TwADIalUgtLoMa9uDV
 aibi9E9mVRZZg3yM7mjGCQKbshGYbiFX8+uF3JsaC0Q/WN9/r0WWteu3KM6BBi0newoI
 If4XloVIpiUHVdEKHmxEr11MHpuFEgodNlWYXZOW9cJFOFQsNBx0aXciAV7IELN4k4iJ
 nl2lKR4bDWmmwwnuBzxqZNAtJ1fCEJ7ZnBn6MZ4wlgMm4ZHronPmkCX/a85exVyMsTb0
 AWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LiWS38A3THYpXOen6RXlftk1ExUrQQy+tFnKxWssi6A=;
 b=TJ98AUIYNWkcaKkJCjjAk7ioqdfqJGjNcgOzerN2mW6/SBZ+d85vdgLh4NSONEkdEa
 tBI8EvlNAbiQlcJcAPCYNPIqdZuxTcyfzbtW4aBHw9rvBTV2MkBsLiCFG32NcLU19I6w
 9LxzMnyDb/WQ2U3I75fomnQB551cHgOPV3aFDofDA8Mr53Mz6zpDGwcLgU7UWr87WUah
 IfbLdG2mhDXRGcXXcjbr0t+OqnIkuijUdnD8DfhjlV2Ik3MMJhF1nGODK4jLbqy+G7fW
 qQg5zqVqBcej4i3ADuloTLfBJR9ctJl0bT8Q6EjrKGyQnQflgRVOfCnYsdnwBarKzAGz
 P9wg==
X-Gm-Message-State: AOAM5334lERsZRIQJdeAp8CoZ/jS9JbPvC7ZG+D3U/rlR/lbhFNmHs5s
 AnJa9bLqxbrp7cTiGZyYdH0PfLauJbcUNq6ldLE=
X-Google-Smtp-Source: ABdhPJw4AtIJCgqAzIMdxqS4RqDirZflSs0s9NRvI0flU1Ts1as8WLe5W5GMwgARaG3EFfs1DiQhMXzusa5XfjPf85g=
X-Received: by 2002:a05:6808:68a:: with SMTP id
 k10mr17735oig.120.1618320339154; 
 Tue, 13 Apr 2021 06:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210412232744.8655-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20210412232744.8655-1-Ramesh.Errabolu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Apr 2021 09:25:28 -0400
Message-ID: <CADnq5_O87pRjNkPm=nAwD8DmP+vs9HS7zpmNdhTTQ-FvAnbFng@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use iterator methods exposed by
 amdgpu_res_cursor.h in building SG_TABLE's for a VRAM BO
To: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 12, 2021 at 7:28 PM Ramesh Errabolu <Ramesh.Errabolu@amd.com> wrote:
>
> Extend current implementation of SG_TABLE construction method to
> allow exportation of sub-buffers of a VRAM BO. This capability will
> enable logical partitioning of a VRAM BO into multiple non-overlapping
> sub-buffers. One example of this use case is to partition a VRAM BO
> into two sub-buffers, one for SRC and another for DST.
>
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 32 ++++++++++++++------
>  3 files changed, 27 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index e0c4f7c7f1b9..57534b93bd91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -255,6 +255,7 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>         struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>         struct sg_table *sgt;
> +       u64 num_bytes;
>         long r;
>
>         if (!bo->tbo.pin_count) {
> @@ -291,8 +292,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>                 break;
>
>         case TTM_PL_VRAM:
> -               r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, attach->dev,
> -                                             dir, &sgt);
> +               num_bytes = bo->tbo.mem.num_pages << PAGE_SHIFT;
> +               r = amdgpu_vram_mgr_alloc_sgt(adev, &bo->tbo.mem, 0, num_bytes,
> +                                             attach->dev, dir, &sgt);
>                 if (r)
>                         return ERR_PTR(r);
>                 break;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index dec0db8b0b13..9e38475e0f8d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -112,6 +112,7 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man);
>  u64 amdgpu_vram_mgr_bo_visible_size(struct amdgpu_bo *bo);
>  int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>                               struct ttm_resource *mem,
> +                             u64 offset, u64 size,
>                               struct device *dev,
>                               enum dma_data_direction dir,
>                               struct sg_table **sgt);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 592a2dd16493..fcdee0deba16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -25,6 +25,7 @@
>  #include <linux/dma-mapping.h>
>  #include "amdgpu.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_res_cursor.h"
>  #include "amdgpu_atomfirmware.h"
>  #include "atom.h"
>
> @@ -565,6 +566,8 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>   *
>   * @adev: amdgpu device pointer
>   * @mem: TTM memory object
> + * @offset: byte offset from the base of VRAM BO
> + * @length: number of bytes to export in sg_table
>   * @dev: the other device
>   * @dir: dma direction
>   * @sgt: resulting sg table
> @@ -573,39 +576,45 @@ static void amdgpu_vram_mgr_del(struct ttm_resource_manager *man,
>   */
>  int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>                               struct ttm_resource *mem,
> +                             u64 offset, u64 length,
>                               struct device *dev,
>                               enum dma_data_direction dir,
>                               struct sg_table **sgt)
>  {
> -       struct drm_mm_node *node;
> +       struct amdgpu_res_cursor cursor;
>         struct scatterlist *sg;
>         int num_entries = 0;
> -       unsigned int pages;
>         int i, r;
>
>         *sgt = kmalloc(sizeof(**sgt), GFP_KERNEL);
>         if (!*sgt)
>                 return -ENOMEM;
>
> -       for (pages = mem->num_pages, node = mem->mm_node;
> -            pages; pages -= node->size, ++node)
> -               ++num_entries;
> +       // Determine the number of DRM_MM nodes to export
> +       amdgpu_res_first(mem, offset, length, &cursor);
> +       while (cursor.remaining) {
> +               num_entries++;
> +               amdgpu_res_next(&cursor, cursor.size);
> +       }
>
>         r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
>         if (r)
>                 goto error_free;
>
> +       // Initialize scatterlist nodes of sg_table
>         for_each_sgtable_sg((*sgt), sg, i)
>                 sg->length = 0;
>
> -       node = mem->mm_node;
> +       // Walk down DRM_MM nodes to populate scatterlist nodes
> +       // @note: Use iterator api to get first the DRM_MM node
> +       // and the number of bytes from it. Access the following
> +       // DRM_MM node(s) if more buffer needs to exported

Please use C style comments for consistency.

Alex

> +       amdgpu_res_first(mem, offset, length, &cursor);
>         for_each_sgtable_sg((*sgt), sg, i) {
> -               phys_addr_t phys = (node->start << PAGE_SHIFT) +
> -                       adev->gmc.aper_base;
> -               size_t size = node->size << PAGE_SHIFT;
>                 dma_addr_t addr;
> +               size_t size = cursor.size;
> +               phys_addr_t phys = cursor.start + adev->gmc.aper_base;
>
> -               ++node;
>                 addr = dma_map_resource(dev, phys, size, dir,
>                                         DMA_ATTR_SKIP_CPU_SYNC);
>                 r = dma_mapping_error(dev, addr);
> @@ -615,7 +624,10 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>                 sg_set_page(sg, NULL, size, 0);
>                 sg_dma_address(sg) = addr;
>                 sg_dma_len(sg) = size;
> +
> +               amdgpu_res_next(&cursor, cursor.size);
>         }
> +
>         return 0;
>
>  error_unmap:
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
