Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97671C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 18:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22CA410E086;
	Wed, 12 Mar 2025 18:50:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U0Gv0ulp";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F7A10E086
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 18:50:51 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2ff5f2c5924so52299a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 11:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741805450; x=1742410250; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AMJ7BWXJJXBD1JX6HIUaaQHYkctD1Abe2vXrvNzTcE8=;
 b=U0Gv0ulp7A1ybMSQ2f/QB/AVYBDBlH1+g8qZS/ZczRQkCYcGVumwc9tGsP0OWU6jaJ
 xiTKglTC4aiReL03k19SkvZ2Tooe+z2gJ3GlN8Iern1R3/lsXXWzooMDGPDJveh7leGk
 fiEDDpz5O7rLtggZ5x1q7V7E2HsiWHel0uPS2WEv8a6h0GzNEd+VJTn5/v3LfpHMjVcW
 +Zvl3jzu6Yn+6GHs5Hj7mbl5dCH/AcRaJcWYI2fPHOW4TTPkSpE8kdJcxdSpTFAGeEbp
 oXG9OOShUmXFiIj+ZiPQK27zxO+A/3Eo5C1LCu+k1tB90UTztVsCnsoyypYK2WgjeL3t
 6yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741805450; x=1742410250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AMJ7BWXJJXBD1JX6HIUaaQHYkctD1Abe2vXrvNzTcE8=;
 b=PFs/n4RWvFM3bawh48Vp3j/zEJWa16oiFne1OrR6ooAXPv0FrVdH0yteeX7ELfEdFm
 wndicCQC4rOtbNBSJyCc03iynify6xzYVvxK0XGARWyHG6eqc4mEw4OiWwwBEE5pY7oM
 7OBA3Wqu+TLS4aPZHGeNmzGHTgZ13sYXBrK/mGJMA6g6xTPK46pggugeGxoN5Tk0/t8I
 wOot43gC0teZkssZX6FgtLThShbfwyUXUNycwJuKeNZBh46AlF/IuphLUHPL8BiFa0Jv
 BqckCOaaWENQNrH3Rr/NJ1/nZpAOvGOiVlWRhOWE56gnKFHiFtNo8OWhh0BWDyV8pNbH
 32Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWewQc1VBwdGGSbgyHqF3B2xeDTNx5wNZ3qWk+VpdZ8ywGIpBHhSBs9F+fHb2V9FykZwd3jNNDA@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKNw09xvRt+E9EHGHRkswLWQG+/dRYqODADbFXqrccshf+XYS3
 YM2qQmvNRObuWPe8zazsNvr8ovRi0PA+RC8cG9y4dKmVwBrwhyDJ+rjA2MnPE9bxwiEAczmUJEh
 E8sQt6GNxYGA7iOadNtG3ymp6MHM5SA==
X-Gm-Gg: ASbGncujbvnYZdhjrq+jwwbQlxuFRiydLyrS5YvnnIrR68T2jZtqutd+D0ZzW91wdfR
 Qyn5fhM6fwqUcLyRXQuwXG4OxcbRoLnkQTJmWzzwLGRtoGgVOqT28pVI8pYaCLnW6be3eqpP/Xa
 lw8eHxmvqZ3RgZhtsAU9IkuDKqXg==
X-Google-Smtp-Source: AGHT+IEUIovbt58XKrolITTv2GUb/FhzspgTGCeeQA0DIZutiK8GvSDtdSfEJ6/frp31ZWpnme0hKlPduy0VUrstNS0=
X-Received: by 2002:a17:90b:1b0a:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-300ff8b8a6fmr4314184a91.4.1741805448884; Wed, 12 Mar 2025
 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250306184612.8910-1-alexander.deucher@amd.com>
 <20250306184612.8910-3-alexander.deucher@amd.com>
 <DS7PR12MB6005D31E47FC8DF70E6555C0FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB6005D31E47FC8DF70E6555C0FBD12@DS7PR12MB6005.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Mar 2025 14:50:36 -0400
X-Gm-Features: AQ5f1JqevQk-wyhcKasW-g5VsBaBDqy6Ni-bhk0JfZ4m501aoQHxAiM5fDRy1Sw
Message-ID: <CADnq5_OmMf3QafO988AE9FsbHwPAD=2DRD9MQ0qNLb+LeYy40A@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Tue, Mar 11, 2025 at 9:13=E2=80=AFAM Liang, Prike <Prike.Liang@amd.com> =
wrote:
>
> [Public]
>
> > From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> > Deucher
> > Sent: Friday, March 7, 2025 2:46 AM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Subject: [PATCH 02/11] drm/amdgpu: add ring flag for no user submission=
s
> >
> > This would be set by IPs which only accept submissions from the kernel,=
 not
> > userspace, such as when kernel queues are disabled. Don't expose the ri=
ngs to
> > userspace and reject any submissions in the CS IOCTL.
> >
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
>
> Do we need reject the kernel queue submission at the beginning placement =
of amdgpu_cs_ioctl()?

I think we only need to reject it if it's targeted at a kernel ring
and this is the first place we can determine that.

Alex

>
> Thanks,
> Prike
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
> > -                             if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady)
> > +                             if (adev->uvd.inst[i].ring_enc[j].sched.r=
eady &&
> > +                                 !adev->uvd.inst[i].ring_enc[j].no_use=
r_submission)
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
> > @@ -496,7 +504,8 @@ static int amdgpu_hw_ip_info(struct amdgpu_device
> > *adev,
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
> >  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p),=
 (job), (ib)))
> > --
> > 2.48.1
>
