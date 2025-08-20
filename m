Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE98CA0EF8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 21:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1479810E7FA;
	Wed, 20 Aug 2025 21:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXW38PET";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F22010E7FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 21:29:12 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-245f580c6e5so566725ad.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755725352; x=1756330152; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeTwEeZ/P0WNw2bg1L/IOxweS2LJiTvsHMWsWm+UXmQ=;
 b=jXW38PETW1BMdyJ11piiRVpsPeZ1e8zyaya3cA9xXhSamskXjSxQJeLoz4h7BhHtts
 qN9uj6sVk4qPaA2QKJmsT9ss0YPHynmyH7qe954HSVTm8kbZ/yhXtUxfsvr2mW7jOqT7
 BSeq97xo5QuGjK/E9O+coFJvRXTCUI3yuR2spLSmIbOIJhrKXz9zBpUBs1DWJNabbbw0
 duMMOSk5QMyado6AMX2Uy9OJAFj0ZklADCpbGzQzRWhabTjlcKlaCdxYga1lxvxvcpfH
 SaPPv5sUvFevr6/qOkP9FbyZAJ73ewwnsd50dghuf6OLda+kqr602Bb6Pjgmon0qcow9
 tqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755725352; x=1756330152;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UeTwEeZ/P0WNw2bg1L/IOxweS2LJiTvsHMWsWm+UXmQ=;
 b=n11Mw4iokVJOvlmivHf98FOkS3PmmLUKwgZFFgbX8AQFzGZmGZtOvNtGcbfi3cP+up
 /zAgCo0vwd8EGV4675OybCI+v2KLm8WC+PTXzsmOqE6yVWGxsHlTyU/nRwN+9eTWybZ1
 1/NekxxvWOqer9rWEng4mwaZTTdSKXvGrMS99Wclz5G7GRqAvCqCe+BpHC+9Eqg/D7gR
 aNuM7LXSfKlbJgcAKOc1L/IxYBrxaKoQqzLKneg3EpM7/LDIgWIYNCH8CRns2jSMtKwv
 nJtZvSXE2vEKQEQm+EPpV7NjcQ6smUx+w/M6kDPggVB8VkrYBDDbKH8OJ6wI+tL6HnE3
 RAIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBPstREQgIH7m24BSKiut3GNsBJHjOP3BFjBmArhAeZeXT7CjCopYGliruuRsccIPC77fHw77o@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrRAq6upFtvFb80VG25BKw4m86jrbl2J6TGE43qrxeImRxgB1s
 7Jl6AmEqVplLYYu5ZcanTGrIoS7EHP0VPwno7IlBCrrmLTOvENXoPSKxNkTUEPqtD9ygCYheaE8
 JodifI9xZ5bws+jOq2wFKWlyTFVpeQ3x5ndrL
X-Gm-Gg: ASbGncsKLPixJksGkbtzUPuKkxWrfM1P5bsRmo8ApryyCT7cCti8icS86B0p9no9YCN
 WYgffyyqOuRyObCCnTHXmyKPUZ9eVMP4dJ0NRZouowusI1ASOZbkTiS5aKPSv0bDwaJtAM4Jkne
 Uy4w1Hsctt50zMFM8m0hE3gYTjOova/wIqmhlvaNl3CdCsOEEH0lLtBrsunnR4r+ylRSAmAoZFC
 eK6HXQ=
X-Google-Smtp-Source: AGHT+IEY4a7njGojTeZvSqR8t1s4y1qbfL9koBJEP914pr4m0iEBIkGU863YIqQhEdgCxHQWtXnhVG8DdbLfSYDNICI=
X-Received: by 2002:a17:902:d4c9:b0:231:c9bb:6105 with SMTP id
 d9443c01a7336-245feae7dfbmr1939605ad.0.1755725351684; Wed, 20 Aug 2025
 14:29:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250820113254.3864753-7-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250820113254.3864753-7-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 17:28:58 -0400
X-Gm-Features: Ac12FXyQCGh_Er3j-y0ykSfCN0nlAnukwsrgHrF-ZY0kJCPALuMCfdwQnjc9rjM
Message-ID: <CADnq5_O0ABmNWSCyjUsPcjZcMr0TuMXXOsUe381cA76Sn7ipoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] drm/amdgpu: Create Singleton MMIO_REMAP BO and
 Initialize its pool
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

On Wed, Aug 20, 2025 at 7:33=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Create the single-page MMIO_REMAP BO and initialize a tiny on-chip
> range manager for the new placement:
>
> * add amdgpu_mmio_remap_bo_init()/fini()
> * in amdgpu_ttm_init(): initialize AMDGPU_PL_MMIO_REMAP heap and create
>   the PAGE_SIZE BO
> * in amdgpu_ttm_fini(): drop BO and tear down the range manager
>
> This isolates lifetime management and error paths for the remap BO and
> ties them into the TTM bring-up/teardown flow.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 86 +++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 157a5416a826..ab93fbec2a34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1859,6 +1859,73 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_de=
vice *adev)
>         adev->mman.ttm_pools =3D NULL;
>  }
>
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D MMIO remap (HDP f=
lush) singleton BO =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
> +static int amdgpu_mmio_remap_bo_init(struct amdgpu_device *adev)

Prefix this function with amdgpu_ttm_ for consistency.

> +{
> +       resource_size_t bar_base, bar_len, bus, off;
> +       int r;
> +
> +       /* The ASIC code should have set this to the absolute bus address
> +        * of the remap page (inside the register BAR).
> +        */
> +       bus =3D adev->rmmio_remap.bus_addr;

Just remove adev->rmmio_remap.bus_addr and use the new
adev->mmio_remap.base that you added.  We don't need two copies.

if the base is 0, then we can just return 0 here.  We can't allocate
the buffer if the PAGE_SIZE is > 4K.

> +       if (!bus) {
> +               dev_dbg(adev->dev, "MMIO_REMAP: no remap bus addr; skippi=
ng BO\n");
> +               return -ENODEV;
> +       }
> +
> +       /* The register BAR base/size were established in amdgpu_device_i=
nit() */
> +       bar_base =3D adev->rmmio_base;
> +       bar_len  =3D adev->rmmio_size;
> +
> +       /* Sanity: page must lie wholly inside the register BAR */
> +       if (bus < bar_base || (bus + PAGE_SIZE) > (bar_base + bar_len)) {
> +               dev_err(adev->dev,
> +                       "MMIO_REMAP: bus 0x%llx not in REG BAR [0x%llx..0=
x%llx)\n",
> +                       (unsigned long long)bus,
> +                       (unsigned long long)bar_base,
> +                       (unsigned long long)(bar_base + bar_len));
> +               return -ERANGE;
> +       }
> +
> +       off =3D bus - bar_base;
> +       if (!IS_ALIGNED(off, PAGE_SIZE)) {
> +               dev_err(adev->dev, "MMIO_REMAP: offset 0x%llx not page-al=
igned\n",
> +                       (unsigned long long)off);
> +               return -EINVAL;
> +       }

All of this can be dropped.

> +
> +       /* Create exactly ONE kernel-owned BO in the MMIO_REMAP domain */
> +       r =3D amdgpu_bo_create_kernel(adev,
> +                                   PAGE_SIZE,                 /* bo_size=
  */
> +                                   PAGE_SIZE,                 /* alignme=
nt*/
> +                                   AMDGPU_GEM_DOMAIN_MMIO_REMAP,
> +                                   &adev->mmio_remap_bo,
> +                                   NULL, NULL);

You can probably just call this directly below rather than adding a
wrapper function.

> +       if (r) {
> +               dev_err(adev->dev, "MMIO_REMAP: BO create failed (%d)\n",=
 r);
> +               return r;
> +       }
> +
> +       dev_dbg(adev->dev,
> +               "MMIO_REMAP: base=3D0x%llx off=3D0x%llx size=3D0x%lx (BO =
created)\n",
> +               (unsigned long long)adev->mmio_remap_base,
> +               (unsigned long long)adev->mmio_remap_offset,
> +               (unsigned long)adev->mmio_remap_size);
> +
> +       return 0;
> +}
> +
> +static void amdgpu_mmio_remap_bo_fini(struct amdgpu_device *adev)
> +{
> +
> +       if (adev->mmio_remap_bo)
> +               amdgpu_bo_free_kernel(&adev->mmio_remap_bo, NULL, NULL);
> +       adev->mmio_remap_bo =3D NULL;

Same here.

> +
> +       return;
> +}
> +
>  /*
>   * amdgpu_ttm_init - Init the memory management (ttm) as well as various
>   * gtt/vram related fields.
> @@ -2026,6 +2093,20 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>                 return r;
>         }
>
> +       /* Initialize MMIO-remap pool (single page) */
> +       r =3D amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
> +       if (r) {
> +               dev_err(adev->dev, "Failed initializing MMIO-remap heap.\=
n");
> +               return r;
> +       }
> +
> +       /* Create the singleton MMIO-remap BO (one page) */
> +       r =3D amdgpu_mmio_remap_bo_init(adev);
> +       if (r) {
> +               dev_err(adev->dev, "Failed to create MMIO-remap singleton=
 BO.\n");
> +               return r;
> +       }

This could be split into a separate patch.  One patch to create the
heap and a separate patch to allocate the BO.

> +
>         /* Initialize preemptible memory pool */
>         r =3D amdgpu_preempt_mgr_init(adev);
>         if (r) {
> @@ -2088,6 +2169,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         }
>         amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
>                                         &adev->mman.sdma_access_ptr);
> +
> +       /* =3D=3D=3D Drop the singleton MMIO-remap BO =3D=3D=3D */

Drop this comment.

> +       amdgpu_mmio_remap_bo_fini(adev);
>         amdgpu_ttm_fw_reserve_vram_fini(adev);
>         amdgpu_ttm_drv_reserve_vram_fini(adev);
>
> @@ -2109,6 +2193,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>         ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
> +       /* Tear down the tiny range manager for MMIO-remap */

Drop this comment.

Alex

> +       ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
>         ttm_device_fini(&adev->mman.bdev);
>         adev->mman.initialized =3D false;
>         dev_info(adev->dev, "amdgpu: ttm finalized\n");
> --
> 2.34.1
>
