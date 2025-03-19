Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB394C35FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 13:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3792510E4FE;
	Wed, 19 Mar 2025 13:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TuupEsAs";
	dkim-atps=neutral
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BCC10E4FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 13:46:44 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-86ca7d2bda0so364264241.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742392003; x=1742996803; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qVFfTOFQ3lxQD16QZ09+hI5LxomGYerHP1X7dGEFnBI=;
 b=TuupEsAsRr3UiCI/FyD0YpwMl9D3eIzCHUNRekV49AsDPsJ5gJNKy370pqEqszFRy6
 Rss5d9cXg+BqGzaITbov72bPTWGkZosyEIP2mm6WUcTyzLLUnkAi9ixYwzgphtBxv0S/
 7WpgmxucB0JKE7K6Y+ak1PMYDUgeGGXSdp83eJkqy3u6i+HYx5iT2I7wEYETjDBQY5iT
 NZjKiUNwQjgG3q+IsABuF8pR+Dp4Yk5AabUDzH8TlDodaupuEHER7R1v/14ehcW4vk1S
 BRpf57eLWcTc0J+fYm+lgSv8v85o5aCkpAXGWWkuk9SD8HJckUjhf0YKzDCmBv+gwimg
 JLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742392003; x=1742996803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qVFfTOFQ3lxQD16QZ09+hI5LxomGYerHP1X7dGEFnBI=;
 b=OrnGCDeviq0tlbHPxU9cBIofycpVyje+mfZizIwzg4iMEQq8GWXTuhqFSF/P7iyVAa
 XkpmDzhyfKHTT7q/PcjV1d+BcI86x3IkzmWyd1saBHSuHbGHxs8LBCq+zN+qXO3OxC07
 psQic78UT83wfPy6YGJaa2ExYlrNH6FJsDSfrfssniWA+F027RAy8o6/k0gBepXsKTfm
 VKa89C75rXD770Q8v2O6H2JRXG7sRXoNG9SDZw6LfCD1qZCIJhqbMrlcvaMF3j6FlX19
 IeUcPrspGX0hWYfp23zeptAhyJrT76NyBFbHB4rtbbGMFzC3jqEAAwCIPcoNuS5t+hkP
 bowA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYO1TRwoojpz99G53MAUMlmCZSMy8kQhrBcT+hbRFKTSLK1ZG3G00+K4ySxANtQJFdYO6Oae+N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgaR7rI1yfoFMaedQED1s7m4Mk/o28Sqru9X3WXhnhJzw/hN69
 sg2Uh21Dc0qPmCHRMNCcOUp70qxSf59jTCiRRcRPQS6LfIh0zjg6YPa4/cPiG2fQJSW477wKsY8
 lg8CWNGEg+DalHO1Oz++Gb6n1k34=
X-Gm-Gg: ASbGnct6Ask+/psXVxOrWdLRbmKIZMHiTpvJmT5jiu4VD8cNlvZ4TsIriR6V9xTVCoC
 rhbX9OYOoywffZEtauBnokMqIUBPN/rcWTiFrqJws0pUKVNyGd6HAOkC6tIl8THcrqMgij7nBda
 qefLPjy46A+1j96dynCIHaYbnTcw==
X-Google-Smtp-Source: AGHT+IGnr+vPv0C4x6roixAP+lDtAGf1e+9uHTWZSRrALedtLqyJh1XCmeE2roP8HwcGRVPi+a+b80R1NVn18rmoj3w=
X-Received: by 2002:a05:6102:5e82:b0:4c1:8047:e002 with SMTP id
 ada2fe7eead31-4c4ef3842e8mr345707137.1.1742392003488; Wed, 19 Mar 2025
 06:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-5-alexander.deucher@amd.com>
 <DS7PR12MB6005D659588057084A2A1097FBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005D659588057084A2A1097FBD92@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Mar 2025 09:46:30 -0400
X-Gm-Features: AQ5f1JpxuCl9op2dyMKK5cxW4BsYxGdlJ8JZLvjVGnK8o_V6yoMF_QIPrS9xZKM
Message-ID: <CADnq5_OpckMBR=12+Q2d7Di08YVaUG_0xJsjk0Gj_t1VfVvmvA@mail.gmail.com>
Subject: Re: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask management
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Khatri,
 Sunil" <Sunil.Khatri@amd.com>
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

On Wed, Mar 19, 2025 at 2:12=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, March 13, 2025 10:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>
> > Subject: [PATCH 04/11] drm/amdgpu/mes: centralize gfx_hqd mask manageme=
nt
> >
> > Move it to amdgpu_mes to align with the compute and sdma hqd masks. No
> > functional change.
> >
> > v2: rebase on new changes
> >
> > Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 22 ++++++++++++++++++++++
> > drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 16 +++-------------
> > drivers/gpu/drm/amd/amdgpu/mes_v12_0.c  | 15 +++------------
> >  3 files changed, 28 insertions(+), 25 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 6f5e272d7ded3..5abc1ca0fee98 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -108,6 +108,28 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
> >       adev->mes.vmid_mask_mmhub =3D 0xffffff00;
> >       adev->mes.vmid_mask_gfxhub =3D 0xffffff00;
> >
> > +     for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++) {
> > +             /* use only 1st ME pipe */
> > +             if (i >=3D adev->gfx.me.num_pipe_per_me)
> > +                     continue;
> If only requires setting the 1st pipe MES mask here, it seems unnecessary=
 to continue the rest setting loop.

oh, yeah, this should be break.  Same for compute.

Alex

> Other than that, the patch is Reviewed-by: Prike Liang <Prike.Liang@amd.c=
om>.
>
> Thanks,
> Prike
> > +             if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D
> > +                 IP_VERSION(12, 0, 0))
> > +                     /*
> > +                      * GFX V12 has only one GFX pipe, but 8 queues in=
 it.
> > +                      * GFX pipe 0 queue 0 is being used by Kernel que=
ue.
> > +                      * Set GFX pipe 0 queue 1-7 for MES scheduling
> > +                      * mask =3D 1111 1110b
> > +                      */
> > +                     adev->mes.gfx_hqd_mask[i] =3D 0xFE;
> > +             else
> > +                     /*
> > +                      * GFX pipe 0 queue 0 is being used by Kernel que=
ue.
> > +                      * Set GFX pipe 0 queue 1 for MES scheduling
> > +                      * mask =3D 10b
> > +                      */
> > +                     adev->mes.gfx_hqd_mask[i] =3D 0x2;
> > +     }
> > +
> >       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++) {
> >               /* use only 1st MEC pipes */
> >               if (i >=3D adev->gfx.mec.num_pipe_per_mec) diff --git
> > a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > index a569d09a1a748..39b45d8b5f049 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> > @@ -669,18 +669,6 @@ static int mes_v11_0_misc_op(struct amdgpu_mes
> > *mes,
> >                       offsetof(union MESAPI__MISC, api_status));  }
> >
> > -static void mes_v11_0_set_gfx_hqd_mask(union
> > MESAPI_SET_HW_RESOURCES *pkt) -{
> > -     /*
> > -      * GFX pipe 0 queue 0 is being used by Kernel queue.
> > -      * Set GFX pipe 0 queue 1 for MES scheduling
> > -      * mask =3D 10b
> > -      * GFX pipe 1 can't be used for MES due to HW limitation.
> > -      */
> > -     pkt->gfx_hqd_mask[0] =3D 0x2;
> > -     pkt->gfx_hqd_mask[1] =3D 0;
> > -}
> > -
> >  static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)  {
> >       int i;
> > @@ -705,7 +693,9 @@ static int mes_v11_0_set_hw_resources(struct
> > amdgpu_mes *mes)
> >               mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
> >                       mes->compute_hqd_mask[i];
> >
> > -     mes_v11_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> > +     for (i =3D 0; i < MAX_GFX_PIPES; i++)
> > +             mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> > +                     mes->gfx_hqd_mask[i];
> >
> >       for (i =3D 0; i < MAX_SDMA_PIPES; i++)
> >               mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D mes-
> > >sdma_hqd_mask[i]; diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > index 96336652d14c5..519f054bec60d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> > @@ -694,17 +694,6 @@ static int mes_v12_0_set_hw_resources_1(struct
> > amdgpu_mes *mes, int pipe)
> >                       offsetof(union MESAPI_SET_HW_RESOURCES_1,
> > api_status));  }
> >
> > -static void mes_v12_0_set_gfx_hqd_mask(union
> > MESAPI_SET_HW_RESOURCES *pkt) -{
> > -     /*
> > -      * GFX V12 has only one GFX pipe, but 8 queues in it.
> > -      * GFX pipe 0 queue 0 is being used by Kernel queue.
> > -      * Set GFX pipe 0 queue 1-7 for MES scheduling
> > -      * mask =3D 1111 1110b
> > -      */
> > -     pkt->gfx_hqd_mask[0] =3D 0xFE;
> > -}
> > -
> >  static int mes_v12_0_set_hw_resources(struct amdgpu_mes *mes, int pipe=
)  {
> >       int i;
> > @@ -727,7 +716,9 @@ static int mes_v12_0_set_hw_resources(struct
> > amdgpu_mes *mes, int pipe)
> >                       mes_set_hw_res_pkt.compute_hqd_mask[i] =3D
> >                               mes->compute_hqd_mask[i];
> >
> > -             mes_v12_0_set_gfx_hqd_mask(&mes_set_hw_res_pkt);
> > +             for (i =3D 0; i < MAX_GFX_PIPES; i++)
> > +                     mes_set_hw_res_pkt.gfx_hqd_mask[i] =3D
> > +                             mes->gfx_hqd_mask[i];
> >
> >               for (i =3D 0; i < MAX_SDMA_PIPES; i++)
> >                       mes_set_hw_res_pkt.sdma_hqd_mask[i] =3D
> > --
> > 2.48.1
>
