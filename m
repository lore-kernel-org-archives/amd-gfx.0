Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A74FC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 20:44:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6662410E26A;
	Mon, 14 Mar 2022 20:44:51 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0244910E26A
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 20:44:50 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 g5-20020a4ae885000000b003240bc9b2afso9361322ooe.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=zG+d/uKNgTQFwKs/qCVQ5ToSUVRXxPWj/NUMadJYqQ8=;
 b=A1bosvQJOKw6yUPXwwL5nTkIYiNs239SR5diSZiJGteFeyeMxY+6BhymkiZAAR7mK8
 j+FootOmwEfSN6ftC9JNbmld48W/VmvIH38IcexJ+3Xys3ENvxqGIOyNX7bMJntndACX
 9OZNyBPdBHj9toZr3w2EKLHdquB3iRnICSogeZQEBNT0AX5xZuWihWFqr9N9EUEFjcI/
 owBSB7ykepc+8sgF+SMgkXWcTDABmCWGpGF2BTI0PtUaaWu3/TZC2R2ce16Q6/Sbkvk9
 iKdqPqU6izP/E7+0VJzDxPsqu/gHWUmmBC3UqOpik7GOFOb/dLsha2dMjkIzLMrRzASo
 NfHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=zG+d/uKNgTQFwKs/qCVQ5ToSUVRXxPWj/NUMadJYqQ8=;
 b=k+B+5sObEw5rtfg4EY4QpDDN7HdRnDednE2gOlk1dYWVlzeJwRuoPrEC9BHWxsujaQ
 uF3jgzbsIE/GGQXO6Q8xKY3sBxEo+rhuX09NtTUdgchaxO+yio+hrugIF88WTtFmiOQk
 0juAdBBmDcF9j8Xgvk4Q2bfNnigifqcytq5AZ6aH49VSeufAIB2d16ED99PD77OXOAKR
 GYVv7YuLBRjmAdVfAPaB7WDxpZdsK3LXweZqG2tD8TFMfqry9yVDW/Fk32W3xfo47Si0
 PZyqBwx+EPbWpipFEARDXExV8Y1o/0TC/4x/aZmOvB1H/mjBUg3WAfcuBscx8V0V2H3o
 ErYA==
X-Gm-Message-State: AOAM533n2braQn5w4tJPslrDm/aj/6zcVb9/mkaFz+yjNDuJA+sCXT2a
 IUFinuJ0PzalqDtfziejV0v7vtREotLjor+XSM4=
X-Google-Smtp-Source: ABdhPJxxcEsUOdRh7PH/Mx3kG8JxO72DBsIF40OQOpy4BPAoqB5fczfcZsChb2GDMa+LlKQsQsYvqhLfhGihDso9FkM=
X-Received: by 2002:a05:6870:d250:b0:da:b3f:2b29 with SMTP id
 h16-20020a056870d25000b000da0b3f2b29mr364430oac.200.1647290690240; Mon, 14
 Mar 2022 13:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220314185403.137623-1-yongqiang.sun@amd.com>
 <20220314185403.137623-2-yongqiang.sun@amd.com>
 <e2b06b36-293f-ce39-0f78-d4768ac0456b@gmail.com>
In-Reply-To: <e2b06b36-293f-ce39-0f78-d4768ac0456b@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Mar 2022 16:44:39 -0400
Message-ID: <CADnq5_P4wWnhzn1zwFA4TgbGPTVcWUbDTVtmGO5w5bWGS_JtEg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add stolen reserved memory for MI25 SRIOV.
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

On Mon, Mar 14, 2022 at 3:41 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.03.22 um 19:54 schrieb Yongqiang Sun:
> > [Why]
> > MI25 SRIOV guest driver loading failed due to allocate
> > memory overlaps with private memory area.
> >
> > [How]
> > 1. Allocate stolen reserved memory for MI25 SRIOV specifically to avoid
> > the memory overlap.
> > 2. Move allocate reserve allocation to vbios allocation since both the
> > two functions are doing similar asic type check and no need to have
> > seperate functions.
> >
> > Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> > Change-Id: I142127513047a3e81573eb983c510d763b548a24
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 37 ++++++++++++------------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 -
> >   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  1 -
> >   3 files changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 7c2a9555b7cc..f7f4f00dd2b2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -626,6 +626,11 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgp=
u_device *adev)
> >   {
> >       unsigned size;
> >
> > +     /* Some ASICs need to reserve a region of video memory to avoid a=
ccess
> > +      * from driver */
> > +     adev->mman.stolen_reserved_offset =3D 0;
> > +     adev->mman.stolen_reserved_size =3D 0;
> > +
> >       /*
> >        * TODO:
> >        * Currently there is a bug where some memory client outside
> > @@ -635,11 +640,24 @@ void amdgpu_gmc_get_vbios_allocations(struct amdg=
pu_device *adev)
> >        * Keep the stolen memory reservation until the while this is not=
 solved.
> >        */
> >       switch (adev->asic_type) {
> > +
> >       case CHIP_VEGA10:
>
> Please don't add empty lines between switch and case. Good practice is
> to check your patches with checkpatch.pl before sending it out.
>
> > +             adev->mman.keep_stolen_vga_memory =3D true;
> > +             if (amdgpu_sriov_vf(adev)) {
> > +                     adev->mman.stolen_reserved_offset =3D 0x100000;
> > +                     adev->mman.stolen_reserved_size =3D 0x600000;
> > +             }
> > +             break;
> >       case CHIP_RAVEN:
> >       case CHIP_RENOIR:
> >               adev->mman.keep_stolen_vga_memory =3D true;
> >               break;
> > +     case CHIP_YELLOW_CARP:
> > +             if (amdgpu_discovery =3D=3D 0) {
> > +                     adev->mman.stolen_reserved_offset =3D 0x1ffb0000;
> > +                     adev->mman.stolen_reserved_size =3D 64 * PAGE_SIZ=
E;
> > +             }
> > +             break;
>
> That looks like this is somehow mixed up. The stolen memory is for VGA
> emulation, but under SRIOV we should not have VGA emulation as far as I
> know.
>
> Alex, what's going on here?

I suggested calling amdgpu_gmc_get_reserved_allocation() from
amdgpu_gmc_get_vbios_allocations() rather calling
amdgpu_gmc_get_reserved_allocation() in every gmc file since it
handles additional reserved areas used allocated by firmware, etc.  My
understanding is that there is some additional reserved area set up in
the hypervisor that we want reserved in the guest.  The idea was to
just use stolen_reserved_offset for that similar to what we do for the
bring up case for yellow carp.

Alex


>
> Regards,
> Christian.
>
> >       default:
> >               adev->mman.keep_stolen_vga_memory =3D false;
> >               break;
> > @@ -760,25 +778,6 @@ uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_devi=
ce *adev, struct amdgpu_bo *bo
> >       return amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start + adev->gm=
c.aper_base;
> >   }
> >
> > -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev)
> > -{
> > -     /* Some ASICs need to reserve a region of video memory to avoid a=
ccess
> > -      * from driver */
> > -     adev->mman.stolen_reserved_offset =3D 0;
> > -     adev->mman.stolen_reserved_size =3D 0;
> > -
> > -     switch (adev->asic_type) {
> > -     case CHIP_YELLOW_CARP:
> > -             if (amdgpu_discovery =3D=3D 0) {
> > -                     adev->mman.stolen_reserved_offset =3D 0x1ffb0000;
> > -                     adev->mman.stolen_reserved_size =3D 64 * PAGE_SIZ=
E;
> > -             }
> > -             break;
> > -     default:
> > -             break;
> > -     }
> > -}
> > -
> >   int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
> >   {
> >       struct amdgpu_bo *vram_bo =3D NULL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.h
> > index 93505bb0a36c..032b0313f277 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> > @@ -331,7 +331,6 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device =
*adev, int hub_type,
> >                             bool enable);
> >
> >   void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
> > -void amdgpu_gmc_get_reserved_allocation(struct amdgpu_device *adev);
> >
> >   void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
> >   uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t m=
c_addr);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
> > index f60b7bd4dbf5..3c1d440824a7 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -948,7 +948,6 @@ static int gmc_v10_0_sw_init(void *handle)
> >               return r;
> >
> >       amdgpu_gmc_get_vbios_allocations(adev);
> > -     amdgpu_gmc_get_reserved_allocation(adev);
> >
> >       /* Memory manager */
> >       r =3D amdgpu_bo_init(adev);
>
