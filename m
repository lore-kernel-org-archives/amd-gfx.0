Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229D9C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 17:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B75AC10E439;
	Mon, 17 Mar 2025 17:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PbHNtDIh";
	dkim-atps=neutral
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A15B10E439
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 17:15:50 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-72b7d7d9ed0so357804a34.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 10:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742231749; x=1742836549; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Iy2TBCu0xGi+Th8D9RmVpGWDUYgEMxjXzAXQXwCSc1s=;
 b=PbHNtDIhlf3NWXTN5651dU7hRcxGtv8kTmk/eRLr3Rl681bQ3UvhvjZsmCg0Ktr5CM
 kkK/0DiO7IBWpSrWuTo++S4oX/j6JpqvYlDgaXx4S2tPOwJMofTDGhmI+m4R1UVvC9TR
 mWhQVcgf8oHrtmYir4lPGqcbrZxoPM763R0agm25L9qZ6zHYLdAWVudA2ECvOI5MgCHI
 4BjRoBCOxYzcSGkTDadzLGTDu0KX8z5otc5PP1nCrK8rQL+k1Cylm1CcCzuRTa4PQ9xo
 pqruvh/MgFHSD4ExOaKjLvZK7gcEEtAYVrt0rAUQid/ompEb2lXgoNAOaaKl7lgdYiJP
 gUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742231749; x=1742836549;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Iy2TBCu0xGi+Th8D9RmVpGWDUYgEMxjXzAXQXwCSc1s=;
 b=v+G/h/ZPsV6L7obnyifXqB4oxdzzwLhTVpeTSCK+Z44z9KAnSBHLtvVt+K346END75
 5XaKMPTecVbjkUIizVPVxuJJoH+M5q6Q+9o08jqXV8vrkQDRPoMimqQP+sDEHSQAqP3o
 d457uZeZA1pPSA1GWCQA/kTY9zTOOvA52gCABSDiHj/9waqwCaLPKe9Tg4xIvU6ZObpy
 Carii1wkRkCAq3yrg3TZCr/vC2pXhs1Y26DyalbvdwlT+y1+yGibvr/TCHslvJsPe9uF
 D+XgEPokpCQbXV1fd4eo/uYe93vjnyYcwcKPkXWgazVx399m2oFjUS7XyH9J1zFNHqSS
 FoCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlOmRoxAxFUXvrREsRwVn6m8kpsVEkl8FJqetKmUpk8Z51RfiQRYta3np8esVUDuahw8gUXScZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydoCovCh0B3gT9dZIaadez5hccJmVHvOsu7M+n9nh5NaxsX0Vh
 kLtKxKO6n3WsyRNXBMBW60K6totSPUGMP3C566UlhVVjE3v/DsD9KteBS7/UxUXaPuAQbQ1ov45
 cnODJ/BwLpRQVPb0fwsvPNPRJVd0=
X-Gm-Gg: ASbGncuzTRAO69F4e7bNLsD3ZqasJtAHPCm+L7n6XNPK4UUfZhY7u8OrqguSTDmv9IF
 6VQsy7XsJ9FmOFKnfHz+YwUwqhLpUgCH3pfOInjnzMGenilaqOQkp5NSt9nvqnGqeqovlCS8gK3
 dHNXIJBsGfeXxd+Abfcl6FgGV4nFU=
X-Google-Smtp-Source: AGHT+IFRHFLCV0mqc9EwCVGwZ9uip20nOcUVU5dvdvXoc3oDTpzZv/22S+pAEm6BYdJmyWBHKK9v+njI/tdMyfTi/LA=
X-Received: by 2002:a05:6870:b69c:b0:2c1:70c8:476f with SMTP id
 586e51a60fabf-2c69101cecfmr2606208fac.7.1742231748940; Mon, 17 Mar 2025
 10:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
 <DS7PR12MB60057FE73D45BF10F18E0046FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB60057FE73D45BF10F18E0046FBDF2@DS7PR12MB6005.namprd12.prod.outlook.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 17 Mar 2025 13:15:11 -0400
X-Gm-Features: AQ5f1JrRaKhne1zt8u5TqWcxIcu53RVSlhTraI_rCGgU67LSOOq-I-gZWYaoZZg
Message-ID: <CAAxE2A4KPSniNzPJ=3_JMHmCCyaOR77mXqarQr5=FWi7eiZ9Hw@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Olsak,
 Marek" <Marek.Olsak@amd.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Content-Type: multipart/alternative; boundary="0000000000008324b006308cf00e"
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

--0000000000008324b006308cf00e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Userspace needs a query that a queue IP type is supported.
"available_rings" is used for that right now, but if that's 0, something
else must indicate IP support.

amd_ip_info::num_queues should be non-zero even when user queues are
supported. The exact number doesn't matter with user queues.

Marek

On Mon, Mar 17, 2025 at 3:09=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:

> [Public]
>
> We might still need to export each ring's number correctly; otherwise, th=
e
> Mesa driver will consider there's no available ring supported from the
> driver and then further assert before submitting the user queue.
>
> If we want to keep the ring number being zero, the Mesa driver may need a=
n
> attachment change to allow the command submitted to the zero-ring number =
if
> the user queue is enabled.
>
> Hi @Olsak, Marek Do you think it's fine to have the attachment patch for
> the userq support? Except for such changes, maybe we also need to clean u=
p
> the IB-related part.
>
> Regards,
>       Prike
>
> > -----Original Message-----
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Thursday, March 13, 2025 10:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Khatri, Sunil
> > <Sunil.Khatri@amd.com>
> > Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submission=
s
> >
> > This would be set by IPs which only accept submissions from the kernel,
> not
> > userspace, such as when kernel queues are disabled. Don't expose the
> rings to
> > userspace and reject any submissions in the CS IOCTL.
> >
> > Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
> > drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
> >  3 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 5df21529b3b13..5cc18034b75df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser
> > *p,
> >       ring =3D amdgpu_job_ring(job);
> >       ib =3D &job->ibs[job->num_ibs++];
> >
> > +     /* submissions to kernel queus are disabled */
> > +     if (ring->no_user_submission)
> > +             return -EINVAL;
> > +
> >       /* MM engine doesn't support user fences */
> >       if (p->uf_bo && ring->funcs->no_user_fence)
> >               return -EINVAL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >       case AMDGPU_HW_IP_GFX:
> >               type =3D AMD_IP_BLOCK_TYPE_GFX;
> >               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> > -                     if (adev->gfx.gfx_ring[i].sched.ready)
> > +                     if (adev->gfx.gfx_ring[i].sched.ready &&
> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 32;
> >               ib_size_alignment =3D 32;
> > @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >       case AMDGPU_HW_IP_COMPUTE:
> >               type =3D AMD_IP_BLOCK_TYPE_GFX;
> >               for (i =3D 0; i < adev->gfx.num_compute_rings; i++)
> > -                     if (adev->gfx.compute_ring[i].sched.ready)
> > +                     if (adev->gfx.compute_ring[i].sched.ready &&
> > +                         !adev->gfx.compute_ring[i].no_user_submission=
)
> >                               ++num_rings;
> >               ib_start_alignment =3D 32;
> >               ib_size_alignment =3D 32;
> > @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >       case AMDGPU_HW_IP_DMA:
> >               type =3D AMD_IP_BLOCK_TYPE_SDMA;
> >               for (i =3D 0; i < adev->sdma.num_instances; i++)
> > -                     if (adev->sdma.instance[i].ring.sched.ready)
> > +                     if (adev->sdma.instance[i].ring.sched.ready &&
> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >                       if (adev->uvd.harvest_config & (1 << i))
> >                               continue;
> >
> > -                     if (adev->uvd.inst[i].ring.sched.ready)
> > +                     if (adev->uvd.inst[i].ring.sched.ready &&
> > +                         !adev->uvd.inst[i].ring.no_user_submission)
> >                               ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >       case AMDGPU_HW_IP_VCE:
> >               type =3D AMD_IP_BLOCK_TYPE_VCE;
> >               for (i =3D 0; i < adev->vce.num_rings; i++)
> > -                     if (adev->vce.ring[i].sched.ready)
> > +                     if (adev->vce.ring[i].sched.ready &&
> > +                         !adev->vce.ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
> > -                             if
> (adev->uvd.inst[i].ring_enc[j].sched.ready)
> > +                             if
> (adev->uvd.inst[i].ring_enc[j].sched.ready &&
> > +
>  !adev->uvd.inst[i].ring_enc[j].no_user_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >                       if (adev->vcn.harvest_config & (1 << i))
> >                               continue;
> >
> > -                     if (adev->vcn.inst[i].ring_dec.sched.ready)
> > +                     if (adev->vcn.inst[i].ring_dec.sched.ready &&
> > +                         !adev->vcn.inst[i].ring_dec.no_user_submissio=
n)
> >                               ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
;
> j++)
> > -                             if
> (adev->vcn.inst[i].ring_enc[j].sched.ready)
> > +                             if
> (adev->vcn.inst[i].ring_enc[j].sched.ready &&
> > +
>  !adev->vcn.inst[i].ring_enc[j].no_user_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++)
> > -                             if
> (adev->jpeg.inst[i].ring_dec[j].sched.ready)
> > +                             if
> (adev->jpeg.inst[i].ring_dec[j].sched.ready &&
> > +
>  !adev->jpeg.inst[i].ring_dec[j].no_user_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
> >               break;
> >       case AMDGPU_HW_IP_VPE:
> >               type =3D AMD_IP_BLOCK_TYPE_VPE;
> > -             if (adev->vpe.ring.sched.ready)
> > +             if (adev->vpe.ring.sched.ready &&
> > +                 !adev->vpe.ring.no_user_submission)
> >                       ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > index b4fd1e17205e9..4a97afcb38b78 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -297,6 +297,7 @@ struct amdgpu_ring {
> >       struct dma_fence        *vmid_wait;
> >       bool                    has_compute_vm_bug;
> >       bool                    no_scheduler;
> > +     bool                    no_user_submission;
> >       int                     hw_prio;
> >       unsigned                num_hw_submission;
> >       atomic_t                *sched_score;
> > @@ -310,7 +311,6 @@ struct amdgpu_ring {
> >       unsigned int    entry_index;
> >       /* store the cached rptr to restore after reset */
> >       uint64_t cached_rptr;
> > -
> >  };
> >
> >  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p),
> (job), (ib)))
> > --
> > 2.48.1
>
>

--0000000000008324b006308cf00e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Userspace needs a query that a queue IP type is suppo=
rted. &quot;available_rings&quot; is used for that right now, but if that&#=
39;s 0, something else must indicate IP support.</div><div><br></div><div>a=
md_ip_info::num_queues should be non-zero even when user queues are support=
ed. The exact number doesn&#39;t matter with user queues.</div><div><br></d=
iv><div>Marek</div></div><br><div class=3D"gmail_quote gmail_quote_containe=
r"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Mar 17, 2025 at 3:09=E2=80=
=AFAM Liang, Prike &lt;<a href=3D"mailto:Prike.Liang@amd.com">Prike.Liang@a=
md.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">[Public]<br>
<br>
We might still need to export each ring&#39;s number correctly; otherwise, =
the Mesa driver will consider there&#39;s no available ring supported from =
the driver and then further assert before submitting the user queue.<br>
<br>
If we want to keep the ring number being zero, the Mesa driver may need an =
attachment change to allow the command submitted to the zero-ring number if=
 the user queue is enabled.<br>
<br>
Hi @Olsak, Marek Do you think it&#39;s fine to have the attachment patch fo=
r the userq support? Except for such changes, maybe we also need to clean u=
p the IB-related part.<br>
<br>
Regards,<br>
=C2=A0 =C2=A0 =C2=A0 Prike<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists.freedesktop.=
org" target=3D"_blank">amd-gfx-bounces@lists.freedesktop.org</a>&gt; On Beh=
alf Of Alex<br>
&gt; Deucher<br>
&gt; Sent: Thursday, March 13, 2025 10:41 PM<br>
&gt; To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank"=
>amd-gfx@lists.freedesktop.org</a><br>
&gt; Cc: Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.com=
" target=3D"_blank">Alexander.Deucher@amd.com</a>&gt;; Khatri, Sunil<br>
&gt; &lt;<a href=3D"mailto:Sunil.Khatri@amd.com" target=3D"_blank">Sunil.Kh=
atri@amd.com</a>&gt;<br>
&gt; Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissio=
ns<br>
&gt;<br>
&gt; This would be set by IPs which only accept submissions from the kernel=
, not<br>
&gt; userspace, such as when kernel queues are disabled. Don&#39;t expose t=
he rings to<br>
&gt; userspace and reject any submissions in the CS IOCTL.<br>
&gt;<br>
&gt; Reviewed-by: Sunil Khatri&lt;<a href=3D"mailto:sunil.khatri@amd.com" t=
arget=3D"_blank">sunil.khatri@amd.com</a>&gt;<br>
&gt; Signed-off-by: Alex Deucher &lt;<a href=3D"mailto:alexander.deucher@am=
d.com" target=3D"_blank">alexander.deucher@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0|=C2=A0 4 +++=
+<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c=C2=A0 | 30 +++++++++++++=
+++--------<br>
&gt; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |=C2=A0 2 +-<br>
&gt;=C2=A0 3 files changed, 25 insertions(+), 11 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; index 5df21529b3b13..5cc18034b75df 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parse=
r<br>
&gt; *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ring =3D amdgpu_job_ring(job);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ib =3D &amp;job-&gt;ibs[job-&gt;num_ibs++];<=
br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* submissions to kernel queus are disabled */<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0if (ring-&gt;no_user_submission)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* MM engine doesn&#39;t support user fences=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (p-&gt;uf_bo &amp;&amp; ring-&gt;funcs-&g=
t;no_user_fence)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; index cd6eb7a3bc58a..3b7dfd56ccd0e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_GFX:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D AMD_IP_=
BLOCK_TYPE_GFX;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; adev-&gt;gfx.num_gfx_rings; i++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;gfx.gfx_ring[i].sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;gfx.gfx_ring[i].sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;gfx.gfx_ring[i].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_size_alignmen=
t =3D 32;<br>
&gt; @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_COMPUTE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D AMD_IP_=
BLOCK_TYPE_GFX;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; adev-&gt;gfx.num_compute_rings; i++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;gfx.compute_ring[i].sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;gfx.compute_ring[i].sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;gfx.compute_ring[i].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 32;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_size_alignmen=
t =3D 32;<br>
&gt; @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_DMA:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D AMD_IP_=
BLOCK_TYPE_SDMA;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; adev-&gt;sdma.num_instances; i++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;sdma.instance[i].ring.sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;sdma.instance[i].ring.sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;gfx.gfx_ring[i].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_size_alignmen=
t =3D 4;<br>
&gt; @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (adev-&gt;uvd.harvest_config &amp; (1 &lt;&lt; i))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;uvd.inst[i].ring.sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;uvd.inst[i].ring.sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;uvd.inst[i].ring.no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt; @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_VCE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D AMD_IP_=
BLOCK_TYPE_VCE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i =
&lt; adev-&gt;vce.num_rings; i++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;vce.ring[i].sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;vce.ring[i].sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;vce.ring[i].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_size_alignmen=
t =3D 4;<br>
&gt; @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (j =3D 0; j &lt; adev-&gt;uvd.num_enc_rings; j++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;uvd.inst[i].ring_enc[j].sch=
ed.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;uvd.inst[i].ring_enc[j].sch=
ed.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!adev-&gt;uvd.inst[i].ring=
_enc[j].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_=
rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt; @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (adev-&gt;vcn.harvest_config &amp; (1 &lt;&lt; i))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;vcn.inst[i].ring_dec.sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (adev-&gt;vcn.inst[i].ring_dec.sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0!adev-&gt;vcn.inst[i].ring_dec.no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt; @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (j =3D 0; j &lt; adev-&gt;vcn.inst[i].num_enc_rings; j++)<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;vcn.inst[i].ring_enc[j].sch=
ed.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;vcn.inst[i].ring_enc[j].sch=
ed.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!adev-&gt;vcn.inst[i].ring=
_enc[j].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_=
rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt; @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0continue;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0for (j =3D 0; j &lt; adev-&gt;jpeg.num_jpeg_rings; j++)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;jpeg.inst[i].ring_dec[j].sc=
hed.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;jpeg.inst[i].ring_dec[j].sc=
hed.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!adev-&gt;jpeg.inst[i].rin=
g_dec[j].no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++num_=
rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt; @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device<=
br>
&gt; *adev,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_HW_IP_VPE:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D AMD_IP_=
BLOCK_TYPE_VPE;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;vpe.ring=
.sched.ready)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-&gt;vpe.ring=
.sched.ready &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!adev-&=
gt;vpe.ring.no_user_submission)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0++num_rings;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_start_alignme=
nt =3D 256;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ib_size_alignmen=
t =3D 4;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; index b4fd1e17205e9..4a97afcb38b78 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; @@ -297,6 +297,7 @@ struct amdgpu_ring {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dma_fence=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
*vmid_wait;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 has_compute_vm_bug;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_scheduler;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 no_user_submission;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hw_prio;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 num_hw_submission;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0atomic_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 *sched_score;<br>
&gt; @@ -310,7 +311,6 @@ struct amdgpu_ring {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int=C2=A0 =C2=A0 entry_index;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* store the cached rptr to restore after re=
set */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t cached_rptr;<br>
&gt; -<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)-&gt;funcs-&gt;p=
arse_cs((p), (job), (ib)))<br>
&gt; --<br>
&gt; 2.48.1<br>
<br>
</blockquote></div>

--0000000000008324b006308cf00e--
