Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC092C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 18:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C46810E053;
	Mon, 17 Mar 2025 18:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtVXeJjw";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E964510E053
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 18:27:51 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2241c95619eso12280845ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 11:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742236071; x=1742840871; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j4lcbfPs8gIb8R8PHTGA461lxW2/xu+XZJDUHRySooE=;
 b=TtVXeJjwOndt/JrXEnWF+x3ZRHpTTaJxkmC7UKGnjmaQBjqMEGxs6ZNNqhzBU1LD7d
 hNFtTkJ6Vj91DVGim9LZnr6RM9mADBOoFvfH3jKhJ9cIBaB71WeIsOuGjtNhfH3k4r0x
 Rpu9KOkJFHmKTa/fhfNOsXIRZIvKpJY/nRU1ZJ1ngLcZUSnbItpiznZQwEGgzaylvibT
 OCvNXHxANFMS8m9TCjAtB2/XECdG+IZEe270/u4Q45jxvdtbTviA3X+T7yQ4kkEa7uEG
 OcQOlcD8ShTyYQvsU6ThEqNWzCT6e4e5T05/rqK4r8hKzQz5tvT4DFy/hwzwwOgd2/74
 RsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742236071; x=1742840871;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4lcbfPs8gIb8R8PHTGA461lxW2/xu+XZJDUHRySooE=;
 b=mCtu45QB1U3Bxd8qrQcAEci005EKVYDByYKgfBv/MED09ESJlQma8ZpYtt269MgQFO
 2ubfL5yaUDNbajxOAxsfVWScGH7K1t4W0W9FI7BlbsKaNRvFwhjlaU9csQV3UTFvsRaq
 cmA22AgwW3OxgnzWtEU2uDonv+uHiWMGbl8Nej1eXJZDb0ZfMprfaTQfZkzaeG4fA5yR
 oG0gL6T6rLwNZIx5TOpJWByZIYd6kRbsxIhA9ZD6Cd8iiX8dFRSMX9m7T9vCjhbkfujA
 YyNHkRlC/qNKNm1vlJRjqxC1LJcR70lQJL9Y5pi+yBLoQFFtal9aj+7Q26xWaaxbZ6HU
 4p7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfy4LNpYY2FdngxZGO7BsX1nhYEu966I/kR3tVSBwG3VhoUTVgTgg1xWpOqo6R6E0tUqeRYLvv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDjeSIcg1e/OIkdJDhJ9dDGwMe/NnuauJi0mE3g4exXSipV3ci
 9vFKkCwzf66HI/SMMbMHVUAoPm7feO2kENUhZaSk65i2SIsfSbAYWRXWyMkdy/rRa0ZV9DuVD0r
 1C9RM2GTpg6nBwrtZ3p6geXWJWZI=
X-Gm-Gg: ASbGncuecVSpZPIbguXe1YzKCw/OnztUxy/nIPna/6KV1Cn0UA0vo+KOw9NXr3m/jF9
 hmrUYI0LkVUqj6h8rqmGA9I0oNJjn3zXw9jjitXu2jDylP0qCLKLsFAdn2Z2mD3EGSltEC11Fp/
 kLiH+8eDC7U8xrWWDP4Uisc0k6Bw==
X-Google-Smtp-Source: AGHT+IEh647lqkD8pG6d3+q7NC2EpH+2wTqR/4nbbIJKMDtA1DjsL/p5Q4zmM/Yk17UFz/hgeGqpcUFYDMGSsmhoV+w=
X-Received: by 2002:a17:902:fc8d:b0:223:49ce:67a2 with SMTP id
 d9443c01a7336-225e0ac4da6mr59287675ad.9.1742236070593; Mon, 17 Mar 2025
 11:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
 <DS7PR12MB60057FE73D45BF10F18E0046FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
 <CAAxE2A4KPSniNzPJ=3_JMHmCCyaOR77mXqarQr5=FWi7eiZ9Hw@mail.gmail.com>
In-Reply-To: <CAAxE2A4KPSniNzPJ=3_JMHmCCyaOR77mXqarQr5=FWi7eiZ9Hw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Mar 2025 14:27:38 -0400
X-Gm-Features: AQ5f1JpnXULc7ajKuKXk-XfHxCqh9pROq5Fq34naiM55KvtFB2ugb3Gc_JsPEJE
Message-ID: <CADnq5_MLAcnBiZHGC_s8es1p7cOAb6Cg89-VvTa=_c8+R3me=Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: "Liang, Prike" <Prike.Liang@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
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

On Mon, Mar 17, 2025 at 1:23=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> Userspace needs a query that a queue IP type is supported. "available_rin=
gs" is used for that right now, but if that's 0, something else must indica=
te IP support.
>
> amd_ip_info::num_queues should be non-zero even when user queues are supp=
orted. The exact number doesn't matter with user queues.

How will mesa determine whether kernel queues are supported?  Can mesa
look at amd_ip_info::num_queues and if it's 0, check some new INFO
query to determine if user queues are available?  If
amd_ip_info::num_queues is always non-0, then it would be assumed that
the kernel supports kernel queues, which it may not.

Alex

>
> Marek
>
> On Mon, Mar 17, 2025 at 3:09=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com=
> wrote:
>>
>> [Public]
>>
>> We might still need to export each ring's number correctly; otherwise, t=
he Mesa driver will consider there's no available ring supported from the d=
river and then further assert before submitting the user queue.
>>
>> If we want to keep the ring number being zero, the Mesa driver may need =
an attachment change to allow the command submitted to the zero-ring number=
 if the user queue is enabled.
>>
>> Hi @Olsak, Marek Do you think it's fine to have the attachment patch for=
 the userq support? Except for such changes, maybe we also need to clean up=
 the IB-related part.
>>
>> Regards,
>>       Prike
>>
>> > -----Original Message-----
>> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ale=
x
>> > Deucher
>> > Sent: Thursday, March 13, 2025 10:41 PM
>> > To: amd-gfx@lists.freedesktop.org
>> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
>> > <Sunil.Khatri@amd.com>
>> > Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissio=
ns
>> >
>> > This would be set by IPs which only accept submissions from the kernel=
, not
>> > userspace, such as when kernel queues are disabled. Don't expose the r=
ings to
>> > userspace and reject any submissions in the CS IOCTL.
>> >
>> > Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
>> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> > ---
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
>> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++-------=
-
>> > drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
>> >  3 files changed, 25 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > index 5df21529b3b13..5cc18034b75df 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parse=
r
>> > *p,
>> >       ring =3D amdgpu_job_ring(job);
>> >       ib =3D &job->ibs[job->num_ibs++];
>> >
>> > +     /* submissions to kernel queus are disabled */
>> > +     if (ring->no_user_submission)
>> > +             return -EINVAL;
>> > +
>> >       /* MM engine doesn't support user fences */
>> >       if (p->uf_bo && ring->funcs->no_user_fence)
>> >               return -EINVAL;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> > @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >       case AMDGPU_HW_IP_GFX:
>> >               type =3D AMD_IP_BLOCK_TYPE_GFX;
>> >               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
>> > -                     if (adev->gfx.gfx_ring[i].sched.ready)
>> > +                     if (adev->gfx.gfx_ring[i].sched.ready &&
>> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
>> >                               ++num_rings;
>> >               ib_start_alignment =3D 32;
>> >               ib_size_alignment =3D 32;
>> > @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >       case AMDGPU_HW_IP_COMPUTE:
>> >               type =3D AMD_IP_BLOCK_TYPE_GFX;
>> >               for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
>> > -                     if (adev->gfx.compute_ring[i].sched.ready)
>> > +                     if (adev->gfx.compute_ring[i].sched.ready &&
>> > +                         !adev->gfx.compute_ring[i].no_user_submissio=
n)
>> >                               ++num_rings;
>> >               ib_start_alignment =3D 32;
>> >               ib_size_alignment =3D 32;
>> > @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >       case AMDGPU_HW_IP_DMA:
>> >               type =3D AMD_IP_BLOCK_TYPE_SDMA;
>> >               for (i =3D 0; i < adev->sdma.num_instances; i++)
>> > -                     if (adev->sdma.instance[i].ring.sched.ready)
>> > +                     if (adev->sdma.instance[i].ring.sched.ready &&
>> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
>> >                               ++num_rings;
>> >               ib_start_alignment =3D 256;
>> >               ib_size_alignment =3D 4;
>> > @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >                       if (adev->uvd.harvest_config & (1 << i))
>> >                               continue;
>> >
>> > -                     if (adev->uvd.inst[i].ring.sched.ready)
>> > +                     if (adev->uvd.inst[i].ring.sched.ready &&
>> > +                         !adev->uvd.inst[i].ring.no_user_submission)
>> >                               ++num_rings;
>> >               }
>> >               ib_start_alignment =3D 256;
>> > @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >       case AMDGPU_HW_IP_VCE:
>> >               type =3D AMD_IP_BLOCK_TYPE_VCE;
>> >               for (i =3D 0; i < adev->vce.num_rings; i++)
>> > -                     if (adev->vce.ring[i].sched.ready)
>> > +                     if (adev->vce.ring[i].sched.ready &&
>> > +                         !adev->vce.ring[i].no_user_submission)
>> >                               ++num_rings;
>> >               ib_start_alignment =3D 256;
>> >               ib_size_alignment =3D 4;
>> > @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >                               continue;
>> >
>> >                       for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
>> > -                             if (adev->uvd.inst[i].ring_enc[j].sched.=
ready)
>> > +                             if (adev->uvd.inst[i].ring_enc[j].sched.=
ready &&
>> > +                                 !adev->uvd.inst[i].ring_enc[j].no_us=
er_submission)
>> >                                       ++num_rings;
>> >               }
>> >               ib_start_alignment =3D 256;
>> > @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >                       if (adev->vcn.harvest_config & (1 << i))
>> >                               continue;
>> >
>> > -                     if (adev->vcn.inst[i].ring_dec.sched.ready)
>> > +                     if (adev->vcn.inst[i].ring_dec.sched.ready &&
>> > +                         !adev->vcn.inst[i].ring_dec.no_user_submissi=
on)
>> >                               ++num_rings;
>> >               }
>> >               ib_start_alignment =3D 256;
>> > @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >                               continue;
>> >
>> >                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_ring=
s; j++)
>> > -                             if (adev->vcn.inst[i].ring_enc[j].sched.=
ready)
>> > +                             if (adev->vcn.inst[i].ring_enc[j].sched.=
ready &&
>> > +                                 !adev->vcn.inst[i].ring_enc[j].no_us=
er_submission)
>> >                                       ++num_rings;
>> >               }
>> >               ib_start_alignment =3D 256;
>> > @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >                               continue;
>> >
>> >                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++=
)
>> > -                             if (adev->jpeg.inst[i].ring_dec[j].sched=
.ready)
>> > +                             if (adev->jpeg.inst[i].ring_dec[j].sched=
.ready &&
>> > +                                 !adev->jpeg.inst[i].ring_dec[j].no_u=
ser_submission)
>> >                                       ++num_rings;
>> >               }
>> >               ib_start_alignment =3D 256;
>> > @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
>> > *adev,
>> >               break;
>> >       case AMDGPU_HW_IP_VPE:
>> >               type =3D AMD_IP_BLOCK_TYPE_VPE;
>> > -             if (adev->vpe.ring.sched.ready)
>> > +             if (adev->vpe.ring.sched.ready &&
>> > +                 !adev->vpe.ring.no_user_submission)
>> >                       ++num_rings;
>> >               ib_start_alignment =3D 256;
>> >               ib_size_alignment =3D 4;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > index b4fd1e17205e9..4a97afcb38b78 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>> > @@ -297,6 +297,7 @@ struct amdgpu_ring {
>> >       struct dma_fence        *vmid_wait;
>> >       bool                    has_compute_vm_bug;
>> >       bool                    no_scheduler;
>> > +     bool                    no_user_submission;
>> >       int                     hw_prio;
>> >       unsigned                num_hw_submission;
>> >       atomic_t                *sched_score;
>> > @@ -310,7 +311,6 @@ struct amdgpu_ring {
>> >       unsigned int    entry_index;
>> >       /* store the cached rptr to restore after reset */
>> >       uint64_t cached_rptr;
>> > -
>> >  };
>> >
>> >  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p)=
, (job), (ib)))
>> > --
>> > 2.48.1
>>
