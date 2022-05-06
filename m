Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46538C433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  6 May 2022 14:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C41310E893;
	Fri,  6 May 2022 14:22:41 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB71510E893
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 May 2022 14:22:39 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-d6e29fb3d7so7325718fac.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 May 2022 07:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=VkTDBxo8HRG0orJi7pyZ1QrLmrlIiJFRlNmUNRMki9s=;
 b=Y2YxZKB7M7TLKI5le88v8rCvuSlhwjrTr/9u2suDErvmeFumOcsuni2vwrbSbeIxx7
 srOqr1CZgHY+sVKe/dlQIscGBQ8Fv/ULBK9pf2gZqyg7ehIXd5Sv2sKESYAh4v4xoBTI
 6HQ6NyTua8YuKoXH0QSvnfS/W4mzgFSHQfEPCqUh2z9/ISeel7UeVVB73TU4wu/Uj+sm
 VartW0uz4A3ZNfJu4UvaF9fcAteADn4FTAaG41GdQBB3K5MTQRrfwOu8XxtbiyWfKCMR
 I16CIy6BkaboGC9Rk1uDoZGkiAkeRGPvNIqvRAY/BuCAQQLlRvEbLPb5NdFfrrw9OSwG
 EQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=VkTDBxo8HRG0orJi7pyZ1QrLmrlIiJFRlNmUNRMki9s=;
 b=dZx3qYaU0xni9zC/RUiMwv9Gbz6C6RiAHYpYP7EIkT6wtyMzumczH0+MlPJPa0tUJE
 +wUqyyQRQzTnh73GtUpKUH7lbstpDljVHmwi+tcFiWUVGGnzxRB0Z50oT1090upBzA2U
 g0BbyUH+SAXa6rUxIR4PoAmhYSlPBJDUNsJHaV837AAfl33OnmFRxngin24MWOzLtq5N
 3TLxGln4mGWITskhc2suxXikYihyI+S5/VvD9CfX9K3TiOkrhBSHz0cLfXaPIlcjiJz0
 TX+2WO+Lw1MRwSwPEt9TftL/HIzhSLr23dlWdiZsD+/jgZZQdlKJVOfIh+8JFLUo+W+y
 P4rA==
X-Gm-Message-State: AOAM533/XUJEp0H1Dyl+NDkHfrHmcDeGUE/cCKeqdcRTktFQZZbJyosW
 JrkEO1UNFcxABq3gpRwbbel0cVCQQUFjffs2dRo=
X-Google-Smtp-Source: ABdhPJxj56c6PT4ftizY9Dyobw7K0cKYww97gK1X1u2Y1j0aOetb8m8cj3EVbgdCREtr3v0KcSdY6bQ/72gHoq5rmGE=
X-Received: by 2002:a05:6870:d683:b0:de:eaa2:3550 with SMTP id
 z3-20020a056870d68300b000deeaa23550mr1427740oap.253.1651846959199; Fri, 06
 May 2022 07:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220505200406.1293467-1-alexander.deucher@amd.com>
 <20220505200406.1293467-3-alexander.deucher@amd.com>
 <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
In-Reply-To: <ac0c55f7-20ee-9cf4-f52f-1a168cc4e8f8@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 May 2022 10:22:28 -0400
Message-ID: <CADnq5_OZE-vum4V7UJMeyZNJDj8gqgcSK1FJiF0LrR2s6dRd1Q@mail.gmail.com>
Subject: Re: [PATCH 3/8] drm/amdgpu: support mem copy for LSDMA
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 6, 2022 at 1:02 AM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
>
>
> On 2022-05-05 16:04, Alex Deucher wrote:
> > From: Likun Gao <Likun.Gao@amd.com>
> >
> > Support memory to memory linear copy in PIO mode for LSDMA.
> >
> > Signed-off-by: Likun Gao <Likun.Gao@amd.com>
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c | 26 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h |  5 +++
> >  drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c   | 44 +++++++++++++++++++++++
> >  3 files changed, 75 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lsdma.c
> > index af00a66f8282..3f1c674afe41 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.c
> > @@ -23,3 +23,29 @@
> >
> >  #include "amdgpu.h"
> >  #include "amdgpu_lsdma.h"
> > +
> > +#define AMDGPU_LSDMA_MAX_SIZE        0x2000000ULL
> > +
> > +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev,
> > +                       uint64_t src_addr,
> > +                       uint64_t dst_addr,
> > +                       uint64_t mem_size)
> > +{
> > +     int ret;
> > +
> > +     if (mem_size =3D=3D 0)
> > +             return -EINVAL;
> > +
> > +     while(mem_size > 0) {
>
> Kernel style requires a space after the "while" and before the "(".
>
> > +             uint64_t current_copy_size =3D min(mem_size, AMDGPU_LSDMA=
_MAX_SIZE);
> > +
> > +             ret =3D adev->lsdma.funcs->copy_mem(adev, src_addr, dst_a=
ddr, current_copy_size);
> > +             if (ret)
> > +                     return ret;
> > +             src_addr +=3D current_copy_size;
> > +             dst_addr +=3D current_copy_size;
> > +             mem_size -=3D current_copy_size;
> > +     }
> > +
> > +     return 0;
> > +}
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_lsdma.h
> > index 4df4da423181..be397666e4c1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lsdma.h
> > @@ -30,6 +30,11 @@ struct amdgpu_lsdma {
> >
> >  struct amdgpu_lsdma_funcs
> >  {
> > +     int (*copy_mem)(struct amdgpu_device *adev, uint64_t src_addr,
> > +                    uint64_t dst_addr, uint64_t size);
> >  };
> >
> > +int amdgpu_lsdma_copy_mem(struct amdgpu_device *adev, uint64_t src_add=
r,
> > +                          uint64_t dst_addr, uint64_t mem_size);
> > +
> >  #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c b/drivers/gpu/drm/=
amd/amdgpu/lsdma_v6_0.c
> > index b611ade53be2..0d2bdd04bd76 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v6_0.c
> > @@ -29,5 +29,49 @@
> >  #include "lsdma/lsdma_6_0_0_offset.h"
> >  #include "lsdma/lsdma_6_0_0_sh_mask.h"
> >
> > +static int lsdma_v6_0_copy_mem(struct amdgpu_device *adev,
> > +                            uint64_t src_addr,
> > +                            uint64_t dst_addr,
> > +                            uint64_t size)
> > +{
> > +     uint32_t usec_timeout =3D 5000;  /* wait for 5ms */
> > +     uint32_t tmp, expect_val;
> > +     int i;
> > +
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(sr=
c_addr));
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(sr=
c_addr));
> > +
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(ds=
t_addr));
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(ds=
t_addr));
> > +
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
> > +
> > +     tmp =3D RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0)=
;
> > +     tmp =3D REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
> > +     WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
> > +
> > +     expect_val =3D LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS=
__PIO_FIFO_EMPTY_MASK;
> > +     for (i =3D 0; i < usec_timeout; i++) {
> > +             tmp =3D RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
> > +             if ((tmp & expect_val) =3D=3D expect_val)
> > +                     break;
> > +             udelay(1);
> > +     }
>
> Does the hardware specify a minimum delay after the write to the LSDMA_PI=
O_COMMAND,
> and before we check the LSDMA_PIO_STATUS?

I'm not sure, but it should be pretty minimal.

>
> At the moment the code above checks the status immediately after writing =
to
> LSDMA_PIO_COMMAND, and the copy wouldn't be completed.
>
> If the poll timeout is 1 us, as the loop shows us, maybe the command comp=
letion
> is larger than that (the time after writing to LSDMA_PIO_COMMAND and befo=
re
> checking LSDMA_PIO_STATUS)?

The time it takes for the copy will be dependent on the amount of data
there is to copy.  While the command is probably not complete on the
first read of the status register, it may be required to make sure the
previous write goes through.

Alex

>
> > +
> > +     if (i >=3D usec_timeout) {
> > +             dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  const struct amdgpu_lsdma_funcs lsdma_v6_0_funcs =3D {
> > +     .copy_mem =3D lsdma_v6_0_copy_mem
> >  };
>
> Regards,
> --
> Luben
