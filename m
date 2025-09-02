Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A05CA1005
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 13:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9026410E6FC;
	Tue,  2 Sep 2025 13:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X16wFXvu";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EE110E6FB
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 13:31:37 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-24b14d062acso1467105ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Sep 2025 06:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756819897; x=1757424697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlu/ZSmrhszVqIUBAxFGTkD8R6zV2ggh/C5ayTnTsl8=;
 b=X16wFXvu8Z4yAu7PHQz9fJrY5WYjTcnOPx7XG6f4/8fGbppgyrMxGxnleQnijbs/SO
 MTD5QgicdAMGBx3VN1dbOBQFydMrKqo1IWi6ZyrT8riXemR8uAse5+NjNJJaGWo93CHf
 64/h0X126eRyhfInNlOSl8xtvC9GJBuipS/iXJAMfqdll4g95x4Ko6W0rZXKeC6+twJs
 yDuMl5T77W2OBJh/FBeZz5gYU5VEkRQ+NPowcI7nAEd3XpsIfLt27yFhD1hEVVsDjxNg
 EUc6BQ+1rZeMwVmIuQu7eXWi3M53GglLB7bijLaOI2iGwIV+Fk/ul5Rm2PSuHL1KoIKt
 LS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756819897; x=1757424697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dlu/ZSmrhszVqIUBAxFGTkD8R6zV2ggh/C5ayTnTsl8=;
 b=LY7cTgdQ+iM+mewKhRoJV3HNkX+BbG+zKnZnAXnfFyrDCrEea//F64KzbaeT2ksr+H
 vrpjiFVt438RzZsSEaX50PxgHBVEyCHV/vcLTFCW3KaPPigX9pCumCDf0jox4m5ItWmN
 Wbq1yZ1hl6bU2gms7e39Ua3PDFZzOSxruLc0P9RiY2JwfJ6jJ0j3y1Jx6JK1c2vnOlw5
 3zfcC6/l2xqsRDDjKgkVd1QF1A3uPeXNYUqjNNsFdYQOe5ueb7hNp5PGxkUU4SB2+Qbj
 OiyCri3wHEylHsGjP/8psh6f/Pgrsh5g6JeGG1UTwwmivmBc7MJu2IRs4qneAbDlZou3
 0VRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuZxk6bafCLmarwYyJdXjMRx1WYTlqgzDPInvVKgYXrKuVg7e47T07ZPfVRrWgtgI0fsj8DwSb@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/qmXcnmOfsn5JDJn8xUR5QjILTxa1eNxYgI/XpWa2Vv3AAyyp
 3ycgh8trQQ+8i+Bk+m8PKGY8zlmfP2ktTRIbvR8m3WxUU+d8AeuI2ZL2U7FJ7nPtpnxznW2ZiuC
 KrdTf0w4oOrRBmrFtBWRtoTnoIE5Tl0E=
X-Gm-Gg: ASbGncugznJ9HsOz3SRv8RNRIfTJoAS22BVmUCseMBOE6lmGtzH2o1mViIiOOrow1jX
 qsQlxriGod8uwJkz1aQaXpyyHyrAvPKMVIWyKMRdyXA+LMiqKe+0NrGDb1+70b00kztd6cWzUO9
 jy9sHK7h5OCd295PcT47vXiyqkVbOMRzM9R1dcKKWR6h0tSCwWbsqOshs62GSrCb7J+4VSuyus2
 Vw/9dAMIYwaQj2qnw==
X-Google-Smtp-Source: AGHT+IHMgAwkXd2MMEQqH3nvm3s9m4N0I2tkENr69/qK245SIUSIApWfA/pEKenHePvhLsxJTSYYO6XmJaL2SK19gdE=
X-Received: by 2002:a17:903:22c6:b0:248:dec9:4d2e with SMTP id
 d9443c01a7336-2491f1386ccmr95408675ad.7.1756819896799; Tue, 02 Sep 2025
 06:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
 <20250902032938.468332-8-srinivasan.shanmugam@amd.com>
 <c1e61d59-b8e7-485d-8e75-34bc306a430b@amd.com>
 <CADnq5_O59on_=wt6ayS-JWY7ZVCzO0EdvikeQAAv6hG_++bZxQ@mail.gmail.com>
 <50b38fdd-93c8-4176-affc-6435aac7640f@amd.com>
In-Reply-To: <50b38fdd-93c8-4176-affc-6435aac7640f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Sep 2025 09:31:24 -0400
X-Gm-Features: Ac12FXyY-0DObYJeZrUE-VpNYmY596xJepQ01dKuT4zfAgu1itINk70Q0tPB4MQ
Message-ID: <CADnq5_OonK_eFiom_0VnFzSEJe2Z=CUSxK8nSt8QFq2bkLfHnQ@mail.gmail.com>
Subject: Re: [PATCH v6 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
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

On Tue, Sep 2, 2025 at 9:27=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 02.09.25 15:25, Alex Deucher wrote:
> > On Tue, Sep 2, 2025 at 3:38=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 02.09.25 05:29, Srinivasan Shanmugam wrote:
> >>> Add mmio_remap bookkeeping to amdgpu_device and introduce
> >>> amdgpu_ttm_mmio_remap_bo_init()/fini() to manage a kernel-owned,
> >>> one-page (4K) BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP.
> >>>
> >>> Bookkeeping:
> >>>   - adev->rmmio_remap.bo : kernel-owned singleton BO
> >>>
> >>> The BO is allocated during TTM init when a remap bus address is avail=
able
> >>> (adev->rmmio_remap.bus_addr) and PAGE_SIZE <=3D AMDGPU_GPU_PAGE_SIZE =
(4K),
> >>> and freed during TTM fini.
> >>>
> >>> v2:
> >>>  - Check mmio_remap bus address (adev->rmmio_remap.bus_addr) instead =
of
> >>>    rmmio_base. (Alex)
> >>>  - Skip quietly if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE or no bus address
> >>>    (no warn). (Alex)
> >>>  - Use `amdgpu_bo_create()` (not *_kernel) - Only with this The objec=
t
> >>>    is stored in adev->mmio_remap.bo and will later be exposed to
> >>>    userspace via a GEM handle. (Christian)
> >>>
> >>> v3:
> >>>  - Remove obvious comment before amdgpu_ttm_mmio_remap_bo_fini() call=
.
> >>>    (Alex)
> >>>
> >>> v4:
> >>>  - Squash bookkeeping into this patch
> >>>  - Place longer declaration first; clear bp via memset
> >>>  - Reserve + pin + kmap(+kunmap) the BO at init; unpin in fini
> >>>    (Christian)
> >>>
> >>> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> >>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 87 +++++++++++++++++++++++=
++
> >>>  2 files changed, 88 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu.h
> >>> index ddd472e56f69..24501d3fbefe 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >>> @@ -752,6 +752,7 @@ typedef void (*amdgpu_block_wreg_t)(struct amdgpu=
_device*, uint32_t, uint32_t, u
> >>>  struct amdgpu_mmio_remap {
> >>>       u32 reg_offset;
> >>>       resource_size_t bus_addr;
> >>> +     struct amdgpu_bo *bo;
> >>>  };
> >>>
> >>>  /* Define the HW IP blocks will be used in driver , add more if nece=
ssary */
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ttm.c
> >>> index 1a68ba17a62d..0d03e3a6f92d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> @@ -1854,6 +1854,87 @@ static void amdgpu_ttm_pools_fini(struct amdgp=
u_device *adev)
> >>>       adev->mman.ttm_pools =3D NULL;
> >>>  }
> >>>
> >>> +/**
> >>> + * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_RE=
MAP BO
> >>> + * @adev: amdgpu device
> >>> + *
> >>> + * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP =
when the
> >>> + * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and th=
e host
> >>> + * PAGE_SIZE is <=3D AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as=
 a regular
> >>> + * GEM object (amdgpu_bo_create).
> >>> + *
> >>> + * Return:
> >>> + *  * 0 on success or intentional skip (feature not present/unsuppor=
ted)
> >>> + *  * negative errno on allocation failure
> >>> + */
> >>> +static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
> >>> +{
> >>> +     struct amdgpu_bo_param bp;
> >>> +     int r;
> >>
> >>> +     void *kptr;
> >>
> >> kptr should potentially be saved in amdgpu_mmio_remap.
> >>
> >>> +
> >>> +     /* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GP=
U_PAGE_SIZE (4K). */
> >>> +     if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_=
SIZE)
> >>> +             return 0;
> >>> +
> >>> +     memset(&bp, 0, sizeof(bp));
> >>> +
> >>> +     /* Create exactly one GEM BO in the MMIO_REMAP domain. */
> >>> +     bp.type        =3D ttm_bo_type_device;          /* userspace-ma=
ppable GEM */
> >>> +     bp.size        =3D AMDGPU_GPU_PAGE_SIZE;        /* 4K */
> >>> +     bp.byte_align  =3D AMDGPU_GPU_PAGE_SIZE;
> >>> +     bp.domain      =3D AMDGPU_GEM_DOMAIN_MMIO_REMAP;
> >>> +     bp.flags       =3D 0;
> >>> +     bp.resv        =3D NULL;
> >>> +     bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> >>> +
> >>> +     r =3D amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
> >>> +     if (r)
> >>> +             return r;
> >>> +
> >>> +     r =3D amdgpu_bo_reserve(adev->rmmio_remap.bo, false);
> >>
> >> The last parameter should probably be true here.
> >>
> >>> +     if (r)
> >>> +             goto err_unref;
> >>> +
> >>> +     r =3D amdgpu_bo_pin(adev->rmmio_remap.bo, AMDGPU_GEM_DOMAIN_MMI=
O_REMAP);
> >>> +     if (r)
> >>> +             goto err_unres;
> >>> +
> >>> +     r =3D amdgpu_bo_kmap(adev->rmmio_remap.bo, &kptr);
> >
> > Can't we just skip this?  We don't need the CPU address in the kernel.
>
> I thought you suggested to use the remapped HDP registers for the HDP flu=
sh in the kernel as well?
>
> If we don't want to do this we can just skip this.

In the kernel we just use the existing mmio memory map via the WREG()
macros.  Using this other buffer would just complicate things.

Alex

>
> Christian.
>
> >
> > Alex
> >
> >>> +     if (r)
> >>> +             goto err_unpin;
> >>> +
> >>> +     amdgpu_bo_kunmap(adev->rmmio_remap.bo);
> >>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> >>> +     return 0;
> >>> +
> >>> +err_unpin:
> >>> +     amdgpu_bo_unpin(adev->rmmio_remap.bo);
> >>> +err_unres:
> >>> +     amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> >>> +err_unref:
> >>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
> >>> +     adev->rmmio_remap.bo =3D NULL;
> >>> +     return r;
> >>> +}
> >>> +
> >>> +/**
> >>> + * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
> >>> + * @adev: amdgpu device
> >>> + *
> >>> + * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
> >>> + * amdgpu_ttm_mmio_remap_bo_init().
> >>> + */
> >>> +static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev=
)
> >>> +{
> >>> +     if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, false)) {
> >>
> >> Same here.
> >>
> >> Apart from that looks good to me, feel free to add my rb.
> >>
> >> Regards,
> >> Christian.
> >>
> >>> +             amdgpu_bo_unpin(adev->rmmio_remap.bo);
> >>> +             amdgpu_bo_unreserve(adev->rmmio_remap.bo);
> >>> +     }
> >>> +     amdgpu_bo_unref(&adev->rmmio_remap.bo);
> >>> +     adev->rmmio_remap.bo =3D NULL;
> >>> +}
> >>> +
> >>>  /*
> >>>   * amdgpu_ttm_init - Init the memory management (ttm) as well as var=
ious
> >>>   * gtt/vram related fields.
> >>> @@ -2028,6 +2109,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev=
)
> >>>               return r;
> >>>       }
> >>>
> >>> +     /* Allocate the singleton MMIO_REMAP BO (4K) if supported */
> >>> +     r =3D amdgpu_ttm_mmio_remap_bo_init(adev);
> >>> +     if (r)
> >>> +             return r;
> >>> +
> >>>       /* Initialize preemptible memory pool */
> >>>       r =3D amdgpu_preempt_mgr_init(adev);
> >>>       if (r) {
> >>> @@ -2091,6 +2177,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev=
)
> >>>       amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> >>>                                       &adev->mman.sdma_access_ptr);
> >>>
> >>> +     amdgpu_ttm_mmio_remap_bo_fini(adev);
> >>>       amdgpu_ttm_fw_reserve_vram_fini(adev);
> >>>       amdgpu_ttm_drv_reserve_vram_fini(adev);
> >>>
> >>
>
