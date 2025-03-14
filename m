Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4549FC282DE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 01:44:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB99610E238;
	Fri, 14 Mar 2025 01:44:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DCfUNa3l";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A48510E238
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 01:44:54 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff7cf59a8fso405138a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741916694; x=1742521494; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GhRTBL1+OCmdDDN0P98scCgWUKQR9RxNUVL5uLzOdXE=;
 b=DCfUNa3lwwhBZVdvOKTpktPMaigwhxsDONLuhxC9YxStDI9iz7o50gsEnKHssSTQxG
 bRk+/xTQ5JeR5/XO5B2N8+cGhvxUbo10ET7+53a80CWNEnme1bunufskjXOdlplq5/wk
 040JePXkWwzEqghvJIZ549tBCNFId/TViOu3JV3xNiy6SBWeB9YYaWRKjWaUd5xzov7S
 FxoSwwhv4zQ6Z8ggAcrntxbyiTZLoep1wWIsspZOnpQOM6ZEI+G9LBTD2EQ67nQdTG2m
 PjQLhPH7IXlbYeG4NUTdqiEh1g24qIZ1PhkOk9cs6yWVaNvHHxskZdYW4oPjjREiZXl2
 YFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741916694; x=1742521494;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GhRTBL1+OCmdDDN0P98scCgWUKQR9RxNUVL5uLzOdXE=;
 b=cor/OzGryJQ7hOnc1LZ8qWEfn3LGGrHrcDbgB8GiozgK8gBEO3p1cA7UGaWyq0GHAa
 iNTmHq0xlITuaAjnyt7q7c+qNrRm4tqP5lyytdZxPWsKSDcQohPZaT/iHRwdLmOMuySv
 P3+fpxGW6G8UCJxZvtH8kI+3u2+pZp791FYbIxlBxtXOpHAA2281oJZcQNZqMt2DJkzv
 y1AWNG60PWAfFrq8VqW+czO3+AEmQFWC2U84jwig0cBbzsgyYf+8+WbBlAdi78a6ps68
 mqMXwzXuHBxHK+lRq7R+EkkfiqQo8c0nZPGPLYZuMveUqRyFt4mbdrhhC0x/SZS5axDA
 FNBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVBRolcTtm3BDFIPMqasAi3Rt3D3mRMVM9eJt3OkYpX48eNWs/oAt8YjeRduyWq/4B5MTFheD+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxpxEw7qQrAohiTVgb1RI9jVaJjEyYF+utq3MxCwbv0cKZUKLOz
 ctWoz/Zgi1en0cZrGu5yQrdbje+tlbNPEmJqVgCdJVFr/AD41FSxNZWeF2Pi9S0izRu6e+pf4ez
 euuzxRoEqs3zSQ6S5PefLt55hfDI=
X-Gm-Gg: ASbGncsLAbVIDh3sT+iE+Cgm+Zz/7ahg2G7JmrmzhKzs4oEexmsbag++5FfYhH0qtOy
 ql2m8afevuMvRolLIB412Sim46W8cvQuZxTCs15i2WJ78zuWxH/QcRlgKeu/LCh5vP2k1QFEhyc
 Ba1ffEcz+FarkRndYHS4rrJxmgcg==
X-Google-Smtp-Source: AGHT+IHksVYW9hPFah3+9AZHRsJYhEoYQDg8jZmacUI3eB8RapeRu3n9He0CtfyWcVemMn94GM/tMreEIx4lecZIfAo=
X-Received: by 2002:a17:90b:1b0f:b0:2fe:7f51:d2ec with SMTP id
 98e67ed59e1d1-30151ae0dbamr375971a91.0.1741916693605; Thu, 13 Mar 2025
 18:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250313144136.1117072-1-alexander.deucher@amd.com>
 <20250313144136.1117072-3-alexander.deucher@amd.com>
 <6yaahksm3dvejx5ja7dkgg3xi6qpf7izq6kbvje7addkgkuvoj@2qqcgry27paf>
In-Reply-To: <6yaahksm3dvejx5ja7dkgg3xi6qpf7izq6kbvje7addkgkuvoj@2qqcgry27paf>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Mar 2025 21:44:42 -0400
X-Gm-Features: AQ5f1Jrsv1zujednAqdCaVVVFKbxFRCZ0yGe5LI3tMjKdTmXGDLKWA4DLoNPkS0
Message-ID: <CADnq5_NbyC6D5AOXK=cTpHv9XUQkHa8LWGLakUybRX7yW5bV3Q@mail.gmail.com>
Subject: Re: [PATCH 02/11] drm/amdgpu: add ring flag for no user submissions
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Sunil Khatri <sunil.khatri@amd.com>
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

On Thu, Mar 13, 2025 at 5:53=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 03/13, Alex Deucher wrote:
> > This would be set by IPs which only accept submissions
> > from the kernel, not userspace, such as when kernel
> > queues are disabled. Don't expose the rings to userspace
> > and reject any submissions in the CS IOCTL.
>
> Just out of curiosity, is CS =3D=3D Command Submission?

Yes.

>
> >
> > Reviewed-by: Sunil Khatri<sunil.khatri@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 30 ++++++++++++++++--------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  2 +-
> >  3 files changed, 25 insertions(+), 11 deletions(-)
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
>
> /queus/queues/

will fix.

>
> > +     if (ring->no_user_submission)
> > +             return -EINVAL;
>
> Since this will be set for ASICs that don't accept userspace
> submissions, maybe -ENOTSUPP would be more accurate?

I could go either way on that.  When kernel queues are disabled, CS
submissions to a kernel queue are not supported, but it's also an
invalid parameter to the IOCTL.  I don't have a strong opinion.  Maybe
-ENOTSUPP would differentiate it from just general invalid parameters.

Alex

>
> Thanks
>
> > +
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
> >  };
> >
> >  #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p),=
 (job), (ib)))
> > --
> > 2.48.1
> >
>
> --
> Rodrigo Siqueira
