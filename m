Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B91C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 13:28:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB9710E5AA;
	Tue, 24 Jun 2025 13:28:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jXeCYNJv";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A6F510E5AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 13:28:12 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b31aecc78a3so847418a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 06:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750771692; x=1751376492; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zL3z07CRvF2W3OSG6HG47RiVu5K6fAC9QQQwCMfOvfM=;
 b=jXeCYNJvGyzTzxTOoFGScWmYjvvA0Uoc9fyfNGmsm6Be7HlqLWP5WCls8UwEUyMGmP
 I1uikKpju5cPsDMuhXF2k2IIZdZbeZ2UiI7CM2IH6IlZK4T9QuJtt9ImU7C3hhGDC2L3
 VvikSvekXhY7reTrcCKLsTZv/Nuq8f1RLw1NyTElaW7D2pAvM/9NpYTnhXvlNJ2lJN40
 QCmW5poF6ZimvSHkdBtBuGz397SP3p7C3hgqmagrmjseyOc6Vuuh8s447gY5sOFTto/2
 kK6tg1hIPc1c8K/fvDrXMb0kS7uroKLcyMf202eSqbbFvSL5fdwCHwBoLd9NntffzC3t
 JiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750771692; x=1751376492;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zL3z07CRvF2W3OSG6HG47RiVu5K6fAC9QQQwCMfOvfM=;
 b=pLhmJhmfIuqOKQHRnhZeNdPAVaaZSU4y4lWF0T1WEakPLm0S9LuZ5NdzLEPYUgIacC
 5/jgw6Pi9iFqqolZ/Q0xYxepDn8V2Tr4Rlln9lJ/+vlbdaU1CQ60iAewhxR8hL3KRFyM
 1W+TA7ghY1DZQcMyBEG3fSeyRMlInOKHMeIz1q+VAzpubkdDsfGy3N632TzxUt21mMv5
 GQp7X+joPkyEQBugGh9YcSUYXXRcRCUd+kRMA7/NQjs+XUpVMbAXIRtti52VkdH5VUul
 4x/IOt789cBgnh+winbJcAfarrFBlSqPO2PTxNTdxE+UjiF08fUy/c/PFNiIBgOjooGh
 Ls7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCtLArdDx+qVhwJnKsBDcB4ryT0BVIJx3CTDtw9x7DzsaSYW1AyqLg9rl4S8JEVPTNFlDgDycK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwczdWI7QqQ+cR04YJr+gWGCucUb4DVBN76Wu/lOCv9Fy5O2ctN
 KudtT/0Yirm76M5yU3lcmNIXxhzNld9rMbASwhNlF/2+RCIwKpyUnz9RpHmspr/GZ2MNNxKRJ7c
 dOGK7Z9YDx+02Vr6sFrPMXy1hAV+1wxje0Q==
X-Gm-Gg: ASbGncv4vOOD+hlHaDtZcuRR/tZ+Jx6mmPyT1r/dtFcSDf0Cul/dBtRC9B8v2x3Xir/
 qwTnz6JNLUtjKzgexnE+3qqMFBIAsHhAewbNThPu0ZoZJwhZkxEl5do4X8V5/6jJ8T7c4k5SgOv
 TWTilsevWogH8zku8iti2jwBe6cIWw/IXZfQommTxgU7lK
X-Google-Smtp-Source: AGHT+IFVJgJ+QzbxFVsrWsamJbpfkeDJ7XLhJznhXqmZFYwTKTQsv6EJCmZqqZ1GhBjQ/GwrVRelSSLtNctqPwz4BBs=
X-Received: by 2002:a17:90a:d88c:b0:312:25dd:1c8b with SMTP id
 98e67ed59e1d1-3159d62a060mr9301372a91.2.1750771691795; Tue, 24 Jun 2025
 06:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250623111717.224707-1-srinivasan.shanmugam@amd.com>
 <771f083d-be07-4080-a191-d264c355c66c@amd.com>
In-Reply-To: <771f083d-be07-4080-a191-d264c355c66c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Jun 2025 09:27:59 -0400
X-Gm-Features: AX0GCFuurUytgDmSRb5uHZ1eLxklWEY5vzElz_k4Y5R7wOX6HlApdo61GAEMfEw
Message-ID: <CADnq5_PLEy+NTwfNufmK487S4qOycMoA0PHx_SEYqrsyEw1dYA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Unify Device Aperture in amdgpu_info_ioctl
 for KGD/KFD
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

On Tue, Jun 24, 2025 at 4:26=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> On 23.06.25 13:17, Srinivasan Shanmugam wrote:
> > This commit refines the amdgpu_info_ioctl function to unify
> > the reporting of device apertures for both KGD and KFD
> > subsystems.
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 23 ++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h       | 29 ++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c | 29 --------------------
> >  include/uapi/drm/amdgpu_drm.h                |  6 ++++
> >  4 files changed, 58 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index d2ce7d86dbc8..6ca399a92814 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -46,6 +46,7 @@
> >  #include "amdgpu_reset.h"
> >  #include "amd_pcie.h"
> >  #include "amdgpu_userq.h"
> > +#include "amdgpu_vm.h"
> >
> >  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
> >  {
> > @@ -1011,6 +1012,28 @@ int amdgpu_info_ioctl(struct drm_device *dev, vo=
id *data, struct drm_file *filp)
> >
> >               dev_info->userq_ip_mask =3D amdgpu_userq_get_supported_ip=
_mask(adev);
> >
> > +             /* Retrieve Device Apertures */
> > +             if (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(9, 0,=
 0)) {
> > +                     dev_info->lds_base =3D MAKE_LDS_APP_BASE_V9();
> > +                     dev_info->scratch_base =3D MAKE_SCRATCH_APP_BASE_=
V9();
> > +
> > +                     dev_info->lds_limit =3D MAKE_LDS_APP_LIMIT(dev_in=
fo->lds_base);
> > +                     dev_info->scratch_limit =3D MAKE_SCRATCH_APP_LIMI=
T(dev_info->scratch_base);
> > +             } else {
> > +                     dev_info->lds_base =3D MAKE_LDS_APP_BASE_VI();
> > +                     dev_info->scratch_base =3D MAKE_SCRATCH_APP_BASE_=
VI();
> > +
> > +                     dev_info->lds_limit =3D MAKE_LDS_APP_LIMIT(dev_in=
fo->lds_base);
> > +                     dev_info->scratch_limit =3D MAKE_SCRATCH_APP_LIMI=
T(dev_info->scratch_base);
> > +             }
> > +
> > +             dev_dbg(adev->dev, "Node ID: %u\n", adev->dev->id);
> > +             dev_dbg(adev->dev, "GPU ID: %u\n", dev_info->device_id);
> > +             dev_dbg(adev->dev, "LDS Base: %llX\n", dev_info->lds_base=
);
> > +             dev_dbg(adev->dev, "LDS Limit: %llX\n", dev_info->lds_lim=
it);
> > +             dev_dbg(adev->dev, "Scratch Base: %llX\n", dev_info->scra=
tch_base);
> > +             dev_dbg(adev->dev, "Scratch Limit: %llX\n", dev_info->scr=
atch_limit);
> > +
> >               ret =3D copy_to_user(out, dev_info,
> >                                  min((size_t)size, sizeof(*dev_info))) =
? -EFAULT : 0;
> >               kfree(dev_info);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vm.h
> > index f3ad687125ad..6ee09df0d345 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> > @@ -184,6 +184,35 @@ struct amdgpu_bo_vm;
> >  #define AMDGPU_VM_USE_CPU_FOR_GFX (1 << 0)
> >  #define AMDGPU_VM_USE_CPU_FOR_COMPUTE (1 << 1)
> >
> > +#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> > +     (((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
>
> AMDGPU_VM_* prefix for those defines please.
>
> > +
> > +#define MAKE_GPUVM_APP_LIMIT(base, size) \
> > +     (((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> > +
> > +#define MAKE_SCRATCH_APP_BASE_VI() \
> > +     (((uint64_t)(0x1UL) << 61) + 0x100000000L)
> > +
> > +#define MAKE_SCRATCH_APP_LIMIT(base) \
> > +     (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> > +
> > +#define MAKE_LDS_APP_BASE_VI() \
> > +     (((uint64_t)(0x1UL) << 61) + 0x0)
> > +#define MAKE_LDS_APP_LIMIT(base) \
> > +     (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> > +
> > +/* On GFXv9 the LDS and scratch apertures are programmed independently
> > + * using the high 16 bits of the 64-bit virtual address. They must be
> > + * in the hole, which will be the case as long as the high 16 bits are
> > + * not 0.
>
> That is not 100% correct. The high bits should also not be 0xffff because=
 then we get into trouble with sign extension.
>
> > + *
> > + * The aperture sizes are still 4GB implicitly.
> > + *
> > + * A GPUVM aperture is not applicable on GFXv9.
>
> That's also not correct. We have one APU case where even GFX9 has a limit=
ed GPUVM aperture.
>
> > + */
> > +#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> > +#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
>
> But I don't see where those defines are actually used.
>
> > +
> >  /* VMPT level enumerate, and the hiberachy is:
> >   * PDB2->PDB1->PDB0->PTB
> >   */
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_flat_memory.c
> > index dbcb60eb54b2..fdcbb400f618 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> > @@ -277,35 +277,6 @@
> >   * for FLAT_* / S_LOAD operations.
> >   */
> >
> > -#define MAKE_GPUVM_APP_BASE_VI(gpu_num) \
> > -     (((uint64_t)(gpu_num) << 61) + 0x1000000000000L)
> > -
> > -#define MAKE_GPUVM_APP_LIMIT(base, size) \
> > -     (((uint64_t)(base) & 0xFFFFFF0000000000UL) + (size) - 1)
> > -
> > -#define MAKE_SCRATCH_APP_BASE_VI() \
> > -     (((uint64_t)(0x1UL) << 61) + 0x100000000L)
> > -
> > -#define MAKE_SCRATCH_APP_LIMIT(base) \
> > -     (((uint64_t)base & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> > -
> > -#define MAKE_LDS_APP_BASE_VI() \
> > -     (((uint64_t)(0x1UL) << 61) + 0x0)
> > -#define MAKE_LDS_APP_LIMIT(base) \
> > -     (((uint64_t)(base) & 0xFFFFFFFF00000000UL) | 0xFFFFFFFF)
> > -
> > -/* On GFXv9 the LDS and scratch apertures are programmed independently
> > - * using the high 16 bits of the 64-bit virtual address. They must be
> > - * in the hole, which will be the case as long as the high 16 bits are
> > - * not 0.
> > - *
> > - * The aperture sizes are still 4GB implicitly.
> > - *
> > - * A GPUVM aperture is not applicable on GFXv9.
> > - */
> > -#define MAKE_LDS_APP_BASE_V9() ((uint64_t)(0x1UL) << 48)
> > -#define MAKE_SCRATCH_APP_BASE_V9() ((uint64_t)(0x2UL) << 48)
> > -
> >  /* User mode manages most of the SVM aperture address space. The low
> >   * 16MB are reserved for kernel use (CWSR trap handler and kernel IB
> >   * for now).
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 45c4fa13499c..a52683ae7115 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1477,6 +1477,12 @@ struct drm_amdgpu_info_device {
> >       /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
> >       __u32 userq_ip_mask;
> >       __u32 pad;
> > +
> > +     /* Additional fields for memory aperture information */
> > +     __u64 lds_base;          /* LDS base */
> > +     __u64 lds_limit;         /* LDS limit */
> > +     __u64 scratch_base;      /* Scratch base */
> > +     __u64 scratch_limit;     /* Scratch limit */
>
> It might be better to have a separate IOCTL instead of extending the amdg=
pu_info_device structure.
>
> But let us discuss that with Alex and eventually Felix on our weekly call=
.

ROCr team said the rest of the stuff in that query is useful to them
so it makes sense to include the aperture info as well to reduce the
number of IOCTLs needed.

Alex

>
> Regards,
> Christian.
>
>
>
> >  };
> >
> >  struct drm_amdgpu_info_hw_ip {
>
