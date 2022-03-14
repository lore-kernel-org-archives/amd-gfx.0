Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524B8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 20:47:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B6210E2F2;
	Mon, 14 Mar 2022 20:47:28 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D77C010E2A6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 20:47:27 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 j3-20020a9d7683000000b005aeed94f4e9so12664562otl.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 13:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7p/mfjx/cTwkEIkTp4IeTUDk5SqY6rEgiU2INODevbI=;
 b=jbt6JEs2SZucaAJw2+MCJ8iWqnUpMQwSHswsOVdm7e6cDoEYybVipREF63hYqpviG3
 m1OqAV+6YC5HMPNg/01Vcsi+lq7Me6GG7Int6qieSwEzH8p2PKXsKCG1tDPBdsz+oPyK
 vd+WROjlooyfmmUZ0lF4iA9Joj4GnjCOx/L44Bu8yzTDmvkGasftsM0D+V4rVSKb3fxO
 QCmCAM5yN1Kgs1cT4gXOpKMda2xtCG3YR1XdUs/lplwylbvmVfKqRl5+4FTR0ik6EPCG
 aQTxvInHMtodrAKcvjfQ0AGK9p9734yOB4OUomTonj0NAjBwmJPVo+cXdVgDv9O0vOVb
 qz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7p/mfjx/cTwkEIkTp4IeTUDk5SqY6rEgiU2INODevbI=;
 b=kcslVTD1jLBB5+rjo1sjKGr3pVY9UqueY/RC/e4yip6H89iYNojnjzOIyadspHrlhG
 xpscMsQPFmpu9+amsqLhY0cEhIoNjflV5SwXoLmgB8yASLDH+UA10xMLWyRdL/+Z7UPf
 znYr4Vyu6LGTzsDIbiahn2B6yo8fieGHY4O/9bKzObSPfMqtq474m4hrPMPqsaJUNNrA
 Zy330nmxHkzrlURJDPjUsnP2a/nZ63nUNT4Y7TP7viAbmEPQsBRHBqEUBVssDyYkHBbC
 lY5+zyKAXUrO2y+D94qzD3bqvohCO+aQP/Vy+n9Kfdo8MFc+u/3vl23VShEgw1Nt8hlK
 SlSA==
X-Gm-Message-State: AOAM530USeUC0AhMaY2CFusdQsMH1Y/z5wzcZynxklbQrJlBlH1S89KK
 3IsT5KhJMBH6n/KxwayLeAAgK3d4JxjyJ4Re6FY=
X-Google-Smtp-Source: ABdhPJzIMAsP6ZrNWowfG2+gsNQyUUalhlXkeDsur7PCgRP4WbB8wNmZRgkvQ0/4s1112lQ2EPoZTN9R/LmsZTh0BCE=
X-Received: by 2002:a05:6830:2709:b0:5b0:196:dcf with SMTP id
 j9-20020a056830270900b005b001960dcfmr12172479otu.357.1647290847128; Mon, 14
 Mar 2022 13:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220314185403.137623-1-yongqiang.sun@amd.com>
 <36a827c9-1ec9-1131-7d92-d5dc972472a1@gmail.com>
In-Reply-To: <36a827c9-1ec9-1131-7d92-d5dc972472a1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Mar 2022 16:47:16 -0400
Message-ID: <CADnq5_NCPZqm7XELbJDZ_zBMGA0indEOQKGNOBpREEzSrP7ePA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Use fw vram offset when allocating stolen
 vga memory.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, nikola.veljkovic@amd.com,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 14, 2022 at 3:35 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.03.22 um 19:54 schrieb Yongqiang Sun:
> > [Why]
> > Memory access violation will happen in case of allocate stolen vga
> > memory with size isn't 0.
> >
> > [How]
> > when allocating stolen vga memory, use fw vram offset as the start poin=
t
> > instead of hard code value 0.
>
> Please stop separating commit message into [Why] and [How], that is not
> well received everywhere.
>
> Apart from that the patch is a certain NAK, you are messing things quite
> up here.
>
> >
> > Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> > Change-Id: I7c555a6c1fb4b3fa8685753b4bdcbe215f89ea1e
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 31 +++++++++++++++++++-----=
-
> >   1 file changed, 24 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ttm.c
> > index 41d6f604813d..1f635fdb0395 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1708,6 +1708,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >       uint64_t gtt_size;
> >       int r;
> >       u64 vis_vram_limit;
> > +     u64 memory_offset =3D adev->mman.fw_vram_usage_start_offset + ade=
v->mman.fw_vram_usage_size;
> >
> >       mutex_init(&adev->mman.gtt_window_lock);
> >
> > @@ -1774,24 +1775,40 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
> >        * This is used for VGA emulation and pre-OS scanout buffers to
> >        * avoid display artifacts while transitioning between pre-OS
> >        * and driver.  */
> > -     r =3D amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_s=
ize,
> > +     r =3D amdgpu_bo_create_kernel_at(adev,
> > +                                        memory_offset,
> > +                                adev->mman.stolen_vga_size,
>
> That is certainly incorrect. See function amdgpu_ttm_fw_reserve_vram_init=
().
>
> The stolen VGA buffer always started at offset 0 and is independent of
> the range defined by fw_vram_usage_start_offset and fw_vram_usage_size.
>

Yeah these are separate ranges.  I just had a chat with Yongqiang and
there was some confusion around this, but this patch can be dropped.

Alex


> Regards,
> Christian.
>
> >                                      AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &adev->mman.stolen_vga_memory,
> >                                      NULL);
> >       if (r)
> >               return r;
> > -     r =3D amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size=
,
> > +
> > +     memory_offset +=3D adev->mman.stolen_vga_size;
> > +
> > +     r =3D amdgpu_bo_create_kernel_at(adev,
> > +                                        memory_offset,
> >                                      adev->mman.stolen_extended_size,
> >                                      AMDGPU_GEM_DOMAIN_VRAM,
> >                                      &adev->mman.stolen_extended_memory=
,
> >                                      NULL);
> >       if (r)
> >               return r;
> > -     r =3D amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved=
_offset,
> > -                                    adev->mman.stolen_reserved_size,
> > -                                    AMDGPU_GEM_DOMAIN_VRAM,
> > -                                    &adev->mman.stolen_reserved_memory=
,
> > -                                    NULL);
> > +
> > +     memory_offset +=3D adev->mman.stolen_extended_size;
> > +
> > +     if (adev->mman.stolen_reserved_offset > memory_offset)
> > +             r =3D amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_=
reserved_offset,
> > +                                                adev->mman.stolen_rese=
rved_size,
> > +                                                AMDGPU_GEM_DOMAIN_VRAM=
,
> > +                                                &adev->mman.stolen_res=
erved_memory,
> > +                                                NULL);
> > +     else if (adev->mman.stolen_reserved_offset + adev->mman.stolen_re=
served_size > memory_offset)
> > +             r =3D amdgpu_bo_create_kernel_at(adev, memory_offset,
> > +                                             adev->mman.stolen_reserve=
d_offset + adev->mman.stolen_reserved_size - memory_offset,
> > +                                                AMDGPU_GEM_DOMAIN_VRAM=
,
> > +                                                &adev->mman.stolen_res=
erved_memory,
> > +                                                NULL);
> >       if (r)
> >               return r;
> >
>
