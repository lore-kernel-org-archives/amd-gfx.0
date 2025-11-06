Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAC7CCFA05
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 17:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31AA310E990;
	Thu,  6 Nov 2025 17:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ltqdjhvy";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92FB410E990
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 17:10:18 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b983fbc731bso85631a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762449018; x=1763053818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qlud7mJ7kdfHb7Ts67H1pJKMMvRlXy6jj2s32/zJgFs=;
 b=LtqdjhvyQioRqEn0eKzfwnnNaYONU/pdIqf4WBLfe8DWNLdEHRSLBOS/79f+YCU1ub
 Luo2FWe9Swof22ZoQvKVudjoRX20/l/ecfSnExzGiFFvHGDFKQ96mC5p+YmnePVjfhUD
 xQ0iCu0HRo32NpW8dL0fHhVxakuMzJXOoihFMjvuOUMCs3ThcdIQojMDMT4D7akNxkBr
 3lEjsMJtDS4RdbmL7tYrVrJ6N7YSBVWIJUh6IEC6JH6wxoOoj9LM32C1LjA2DMMFEyAR
 LTFCb1lGjjid4Lt8VA5Y+uGeKufNjWwW+uqr+n6mVZ9gaXdGsaak54GStjkt1G50ZugN
 cpgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762449018; x=1763053818;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qlud7mJ7kdfHb7Ts67H1pJKMMvRlXy6jj2s32/zJgFs=;
 b=NZxRmIIpULYCL2n3WotphlEIi5by1yxuiS96QJ4h+nEfNv9s6Uigrmgg1VljGuLazf
 +cj3+UoLVuM0YydQsyl5iljDZG/hIYqPzVYuHLl4w4URNzH8PCrlQt32rXS5GipfZDeV
 JZm27i3kxtwUCtQuV/WCaG8svq91nvASGKLiztM8V7DPl1YBQPTYwEdU5RiiqdrAfUGI
 gv4h1o14K4yWCtwX5YWSuY9T5wABG9tpEOp+x3aaGjo2LG/2FsQARUb1LCmY7Ff+XoKM
 r2mCFsNG+Sp9IMtUfPT/WjTbP64A/KItHZPtT28d1is0eVZy1SNI19si+wp9Un28DzHV
 vYDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVM4erF5BQXrL74LgzTayN4KkS1VBL0xjQE7YBlSUhXETXFkZ/pI8SaRxdXjWrppX9waaflwUb0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxS7ybkfUURSCLZidpeqc4GOCG++GoLoD2Q8cD05BWKpASzNycT
 l7H0vCEWV1dR1UwqJwiANP+yRRxfCxpZiSLDv0nBMTi433whJk13ayErCsMbwMezhLa4PbREMNT
 Ot2dPgEbspr4fA/4DR37LJK6cPdMsHJ8=
X-Gm-Gg: ASbGncsmLg6ZLIM4BS4N2UnizO0CgHnk63+Q6Ykcd3YIPmEtx4La+6cPFOsDZBh++ur
 PHs3gtimbX2KHilRJM47dmioGX93tIFYFy2p2Aal9QIZt1513pDtVeDPyuO7nc9lLMzJgNnt22e
 pL1lbvQqJR7fd5HXDX6txeuDaitkJQd+NP346ly/mPCeKtjvIvV2tVretgsil8DeF1whWPdgrIR
 oDKWEkFI1ETKuh7ljKrkhiZNvDl5ZnqJnLYUx0ivlkbISyhYUKZdg+7l9S8uog7XgFJF90sgPNk
 g1748g==
X-Google-Smtp-Source: AGHT+IGqlbZOoP0cXrVKrdt9Gd68WDTQyaCPQKCKsp2EIm+ClNY362fwpsRtGPk/tuxKObHj0CIQ2ok/7Xw8bDPBEAs=
X-Received: by 2002:a17:903:1cd:b0:296:4e0c:8013 with SMTP id
 d9443c01a7336-297c045d1ecmr1264855ad.6.1762449017841; Thu, 06 Nov 2025
 09:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
 <20251006141654.32291-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20251006141654.32291-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Nov 2025 12:10:06 -0500
X-Gm-Features: AWmQ_bnZVEMBxFtnngl9RTJPBbpRF7F91nNUfyHagH5B9hJiN-HhIs44-v2YPjk
Message-ID: <CADnq5_Pq+mGqMDV_nnKvQ1CbMu7eM2dVU8Q+MfJyM-FwRnO-8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/amdgpu: Map/Unmap MMIO_REMAP as BAR register
 window; add TTM sg helpers; wire dma-buf
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Oct 6, 2025 at 10:36=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> MMIO_REMAP (HDP flush page) exposes a hardware MMIO register window via
> a PCI BAR; there are no struct pages backing it (not normal RAM).  But
> when one device shares memory with another through dma-buf, the receiver
> still expects a delivery route=E2=80=94a list of DMA-able chunks=E2=80=94=
called an
> sg_table. For the BAR window, we can=E2=80=99t (no pages!), so we instead=
 create
> a one-entry list that points directly to the BAR=E2=80=99s physical bus a=
ddress
> and tell DMA: =E2=80=9Cuse this I/O span.=E2=80=9D - A single, contiguous=
 byte range on
> the PCI bus (start DMA address + length)). That=E2=80=99s why we map it w=
ith
> dma_map_resource() and set sg_set_page(..., NULL, ...). Perform DMA
> reads/writes directly to that range so we build an sg_table from a BAR
> physical span and map it with dma_map_resource().
>
> This patch centralizes the BAR-I/O mapping in TTM and wires dma-buf to
> it:
>
> Add amdgpu_ttm_mmio_remap_alloc_sgt() /
> amdgpu_ttm_mmio_remap_free_sgt(). They walk the TTM resource via
> amdgpu_res_cursor, add the byte offset to adev->rmmio_remap.bus_addr,
> build a one-entry sg_table with sg_set_page(NULL, =E2=80=A6), and map/unm=
ap it
> with dma_map_resource().
>
> In dma-buf map/unmap, if the BO is in AMDGPU_PL_MMIO_REMAP, call the new
> helpers.
>
> Single place for BAR-I/O handling: amdgpu_ttm.c in
> amdgpu_ttm_mmio_remap_alloc_sgt() and ..._free_sgt().
> No struct pages: sg_set_page(sg, NULL, cur.size, 0); inside
> amdgpu_ttm_mmio_remap_alloc_sgt().
> Minimal sg_table: sg_alloc_table(*sgt, 1, GFP_KERNEL); inside
> amdgpu_ttm_mmio_remap_alloc_sgt().
> Hooked into dma-buf: amdgpu_dma_buf_map()/unmap() in amdgpu_dma_buf.c
> call these helpers for AMDGPU_PL_MMIO_REMAP.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 18 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 80 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  9 +++
>  3 files changed, 107 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_dma_buf.c
> index ff98c87b2e0b..2fbd6d458a6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -37,6 +37,7 @@
>  #include "amdgpu_dma_buf.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_vm.h"
> +#include "amdgpu_ttm.h"
>  #include <drm/amdgpu_drm.h>
>  #include <drm/ttm/ttm_tt.h>
>  #include <linux/dma-buf.h>
> @@ -210,6 +211,14 @@ static struct sg_table *amdgpu_dma_buf_map(struct dm=
a_buf_attachment *attach,
>                 if (r)
>                         return ERR_PTR(r);
>                 break;
> +
> +       case AMDGPU_PL_MMIO_REMAP:
> +               r =3D amdgpu_ttm_mmio_remap_alloc_sgt(adev, bo->tbo.resou=
rce,
> +                                                   attach->dev, dir, &sg=
t);
> +               if (r)
> +                       return ERR_PTR(r);
> +               break;
> +
>         default:
>                 return ERR_PTR(-EINVAL);
>         }
> @@ -235,6 +244,15 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_atta=
chment *attach,
>                                  struct sg_table *sgt,
>                                  enum dma_data_direction dir)
>  {
> +       struct drm_gem_object *obj =3D attach->dmabuf->priv;
> +       struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
> +
> +       if (bo->tbo.resource &&
> +           bo->tbo.resource->mem_type =3D=3D AMDGPU_PL_MMIO_REMAP) {
> +               amdgpu_ttm_mmio_remap_free_sgt(attach->dev, dir, sgt);
> +               return;
> +       }
> +
>         if (sg_page(sgt->sgl)) {
>                 dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>                 sg_free_table(sgt);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index d4c93c78b80a..17ea079bd96f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1102,6 +1102,86 @@ static void amdgpu_ttm_backend_destroy(struct ttm_=
device *bdev,
>         kfree(gtt);
>  }
>
> +/**
> + * amdgpu_ttm_mmio_remap_alloc_sgt - build an sg_table for MMIO_REMAP I/=
O aperture
> + * @adev: amdgpu device providing the remap BAR base (adev->rmmio_remap.=
bus_addr)
> + * @res:  TTM resource of the BO to export; expected to live in AMDGPU_P=
L_MMIO_REMAP
> + * @dev:  importing device to map for (typically @attach->dev in dma-buf=
 paths)
> + * @dir:  DMA data direction for the importer (passed to dma_map_resourc=
e())
> + * @sgt:  output; on success, set to a newly allocated sg_table describi=
ng the I/O span
> + *
> + * The HDP flush page (AMDGPU_PL_MMIO_REMAP) is a fixed hardware I/O win=
dow in a PCI
> + * BAR=E2=80=94there are no struct pages to back it. Importers still nee=
d a DMA address list,
> + * so we synthesize a minimal sg_table and populate it from dma_map_reso=
urce(), not
> + * from pages. Using the common amdgpu_res_cursor walker keeps the offse=
t/size math
> + * consistent with other TTM/manager users.
> + *
> + * - @res is assumed to be a small, contiguous I/O region (typically a s=
ingle 4 KiB
> + *   page) in AMDGPU_PL_MMIO_REMAP. Callers should validate placement be=
fore calling.
> + * - The sg entry is created with sg_set_page(sg, NULL, =E2=80=A6) to re=
flect I/O space.
> + * - The mapping uses DMA_ATTR_SKIP_CPU_SYNC because this is MMIO, not c=
acheable RAM.
> + * - Peer reachability / p2pdma policy checks must be done by the caller=
.
> + *
> + * Return:
> + * * 0 on success, with *@sgt set to a valid table that must be freed vi=
a
> + *   amdgpu_ttm_mmio_remap_free_sgt().
> + * * -ENOMEM if allocation of the sg_table fails.
> + * * -EIO if dma_map_resource() fails.
> + *
> + */
> +int amdgpu_ttm_mmio_remap_alloc_sgt(struct amdgpu_device *adev,
> +                                   struct ttm_resource *res,
> +                                   struct device *dev,
> +                                   enum dma_data_direction dir,
> +                                   struct sg_table **sgt)
> +{
> +       struct amdgpu_res_cursor cur;
> +       dma_addr_t dma;
> +       resource_size_t phys;
> +       struct scatterlist *sg;
> +       int r;
> +
> +       /* Walk the resource once; MMIO_REMAP is expected to be contiguou=
s+small. */
> +       amdgpu_res_first(res, 0, res->size, &cur);
> +
> +       /* Translate byte offset in the remap window into a host physical=
 BAR address. */
> +       phys =3D adev->rmmio_remap.bus_addr + cur.start;
> +
> +       /* Build a single-entry sg_table mapped as I/O (no struct page ba=
cking). */
> +       *sgt =3D kzalloc(sizeof(**sgt), GFP_KERNEL);
> +       if (!*sgt)
> +               return -ENOMEM;
> +       r =3D sg_alloc_table(*sgt, 1, GFP_KERNEL);
> +       if (r) {
> +               kfree(*sgt);
> +               return r;
> +       }
> +       sg =3D (*sgt)->sgl;
> +       sg_set_page(sg, NULL, cur.size, 0);  /* WHY: I/O space =E2=86=92 =
no pages */
> +
> +       dma =3D dma_map_resource(dev, phys, cur.size, dir, DMA_ATTR_SKIP_=
CPU_SYNC);
> +       if (dma_mapping_error(dev, dma)) {
> +               sg_free_table(*sgt);
> +               kfree(*sgt);
> +               return -EIO;
> +       }
> +       sg_dma_address(sg) =3D dma;
> +       sg_dma_len(sg) =3D cur.size;
> +       return 0;
> +}
> +
> +void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
> +                                   enum dma_data_direction dir,
> +                                   struct sg_table *sgt)
> +{
> +       struct scatterlist *sg =3D sgt->sgl;
> +
> +       dma_unmap_resource(dev, sg_dma_address(sg), sg_dma_len(sg),
> +                          dir, DMA_ATTR_SKIP_CPU_SYNC);
> +       sg_free_table(sgt);
> +       kfree(sgt);
> +}
> +
>  /**
>   * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.h
> index a8379b925878..116f3bb1d64b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -233,4 +233,13 @@ int amdgpu_ttm_evict_resources(struct amdgpu_device =
*adev, int mem_type);
>
>  void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
>
> +int amdgpu_ttm_mmio_remap_alloc_sgt(struct amdgpu_device *adev,
> +                                   struct ttm_resource *res,
> +                                   struct device *dev,
> +                                   enum dma_data_direction dir,
> +                                   struct sg_table **sgt);
> +void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
> +                                   enum dma_data_direction dir,
> +                                   struct sg_table *sgt);
> +
>  #endif
> --
> 2.34.1
>
