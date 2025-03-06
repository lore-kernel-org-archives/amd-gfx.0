Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA6C28B24
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 874EA10E9E4;
	Thu,  6 Mar 2025 16:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VKY2cKao";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9B410E9E2
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 16:00:28 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2fd02536660so216313a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 08:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741276828; x=1741881628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U66hEkL3wzxVOKYUAKrdJaW7R5Lb03JhfBMPDNfD85M=;
 b=VKY2cKaoxko/yyFbp7L1G8fQ+iOyXIxpoWELMGwagGiagwQ9zAEjrsMOHoJiBgQAgu
 iUfyAYF96GX9Zb4iLzf84JsDk7hHrkMxHwfqM+0WqXnntPOIXovqYRrT+EGH1xiP9nvG
 IAI2NDUQFoj65lZwYgyaegzs6UHk2Re5EMDgCmDfPycF7atyYSzIxOjAvS5uNOVdxL52
 v/462mMgm6W2ysU749m6PzQKOrqgrB8Ft+4aYS6Z+MHw2yigX+gtmj8kQNLNqJb514dY
 f/937jk4bk5TUSSjv+VAC/vB2nJz9nW4zz22cUHrFUgFQPOvgdGagPfrnZ8gTUS83ocb
 pwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276828; x=1741881628;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U66hEkL3wzxVOKYUAKrdJaW7R5Lb03JhfBMPDNfD85M=;
 b=jban0FvPjBAyfcHklN6MeSYiFm/kk5TuGVeQwEkP9XPELU6uBt48DKUtSu3rCxZjBX
 0ASAn3AR+hMzK/pxfwhK940VZ8oIjJCzAZrElIcD/ZBWcT8WvZy92MAwHZPHC+RS2Mwi
 EUedzi62GDm0fu6WXwLblPh6u3mCQmAlL54CXnNuxoFaiFAhNWWOVeaYLeNgZzx+BMC+
 26X8Igh90wA6UjuR6iM6soEAL/7wzfvJRH6hWzQE8YJZy8Zkoy5m1LwS8uZGnrgVAUgN
 o07mv9FoYIuxVHp4sPm3AfU9tfBSpRWh+HttGEwuwH+8Iz+8finj6oZgy7VgdwISwv68
 2xOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6pK/wC/Q+agWP7ijr2FNTKtozfW6VkY5b5j/hvIsdxSXXJftcmiAW1x+OdsfY2BJiN80GhuAt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaeTVBj7l7Ctm1FhzFhj8TmheLsH5MUdg6fI5JCMdKZ2Ree38T
 yIbR/q+gVufNkcH4wwqFf+149a/0imalCc6jsnEj4PxdHTRaynteh/7D+LbOwwfBzKpTXFLVoYO
 bdzDjvG0lEfAE9YLHXhAsUtLyByyozQ==
X-Gm-Gg: ASbGnctKd5SgDYHJRLdUneTpKl5EHrO2sl8PboN9EPJIW6p2LBR86s7XpQpGwoAgFUC
 +zn4GKTllmxE/kL8tXNkgtYPx9jNnAD/lmiKEkpHWyAtKgD9OQ5QQY6ZPYf+gJDrimqlZjoOFXR
 ikd2Gsp5z/s4p6LKt6cYzlL0jyRQ==
X-Google-Smtp-Source: AGHT+IH3qC/DC71RtrMjptjGYCIXBwE+WSega3BZvVl7yWDW0Ckai93Ap3HbHKVauA5QVrX2SXXfgKB96d0DJF9uvH8=
X-Received: by 2002:a17:90b:1e41:b0:2fe:a8f0:5265 with SMTP id
 98e67ed59e1d1-2ff4978c224mr4780043a91.2.1741276826275; Thu, 06 Mar 2025
 08:00:26 -0800 (PST)
MIME-Version: 1.0
References: <20250305204721.1213836-1-alexander.deucher@amd.com>
 <20250305204721.1213836-3-alexander.deucher@amd.com>
 <ff8c8af5-aaa6-491f-8b9d-71f788ea48fb@amd.com>
In-Reply-To: <ff8c8af5-aaa6-491f-8b9d-71f788ea48fb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 11:00:14 -0500
X-Gm-Features: AQ5f1JqZngokEKAw0wNIuGw2vMGI2FkRacOYYUNs83zREpikbvCGZU7IKeprtkI
Message-ID: <CADnq5_MGA-4zWYqiuUtp-QUrAdn8z2DgbxMs1GmhRKOF=g=m0A@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: "Khatri, Sunil" <sukhatri@amd.com>
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

On Thu, Mar 6, 2025 at 2:48=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wro=
te:
>
>
> On 3/6/2025 2:17 AM, Alex Deucher wrote:
> > This would be set by IPs which only accept submissions
> > from the kernel, not userspace, such as when kernel
> > queues are disabled. Don't expose the rings to userspace
> > and reject any submissions in the CS IOCTL.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++-------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
> >   3 files changed, 25 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 5df21529b3b13..5cc18034b75df 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -349,6 +349,10 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser=
 *p,
> >       ring =3D amdgpu_job_ring(job);
> >       ib =3D &job->ibs[job->num_ibs++];
> >
> > +     /* submissions to kernel queus are disabled */
> > +     if (ring->no_user_submission)
> > +             return -EINVAL;
> > +
> Alex, dont we need to disable submission for other type of chunks, from
> function amdgpu_cs_pass2 ? chunk type of bo list and fences are
> submitted by users and we do want to handle that too.
> If that's not needed then lgtm.

That is the only chunk type which directly involves the kernel rings.

Alex


> >       /* MM engine doesn't support user fences */
> >       if (p->uf_bo && ring->funcs->no_user_fence)
> >               return -EINVAL;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_kms.c
> > index cd6eb7a3bc58a..3b7dfd56ccd0e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -408,7 +408,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >       case AMDGPU_HW_IP_GFX:
> >               type =3D AMD_IP_BLOCK_TYPE_GFX;
> >               for (i =3D 0; i < adev->gfx.num_gfx_rings; i++)
> > -                     if (adev->gfx.gfx_ring[i].sched.ready)
> > +                     if (adev->gfx.gfx_ring[i].sched.ready &&
> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 32;
> >               ib_size_alignment =3D 32;
> > @@ -416,7 +417,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
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
> > @@ -424,7 +426,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >       case AMDGPU_HW_IP_DMA:
> >               type =3D AMD_IP_BLOCK_TYPE_SDMA;
> >               for (i =3D 0; i < adev->sdma.num_instances; i++)
> > -                     if (adev->sdma.instance[i].ring.sched.ready)
> > +                     if (adev->sdma.instance[i].ring.sched.ready &&
> > +                         !adev->gfx.gfx_ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > @@ -435,7 +438,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >                       if (adev->uvd.harvest_config & (1 << i))
> >                               continue;
> >
> > -                     if (adev->uvd.inst[i].ring.sched.ready)
> > +                     if (adev->uvd.inst[i].ring.sched.ready &&
> > +                         !adev->uvd.inst[i].ring.no_user_submission)
> >                               ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -444,7 +448,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >       case AMDGPU_HW_IP_VCE:
> >               type =3D AMD_IP_BLOCK_TYPE_VCE;
> >               for (i =3D 0; i < adev->vce.num_rings; i++)
> > -                     if (adev->vce.ring[i].sched.ready)
> > +                     if (adev->vce.ring[i].sched.ready &&
> > +                         !adev->vce.ring[i].no_user_submission)
> >                               ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > @@ -456,7 +461,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->uvd.num_enc_rings; j++)
> > -                             if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady)
> > +                             if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady &&
> > +                                 !adev->uvd.inst[i].ring_enc[j].no_use=
r_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -468,7 +474,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
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
> > @@ -481,7 +488,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->vcn.inst[i].num_enc_rings=
; j++)
> > -                             if (adev->vcn.inst[i].ring_enc[j].sched.r=
eady)
> > +                             if (adev->vcn.inst[i].ring_enc[j].sched.r=
eady &&
> > +                                 !adev->vcn.inst[i].ring_enc[j].no_use=
r_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >                               continue;
> >
> >                       for (j =3D 0; j < adev->jpeg.num_jpeg_rings; j++)
> > -                             if (adev->jpeg.inst[i].ring_dec[j].sched.=
ready)
> > +                             if (adev->jpeg.inst[i].ring_dec[j].sched.=
ready &&
> > +                                 !adev->jpeg.inst[i].ring_dec[j].no_us=
er_submission)
> >                                       ++num_rings;
> >               }
> >               ib_start_alignment =3D 256;
> > @@ -504,7 +513,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *=
adev,
> >               break;
> >       case AMDGPU_HW_IP_VPE:
> >               type =3D AMD_IP_BLOCK_TYPE_VPE;
> > -             if (adev->vpe.ring.sched.ready)
> > +             if (adev->vpe.ring.sched.ready &&
> > +                 !adev->vpe.ring.no_user_submission)
> >                       ++num_rings;
> >               ib_start_alignment =3D 256;
> >               ib_size_alignment =3D 4;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
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
> >   };
> >
> >   #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p)=
, (job), (ib)))
