Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF22C47DA2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jan 2024 23:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2275910E8D8;
	Wed, 17 Jan 2024 23:01:34 +0000 (UTC)
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010B110E8D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 23:01:32 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-20503dc09adso7695988fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jan 2024 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705532432; x=1706137232; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lC6UIOTpKhAlk48FNal0Q0PBAlGeCki955CYziO3ig=;
 b=Lylhov9B98wUzpx9rrkH3TwDxpKtUrXuWjgmUzDSgqUpFv3Ej7ulzw2FxtoPVYTMsl
 uH4GbX6xXSGlWNLZrMs3lnqpWSQyXq1LGfUh3+PorBINyDAKZw+T/rwPJohT9+HERk0l
 Z+StfpmU644Xwvm7kGIGr3iqkjrX8oMOGYU0wcmiITMdPDokiJ+t4men+V3/oRWc5Gd4
 JDCJvaI0AsZoMWrijW4/Lax/kmRRtE/bGbQ6rnEpuDE/xVFWZIx7zdjO3497+yMJC9Iy
 vOZw5NR/oooFBm6P58B/3GtObtxA0i/QL9peojctZE6sw9oeIBA7t944bSgiSBM14zJd
 7mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705532432; x=1706137232;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lC6UIOTpKhAlk48FNal0Q0PBAlGeCki955CYziO3ig=;
 b=mwSSJUYmUyHCd1nVEd/zJs8U9vkE/adnBAWZQz9AbpPqEoZCX84olLsIzp1Am8j/aZ
 gllJmmEDw0DfbYZFEVH6x03bPgpT58QNjXCXz/ne4eWbQOQVXhAr9vPVHRV/8RCLOkWR
 vDVyTQ1CHYuv4kXCxEAbVsHYBNJOfZJ3BVtE7J/jTAZ88UUMeXe8kz9YLZWMvoUQ/59c
 42kBeyZR9pzPIezuTzWoxm/8/o+qShhKPd33er4J6zsLg2eG86AKjyMRoXNPQ89Wei7J
 TbRH7nY2CdaX+84UvkQVpqBylmpeU3IQTqU22UambnzVBepktflHtA52jTOVkWfGkVCb
 vKSA==
X-Gm-Message-State: AOJu0YxhKuz7i9Va5qh+ae4zvRUxpFbOaTTeDduoOXXWcj8ENuE+toJ8
 dKkKRlwBoJncwFSTV5isUO6RXeudc0bmQQe9Ymk=
X-Google-Smtp-Source: AGHT+IGXPZJLBTNX0ngb9a+y8MnCb72vl3r+37sdmODk3Pjyvm60ggvogpze2bOQmcn767FYlG08ZHi9drJyLBJkt2A=
X-Received: by 2002:a05:6870:3050:b0:206:233:9234 with SMTP id
 u16-20020a056870305000b0020602339234mr13541817oau.15.1705532431904; Wed, 17
 Jan 2024 15:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20240114130008.868941-1-friedrich.vock@gmx.de>
 <69cec077-4011-4738-bbb0-8fb1e6f52159@gmail.com>
 <abdfec21-2642-4c68-8c51-cdfba54928aa@gmx.de>
 <577a8451-0791-4bd1-8c6c-61a7cc293174@gmail.com>
 <d15ac325-e830-4e11-a239-56eaeddecae8@gmx.de>
 <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
In-Reply-To: <e977939c-db01-4b14-8494-0bdad5be7a8a@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jan 2024 18:00:20 -0500
Message-ID: <CADnq5_Nb=ruoA2j-mHrQbxHY=yzwGm2kKjDiQ+ajk3urKKLing@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit after writing
 rptr
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Christian Koenig <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, Joshua Ashton <joshua@froggi.es>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jan 17, 2024 at 7:36=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 16.01.24 um 11:31 schrieb Friedrich Vock:
> > On 16.01.24 08:03, Christian K=C3=B6nig wrote:
> >> Am 15.01.24 um 12:18 schrieb Friedrich Vock:
> >>> [SNIP]
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>> +        tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >>>>> +        WREG32(mmIH_RB_CNTL, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>
> >>>> Well that is an extremely bad idea. We already reset the overflow
> >>>> after reading the WPTR.
> >>>
> >>> This is not resetting the overflow bit. This is resetting a "clear
> >>> overflow" bit. I don't have the hardware docs, but the name (and my
> >>> observations) strongly suggest that setting this bit actually prevent=
s
> >>> the hardware from setting the overflow bit ever again.
> >>
> >> Well that doesn't make any sense at all. The hardware documentation
> >> clearly states that this bit is write only and should always read as
> >> zero.
> >>
> >> Setting this bit will clear the overflow flag in the WPTR register and
> >> clearing it has no effect at all.
> >>
> >> I could only ping the hw engineer responsible for this block to double
> >> check if the documentation is somehow outdated, but I really doubt so.
> >>
> > I see. I wish I had access to the documentation,
>
> Well, doesn't Valve has an NDA in place?
>
> > but I don't, so all I
> > can do is tell you what I observe the hardware doing. I've tested this
> > on both a Steam Deck (OSSYS 5.2.0) and an RX 6700 XT (OSSYS 5.0.3). On
> > both systems, launching a bunch of shaders that cause page faults leads
> > to lots of "[gfxhub] page fault" messages in dmesg, followed by an
> > "amdgpu: IH ring buffer overflow".
>
> Well that is certainly a bug, maybe even the same thing we have seen on
> Vega and MI.
>
> What we could do is to try to apply the same workaround to re-route the
> page faults to a different IH ring.
>
> See those patches here as well:
>
> commit 516bc3d8dd7965f1a8a3ea453857f14d95971e62
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Fri Nov 2 15:00:16 2018 +0100
>
>      drm/amdgpu: reroute VMC and UMD to IH ring 1
>
>      Page faults can easily overwhelm the interrupt handler.
>
>      So to make sure that we never lose valuable interrupts on the
> primary ring
>      we re-route page faults to IH ring 1.
>
> commit b849aaa41c914a0fd88003f88cb04420a873c624
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Mon Mar 4 19:34:34 2019 +0100
>
>      drm/amdgpu: also reroute VMC and UMD to IH ring 1 on Vega 20
>
>      Same patch we alredy did for Vega10. Just re-route page faults to a
> separate
>      ring to avoid drowning in interrupts.
>
> >
> > If I re-launch the same set of shaders after the GPU has soft-recovered=
,
> > the "amdgpu: IH ring buffer overflow" message is missing, even though
> > the same amount of page faults should've been triggered at roughly the
> > same rate. Running with this patch applied makes more "amdgpu: IH ring
> > buffer overflow" messages appear after relaunching the faulting shaders
> > (but not when processing any non-faulting work).
>
> That is actually the expected behavior. There should be a limit on the
> number of faults written to the ring so that the ring never overflows.
>
> >
> > The only possible conclusion I can draw from this is that clearing that
> > bit *does* have an effect, and I don't think it's far-fetched to assume
> > the IH ring buffer overflows still happen after re-launching the
> > faulting shaders but go undetected so far.
>
> Well that can only mean that the hw documentation is incorrect.
>
> Either the value is not write only trigger bit as documented or we need
> an additional read of the register for it to take effect or something
> like this.
>
> >>> Right now, IH overflows, even if they occur repeatedly, only get
> >>> registered once. If not registering IH overflows can trivially lead t=
o
> >>> system crashes, it's amdgpu's current handling that is broken.
> >>
> >> It's years that we last tested this but according to the HW
> >> documentation this should work fine.
> >>
> >> What could potentially happen is that the IH has silenced the source
> >> of the overflow. We never implemented resetting those, but in this
> >> case that here won't help either.
> >>
> > If the IH silenced the page faults (which quite clearly cause the
> > overflow here), then how are the page faults still logged in dmesg?
>
> There should be a hardware rate limit for the page faults, e.g. there
> can only be X faults reported in N clock cycles and then a delay is
> inserted.

@Christian Koenig  Is that tied to xnack (i.e., noretry)?  The default
is noretry=3D1 on gfx10.3 and newer.  But it can be overridden.  It was
not set on some older kernels, maybe that is the problem?  @Friedrich
Vock does setting amdgpu.noretry=3D1 fix the issue?

Alex

>
> >>>
> >>> The possibility of a repeated IH overflow in between reading the wptr
> >>> and updating the rptr is a good point, but how can we detect that at
> >>> all? It seems to me like we can't set the OVERFLOW_CLEAR bit at all
> >>> then, because we're guaranteed to miss any overflows that happen whil=
e
> >>> the bit is set.
> >>
> >> When an IH overflow is signaled we clear that flag by writing 1 into
> >> the OVERFLOW_CLEAR bit and skip one entry in the IH ring buffer.
> >>
> >> What can of course happen is that the IH ring buffer overflows more
> >> than this single entry and we process IVs which are potentially
> >> corrupted, but we won't miss any additional overflows since we only
> >> start processing after resetting the flag.
> >>
> >> An IH overflow is also something you should *never* see in a
> >> production system. This is purely for driver bringup and as fallback
> >> when there is a severe incorrect programming of the HW.
> >>
> >> The only exception of that is page fault handling on MI products
> >> because of a hardware bug, to mitigate this we are processing page
> >> faults on a separate IH ring on those parts.
> >>
> >> On all other hw generations the IH should have some rate limit for the
> >> number of faults generated per second, so that the CPU is always able
> >> to catch up.
> >
> > I'm wondering if there is another bug in here somewhere. Your
> > explanation of how it's supposed to work makes a lot of sense, but from
> > what I can tell it doesn't work that way when I test it.
> >
> > From the printk_ratelimit stats it would seem like >2000 faults arrive
> > in less than a second, so perhaps your theory about fault interrupt
> > ratelimiting not working is correct (but it's hard for me to verify wha=
t
> > is going on without the documentation).
>
> I'm going to ping the relevant engineer and putting someone on the task
> to take a look.
>
> Thanks,
> Christian.
>
> >
> > Regards,
> > Friedrich
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards,
> >>> Friedrich
> >>>
> >>>>
> >>>> When you clear the overflow again when updating the RPTR you could
> >>>> loose another overflow which might have happened in between and so
> >>>> potentially process corrupted IVs.
> >>>>
> >>>> That can trivially crash the system.
> >>>>
> >>>> Regards,
> >>>> Christian.
> >>>>
> >>>>>   }
> >>>>>
> >>>>>   static int cik_ih_early_init(void *handle)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> >>>>> index b8c47e0cf37a..076559668573 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> >>>>> @@ -215,7 +215,7 @@ static u32 cz_ih_get_wptr(struct amdgpu_device
> >>>>> *adev,
> >>>>>       tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32(mmIH_RB_CNTL, tmp);
> >>>>> -
> >>>>> +    ih->overflow =3D true;
> >>>>>
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>> @@ -266,7 +266,19 @@ static void cz_ih_decode_iv(struct amdgpu_devi=
ce
> >>>>> *adev,
> >>>>>   static void cz_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                  struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>> +
> >>>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32(mmIH_RB_CNTL, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   static int cz_ih_early_init(void *handle)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> >>>>> index aecad530b10a..1a5e668643d1 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> >>>>> @@ -214,7 +214,7 @@ static u32 iceland_ih_get_wptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>       tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32(mmIH_RB_CNTL, tmp);
> >>>>> -
> >>>>> +    ih->overflow =3D true;
> >>>>>
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>> @@ -265,7 +265,19 @@ static void iceland_ih_decode_iv(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void iceland_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                   struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>> +
> >>>>>       WREG32(mmIH_RB_RPTR, ih->rptr);
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32(mmIH_RB_CNTL, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   static int iceland_ih_early_init(void *handle)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>>> index d9ed7332d805..ce8f7feec713 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> >>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_devic=
e
> >>>>> *adev,
> >>>>>       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>> +
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>>   }
> >>>>> @@ -459,6 +461,7 @@ static void ih_v6_0_irq_rearm(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void ih_v6_0_set_rptr(struct amdgpu_device *adev,
> >>>>>                      struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>>       struct amdgpu_ih_regs *ih_regs;
> >>>>>
> >>>>>       if (ih->use_doorbell) {
> >>>>> @@ -472,6 +475,16 @@ static void ih_v6_0_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>           ih_regs =3D &ih->ih_regs;
> >>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   /**
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> >>>>> index 8fb05eae340a..668788ad34d9 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> >>>>> @@ -418,6 +418,8 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_devic=
e
> >>>>> *adev,
> >>>>>       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>> +
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>>   }
> >>>>> @@ -459,6 +461,7 @@ static void ih_v6_1_irq_rearm(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void ih_v6_1_set_rptr(struct amdgpu_device *adev,
> >>>>>                      struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>>       struct amdgpu_ih_regs *ih_regs;
> >>>>>
> >>>>>       if (ih->use_doorbell) {
> >>>>> @@ -472,6 +475,16 @@ static void ih_v6_1_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>           ih_regs =3D &ih->ih_regs;
> >>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   /**
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >>>>> index e64b33115848..0bdac923cb4d 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> >>>>> @@ -442,6 +442,7 @@ static u32 navi10_ih_get_wptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>>   }
> >>>>> @@ -483,6 +484,7 @@ static void navi10_ih_irq_rearm(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void navi10_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                      struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>>       struct amdgpu_ih_regs *ih_regs;
> >>>>>
> >>>>>       if (ih =3D=3D &adev->irq.ih_soft)
> >>>>> @@ -499,6 +501,16 @@ static void navi10_ih_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>           ih_regs =3D &ih->ih_regs;
> >>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   /**
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> >>>>> index 9a24f17a5750..ff35056d2b54 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> >>>>> @@ -119,6 +119,7 @@ static u32 si_ih_get_wptr(struct amdgpu_device
> >>>>> *adev,
> >>>>>           tmp =3D RREG32(IH_RB_CNTL);
> >>>>>           tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >>>>>           WREG32(IH_RB_CNTL, tmp);
> >>>>> +        ih->overflow =3D true;
> >>>>>       }
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>>   }
> >>>>> @@ -147,7 +148,18 @@ static void si_ih_decode_iv(struct amdgpu_devi=
ce
> >>>>> *adev,
> >>>>>   static void si_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                  struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>> +
> >>>>>       WREG32(IH_RB_RPTR, ih->rptr);
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32(IH_RB_CNTL);
> >>>>> +        tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >>>>> +        WREG32(IH_RB_CNTL, tmp);
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   static int si_ih_early_init(void *handle)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> >>>>> index 917707bba7f3..6f5090d3db48 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> >>>>> @@ -218,6 +218,7 @@ static u32 tonga_ih_get_wptr(struct amdgpu_devi=
ce
> >>>>> *adev,
> >>>>>       tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32(mmIH_RB_CNTL, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>>
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>> @@ -268,6 +269,8 @@ static void tonga_ih_decode_iv(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void tonga_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                     struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>> +
> >>>>>       if (ih->use_doorbell) {
> >>>>>           /* XXX check if swapping is necessary on BE */
> >>>>>           *ih->rptr_cpu =3D ih->rptr;
> >>>>> @@ -275,6 +278,16 @@ static void tonga_ih_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>       } else {
> >>>>>           WREG32(mmIH_RB_RPTR, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32(mmIH_RB_CNTL);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32(mmIH_RB_CNTL, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   static int tonga_ih_early_init(void *handle)
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >>>>> index d364c6dd152c..bb005924f194 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> >>>>> @@ -372,6 +372,7 @@ static u32 vega10_ih_get_wptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>>
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>> @@ -413,6 +414,7 @@ static void vega10_ih_irq_rearm(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void vega10_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                      struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>>       struct amdgpu_ih_regs *ih_regs;
> >>>>>
> >>>>>       if (ih =3D=3D &adev->irq.ih_soft)
> >>>>> @@ -429,6 +431,16 @@ static void vega10_ih_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>           ih_regs =3D &ih->ih_regs;
> >>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   /**
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> >>>>> index ddfc6941f9d5..bb725a970697 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> >>>>> @@ -420,6 +420,7 @@ static u32 vega20_ih_get_wptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >>>>>       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1=
);
> >>>>>       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >>>>> +    ih->overflow =3D true;
> >>>>>
> >>>>>   out:
> >>>>>       return (wptr & ih->ptr_mask);
> >>>>> @@ -462,6 +463,7 @@ static void vega20_ih_irq_rearm(struct
> >>>>> amdgpu_device *adev,
> >>>>>   static void vega20_ih_set_rptr(struct amdgpu_device *adev,
> >>>>>                      struct amdgpu_ih_ring *ih)
> >>>>>   {
> >>>>> +    u32 tmp;
> >>>>>       struct amdgpu_ih_regs *ih_regs;
> >>>>>
> >>>>>       if (ih =3D=3D &adev->irq.ih_soft)
> >>>>> @@ -478,6 +480,16 @@ static void vega20_ih_set_rptr(struct
> >>>>> amdgpu_device *adev,
> >>>>>           ih_regs =3D &ih->ih_regs;
> >>>>>           WREG32(ih_regs->ih_rb_rptr, ih->rptr);
> >>>>>       }
> >>>>> +
> >>>>> +    /* If we overflowed previously (and thus set the OVERFLOW_CLEA=
R
> >>>>> bit),
> >>>>> +     * reset it here to detect more overflows if they occur.
> >>>>> +     */
> >>>>> +    if (ih->overflow) {
> >>>>> +        tmp =3D RREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl);
> >>>>> +        tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR=
,
> >>>>> 0);
> >>>>> +        WREG32_NO_KIQ(ih->ih_regs.ih_rb_cntl, tmp);
> >>>>> +        ih->overflow =3D false;
> >>>>> +    }
> >>>>>   }
> >>>>>
> >>>>>   /**
> >>>>> --
> >>>>> 2.43.0
> >>>>>
> >>>>
> >>
>
