Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018CAC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7335810E52B;
	Tue, 15 Mar 2022 15:46:41 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD50E10E52B
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:46:40 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 n5-20020a4a9545000000b0031d45a442feso24858364ooi.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 08:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ClUTvr1q4W+n9qFtKvkBFof95AMXNne8KJZiK/CZhsg=;
 b=RIHq0D4fZeTNBqoOa6VjRwJ2m+07QLXVzo26FrAz6Tea8ZixYRVP8CEN/JGHfRGk1u
 V6E86AkiXiNm8Wr2PgA5IrKzT4zLeh6ANAbSJ2+uRU5QEX0TbEfsJ0Mjjl68UFmMhSNS
 tdEpFX3xAfdj4tQLIDIdOGaSsnbxUi0oDnEKGcg3g/PDAR8BYDVOGVKZklX2CEwkBmOl
 bz2fr+224b5A2sqq2BO7CWpPfByryLYiIkfJCF/BIWtRG8+P+31e8LmYvjsJ4wyB6zXW
 urEdmqx2wuO37chWn7yfjhIW261h3HjmnzTRzzIeztQUHwkLrmB9JDsy3+m0gHwHhqQN
 SrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ClUTvr1q4W+n9qFtKvkBFof95AMXNne8KJZiK/CZhsg=;
 b=bmY09V/GoaLK0Q+bSA5QJoe1Eubz46GvvypiE98pY+SXHudDqRhpqOzEFQ6nxntBPm
 ZoujFGFlVKfwgT6P0d7TZ7R7Y5hA8FnRzcFj6+QAvg1TfgoktrtLBa+mVPKjIdJfriCN
 7wqXyGktOMgCY5N4aIw5Zj9waJs92gH5FedvV3wxfe/RHFp5RdYlU0DPoW/+463cc1Et
 f2YgWp+4KaC5x3OoC6BaH5zzdSSz+XAsliPccpUifrdp2S8Jhy01lGSa93YpXg6a7jCx
 uotWDazgmAbC29uzJfEG7G+PlVtIWBLJGaykKkaAqr+nyI4uBdLLCjXYbUy6KVOW8pMY
 Q3NQ==
X-Gm-Message-State: AOAM533URPzhhfCuLJnhBWQdyiYUrasXGzMp3WlKlIbae5ME4ZAkntQA
 P4025FMCGaj2jyO/dkuOL25mMR+m/+ot1ydf7bQuaXxd
X-Google-Smtp-Source: ABdhPJx9g6odsFrbgMFKM1IVdW1enKxgoj1YHUTp4AIGabGl6uvxlTGVf4fB148md/00Kyqp68N84F3uyqqkSk2nhe4=
X-Received: by 2002:a4a:db64:0:b0:2ea:37f4:d798 with SMTP id
 o4-20020a4adb64000000b002ea37f4d798mr11509551ood.23.1647359200131; Tue, 15
 Mar 2022 08:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220314055221.3100329-1-YiPeng.Chai@amd.com>
 <DM5PR12MB177083EF87DF35009A324855B00F9@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB177083EF87DF35009A324855B00F9@DM5PR12MB1770.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Mar 2022 11:46:28 -0400
Message-ID: <CADnq5_PbgY1zET6+vGN3C3_wqtaf+ejaJE59SRURqo=7czSKyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test
 robot
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Clements,
 John" <John.Clements@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Mon, Mar 14, 2022 at 2:28 AM Zhou1, Tao <Tao.Zhou1@amd.com> wrote:
>
> [AMD Official Use Only]
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > -----Original Message-----
> > From: Chai, Thomas <YiPeng.Chai@amd.com>
> > Sent: Monday, March 14, 2022 1:52 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> > John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> > Subject: [PATCH] drm/amdgpu: fixed the warnings reported by kernel test robot
> >
> > The reported warnings are as follows:
> >   1.warning:no-previous-prototype-for-amdgpu_hdp_ras_fini.
> >   2.warning:no-previous-prototype-for-amdgpu_mmhub_ras_fini.
> >
> > Amdgpu_hdp_ras_fini and amdgpu_mmhub_ras_fini are unused in the code,
> > they are the only functions in amdgpu_hdp.c and amdgpu_mmhub.c. After
> > removing these two functions, both amdgpu_hdp.c and amdgpu_mmhub.c are
> > empty, so these two files can be deleted to fix the warning.
> >
> > Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/Makefile       |  4 +--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c   | 30 -----------------------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c | 30 -----------------------
> >  3 files changed, 2 insertions(+), 62 deletions(-)  delete mode 100644
> > drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> >  delete mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile
> > b/drivers/gpu/drm/amd/amdgpu/Makefile
> > index 5dfe08cb045e..40e2c6e2df79 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> > +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> > @@ -53,11 +53,11 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
> >       amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
> >       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o
> > amdgpu_virt.o \
> >       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
> > -     amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o amdgpu_mmhub.o \
> > +     amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
> >       amdgpu_xgmi.o amdgpu_csa.o amdgpu_ras.o amdgpu_vm_cpu.o \
> >       amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o
> > amdgpu_nbio.o \
> >       amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o
> > amdgpu_rap.o \
> > -     amdgpu_fw_attestation.o amdgpu_securedisplay.o amdgpu_hdp.o \
> > +     amdgpu_fw_attestation.o amdgpu_securedisplay.o \
> >       amdgpu_eeprom.o amdgpu_mca.o
> >
> >  amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o diff --git
> > a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > deleted file mode 100644
> > index 3f3d92e16c2e..000000000000
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -/*
> > - * Copyright 2021 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaining a
> > - * copy of this software and associated documentation files (the "Software"),
> > - * to deal in the Software without restriction, including without limitation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> > EVENT SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > OTHERWISE,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> > USE OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - */
> > -
> > -#include "amdgpu.h"
> > -#include "amdgpu_ras.h"
> > -
> > -void amdgpu_hdp_ras_fini(struct amdgpu_device *adev, struct ras_common_if
> > *ras_block) -{
> > -
> > -}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> > deleted file mode 100644
> > index 8f2fa247d605..000000000000
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mmhub.c
> > +++ /dev/null
> > @@ -1,30 +0,0 @@
> > -/*
> > - * Copyright 2019 Advanced Micro Devices, Inc.
> > - *
> > - * Permission is hereby granted, free of charge, to any person obtaining a
> > - * copy of this software and associated documentation files (the "Software"),
> > - * to deal in the Software without restriction, including without limitation
> > - * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > - * and/or sell copies of the Software, and to permit persons to whom the
> > - * Software is furnished to do so, subject to the following conditions:
> > - *
> > - * The above copyright notice and this permission notice shall be included in
> > - * all copies or substantial portions of the Software.
> > - *
> > - * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> > EXPRESS OR
> > - * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> > MERCHANTABILITY,
> > - * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> > EVENT SHALL
> > - * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> > DAMAGES OR
> > - * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> > OTHERWISE,
> > - * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> > USE OR
> > - * OTHER DEALINGS IN THE SOFTWARE.
> > - *
> > - */
> > -
> > -#include "amdgpu.h"
> > -#include "amdgpu_ras.h"
> > -
> > -void amdgpu_mmhub_ras_fini(struct amdgpu_device *adev, struct
> > ras_common_if *ras_block) -{
> > -
> > -}
> > --
> > 2.25.1
