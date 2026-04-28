Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62E2FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 16:00:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F0510E338;
	Tue, 28 Apr 2026 16:00:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mekTfX0j";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 076A610E338
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 16:00:00 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2dd52990758so737506eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 09:00:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391999; cv=none;
 d=google.com; s=arc-20240605;
 b=X2aQ2OKm/dm4/oGRuzzMMaFbSLn11Vla45OxU4hQuXo0kVGm/9eECyIqcUCCeVBm2e
 UrRiASN7YwXDxNwdXLvx8DVUpWj/yNbX0tC+4CwrZWkPfZG/8WDfCyMvtSWXZTNezU+A
 6nkEZFjYXHF7T1wXGveTeAmO5LKqbdw6XbvX9dnPysIqXjh5KRvQdPnHV4GtpDn8XSNU
 HlCwfPxMiQIuzncuIRb3wM0t/KOb5fmxBQ1/aYkBUUdLOL99qJ38N8t+VnrRz1quT21p
 CfOYY/retH5R4O/P5QWgqGK5wwFWXs0hNlWDDrFvyshrWKSrZcSVj+W0A+BDTycemkxj
 yoLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8D1ogOAlkuJx9BglhMeCnWPKrGZm+swKUWP8ip4Ejic=;
 fh=vwH+z4rW0AhcHXbAs3qH4QlXhPdlWOpRz+aKiYkebl8=;
 b=W+UZ6TLt7+f2aOXtIiOUkEOieszjmp+zVrPmMBQX10RdMddCSX5ld7LcTZaefunQIC
 pQ5TyskxWZVbwRdSRZfHseQCdWD6kcVhnc771dpKnSYLhx6Kgl3PiCRR7EKT2kjGEtv5
 3K2xhr1jHbgs0qvtBHt+cVGnKLea+tjbYXRvGRsZI23P8qPxw8j9Enx190Qm5JiBOgwo
 zIfe67PWVjtx6AEHFMaAS/S/6KvZURDNgC3wbk2QFQ8Mw2hi3qGsLZZFWcjkXza+gfze
 hzLBW12upj4VeYTdOlYWmOnhuNiSZr+nmf9KK/Eh88dSXQGG3xImfzWu6/p/1S2x6yop
 KoVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777391999; x=1777996799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8D1ogOAlkuJx9BglhMeCnWPKrGZm+swKUWP8ip4Ejic=;
 b=mekTfX0juJNGhd3HbjCviudZB7t9agTb7a8ImRRzZfdSe6gCPjqMqYXWZEK4EJuVm4
 p/voBM+uxxSyYHOI1b0vetntblamaWwtwQJTDzbHfr+PLaNRH7y5D+aigwsPXcmzuz2y
 KKjfguCvifAs7U/X4GT2hXWKJervXJnm/QGXe6sp/C+gDtV6puLUmIbffcLsjOLgjwVm
 ppTPFtMwvIutZv0FGgXQ1Q69NXWiityNyIi7IAXk19huZDuYOtKwKoMyeRKWZWjV/ELv
 Xr0ME7gv7DZxxkhcU5e//jMU6PB7ngBY2cdyTd3u1Ee8MpUVSzuYY0zDR6Ans7jwZHbr
 LAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391999; x=1777996799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8D1ogOAlkuJx9BglhMeCnWPKrGZm+swKUWP8ip4Ejic=;
 b=CTffOJBL8p8O4qahVy+h0rkgp6yagxHH/Y0+5104vNytjxlXJjWpOyJEQyYTcU9udx
 NhXdaG1CXKD6XIH8vb1c5o5H8G8FjHwjncEMXQwq7qjpCAjsLHuzDlRovMg9xqP5Lo8J
 HWN0/he5uxXMHoCUao3TBe1UgMAWEGcUfeNKqKX/Q5L3UZx2DJZz2ikgXzMz/zYjT5nE
 JLtAzNiJRM9Q6DwX5N++I98dEEeyeDMQuygF6yU/Ut/feQmn55N6/+1SEp+onHGhnquz
 PWPFiGaY6ypCAKPfysp9SIFsvRKTt5ngqFvKPLEnu0ESbV65bkwTYeALcysAGWAapppN
 V50A==
X-Gm-Message-State: AOJu0YyufvVO/TikLQtvaEUs0HKzrRL2gbi4IRkrJhRs6MzsrkOYqmHp
 1VR9jIPxjOQfwxkcI8dLAycU1iATN739V1A9GIcGoceqSxofkL2ZfLt01+8TTu0utcEo8pgwz8e
 BIrRWMFrJXaI7vmHxIXMDbvO4EceFEYU=
X-Gm-Gg: AeBDietOkv1s2541aB2CP0tUnFMTkYoHnUe1T0N4qx0nD78baLItM9QFapkkKYLgrl+
 KLh5Sz+WszCNRYjuUM/dpSdNq/XDXkoWCmeO6IGFxrWEA7pthaqRB96iq9DeJ4ydWT9F5ZmmBPG
 LwyhTYE6SpHuG6/QXjOsjWHm0rVXWfnwDNIYJCwZXeafHSFihavCf4iq1XbQPHJw+Pwdm8uVxPy
 idUTL3TaMrJk4xxQrefj5BzYDi/1YeqXrs21gtJkauyG5aaOOIFlB52w4Uv684ftF1P+9vLlSfc
 RGyrONBWpl72WZg7uaVGef6ioM+nB7VSoL1lNfOKZdmxR4+wE1zKAF7pFHT8o1tpEZ2WY3O/bzc
 cRJuR
X-Received: by 2002:a05:7022:1e11:b0:119:e56b:c3f3 with SMTP id
 a92af1059eb24-12ddd539b3dmr781861c88.3.1777391998832; Tue, 28 Apr 2026
 08:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260428100239.1609179-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 11:59:45 -0400
X-Gm-Features: AVHnY4LqpblzeDB5SL1Yp6irU6BS88bkfisl2mUI_qsagjuwnTvB8k3YTnPqoBo
Message-ID: <CADnq5_NxjD9X3295RdrMROa9xyoKUVEwm6v2JU7OqwmdreiM=w@mail.gmail.com>
Subject: Re: [PATCH v3 01/11] drm/amdgpu/sdma: add SDMA usermode-queue
 doorbell pool infra
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Prike Liang <Prike.Liang@amd.com>
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

On Tue, Apr 28, 2026 at 6:09=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> Add a per-device qword-slot pool covering the firmware-managed NBIO
> SDMA decode window (BAR dwords [sdma_engine[0],
> sdma_engine[0] + sdma_doorbell_range * num_instances)) =E2=80=94 the only
> range whose writes are routed to the SDMA back-end.  Kernel SDMA ring
> slots are pre-masked at init.
>
> Exposed to userspace via a fixed mmap pgoff sentinel
> (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET, bit 56 of the offset, well above
> DRM's vma_offset_manager range so it can never collide with a real GEM
> mmap offset).  amdgpu_sdma_userq_doorbell_mmap() does
> io_remap_pfn_range() straight into the SDMA decode window.  The
> pgoff-sentinel dispatcher in amdgpu_drm_mmap() and the
> AMDGPU_INFO_USERQ_DOORBELL ioctl that hands the offset to userspace
> land in subsequent patches.  Same general pattern as KFD's
> KFD_MMAP_TYPE_* .
>
> Slots are allocated/freed via amdgpu_sdma_userq_doorbell_alloc/free.
> The init/fini hooks land in the per-engine sdma6/sdma7 patches.

This shouldn't be necessary.  The doorbell offsets are relative to
each 4K page in the doorbell aperture.

Alex

>
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 154 +++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  61 +++++++++
>  2 files changed, 215 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 321310ba2c08..be7e9de0630e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -22,6 +22,8 @@
>   */
>
>  #include <linux/firmware.h>
> +#include <linux/io.h>
> +#include <linux/mm.h>
>  #include "amdgpu.h"
>  #include "amdgpu_sdma.h"
>  #include "amdgpu_ras.h"
> @@ -200,6 +202,158 @@ void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_dev=
ice *adev,
>                sizeof(struct amdgpu_sdma_instance) * AMDGPU_MAX_SDMA_INST=
ANCES);
>  }
>
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev)
> +{
> +       struct amdgpu_sdma_userq_db *db;
> +       u32 base_dw, size_dw, nslots, ring_dw;
> +       int i;
> +
> +       if (!adev->userq_funcs[AMDGPU_HW_IP_DMA])
> +               return 0;
> +
> +       base_dw =3D adev->doorbell_index.sdma_engine[0] << 1;
> +       size_dw =3D adev->doorbell_index.sdma_doorbell_range *
> +                 adev->sdma.num_instances;
> +       nslots  =3D size_dw / 2;  /* qword slots */
> +       if (!nslots)
> +               return 0;
> +
> +       db =3D kzalloc(sizeof(*db), GFP_KERNEL);
> +       if (!db)
> +               return -ENOMEM;
> +
> +       db->phys_base =3D adev->doorbell.base +
> +                       (resource_size_t)base_dw * sizeof(u32);
> +       db->size      =3D size_dw * sizeof(u32);
> +
> +       mutex_init(&adev->sdma.userq_db_mutex);
> +       adev->sdma.userq_db_bitmap =3D bitmap_zalloc(nslots, GFP_KERNEL);
> +       if (!adev->sdma.userq_db_bitmap) {
> +               kfree(db);
> +               return -ENOMEM;
> +       }
> +
> +       adev->sdma.userq_db        =3D db;
> +       adev->sdma.userq_db_nslots =3D nslots;
> +
> +       /*
> +        * Mask out the qword slots used by the kernel SDMA rings
> +        * (sdma_engine[i] << 1 in absolute BAR dwords =E2=87=92 qword sl=
ot
> +        * (sdma_engine[i] - sdma_engine[0]) within this window).
> +        */
> +       for (i =3D 0; i < adev->sdma.num_instances; i++) {
> +               ring_dw =3D adev->doorbell_index.sdma_engine[i] << 1;
> +               if (ring_dw >=3D base_dw && ring_dw < base_dw + size_dw)
> +                       set_bit((ring_dw - base_dw) / 2,
> +                               adev->sdma.userq_db_bitmap);
> +       }
> +
> +       dev_info(adev->dev,
> +                "SDMA UMQ doorbell pool: %u qword slots in BAR dword [%u=
, %u)\n",
> +                nslots, base_dw, base_dw + size_dw);
> +       return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev)
> +{
> +       if (!adev->sdma.userq_db)
> +               return;
> +       bitmap_free(adev->sdma.userq_db_bitmap);
> +       adev->sdma.userq_db_bitmap =3D NULL;
> +       adev->sdma.userq_db_nslots =3D 0;
> +       kfree(adev->sdma.userq_db);
> +       adev->sdma.userq_db =3D NULL;
> +}
> +
> +/*
> + * Allocate one qword doorbell slot.  On success, *out_slot receives the
> + * slot id (also the qword index inside the userspace mmap of the window=
)
> + * which the caller passes back to free.
> + */
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *ou=
t_slot)
> +{
> +       u32 slot;
> +
> +       if (!adev->sdma.userq_db || !adev->sdma.userq_db_nslots)
> +               return -ENODEV;
> +
> +       mutex_lock(&adev->sdma.userq_db_mutex);
> +       slot =3D find_first_zero_bit(adev->sdma.userq_db_bitmap,
> +                                  adev->sdma.userq_db_nslots);
> +       if (slot >=3D adev->sdma.userq_db_nslots) {
> +               mutex_unlock(&adev->sdma.userq_db_mutex);
> +               return -ENOSPC;
> +       }
> +       set_bit(slot, adev->sdma.userq_db_bitmap);
> +       mutex_unlock(&adev->sdma.userq_db_mutex);
> +
> +       *out_slot =3D slot;
> +       return 0;
> +}
> +
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slo=
t)
> +{
> +       if (!adev->sdma.userq_db)
> +               return;
> +       if (slot >=3D adev->sdma.userq_db_nslots)
> +               return;
> +       mutex_lock(&adev->sdma.userq_db_mutex);
> +       clear_bit(slot, adev->sdma.userq_db_bitmap);
> +       mutex_unlock(&adev->sdma.userq_db_mutex);
> +}
> +
> +/*
> + * Report the fake mmap offset/size for the SDMA UMQ doorbell window.
> + *
> + * No drm_gem_object, no GEM handle.  Userspace passes the returned offs=
et
> + * directly to mmap(drm_fd, ...); amdgpu_drm_mmap() recognises the
> + * sentinel pgoff and routes the call to amdgpu_sdma_userq_doorbell_mmap=
()
> + * below, which io_remap_pfn_range()s the routable SDMA doorbell BAR win=
dow.
> + *
> + * Same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL =E2=80=94 the doorbe=
ll window
> + * is unreachable from any drm_gem_object_lookup() / gem_to_amdgpu_bo()
> + * code path because it never enters the GEM object space at all.
> + */
> +int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
> +                                       u64 *mmap_offset, u64 *mmap_size)
> +{
> +       if (!adev->sdma.userq_db)
> +               return -ENODEV;
> +
> +       *mmap_offset =3D AMDGPU_USERQ_DOORBELL_MMAP_OFFSET;
> +       *mmap_size   =3D adev->sdma.userq_db->size;
> +       return 0;
> +}
> +
> +bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff)
> +{
> +       return pgoff =3D=3D (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET >> PAGE_SH=
IFT);
> +}
> +
> +int amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
> +                                   struct vm_area_struct *vma)
> +{
> +       struct drm_file *file_priv =3D filp->private_data;
> +       struct drm_device *dev =3D file_priv->minor->dev;
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       struct amdgpu_sdma_userq_db *db =3D adev->sdma.userq_db;
> +
> +       if (!db)
> +               return -ENODEV;
> +
> +       if (vma->vm_end - vma->vm_start > round_up(db->size, PAGE_SIZE))
> +               return -EINVAL;
> +
> +       vm_flags_set(vma, VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESE=
RVE |
> +                         VM_DONTDUMP | VM_PFNMAP);
> +       vma->vm_page_prot =3D pgprot_noncached(vma->vm_page_prot);
> +
> +       return io_remap_pfn_range(vma, vma->vm_start,
> +                                 db->phys_base >> PAGE_SHIFT,
> +                                 vma->vm_end - vma->vm_start,
> +                                 vma->vm_page_prot);
> +}
> +
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
>                                u32 instance, bool duplicate)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.h
> index 2bf365609775..a308d5e6ee54 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
> @@ -146,6 +146,20 @@ struct amdgpu_sdma {
>         bool                    disable_uq;
>         void (*get_csa_info)(struct amdgpu_device *adev,
>                              struct amdgpu_sdma_csa_info *csa_info);
> +
> +       /*
> +        * SDMA usermode-queue doorbell pool.  The window covers
> +        * BAR dwords [sdma_engine[0], sdma_engine[0] +
> +        * sdma_doorbell_range * num_instances) =E2=80=94 the only range =
that NBIO
> +        * routes to the SDMA back-end.  Each bit in the bitmap represent=
s
> +        * one qword slot; kernel SDMA ring slots are pre-masked at init.
> +        * Exposed to userspace via a fixed mmap pgoff sentinel handled b=
y
> +        * amdgpu_drm_mmap() =E2=80=94 see AMDGPU_USERQ_DOORBELL_MMAP_OFF=
SET below.
> +        */
> +       struct amdgpu_sdma_userq_db *userq_db;
> +       struct mutex            userq_db_mutex;
> +       unsigned long           *userq_db_bitmap;
> +       u32                     userq_db_nslots;        /* qword slots */
>  };
>
>  /*
> @@ -185,6 +199,42 @@ struct amdgpu_buffer_funcs {
>                                  uint32_t byte_count);
>  };
>
> +/*
> + * SDMA usermode-queue doorbell pool.
> + *
> + * The pool re-uses qword doorbell slots inside the firmware-managed NBI=
O
> + * SDMA decode window (BAR dwords [sdma_engine[0],
> + * sdma_engine[0] + sdma_doorbell_range * num_instances)) =E2=80=94 that=
 range is
> + * the only one whose writes are routed to the SDMA back-end.  The kerne=
l
> + * SDMA ring slots are pre-marked so they keep working alongside any
> + * number of SDMA UMQs.
> + *
> + * Exposed to userspace via a fixed mmap pgoff sentinel
> + * (AMDGPU_USERQ_DOORBELL_MMAP_OFFSET) handled in amdgpu_drm_mmap()'s
> + * dispatcher =E2=80=94 same pattern KFD uses for KFD_MMAP_TYPE_DOORBELL=
.  No
> + * drm_gem_object, no GEM handle, no GEM consumer can ever look this
> + * up via drm_gem_object_lookup() / gem_to_amdgpu_bo().
> + */
> +
> +struct amdgpu_sdma_userq_db {
> +       resource_size_t         phys_base;      /* BAR phys addr of windo=
w start */
> +       u32                     size;           /* window size in bytes *=
/
> +};
> +
> +/*
> + * Fake mmap offsets returned to userspace for amdgpu private mmap regio=
ns.
> + *
> + * The high bits (>=3D bit 56) form a "type" field that amdgpu_drm_mmap(=
)
> + * uses to dispatch to a private handler instead of drm_gem_mmap().  Liv=
es
> + * well above DRM's vma_offset_manager range so any sentinel can never
> + * collide with a real GEM mmap offset.  Internal-only =E2=80=94 userspa=
ce MUST
> + * get the value via AMDGPU_INFO_USERQ_DOORBELL.  Same general pattern
> + * as KFD's KFD_MMAP_TYPE_* (kfd_priv.h).
> + */
> +#define AMDGPU_USERQ_MMAP_TYPE_MASK            (0xFULL << 56)
> +#define AMDGPU_USERQ_MMAP_TYPE_SDMA_DOORBELL   (0x1ULL << 56)
> +#define AMDGPU_USERQ_DOORBELL_MMAP_OFFSET      AMDGPU_USERQ_MMAP_TYPE_SD=
MA_DOORBELL
> +
>  int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instan=
ce_id,
>                              bool caller_handles_kernel_queues);
>
> @@ -205,6 +255,17 @@ int amdgpu_sdma_process_ecc_irq(struct amdgpu_device=
 *adev,
>                                       struct amdgpu_iv_entry *entry);
>  int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
>                                bool duplicate);
> +struct file;
> +struct vm_area_struct;
> +int amdgpu_sdma_userq_doorbell_init(struct amdgpu_device *adev);
> +void amdgpu_sdma_userq_doorbell_fini(struct amdgpu_device *adev);
> +int amdgpu_sdma_userq_doorbell_alloc(struct amdgpu_device *adev, u32 *ou=
t_slot);
> +void amdgpu_sdma_userq_doorbell_free(struct amdgpu_device *adev, u32 slo=
t);
> +int amdgpu_sdma_userq_doorbell_get_mmap(struct amdgpu_device *adev,
> +                                       u64 *mmap_offset, u64 *mmap_size)=
;
> +bool amdgpu_sdma_userq_doorbell_is_our_pgoff(unsigned long pgoff);
> +int  amdgpu_sdma_userq_doorbell_mmap(struct file *filp,
> +                                    struct vm_area_struct *vma);
>  void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
>          bool duplicate);
>  int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
> --
> 2.49.0
>
