Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F14FEF8FEF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 14:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAACB10E18A;
	Wed,  4 Mar 2026 14:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YjTAqA5H";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B02310E18A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 14:40:51 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-124713e4244so373035c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Mar 2026 06:40:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772635250; cv=none;
 d=google.com; s=arc-20240605;
 b=XB2XDsHyh703eUQQB2Ik9Bz1rY4TUiPFTX0HMjVMeriZWtlWWTntYI2TusLJ5gqsYA
 JyvtuIlqjPnAxqivb23uLDAwlFjeZ8PwNYW4ldnM3Ft0kNdFnKlCzY6SOrAjP7/+s9FB
 PwWGemo4igSS69dwNq8reJAOwWg9A99vfYJYVM4Sw+rsW48YrhkAEqZkxQUKE1gkOfyL
 xPUrL171gNruyII99sulMjRSZYcVxc3jbKoYmCUoKbFXn2g7Bxhs8/HxcNqCa+h+5RBQ
 pINMsTL4lokwkg3ADnAWUA3KTzGeQIrKt6XTX/agLeC9Hg9CRz3ArfU4lm1GPwmvSmi9
 KEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yjZIqJQ2UGUigGx8aHYj9EU5eU3mkr4xpXOg/v+M/sc=;
 fh=g1L5v4RupGPNduMlntwNSTqax+QxbNfXW/Y0x0AAoXY=;
 b=jv2kIRFHxFOuPPi4SRVitMosYfXFn0CQQSm2kIAnUYeTlG+51KB9plPgKJL1uI67m8
 PUGxbrc5a7MjekRGew4Y0jnz3pH5/uP/WQazxzPHUxLXhqLcusISHK6nlW2NRlan4FG4
 97dPyPIgpeQbapNe/+vcfKopV9IAev9bQm4xUS8GWXxO3UvY2xetCvoPF50Nu7EOCmay
 1tuXeFjB3j9RRRio+LwhJNZcFAv2xrtZD8mvBk6GQa7511BUyAxel9hu20065nFSMU+i
 FQR/h4XcKjynb+UDCcXp4Jtg5TS9kfXCkdOe3eiLGXdSVtUx7VZ5Eo62uE9gGvjAimqh
 HWtA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772635250; x=1773240050; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjZIqJQ2UGUigGx8aHYj9EU5eU3mkr4xpXOg/v+M/sc=;
 b=YjTAqA5HbDs9QYSJXPC2xQAQSwiW0SG26BvKj65Kw4wBHby3KdUfNDa9Dbrk0eRaLY
 HwCKmMTiqH7N8PZPDgjCnSotgwEEkiLQc6EFtNUc1AoD5PH8XMrh+b24wJQVTGr3pRfX
 peLfNvvXpguKepwtltCPEOyGVLt0nx1OCJ279Z1Hqu0PctscyOuThkwpc0dI0Gtf/Tgr
 f6mV7eMDse/nz+/E4pNvF0iuxkloDgetiyZnIWAZcJ4HYlQ0O20AvG747itelWhBGupU
 GvH3mQboK7Z3BsKYjbMGsXbQhtzdgDLJqzT1f103YGNSg96e+CDrj9eDCoAJoj7MT2cR
 Rs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772635250; x=1773240050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yjZIqJQ2UGUigGx8aHYj9EU5eU3mkr4xpXOg/v+M/sc=;
 b=erFoPLg57Kt4W8gQoM8b+uMtBbfi80U/xxaiTZTcby7B/PJnLzpdBd/EK9yZLL6nG9
 X104NcSk4NRHq7GGRZKOGUV3/aSAtrZmx2IHmSwSK9c5a8tqFRYjN+efZ1FatkpPf5vJ
 LjAKNnaoSh7UF2mXED0Ya2bPT2RiktV4Lg7HQe0CHKVGvwcu9YKv9f1iGxXj6gm8KFO1
 8OfXO9lkP1zxI4sO23f3+JlYxN+msQ+Y4tr48TJ3CzfEcbOUg+lPKvX+CoViGZkr7Hg5
 quOefBjBLSI/N6W2HSYoXOt6/Qqn8Yvmg85ZR0rwgYDgCvebynj7QJSkWdOU1HcwgY3Q
 ienA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdS1dped/gdgoi5bpsyodo3VuuNQKf+PF3Uyarsa/7srjKu7RJDQWkg4fsroOxxClDInAT4hix@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz38+CUinsR1Ki1Nz0AV+PFAfjB0vzT28wyKSp++p8OMdHeVb1A
 CXl8S4QGrCCGy5E8dNKUqK/yx1epuab1X/umU5Z1dKAK8y2fIjK1oE0lmRngY6XcctcwIIE9LE+
 1yIxUIeKprsUvH3kV90M4m4v+zgtkovo=
X-Gm-Gg: ATEYQzxtUkkocxLW6pdh03t67WZxxw1moWawe5asCGmcv5YQlFob4UJ5uojtEfbH/oa
 v8+oQqr710gM0MxH1022SJ770pOihiRGuiZ/vQLQhjIiC0LA/FzauDkikM0QzoaLlIHKgwLgNX0
 ZBBCkqbmxF0tZVzXy4kAkxi82Ur9KLwofUMhYvUGn+2C/5o1CKnEUav75EUz8n8v3VOH6okCseK
 ztjXbmb5CbdjRbaleLmIKNUeh21KTrZa1IUc9byeWRDvQCu2DY1bhzKwdr/UWc0S2LdvpGGJVt5
 bFyDwsbQ7pY17S6K0tT7LdAT89V4DKeV/Zaa9DTAEx3jdPNYPEUf5IcEsUFOO4DvI0Y0Sg==
X-Received: by 2002:a05:7022:e1d:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-128b70c4a9amr409300c88.5.1772635250346; Wed, 04 Mar 2026
 06:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20260128195327.2158888-1-alexander.deucher@amd.com>
 <e1289ed4-1ba6-4ee2-9858-68ab42abcd79@amd.com>
In-Reply-To: <e1289ed4-1ba6-4ee2-9858-68ab42abcd79@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Mar 2026 09:40:39 -0500
X-Gm-Features: AaiRm51Pis3512NeKAoCncYGX21McUSqAXIx7rI67ZzejyK8pu0VaTLWwZV1dOE
Message-ID: <CADnq5_M-21A=bsk+qmZXYUWO9eZN_-dK0CQwCkCi_bYqqQ=o+A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gfx12.1: add support for disable_kq
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Mar 3, 2026 at 10:19=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 29-Jan-26 1:23 AM, Alex Deucher wrote:
> > Plumb in support for disabling kernel queues and make it
> > the default.  For testing, kernel queues can be re-enabled
> > by setting amdgpu.user_queue=3D0
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 109 +++++++++++++++++++-----=
-
> >   1 file changed, 82 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v12_1.c
> > index 08ae50a6313f3..f93ee275ce398 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> > @@ -1155,11 +1155,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >               break;
> >       }
> >
> > -     /* recalculate compute rings to use based on hardware configurati=
on */
> > -     num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> > -                          adev->gfx.mec.num_queue_per_pipe) / 2;
> > -     adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute_rings,
> > -                                       num_compute_rings);
> > +     if (adev->gfx.num_compute_rings) {
> > +             /* recalculate compute rings to use based on hardware con=
figuration */
> > +             num_compute_rings =3D (adev->gfx.mec.num_pipe_per_mec *
> > +                                  adev->gfx.mec.num_queue_per_pipe) / =
2;
> > +             adev->gfx.num_compute_rings =3D min(adev->gfx.num_compute=
_rings,
> > +                                               num_compute_rings);
> > +     }
> >
> >       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >
> > @@ -2794,6 +2796,36 @@ static void gfx_v12_1_xcc_fini(struct amdgpu_dev=
ice *adev,
> >       gfx_v12_1_xcc_enable_gui_idle_interrupt(adev, false, xcc_id);
> >   }
> >
> > +static int gfx_v12_1_set_userq_eop_interrupts(struct amdgpu_device *ad=
ev,
> > +                                           bool enable)
> > +{
> > +     unsigned int irq_type;
> > +     int m, p, r, x, num_xcc;
> > +
> > +     if (adev->gfx.disable_kq) {
> > +             num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> > +             for (x =3D 0; x < num_xcc; x++) {
> > +                     for (m =3D 0; m < adev->gfx.mec.num_mec; ++m) {
> > +                             for (p =3D 0; p < adev->gfx.mec.num_pipe_=
per_mec; p++) {
> > +                                     irq_type =3D AMDGPU_CP_IRQ_COMPUT=
E_MEC1_PIPE0_EOP
> > +                                             + (m * adev->gfx.mec.num_=
pipe_per_mec)
> > +                                             + p;
>
> if x is not involved in type calculation, I guess iteration over x is
> not required. Only the handler for the interrupt type needs to be
> enabled once.

will fix.

>
> > +                                     if (enable)
> > +                                             r =3D amdgpu_irq_get(adev=
, &adev->gfx.eop_irq,
> > +                                                                irq_ty=
pe);
> > +                                     else
> > +                                             r =3D amdgpu_irq_put(adev=
, &adev->gfx.eop_irq,
> > +                                                                irq_ty=
pe);
> > +                                     if (r)
> > +                                             return r;
> > +                             }
> > +                     }
> > +             }
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static int gfx_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> > @@ -2801,6 +2833,7 @@ static int gfx_v12_1_hw_fini(struct amdgpu_ip_blo=
ck *ip_block)
> >
> >       amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
> >       amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
> > +     gfx_v12_1_set_userq_eop_interrupts(adev, false);
> >
> >       num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
> >       for (i =3D 0; i < num_xcc; i++) {
> > @@ -2868,10 +2901,26 @@ static int gfx_v12_1_early_init(struct amdgpu_i=
p_block *ip_block)
> >   {
> >       struct amdgpu_device *adev =3D ip_block->adev;
> >
> > +
> > +     switch (amdgpu_user_queue) {
> > +     case -1:
> > +     default:
> > +             adev->gfx.disable_kq =3D true;
> > +             adev->gfx.disable_uq =3D true;
> > +             break;
> > +     case 0:
> > +             adev->gfx.disable_kq =3D false;
> > +             adev->gfx.disable_uq =3D true;
> > +             break;
> > +     }
> > +
> >       adev->gfx.funcs =3D &gfx_v12_1_gfx_funcs;
> >
> > -     adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kcq(adev),
> > -                                       AMDGPU_MAX_COMPUTE_RINGS);
> > +     if (adev->gfx.disable_kq)
> > +             adev->gfx.num_compute_rings =3D 0;
> > +     else
> > +             adev->gfx.num_compute_rings =3D min(amdgpu_gfx_get_num_kc=
q(adev),
> > +                                               AMDGPU_MAX_COMPUTE_RING=
S);
> >
> >       gfx_v12_1_set_kiq_pm4_funcs(adev);
> >       gfx_v12_1_set_ring_funcs(adev);
> > @@ -2898,6 +2947,10 @@ static int gfx_v12_1_late_init(struct amdgpu_ip_=
block *ip_block)
> >       if (r)
> >               return r;
> >
> > +     r =3D gfx_v12_1_set_userq_eop_interrupts(adev, true);
> > +     if (r)
> > +             return r;
> > +
> >       return 0;
> >   }
> >
> > @@ -3719,29 +3772,31 @@ static void gfx_v12_1_handle_priv_fault(struct =
amdgpu_device *adev,
> >       if (xcc_id =3D=3D -EINVAL)
> >               return;
> >
> > -     switch (me_id) {
> > -     case 0:
> > -             for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > -                     ring =3D &adev->gfx.gfx_ring[i];
> > -                     /* we only enabled 1 gfx queue per pipe for now *=
/
> > -                     if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id)
> > -                             drm_sched_fault(&ring->sched);
> > -             }
> > -             break;
> > -     case 1:
> > -     case 2:
> > -             for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > -                     ring =3D &adev->gfx.compute_ring
> > +     if (!adev->gfx.disable_kq) {
>
> If no handled here, is this unexpected or handled somewhere else?

If kernel queues are not enabled, a kernel queue would never be
responsible so nothing would match here anyway.  Support for user
queues still needs to be hooked for these faults in general.

>
> > +             switch (me_id) {
> > +             case 0:
> > +                     for (i =3D 0; i < adev->gfx.num_gfx_rings; i++) {
> > +                             ring =3D &adev->gfx.gfx_ring[i];
> > +                             /* we only enabled 1 gfx queue per pipe f=
or now */
> > +                             if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id)
> > +                                     drm_sched_fault(&ring->sched);
> > +                     }
>
> Not related to this patch, but this code looks redundant.

I can clean this up in a separate patch.

Alex

>
> Thanks,
> Lijo
>
> > +                     break;
> > +             case 1:
> > +             case 2:
> > +                     for (i =3D 0; i < adev->gfx.num_compute_rings; i+=
+) {
> > +                             ring =3D &adev->gfx.compute_ring
> >                                       [i +
> >                                        xcc_id * adev->gfx.num_compute_r=
ings];
> > -                     if (ring->me =3D=3D me_id && ring->pipe =3D=3D pi=
pe_id &&
> > -                         ring->queue =3D=3D queue_id)
> > -                             drm_sched_fault(&ring->sched);
> > +                             if (ring->me =3D=3D me_id && ring->pipe =
=3D=3D pipe_id &&
> > +                                 ring->queue =3D=3D queue_id)
> > +                                     drm_sched_fault(&ring->sched);
> > +                     }
> > +                     break;
> > +             default:
> > +                     BUG();
> > +                     break;
> >               }
> > -             break;
> > -     default:
> > -             BUG();
> > -             break;
> >       }
> >   }
> >
>
