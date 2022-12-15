Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3791EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Dec 2022 22:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B91BD10E57E;
	Thu, 15 Dec 2022 22:08:31 +0000 (UTC)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6300710E57E
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 22:08:27 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id q186so407898oia.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Dec 2022 14:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6W+fTmlJy3KyE6fZf6Nf/s69LdITxdvot+GqHv/ld/g=;
 b=MF2Exk6jyX5Fo0ttYN2CduXL/EYXqkXj+qz20XsmRDJo0oBat5UC30LF/H7sXWiS66
 NJ3Dw7cuZ0A25vGLE5dDqGrU3T80wM/6kauqXejjlyza0ShSYWO2b59CsLXP+2Sw638n
 qPhXlFUW4hPC6cBZwZUL70K/wKRLEZdRAt0ecyKY1geRtniCQ2vZjH7OyiJlOx3E9dxY
 Eirg487H44HWuyPPWARldkwPhDskrv0Z8i5jc7wC2GDpunDE67yksZxhzluzJ9PFnI8f
 poE3ZrTFjrJioeUL74rNOWonv3+CG6lNek+i5BvRXdYKKRY5f3ToaDHBDqCu8zfy4F8q
 Tr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6W+fTmlJy3KyE6fZf6Nf/s69LdITxdvot+GqHv/ld/g=;
 b=dnDV8rsDjhuvG1L361y00SXpZb28QYCNbyuhjVFRxGfx18LASsMK/qkkMLuc/w/56S
 /uhvEYtisVRwvAfEkmx6m4N8lyBlsWhY11zTM/0ZdDGJ9ZWM9SwQanO8TP4S1zUDtjYM
 GZfjiFNBG2Rjc0T3EcREz4wdMzx2gP0fs/p820KtHGzJbphV+Uo5hScIJV18xdkdwKfF
 fQchoaUAZ3NnI/a7nMB/MBo2Xemli8NRRFoIPstdrsZYdqULfLAiaSX5k4VY00k6tHqo
 JKi9vs7hCBfUaQs5ctSB+nrN63MFcTBFXKEwT9v9uyyueVkoQjE0TtFaAvkSUMNfELsR
 CGmw==
X-Gm-Message-State: ANoB5pkLLrn08+rp8QxvDYKmi82qAItpk5vKqG1i/3HTQewjIwXXirCQ
 aP7FQNnegeI61hKtE9OLnPEjaQwOkQDUfV907QI=
X-Google-Smtp-Source: AA0mqf7hxEzU9D2I/KmNPmVAh/I/4yFgVcfk7q6kH83SC7i8Bprwqd0gZszwy6voYKsd5L0ed1rz5anw8Y7zXn5g+dg=
X-Received: by 2002:a05:6808:1886:b0:35b:d93f:cbc4 with SMTP id
 bi6-20020a056808188600b0035bd93fcbc4mr449389oib.96.1671142106485; Thu, 15 Dec
 2022 14:08:26 -0800 (PST)
MIME-Version: 1.0
References: <20221214221654.1625194-1-alexander.deucher@amd.com>
 <20221214221654.1625194-2-alexander.deucher@amd.com>
 <83ccb403-5c69-e191-41d9-0e5870baf40d@gmail.com>
In-Reply-To: <83ccb403-5c69-e191-41d9-0e5870baf40d@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Dec 2022 17:08:14 -0500
Message-ID: <CADnq5_NFS1V3gPmfZAm9s8mQe3PJVBvP++WLR_UUKCLfe+WgVA@mail.gmail.com>
Subject: Re: [PATCH 1/7] drm/amdgpu/gmc9: don't touch gfxhub registers during
 S0ix
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Dec 15, 2022 at 2:45 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 14.12.22 um 23:16 schrieb Alex Deucher:
> > gfxhub registers are part of gfx IP and should not need to be
> > changed.  Doing so without disabling gfxoff can hang the gfx IP.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 26 ++++++++++++++++++++------
> >   1 file changed, 20 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index 08d6cf79fb15..5f07c85bf729 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -484,6 +484,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct=
 amdgpu_device *adev,
> >                       for (i =3D 0; i < 16; i++) {
> >                               reg =3D hub->vm_context0_cntl + i;
> >
> > +                             if (adev->in_s0ix && (j =3D=3D AMDGPU_GFX=
HUB_0))
> > +                                     continue;
> > +
>
> I'm not sure we can do this because the higher layer will then have an
> incorrect impression of the interrupt state here.

In this particular case it works because we only touch this interrupt
on init/resume and fini/suspend.  So over the course of a s0i3 cycle
the state would end up being the same, we just don't touch the
registers.

Alex

>
> Christian.
>
> >                               if (j =3D=3D AMDGPU_GFXHUB_0)
> >                                       tmp =3D RREG32_SOC15_IP(GC, reg);
> >                               else
> > @@ -504,6 +507,9 @@ static int gmc_v9_0_vm_fault_interrupt_state(struct=
 amdgpu_device *adev,
> >                       for (i =3D 0; i < 16; i++) {
> >                               reg =3D hub->vm_context0_cntl + i;
> >
> > +                             if (adev->in_s0ix && (j =3D=3D AMDGPU_GFX=
HUB_0))
> > +                                     continue;
> > +
> >                               if (j =3D=3D AMDGPU_GFXHUB_0)
> >                                       tmp =3D RREG32_SOC15_IP(GC, reg);
> >                               else
> > @@ -1862,9 +1868,12 @@ static int gmc_v9_0_gart_enable(struct amdgpu_de=
vice *adev)
> >       }
> >
> >       amdgpu_gtt_mgr_recover(&adev->mman.gtt_mgr);
> > -     r =3D adev->gfxhub.funcs->gart_enable(adev);
> > -     if (r)
> > -             return r;
> > +
> > +     if (!adev->in_s0ix) {
> > +             r =3D adev->gfxhub.funcs->gart_enable(adev);
> > +             if (r)
> > +                     return r;
> > +     }
> >
> >       r =3D adev->mmhub.funcs->gart_enable(adev);
> >       if (r)
> > @@ -1911,11 +1920,15 @@ static int gmc_v9_0_hw_init(void *handle)
> >               value =3D true;
> >
> >       if (!amdgpu_sriov_vf(adev)) {
> > -             adev->gfxhub.funcs->set_fault_enable_default(adev, value)=
;
> > +             if (!adev->in_s0ix)
> > +                     adev->gfxhub.funcs->set_fault_enable_default(adev=
, value);
> >               adev->mmhub.funcs->set_fault_enable_default(adev, value);
> >       }
> > -     for (i =3D 0; i < adev->num_vmhubs; ++i)
> > +     for (i =3D 0; i < adev->num_vmhubs; ++i) {
> > +             if (adev->in_s0ix && (i =3D=3D AMDGPU_GFXHUB_0))
> > +                     continue;
> >               gmc_v9_0_flush_gpu_tlb(adev, 0, i, 0);
> > +     }
> >
> >       if (adev->umc.funcs && adev->umc.funcs->init_registers)
> >               adev->umc.funcs->init_registers(adev);
> > @@ -1939,7 +1952,8 @@ static int gmc_v9_0_hw_init(void *handle)
> >    */
> >   static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
> >   {
> > -     adev->gfxhub.funcs->gart_disable(adev);
> > +     if (!adev->in_s0ix)
> > +             adev->gfxhub.funcs->gart_disable(adev);
> >       adev->mmhub.funcs->gart_disable(adev);
> >   }
> >
>
