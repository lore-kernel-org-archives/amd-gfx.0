Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3543CC44515
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2026 14:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB92510F31F;
	Thu, 16 Jul 2026 14:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K4D2MuVQ";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 961DC10F31F
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 14:01:03 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cac39b729dso16703355ad.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2026 07:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784210463; cv=none;
 d=google.com; s=arc-20260327;
 b=JLadnwl7GqZ4ndcn2mMlmxXRVSL850urSrJApnMYNHoeKUDhZ4xvEkDlc484+evQNU
 R++TaKZzicYrxUDsiAy5r/kgjd1va/yYxjz2xLadCW4EChr5/etLrwO2FUvdqJpDOl1s
 fLWMHXTy2QULhHfVUsEN/B8pqHtVIOKTQYMfeJmkz1BbwtE9o5lUJJAX+AOFyFO/YoUQ
 bF67D7bHc5+gYbfuYKwAuVCDDTPVVTTkYrHrdO54zJ8b3rVa2fNbN3zSEX2YDgAUJuBw
 8wEzbxbSsgJy0lhCDEVl0bAtOQD4EDlj1N7nOSQ+zUTCn9R+hGlkOFk9L2enuKWZDYFM
 t9hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=iZ7LQj/V80q7GW/Qfg1Nt1/2do8wHfbT6i3WQFuZjVU=;
 fh=4ql5AVrIUDvKC2jBuwKXG/FIPmBRqfCOURlaLtLhDxM=;
 b=KAPdnQuYvLY9lKFxI1m0ZDXZ+/WTqS5rUkYB+iX4VDeNlkmqgUj7k8Xw5VR7lgIXcH
 6ptpMDYLPh3OQD+Z82z6mdWeDLCPKkDg4mutx4YXP7o/5x0UqI2LkAF1rhqVGDUMPtb7
 3cyBzlbwEMucdumoUOaY1eqRXdZg8p0kwIOIRaUyVgogYE8s1Vs/iFJ0XYoKz44sB03D
 /DYI3YyqrcSDvUWQONFzaNCYKv3Afq8AnBDCIrA5IKSNmFL54Uw31redKiz/7b7fmrJD
 qwjVBzFywbrJGgN+aJ80FuVkEo//L/fsnsuukHtJBaFFHCUkiqlqyl19exexUogZS36+
 GjqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784210463; x=1784815263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iZ7LQj/V80q7GW/Qfg1Nt1/2do8wHfbT6i3WQFuZjVU=;
 b=K4D2MuVQVe+dr5fJqCR1YFIfgXZT4gmCPL0tT82iWyezWYVIdnn+IIaKmFsVELNV8x
 Ayb4r5qRbsq9OvjMjdFxAEICA5+8Aq8k0txAWG4T1iqxK4VpjN2KRjkA95AoZjq9+ELY
 Lv3110QF1wH3C7Q3IXAL2KMCYESANPMHpHP32YFJtq5ay3Tu6a3asfuLcgLJnyzj1ilC
 K1B+cuNiFsIXANgJ1tFuVelFMYwIQdeBdru3WaO/BBvMZnkcezWU13qWWkp/9tmR2Xjh
 6XhnA+AX/Xm8VlhHfAAX3rYxHwENd/Ifg5zqZ8SFAYqotHqvPKEIeM13/t2D+eMFHIOm
 usVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784210463; x=1784815263;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iZ7LQj/V80q7GW/Qfg1Nt1/2do8wHfbT6i3WQFuZjVU=;
 b=mWGI0HKm6VnRlgb8pJNCUTyJivoggtCa+xzYvWQkpi/P+8pveh2Z7LibPo1XA5782R
 EdYN2V7pyEDar9sF+hEOejremgP9pDM0tptNuV7T6O+8uNuk07iGR12ycu/eiroRDrTI
 YFXO/1Mb1saARTsp+kxMs8mSPNE3yqkrwC6Kx0hu3nORfNJ734tx3YjoE0EP7m/fAr9o
 mpVtZVOGI7rFEn2ySaijA/f/QiwzVzSG8v9EnYsybwqsrrMtWT5xebsOvhmsmIgnAYCl
 zM+oKjPJGinxNMFaLWpblZHrrGLaWW8lJ6HwK4K2JH9n9KUPPmjyLwJTP8XWJQia7sz2
 q36g==
X-Forwarded-Encrypted: i=1;
 AHgh+RokppDJ/sSvweyXVXMZipXArMjYjgmbY05oczd/vd3WaOnQz30rbuG4pHwvxmmhTVkuNI18zlb6@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw33CHBxJ0Ix+QA0koQuNqEWVahPTO69XZTQu3aknbDTsHiqu0I
 giHfoFlvQElChjwR7OqMaD+kPe9T2+kvS3hwccUqmbjhFLfmoSaxKoaGr29FX3pfKqY06y/n2A8
 LgWT64SohtVr5LlzYA21T9sSUkJe44CFrgA==
X-Gm-Gg: AfdE7cnBd5DJqaFSxk65SRWjhpVuv8KMHFnNIcEtteaISP+uINugG2Cp5Q1az+I2mDX
 bTowQydJfZUOUq3jxz66vUTas36Ip6cMVpIj/JT8aL9sbpcqZMZDp7TnXnGk6XzJgEzefZT24MX
 VEYULMaIaftksurHEzTf0JRtK+9x0nCKFclTlz+4Xk6HtS6ZIRTugXAYFB5ifDCUQEg0s3DYsX6
 WKDvuDhFPfeCTYuQUVIJOyfjvsLNlm7i+4vGImPCLQQsIRdXZQbjmDFqjChhUWxWHMjRnbeOa4a
 0t89+N6Of73ixVYiVe6H1JuNWg1XzeLW9bm3d9WtIoq50wW/
X-Received: by 2002:a17:90b:4d08:b0:38d:fe7d:2a83 with SMTP id
 98e67ed59e1d1-38dfe7d2abfmr12017883a91.3.1784210463037; Thu, 16 Jul 2026
 07:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260713130709.34262-1-timur.kristof@gmail.com>
 <5733138.E0xQCEvomI@timur-max>
 <d56d2eef-0bd1-4289-b315-8ecb7f5d01eb@ursulin.net>
 <178429166.VBMTVartND@timur-max>
 <afb43e28-45d2-4529-98af-6fc7ea071ec7@ursulin.net>
In-Reply-To: <afb43e28-45d2-4529-98af-6fc7ea071ec7@ursulin.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 16 Jul 2026 10:00:50 -0400
X-Gm-Features: AUfX_mwWOENa3vbKMZXsYMEYkDm7hoVWyTDYTvIHjGTZhELPo1M2R6cV5zoX2DQ
Message-ID: <CADnq5_OTNp-+mJ=BLU6p4vF4B4xrim+8hOVb6fbkmXC01PxURg@mail.gmail.com>
Subject: Re: [PATCH 07/11] drm/amdgpu/gfx6: Properly enable/disable priv_req
 and priv_inst interrupts
To: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

On Thu, Jul 16, 2026 at 8:24=E2=80=AFAM Tvrtko Ursulin <tursulin@ursulin.ne=
t> wrote:
>
>
> On 15/07/2026 20:23, Timur Krist=C3=B3f wrote:
> > On 2026. j=C3=BAlius 15., szerda 13:22:21 k=C3=B6z=C3=A9p-eur=C3=B3pai =
ny=C3=A1ri id=C5=91 Tvrtko Ursulin
> > wrote:
> >> On 15/07/2026 11:53, Timur Krist=C3=B3f wrote:
> >>> On 2026. j=C3=BAlius 15., szerda 12:19:40 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Tvrtko
> >>> Ursulin
> >>>
> >>> wrote:
> >>>> On 13/07/2026 14:07, Timur Krist=C3=B3f wrote:
> >>>>> These were used without ever calling get()/put() on them.
> >>>>
> >>>>> Implement it like on GFX7-8:
> >>>> Used as in how? Are they even enabled without this change and if not
> >>>> then does this patch fixes something other than being prep work for =
soft
> >>>> reset?
> >>>
> >>> If you open gfx_v6_0.c and search for priv_reg or priv_inst, you can =
see
> >>> that the interrupts are used in the same manner as gfx7 and newer, bu=
t
> >>> without get() and put().
> >>
> >> Yes, they are used in code. Are they used in reality was my question. =
:)
> >
> > Looking at the code I think the original intention was to wire up these
> > interrupts. I think the hardware actually supports these interrupts and=
 the
> > author of the code simply forgot to call get() and put().
> >
> > If you are not convinced, maybe Alex or Christian can confirm whether t=
he
> > interrupt actually exists on this HW generation. If it turns out it doe=
sn't
> > exist then we should just delete this code.
> >
> >> I ask because it appears that without amdgpu_irq_get() they may not ev=
en
> >> get enabled so never received. Yes or no? Consequences if yes?
> >
> > Yes, that sounds correct. The consequence is that the interrupt will no=
w be
> > enabled and the HW will tell us about some illegal register access and =
some
> > illegal instructions when it happens.
>
> Right, AFAIU assuming the CP hangs, instead of waiting for the TDR
> timeout with this patch it will be instant via drm_sched_fault() called
> from either irq handler. Or if CP does not hang but somehow ends up
> going over it with corruption with this patch it will insta GPU hang.
>
> In any case I think it is needed to have a definitive answer whether the
> interrupts were not enabled until now, and if so, also exercise the
> until now unused code paths just to make sure it all works as expected.
> Presumably there are test cases which trigger both conditions?
>
> Then I would suggest putting this info in the commit message. That is,
> instead of saying "These were used without ever calling get()/put() on
> them." expand with the full story so the whole situation is clear both
> before and after the patch.
>
> Assuming interrupts were not enabled until now, that the unused irq
> handlers work as expected, and with the improved commit message:
>

The interrupts would not have been enabled if get() was never called.
I think they were never enabled because radeon didn't implement
support and this code was ported from radeon.

> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> Unless you don't have the hardware to test it and there are no existing
> test cases to verify it?

An example test would be attempting to access a privileged register
from a user IB.

Alex

>
> Regards,
>
> Tvrtko
>
> > To give you additional context: for the purpose of diagnosing issues re=
lated
> > to GPU hangs and recovery, all additional information helps. If the CP =
has
> > interrupts to tell us about some error cases, we should absolutely use =
that.
> >
> > Side note: from the register definitions it looks like the HW actually =
supports
> > other interrupts which would be interesting to enable in the future.
> > In this patch I just wanted to fix up the two that were already in the =
code.
> >
> >>
> >>>>> * Call amdgpu_irq_get() from gfx_v6_0_late_init()
> >>>>> * Call amdgpu_irq_put() from gfx_v6_0_hw_fini()
> >>>>>
> >>>>> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >>>>> ---
> >>>>>
> >>>>>     drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 19 +++++++++++++++++++
> >>>>>     1 file changed, 19 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c index 5b570a4b5c01..1c7cd26=
5fbca
> >>>>> 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> >>>>> @@ -3131,6 +3131,22 @@ static int gfx_v6_0_early_init(struct
> >>>>> amdgpu_ip_block *ip_block)>
> >>>>>
> >>>>>           return 0;
> >>>>>
> >>>>>     }
> >>>>>
> >>>>> +static int gfx_v6_0_late_init(struct amdgpu_ip_block *ip_block)
> >>>>> +{
> >>>>> + struct amdgpu_device *adev =3D ip_block->adev;
> >>>>> + int r;
> >>>>> +
> >>>>> + r =3D amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
> >>>>> + if (r)
> >>>>> +         return r;
> >>>>> +
> >>>>> + r =3D amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
> >>>>> + if (r)
> >>>>> +         return r;
> >>>>> +
> >>>>> + return 0;
> >>>>> +}
> >>>>> +
> >>>>>
> >>>>>     static int gfx_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
> >>>>>     {
> >>>>>
> >>>>>           struct amdgpu_ring *ring;
> >>>>>
> >>>>> @@ -3243,6 +3259,8 @@ static int gfx_v6_0_hw_fini(struct amdgpu_ip_=
block
> >>>>> *ip_block)>
> >>>>>
> >>>>>     {
> >>>>>
> >>>>>           struct amdgpu_device *adev =3D ip_block->adev;
> >>>>>
> >>>>> + amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >>>>> + amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> >>>>>
> >>>>>           gfx_v6_0_cp_enable(adev, false);
> >>>>>           adev->gfx.rlc.funcs->stop(adev);
> >>>>>           gfx_v6_0_fini_pg(adev);
> >>>>>
> >>>>> @@ -3532,6 +3550,7 @@ static void gfx_v6_0_emit_mem_sync(struct
> >>>>> amdgpu_ring *ring)>
> >>>>>
> >>>>>     static const struct amd_ip_funcs gfx_v6_0_ip_funcs =3D {
> >>>>>
> >>>>>           .name =3D "gfx_v6_0",
> >>>>>           .early_init =3D gfx_v6_0_early_init,
> >>>>>
> >>>>> + .late_init =3D gfx_v6_0_late_init,
> >>>>>
> >>>>>           .sw_init =3D gfx_v6_0_sw_init,
> >>>>>           .sw_fini =3D gfx_v6_0_sw_fini,
> >>>>>           .hw_init =3D gfx_v6_0_hw_init,
> >
> >
> >
> >
>
