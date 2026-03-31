Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EB4109B46C
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 13:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F7410E9C1;
	Tue, 31 Mar 2026 13:31:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GobHsh9a";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40DAD10E99C
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:31:08 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124b07e5fe4so230149c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 06:31:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963867; cv=none;
 d=google.com; s=arc-20240605;
 b=HcdYlP1tGTlC03Lh3s7zT/TSKVMn9f8hcjZhm3cUhS5cbiAGc4gtDx5jeOeZhCDcI/
 ZCfKkOLAPwWpGakkzWN9yKoc9J/HD9JYAftaG5KzqcZTOf2qD4wYelHfJ4UXH6sAnhsK
 XiefuvSMJPx8DicohcwjY5tXx96yAKUvh3dTK5o5SrGUnlQiA7EcALSNRaayA5P33lxs
 tYFexG1GJJnHVIsJScdXgZj/t8LaApaqEC8lToxEmqQJHccU3KZsIlsOi0VogettHqAx
 T5Zpxt6vtkk+hVSXIitL4g2T8qgVQOPPgJ1sKBdHNaKV/oh8rROEteyj3++Lbt023cY3
 9JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 fh=GaEvsxOwHkDQCAOvnmTqkv5LnJqzCe85Kna75gCg+qs=;
 b=EYqpQxLDTuXDh59nsxcFbWplP3jl9AjHiSZfsc1WB7AfZP4lqpOb5VeUkk349f2NRI
 BR8Atqo8BIcqqLnGCPpiiSns8Tba9eu1B9IZwE2y1/pfteNphKk+UoQ3yOfchIjLAcMI
 dE6+7e12ZweRaiepH7BIKPPexyhywmG34ye/ZTvOiJCnPEW6/BX9mJ73LbVHbYVB93Dx
 NoYsUYRUwjjmYKXuefk7M11EoWnuimWKq11MZc7fwvazWKnQZoJ32VszPtjTzU8DAaXP
 nIWsS3gjjI/Ol2ldM4BXr4TE62Qe+lz+onIBxDGFY9r/187tyxQss5f+J5zbLtwficyh
 ewsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774963867; x=1775568667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 b=GobHsh9ai1Tkdl3pbhjXGN86YJH63G19DNQGqhq03OvUCX52TRhX0l4UISB/lYl10E
 xOpDFwLZbLP+L8R03mNoZmw46Wohw3g/wHaPeNhVMnCAf4adkzrZ7eGNmz6LaB78Bdg8
 uGJXZUEkIYK9yTJbS2ZuhOX2bXYtdihBM2I7ywzko0/fKhBYICsonrwLh1l87YYLRM00
 DWplEtiM5EB++kpXibkqUcwfBzbJPcPk5M7LLrqAgmci/g7TlqQHzhzU5mMlY7UqVpg7
 gBne1oEkOzIBbMg2SagO9e+n5xZ1j7LBMK99++C/ZrWgMwkeuaBlFXzqjJgu6jzC8qFd
 XkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774963867; x=1775568667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CKnxxuPt7xVeL78mPhkR/266iTwlZuB0T+L5N9bN2ko=;
 b=sqXJUF2SHeujmMFvOPlvyC9QfTECo8nMP2vvD0NicK7EHYSyr8jMoUznbizUPV+Gy5
 //gpZs6rOnKHIjFnk6nNEVujAMIyACBrAd3vHej202NmQsr3zkabV8nzbzZ/2Is6lJS8
 4aQb91ZhUVtHgDYBfFZBV909V4SG77eytuXdRZdmmfXey8goXAQSMiXIUKQX0xVDytZ9
 XlMlzOkp6319jD2fTfWZIOgEpTk4owvHNGRqJIDwVCesjGxiG+0a6X1TJD3yS7VTNYSw
 dRzKcPOzc6yUWVNpfO4WUwZBof/BKkgYqcIL75okRXVTkIwMu9qHjvAj9QcPDRHF609a
 9ViA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3kjVvgFLQ2Xbf45pqLHxIGLgaWN34qB82VhN4NBjevRrpOMOFmANye8xmAKbIKYIXp2ur06sa@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3P+ckSWjux/5JJvzwojueiR8IOj8KIATHjRCeiBwbmlixooNP
 ACGkN2PXDYo3BgcWM/Ip2MlJt9Cb2Rgk0reuetKk5OaoPdJnWYhzaByyIl4NfFeIOyQm+rXgSpD
 xUoNttIFjyuRTgL/SEoHrRnMUkGWPXgQ=
X-Gm-Gg: ATEYQzylZh9EjPOzZfCEx2jNSXpBCC+BBqiG7ZVD6hM9jgMygUpuW8fi3ObJlKrPGd1
 GIHvqfaKFqdLcFGUBVuJ7hDczDd8xHW0sBJJNG3fPWUSeIbONqWh/IP2vD4kQm3i5nTflXWTMfb
 77+3rbQTEQOpgKcQmD/2y4st6pr9SprrBrjHC6FP45+s1EsladkYh0lOiplgA4UlRO/oVFEG5cj
 snbZIgfizgQiU1N2YPDByk25x8haC0sjjVUC/ZHjLeTSPZItsdrzPcRfKKY5iWrKq5JmEiD7hO+
 AdHCtzEd800JDFSu8qlqWJlWsPrQnf41V4sgWGo6kRlZk5AX/jK9yhuagxsk2B8cIkmPRA==
X-Received: by 2002:a05:7022:4387:b0:128:d279:b8ea with SMTP id
 a92af1059eb24-12ab28f3a8amr4386866c88.5.1774963867255; Tue, 31 Mar 2026
 06:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260330224503.548284-1-gabrielsousa230@gmail.com>
 <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
In-Reply-To: <01989c65-1e1e-4f78-ac88-a1c76961b3c3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 31 Mar 2026 09:30:55 -0400
X-Gm-Features: AQROBzCih4ihgjH9jVyAp7rQmVXl4lcb8__K_hTKMUei1aK_aJLkaIo41UNjvIo
Message-ID: <CADnq5_N6bzHTQJjS6__-Fmp15fASUw3C5DG1uNvZgkxCRtFkcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: deduplicate register access and helper
 routines
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Gabriel Almeida <gabrielsousa230@gmail.com>, alexander.deucher@amd.com,
 airlied@gmail.com, 
 simona@ffwll.ch, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 7:34=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/31/26 00:45, Gabriel Almeida wrote:
> > Some helper functions are implemented multiple times with identical
> > logic across different source files.
>
> And that is at least sometimes completely intentional.
>
> Background is that different headers are included which define macros wit=
h different values for each HW generation.
>
> >
> > Extract these implementations into a shared helper file
> > (amdgpu_common.c) and update existing code to reuse them.
>
> Please don't when they are functional identical then move them a layer up=
 instead of messing up the backends.
>
> Regards,
> Christian.
>
> >
> > This simplifies the codebase and avoids duplication without
> > changing behavior.
> >
> > No functional changes intended.
> >
> > Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Makefile        |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.c | 42 ++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_common.h | 12 +++++++

I think amdgpu_common_helper.c/h would be better.

> >  drivers/gpu/drm/amd/amdgpu/nv.c            | 38 +++-----------------
> >  drivers/gpu/drm/amd/amdgpu/soc15.c         | 31 ++--------------
> >  drivers/gpu/drm/amd/amdgpu/soc21.c         | 38 +++-----------------
> >  drivers/gpu/drm/amd/amdgpu/soc24.c         | 29 ++-------------
> >  drivers/gpu/drm/amd/amdgpu/soc_v1_0.c      | 21 ++---------
> >  8 files changed, 72 insertions(+), 141 deletions(-)
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/=
amdgpu/Makefile
> > index 6a7e9bfec..84cce03d7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -69,6 +69,8 @@ amdgpu-y +=3D amdgpu_device.o amdgpu_reg_access.o amd=
gpu_doorbell_mgr.o amdgpu_kms
> >         amdgpu_ring_mux.o amdgpu_xcp.o amdgpu_seq64.o amdgpu_aca.o amdg=
pu_dev_coredump.o \
> >         amdgpu_cper.o amdgpu_userq_fence.o amdgpu_eviction_fence.o amdg=
pu_ip.o
> >
> > +amdgpu-y +=3D amdgpu_common.o
> > +
> >  amdgpu-$(CONFIG_PROC_FS) +=3D amdgpu_fdinfo.o
> >
> >  amdgpu-$(CONFIG_PERF_EVENTS) +=3D amdgpu_pmu.o
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_common.c
> > new file mode 100644
> > index 000000000..34ade6f63
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.c
> > @@ -0,0 +1,42 @@
> > +// SPDX-License-Identifier: GPL-2.0

This should be MIT

> > +#include <linux/module.h>
> > +
> > +#include "amdgpu.h"
> > +#include "amdgpu_common.h"
> > +#include "mxgpu_nv.h"
> > +
> > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > +                              u32 se_num, u32 sh_num, u32 reg_offset)
> > +{
> > +       uint32_t val;
> > +
> > +       mutex_lock(&adev->grbm_idx_mutex);
> > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > +
> > +       val =3D RREG32(reg_offset);
> > +
> > +       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > +               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > +       mutex_unlock(&adev->grbm_idx_mutex);
> > +       return val;
> > +}
> > +
> > +void program_aspm(struct amdgpu_device *adev)
> > +{
> > +       if (!amdgpu_device_should_use_aspm(adev))
> > +               return;
> > +
> > +       if (adev->nbio.funcs->program_aspm)
> > +               adev->nbio.funcs->program_aspm(adev);
> > +}
> > +
> > +int common_sw_init(struct amdgpu_ip_block *ip_block)

Please prefix each of these functions with amdgpu_common_helper_

> > +{
> > +       struct amdgpu_device *adev =3D ip_block->adev;
> > +
> > +       if (amdgpu_sriov_vf(adev))
> > +               xgpu_nv_mailbox_add_irq_id(adev);
> > +
> > +       return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_common.h
> > new file mode 100644
> > index 000000000..314b3506b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_common.h
> > @@ -0,0 +1,12 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */

This should be MIT

Alex

> > +#ifndef __AMDGPU_COMMON_H__
> > +#define __AMDGPU_COMMON_H__
> > +
> > +uint32_t read_indexed_register(struct amdgpu_device *adev,
> > +                              u32 se_num, u32 sh_num, u32 reg_offset);
> > +
> > +void program_aspm(struct amdgpu_device *adev);
> > +
> > +int common_sw_init(struct amdgpu_ip_block *ip_block);
> > +
> > +#endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdg=
pu/nv.c
> > index 7ce1a1b95..cf8052c73 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > @@ -29,6 +29,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_atombios.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -354,29 +355,13 @@ static struct soc15_allowed_register_entry nv_all=
owed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u=
32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> >
> >  static uint32_t nv_get_register_value(struct amdgpu_device *adev,
> >                                       bool indexed, u32 se_num,
> >                                       u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return nv_read_indexed_register(adev, se_num, sh_num, r=
eg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR=
_CONFIG))
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -511,16 +496,6 @@ static int nv_set_vce_clocks(struct amdgpu_device =
*adev, u32 evclk, u32 ecclk)
> >         return 0;
> >  }
> >
> > -static void nv_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -
> > -}
> > -
> >  const struct amdgpu_ip_block_version nv_common_ip_block =3D {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >         .major =3D 1,
> > @@ -965,12 +940,7 @@ static int nv_common_late_init(struct amdgpu_ip_bl=
ock *ip_block)
> >
> >  static int nv_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int nv_common_hw_init(struct amdgpu_ip_block *ip_block)
> > @@ -984,7 +954,7 @@ static int nv_common_hw_init(struct amdgpu_ip_block=
 *ip_block)
> >                 adev->nbio.funcs->apply_l1_link_width_reconfig_wa(adev)=
;
> >
> >         /* enable aspm */
> > -       nv_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/a=
mdgpu/soc15.c
> > index b456e4541..a6b91363d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> > @@ -28,6 +28,7 @@
> >  #include <drm/amdgpu_drm.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -401,29 +402,12 @@ static struct soc15_allowed_register_entry soc15_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, mmDB_DEBUG2)},
> >  };
> >
> > -static uint32_t soc15_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc15_get_register_value(struct amdgpu_device *adev,
> >                                          bool indexed, u32 se_num,
> >                                          u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc15_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, mmGB_ADDR=
_CONFIG))
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -695,15 +679,6 @@ static int soc15_set_vce_clocks(struct amdgpu_devi=
ce *adev, u32 evclk, u32 ecclk
> >         return 0;
> >  }
> >
> > -static void soc15_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -}
> > -
> >  const struct amdgpu_ip_block_version vega10_common_ip_block =3D
> >  {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> > @@ -1284,7 +1259,7 @@ static int soc15_common_hw_init(struct amdgpu_ip_=
block *ip_block)
> >         struct amdgpu_device *adev =3D ip_block->adev;
> >
> >         /* enable aspm */
> > -       soc15_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/a=
mdgpu/soc21.c
> > index fbd1d97f3..586d62202 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> > @@ -27,6 +27,7 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_atombios.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -306,29 +307,12 @@ static struct soc15_allowed_register_entry soc21_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev=
, u32 se_num,
> > -                                        u32 sh_num, u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc21_get_register_value(struct amdgpu_device *adev,
> >                                       bool indexed, u32 se_num,
> >                                       u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc21_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG) && adev->gfx.config.gb_addr_config)
> >                         return adev->gfx.config.gb_addr_config;
> > @@ -470,15 +454,6 @@ static int soc21_set_vce_clocks(struct amdgpu_devi=
ce *adev, u32 evclk, u32 ecclk
> >         return 0;
> >  }
> >
> > -static void soc21_program_aspm(struct amdgpu_device *adev)
> > -{
> > -       if (!amdgpu_device_should_use_aspm(adev))
> > -               return;
> > -
> > -       if (adev->nbio.funcs->program_aspm)
> > -               adev->nbio.funcs->program_aspm(adev);
> > -}
> > -
> >  const struct amdgpu_ip_block_version soc21_common_ip_block =3D {
> >         .type =3D AMD_IP_BLOCK_TYPE_COMMON,
> >         .major =3D 1,
> > @@ -912,12 +887,7 @@ static int soc21_common_late_init(struct amdgpu_ip=
_block *ip_block)
> >
> >  static int soc21_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int soc21_common_hw_init(struct amdgpu_ip_block *ip_block)
> > @@ -925,7 +895,7 @@ static int soc21_common_hw_init(struct amdgpu_ip_bl=
ock *ip_block)
> >         struct amdgpu_device *adev =3D ip_block->adev;
> >
> >         /* enable aspm */
> > -       soc21_program_aspm(adev);
> > +       program_aspm(adev);
> >         /* setup nbio registers */
> >         adev->nbio.funcs->init_registers(adev);
> >         /* remap HDP registers to a hole in mmio space,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/a=
mdgpu/soc24.c
> > index d1adf19a5..f9341c0e4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc24.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/pci.h>
> >
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "amdgpu_ih.h"
> >  #include "amdgpu_uvd.h"
> >  #include "amdgpu_vce.h"
> > @@ -132,31 +133,12 @@ static struct soc15_allowed_register_entry soc24_=
allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
> >  };
> >
> > -static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev=
,
> > -                                           u32 se_num,
> > -                                           u32 sh_num,
> > -                                           u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> > -
> >  static uint32_t soc24_get_register_value(struct amdgpu_device *adev,
> >                                          bool indexed, u32 se_num,
> >                                          u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc24_read_indexed_register(adev, se_num, sh_num=
, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG) &&
> >                     adev->gfx.config.gb_addr_config)
> > @@ -455,12 +437,7 @@ static int soc24_common_late_init(struct amdgpu_ip=
_block *ip_block)
> >
> >  static int soc24_common_sw_init(struct amdgpu_ip_block *ip_block)
> >  {
> > -       struct amdgpu_device *adev =3D ip_block->adev;
> > -
> > -       if (amdgpu_sriov_vf(adev))
> > -               xgpu_nv_mailbox_add_irq_id(adev);
> > -
> > -       return 0;
> > +       return common_sw_init(ip_block);
> >  }
> >
> >  static int soc24_common_hw_init(struct amdgpu_ip_block *ip_block)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/am=
d/amdgpu/soc_v1_0.c
> > index 709b1669b..2f77fb0b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
> > @@ -21,6 +21,7 @@
> >   *
> >   */
> >  #include "amdgpu.h"
> > +#include "amdgpu_common.h"
> >  #include "soc15.h"
> >  #include "soc15_common.h"
> >  #include "soc_v1_0.h"
> > @@ -184,31 +185,13 @@ static struct soc15_allowed_register_entry soc_v1=
_0_allowed_read_registers[] =3D {
> >         { SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG_1) },
> >  };
> >
> > -static uint32_t soc_v1_0_read_indexed_register(struct amdgpu_device *a=
dev,
> > -                                              u32 se_num,
> > -                                              u32 sh_num,
> > -                                              u32 reg_offset)
> > -{
> > -       uint32_t val;
> > -
> > -       mutex_lock(&adev->grbm_idx_mutex);
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, se_num, sh_num, 0xfffffff=
f, 0);
> > -
> > -       val =3D RREG32(reg_offset);
> > -
> > -       if (se_num !=3D 0xffffffff || sh_num !=3D 0xffffffff)
> > -               amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0=
xffffffff, 0);
> > -       mutex_unlock(&adev->grbm_idx_mutex);
> > -       return val;
> > -}
> >
> >  static uint32_t soc_v1_0_get_register_value(struct amdgpu_device *adev=
,
> >                                             bool indexed, u32 se_num,
> >                                             u32 sh_num, u32 reg_offset)
> >  {
> >         if (indexed) {
> > -               return soc_v1_0_read_indexed_register(adev, se_num, sh_=
num, reg_offset);
> > +               return read_indexed_register(adev, se_num, sh_num, reg_=
offset);
> >         } else {
> >                 if (reg_offset =3D=3D SOC15_REG_OFFSET(GC, 0, regGB_ADD=
R_CONFIG_1) &&
> >                     adev->gfx.config.gb_addr_config)
> > --
> > 2.43.0
> >
>
