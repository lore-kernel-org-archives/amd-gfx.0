Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D09D39003
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 18:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC5110E288;
	Wed, 14 Jan 2026 18:14:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GSrhmTfk";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49A2610E288
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 18:14:30 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-1233985e56aso7686c88.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768414469; cv=none;
 d=google.com; s=arc-20240605;
 b=h0jdg7W4mPBtBfAwLmQBKdb/+ZCIioOo/OrHZmcqX9fUy9/jty5VcfL4UdiSN0keaq
 oNsAH8cvkC+CSoso3JNWpfrstysd6KUZls38F7RWWNtsmro6Voada4G2mGVeHGe68pUZ
 q63GEuaP4EFk15cePFnbmyOouHhuwbMUjrx11zVIQV1zKt41kQrjepRJyJwLgGjiGPnj
 DS+Y8QZyVpAReP7ehisZfPyww8T2x2vQ7xJfUJiph+aeZxuwIbLZlXc4uUQD/hasVmTq
 6+eZeheuUwpHrT6ykGblvFM4Cimy8az1p1s0ChXbJu3mbJgk/D9kw3D0C15DqXBWCtVv
 uISg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k3IB4Y6DO18Sibvhy9KJ3idq+kTRhK3PkEdnt2BuZWw=;
 fh=3tIvC4twIXlR8c+yrHQbGNZ7115BvrPPgutCb2nPJlU=;
 b=jK9zVOmJ7N2nxbiAdPiR5soWCMdvcnrPuGzvEeHNJlBnRSXUl+FU/sKH+OkmDliReF
 jhgWbajeuOKA0jgpg2UfSelyv/AnEIHemy0B9kbF8nCkaukxU7Z5qGKd7Bvr4XJwt3aX
 jhabzIoGHmvp7YlqfhhdJ/6hjcjH6A3UialpxEDrK0jk+TfpIZKeB5Q6G7QCygoQ9W+5
 BfPz80VU35cPVzfY3M3UbrcZhvE4J2IopLgjDCjd45MoZhkqOxglKEx4uaa2NZWs4vmm
 MTxwD3YD0awes7VgaxNt0mrQZrXk7NnMx402BEExoZYpWxN8fPDglUs+LSzn1meU4CJo
 u6qw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768414469; x=1769019269; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k3IB4Y6DO18Sibvhy9KJ3idq+kTRhK3PkEdnt2BuZWw=;
 b=GSrhmTfkJzNKIn5vzBjPGZb5WyminDFfsRXf6slezOtysrJDxFZJDIlbrGxMi6x85m
 ekPbYtjj188uS29XTDmyT6FUApicIX2Rb1/nlci0Wb9s6lU6Ej2Ixl9RB+mmewirShs0
 jpsASbb9fGXt64HNzG5bhMdY9qXkrAnfh7wq5QpH6ZrqoLAOeEcuQ2U/s+IqGBqLntVh
 VBaV7JZp1Nojpc3BiSp7dUAOZBckm5n53DW4Zg6BqZ0rdqDe1A8HoDaJVyAc9I7Yb9Wr
 utMy9XYQbPq3gADCyAKBwRuvwtE3zpWBi7AZfyR+S7+pwSrQfz42H93p2gBlYfPAVz24
 E3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768414469; x=1769019269;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k3IB4Y6DO18Sibvhy9KJ3idq+kTRhK3PkEdnt2BuZWw=;
 b=ewTo+THPl82uz5x6eMqOIXSrs8/SIkfl2/5rAX36Bq5h+BIyTmN+hElt/cMcsM4VI+
 1Ei0Q3RQfnIez+Fe/hnEaRXpvXzzxFN71Wr1VWXYlLH8uOvqQdvhKbDyRehsgc2nQ3Lo
 xlvwWmQFITPK5bAm9qMat96GCvvs+1asXTJKHsEX6FCSo7ShoRqCIrzW4Ffq3m2KZAMW
 OWq+PEwxfstgW5kw/FqF3iWtGNIvTGplY8GrHdh5dtRs75GQPd34HKuQ5GwfUZivU3An
 SdfM0nqtjPbHZkF8371kw6qpYEjfNH2E0xLek4bZYVHsTZocGtQN4WOV9S4A0vIdgH9p
 n8/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrC+bQATQsJ9wqfsKbSX5knz5GCFEnurHZs/r08Aa2//qPOKqU9YD6mOuGKTxrmpnIqQDwOBqT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZUz7DhS4ukIxAVcUSglGntetF0/uRAnIs0lPHGeCpzLk2YkO7
 nMWHSXMfipqah4fyas2Wqh+QD7k4m+AW/dw4V7j+HYTzcvg6MOZl9dQUFbUgutT9av1DKCFUxEI
 8KolpLQiWLLT1l9gtjR+hEK7E9XId97g=
X-Gm-Gg: AY/fxX62Mtr8LWGFcjWGotkNE6rEAnsX/X8KMcla0NnPpZDLPRwlWmFkZAToDvP5eq1
 ZxU4tqBdddAvmIHoL31AcBylkGAMGQtDsRweiEB7DKAsf8m63Oau2S00ClcveIIQfRpUKVR9P74
 EpPxBJQWZBcFVWUp1c20vcWlqkfRFiDop6bSZQHAKyBVI1RM4mn532ymEV+MW/gi4iFPq/Pg2YR
 FVUaU9IhX+04Zk7ZQHhHqYovO+6LdoNSWJq4oTaNBiffqcqJ1fk5Z85xYTWilOCFbqpHP8K
X-Received: by 2002:a05:7022:1e09:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-123369702e7mr1633841c88.0.1768414469246; Wed, 14 Jan 2026
 10:14:29 -0800 (PST)
MIME-Version: 1.0
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
 <585f1f3e-6e1c-40b6-a7ca-da0e871ffb00@amd.com>
In-Reply-To: <585f1f3e-6e1c-40b6-a7ca-da0e871ffb00@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jan 2026 13:14:17 -0500
X-Gm-Features: AZwV_QgIab6A0eYVJjjmM3v5CAMYkW9_amJ-CH84rZyC_3FCrPk7CC9Z4XiRfTU
Message-ID: <CADnq5_ORTuUvfAzRxptnkGpSP6ZyFM7xM2zLtOk-XEqP_jd1qw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jan 14, 2026 at 6:27=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 14-Jan-26 2:29 PM, Jesse.Zhang wrote:
> > From: "Alex Deucher" <alexander.deucher@amd.com>
> >
> > Resetting VCN resets the entire tile, including jpeg.
> > When we reset VCN, we also need to handle the jpeg queues.
> > Add a helper to handle recovering the jpeg queues when
> > VCN is reset.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 +++++--
> >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 42 ++++++++++++++++++++++-=
-
> >   2 files changed, 49 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0_3.c
> > index aae7328973d1..1a32dadf8c5d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > @@ -1145,13 +1145,20 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu=
_ring *ring,
> >                                 unsigned int vmid,
> >                                 struct amdgpu_fence *timedout_fence)
> >   {
> > +     struct amdgpu_device *adev =3D ring->adev;
> > +     struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> > +     int r;
> > +
> >       if (amdgpu_sriov_vf(ring->adev))
> >               return -EOPNOTSUPP;
> > -
> > +     /* take the vcn reset mutex here because resetting VCN will reset=
 jpeg as well */
> > +     mutex_lock(&vinst->engine_reset_mutex);
> >       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >       jpeg_v4_0_3_core_stall_reset(ring);
> >       jpeg_v4_0_3_start_jrbc(ring);
> > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +     mutex_unlock(&vinst->engine_reset_mutex);
> > +     return r;
> >   }
> >
> >   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs =3D {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0_3.c
> > index cb7123ec1a5d..31d93c10dfb1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > @@ -1596,6 +1596,32 @@ static void vcn_v4_0_3_unified_ring_set_wptr(str=
uct amdgpu_ring *ring)
> >       }
> >   }
> >
> > +static int vcn_v4_0_3_reset_jpeg_helper(struct amdgpu_device *adev,
> > +                                     int inst)
> > +{
> > +     struct amdgpu_ring *ring;
> > +     int i, r;
> > +
> > +     for (i =3D 0; i < adev->jpeg.num_jpeg_rings; ++i) {
> > +             ring =3D &adev->jpeg.inst[inst].ring_dec[i];
> > +             drm_sched_wqueue_stop(&ring->sched);
> > +             amdgpu_fence_driver_force_completion(ring);
> > +             if (ring->use_doorbell)
> > +                     WREG32_SOC15_OFFSET(
> > +                             VCN, GET_INST(VCN, inst),
> > +                             regVCN_JPEG_DB_CTRL,
> > +                             (ring->pipe ? (ring->pipe - 0x15) : 0),
> > +                             ring->doorbell_index
> > +                             << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> > +                             VCN_JPEG_DB_CTRL__EN_MASK);
> > +             r =3D amdgpu_ring_test_helper(ring);
> > +             if (r)
> > +                     return r;
> > +             drm_sched_wqueue_start(&ring->sched);
> > +     }
> > +     return 0;
> > +}
> > +
> >   static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> >                                unsigned int vmid,
> >                                struct amdgpu_fence *timedout_fence)
> > @@ -1605,6 +1631,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ri=
ng *ring,
> >       struct amdgpu_device *adev =3D ring->adev;
> >       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> >
> > +     /* take the vcn reset mutex here because resetting VCN will reset=
 jpeg as well */
> > +     mutex_lock(&vinst->engine_reset_mutex);
> > +
> >       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> >
> >       vcn_inst =3D GET_INST(VCN, ring->me);
> > @@ -1612,7 +1641,7 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ri=
ng *ring,
> >
> >       if (r) {
> >               DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
> > -             return r;
> > +             goto unlock;
> >       }
> >
> >       /* This flag is not set for VF, assumed to be disabled always */
> > @@ -1621,7 +1650,16 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_r=
ing *ring,
> >       vcn_v4_0_3_hw_init_inst(vinst);
> >       vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirec=
t_sram);
> >
> > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > +     if (r)
> > +             goto unlock;
> > +
> > +     r =3D vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
>
> This doesn't seem to handle any ongoing jpeg activity before doing a vcn
> reset. Is that fine?

We could split the helper in two, in the top helper we can stop the
sched workqueues and attempt to wait for any outstanding fences. Then
in the bottom helper, we can force completion, re-init the rings, and
restart the sched workqueues.  With the patch as is, any outstanding
job fences would be marked with an error, and signalled so userspace
would see their jobs lost.

Alex

>
> Thanks,
> Lijo
>
> > +
> > +unlock:
> > +     mutex_unlock(&vinst->engine_reset_mutex);
> > +
> > +     return r;
> >   }
> >
> >   static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_func=
s =3D {
>
