Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE761D489A8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jan 2026 13:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DA0610E8A3;
	Fri, 16 Jan 2026 13:49:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ts+tddMG";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21AD210E89F
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 13:49:48 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2b1161400afso168445eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jan 2026 05:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768571387; cv=none;
 d=google.com; s=arc-20240605;
 b=JN8DzDRC62vKMDX9XLhBufXJ+q3C5UY2N4y5erug2Yb8nZHNSEfApBAtWikgM/hSDI
 h7ZtdAew7H8pyCgSXLkm0wufv+K5+vai6ZEpQz0ONcB2Wg4fd0z2w2GaIdqQ2zODPikq
 LE+jdWAMR0jRV5YeGbpapLthUakrhwhs+e8Oyo/Hi3ltueYYmXHzFOQXiuXWAbuw8Uym
 YbaPFHVi0ZdFiJ9nkUP+0T92/5jzX7r9IiTVZOsuSrC5PxVnmk/jAlQyrnGupCKHnOgK
 Va1B/UAtFTfaJqzDSDEh3Fvqea0Pmi0FUq+eyIHVmK/7LqD20Y9eR8cnHnfBRR4o9zpQ
 xfRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ll8yb0R5czW70goEZYUkAB2u4PjxzyVEJ0d++6iLD0Q=;
 fh=cnvegLCbJ8QNIRzlx/86yofUaKCMEj/sP7T12u9p4ws=;
 b=TEYahwXQvuvfAui1TnjWIygHz0o5Y1DBW+VqNcKBpsqFW2NRD9UG350Zz8yKNDCzTh
 /rqqJv8S1vasWJTLRzdAYQ34VIimUVlJUQvSpL1CrLZ56lpgMTTVPqxjq8cQ/sdlu9Ql
 5niVkDZDw6Zi4Q3j3ImGwrTgScWMwPL4tnb8m0oQnlfjSkckdMl0jIfzmYc4lCBdy3mE
 wNVQ/kLWaLMZ/e4eI3hq9kWnRgX0vJALrfXWplIeKH30/xmJHJzZj1C5jfHvTh4ZcyCg
 pgJV2EChbOjIDR5Dkc+VghvuZ8NBJ1xKgAMKjSf5s0WrJ76D9Jwl7TO/nMRl02JPe5NL
 jN7Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768571387; x=1769176187; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ll8yb0R5czW70goEZYUkAB2u4PjxzyVEJ0d++6iLD0Q=;
 b=Ts+tddMGG0GMzAY4gueIzgZWfpl93wYaYsfyXzMnoyV/JowK48LaoJqnpGXff+o5qA
 HqaghWHx7pntCBthA1vLJD3/AHcoEk0UPrML7Lz5gJWn42EOw25Vyo5C+CJmitldMFJo
 Rl4s86jE+AoLxCZmBbJqr+FBYoF4NzuEdtymvw3jZuXq/UeM9jzevT3Up9UqHOfmcD/7
 tCgAw7jJmV1NpOaBMK+64JTlIu0fotPCwZic6VLuUjGXcJtZw/F9OeekbrGQA5WXLXVS
 kopexI/iIeVegl89g2/VA1uXNDLC15CUhhsnQHsf88ICFOLsdULXo/xsaVI1ZEM79EIZ
 2h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768571387; x=1769176187;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ll8yb0R5czW70goEZYUkAB2u4PjxzyVEJ0d++6iLD0Q=;
 b=pJ6QN8VY7tEFUMMq498NkLHSBoQQAUj/Lx6CH1pNpF42XDiAgQOHZDAp/J1V/3kdr9
 KYgPWpEEzIYnrxZeeK9qfAtCXxudHPrHsq9v0QHV4TxEqNOhg++Gzxx4uufuLVxstbS8
 Mc04qe4suMXiIxG/AsECIzgqgi9rGABV3IZ3tybcOd5gxLKx65JHH6lipoB0VNG+dr4m
 R0t193HAy3ZoZvUwHZUjA9qE9I80KCVBfWoCTXJ30iyq72JRwuDNQdD8OQmR4EqtlXqs
 BLUsZNaYh4num91VF0mQtZ8Bqs6zqZNn8eSDaSSFn1KC4fW9OoNYVs7wJjQ+VDt52qx6
 ZocA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDoGRwMKGbU+DRf6ze2CwhqW2cxnKdquwNG4MzNCPW884U7fO8r0cv6yvWoRK4UyYAZQXWobc2@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwrJWeMVMiG6l5l5+JjTnYze1a+ARWPqigjud9NLFXQ6s48+fF
 b0/WhFGPxh/xK14a+9DK3ntXIYoG40E5iJdnN840h2kDJA+QtA+SBU1fRVjyRbrhfllFdMzRQ/B
 FXqzI9rge8lTbhEIT57oBVko5C1t3RAY=
X-Gm-Gg: AY/fxX5KqiBCsC4tdfnUEn4gkecIMDIbLF47Wc9Zj61M57LqcBJQnjfvsPcNLMSKzyM
 4wSc6jm2BujNevZuAuIIwmS72sjI4tpGQMfS++IZLQt7+DuhYv/DocKikzRWSxjV9SDw3+0PRLv
 Tktj2j80rAfmQBadyYwAz3OYs2J6NO3PciwwWCALkrYOie3DsH8NwyzseaIfrr0m98xyVFd9Us9
 /vt2p0h3zlwQPiyORYHyQzc5vyOT6xTy/riFq0amfIniRRRkXN/MucgeJM5PaI5XFBiSn39
X-Received: by 2002:a05:701b:2502:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-1244a7f3784mr1159489c88.7.1768571387331; Fri, 16 Jan 2026
 05:49:47 -0800 (PST)
MIME-Version: 1.0
References: <20260114090056.356633-1-Jesse.Zhang@amd.com>
 <585f1f3e-6e1c-40b6-a7ca-da0e871ffb00@amd.com>
 <CADnq5_ORTuUvfAzRxptnkGpSP6ZyFM7xM2zLtOk-XEqP_jd1qw@mail.gmail.com>
 <DM4PR12MB5152E079374990BF66E5FC88E38CA@DM4PR12MB5152.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5152E079374990BF66E5FC88E38CA@DM4PR12MB5152.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jan 2026 08:49:36 -0500
X-Gm-Features: AZwV_Qh__7CmVZuZ3D8jXYh8S7UIrDCaXxBPEeU8xF50jb0I17Sypz8BNNcTlnI
Message-ID: <CADnq5_NHvW5NyNs+s+Sy73w4qGV4Vxp7Dn9-d++r6e7+1kjJWw@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
Cc: "Lazar, Lijo" <Lijo.Lazar@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
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

On Thu, Jan 15, 2026 at 10:10=E2=80=AFAM Zhang, Jesse(Jie) <Jesse.Zhang@amd=
.com> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, January 15, 2026 2:14 AM
> > To: Lazar, Lijo <Lijo.Lazar@amd.com>
> > Cc: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-gfx@lists.freedesktop.=
org;
> > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>
> > Subject: Re: [PATCH 1/5] drm/amdgpu/vcn4.0.3: rework reset handling
> >
> > On Wed, Jan 14, 2026 at 6:27=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> > >
> > >
> > >
> > > On 14-Jan-26 2:29 PM, Jesse.Zhang wrote:
> > > > From: "Alex Deucher" <alexander.deucher@amd.com>
> > > >
> > > > Resetting VCN resets the entire tile, including jpeg.
> > > > When we reset VCN, we also need to handle the jpeg queues.
> > > > Add a helper to handle recovering the jpeg queues when VCN is reset=
.
> > > >
> > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > ---
> > > >   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 11 +++++--
> > > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  | 42
> > ++++++++++++++++++++++--
> > > >   2 files changed, 49 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > index aae7328973d1..1a32dadf8c5d 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> > > > @@ -1145,13 +1145,20 @@ static int jpeg_v4_0_3_ring_reset(struct
> > amdgpu_ring *ring,
> > > >                                 unsigned int vmid,
> > > >                                 struct amdgpu_fence *timedout_fence=
)
> > > >   {
> > > > +     struct amdgpu_device *adev =3D ring->adev;
> > > > +     struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> > > > +     int r;
> > > > +
> > > >       if (amdgpu_sriov_vf(ring->adev))
> > > >               return -EOPNOTSUPP;
> > > > -
> > > > +     /* take the vcn reset mutex here because resetting VCN will r=
eset jpeg as
> > well */
> > > > +     mutex_lock(&vinst->engine_reset_mutex);
> > > >       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > >       jpeg_v4_0_3_core_stall_reset(ring);
> > > >       jpeg_v4_0_3_start_jrbc(ring);
> > > > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > > +     mutex_unlock(&vinst->engine_reset_mutex);
> > > > +     return r;
> > > >   }
> > > >
> > > >   static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs =3D { diff
> > > > --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > index cb7123ec1a5d..31d93c10dfb1 100644
> > > > --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> > > > @@ -1596,6 +1596,32 @@ static void vcn_v4_0_3_unified_ring_set_wptr=
(struct
> > amdgpu_ring *ring)
> > > >       }
> > > >   }
> > > >
> > > > +static int vcn_v4_0_3_reset_jpeg_helper(struct amdgpu_device *adev=
,
> > > > +                                     int inst) {
> > > > +     struct amdgpu_ring *ring;
> > > > +     int i, r;
> > > > +
> > > > +     for (i =3D 0; i < adev->jpeg.num_jpeg_rings; ++i) {
> > > > +             ring =3D &adev->jpeg.inst[inst].ring_dec[i];
> > > > +             drm_sched_wqueue_stop(&ring->sched);
> > > > +             amdgpu_fence_driver_force_completion(ring);
> > > > +             if (ring->use_doorbell)
> > > > +                     WREG32_SOC15_OFFSET(
> > > > +                             VCN, GET_INST(VCN, inst),
> > > > +                             regVCN_JPEG_DB_CTRL,
> > > > +                             (ring->pipe ? (ring->pipe - 0x15) : 0=
),
> > > > +                             ring->doorbell_index
> > > > +                             << VCN_JPEG_DB_CTRL__OFFSET__SHIFT |
> > > > +                             VCN_JPEG_DB_CTRL__EN_MASK);
> > > > +             r =3D amdgpu_ring_test_helper(ring);
> > > > +             if (r)
> > > > +                     return r;
> > > > +             drm_sched_wqueue_start(&ring->sched);
> > > > +     }
> > > > +     return 0;
> > > > +}
> > > > +
> > > >   static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> > > >                                unsigned int vmid,
> > > >                                struct amdgpu_fence *timedout_fence)
> > > > @@ -1605,6 +1631,9 @@ static int vcn_v4_0_3_ring_reset(struct amdgp=
u_ring
> > *ring,
> > > >       struct amdgpu_device *adev =3D ring->adev;
> > > >       struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> > > >
> > > > +     /* take the vcn reset mutex here because resetting VCN will r=
eset jpeg as
> > well */
> > > > +     mutex_lock(&vinst->engine_reset_mutex);
> > > > +
> > > >       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
> > > >
> > > >       vcn_inst =3D GET_INST(VCN, ring->me); @@ -1612,7 +1641,7 @@
> > > > static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> > > >
> > > >       if (r) {
> > > >               DRM_DEV_ERROR(adev->dev, "VCN reset fail : %d\n", r);
> > > > -             return r;
> > > > +             goto unlock;
> > > >       }
> > > >
> > > >       /* This flag is not set for VF, assumed to be disabled always
> > > > */ @@ -1621,7 +1650,16 @@ static int vcn_v4_0_3_ring_reset(struct
> > amdgpu_ring *ring,
> > > >       vcn_v4_0_3_hw_init_inst(vinst);
> > > >       vcn_v4_0_3_start_dpg_mode(vinst,
> > > > adev->vcn.inst[ring->me].indirect_sram);
> > > >
> > > > -     return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > > +     r =3D amdgpu_ring_reset_helper_end(ring, timedout_fence);
> > > > +     if (r)
> > > > +             goto unlock;
> > > > +
> > > > +     r =3D vcn_v4_0_3_reset_jpeg_helper(adev, ring->me);
> > >
> > > This doesn't seem to handle any ongoing jpeg activity before doing a
> > > vcn reset. Is that fine?
> >
> > We could split the helper in two, in the top helper we can stop the sch=
ed workqueues
> > and attempt to wait for any outstanding fences. Then in the bottom help=
er, we can
> > force completion, re-init the rings, and restart the sched workqueues. =
 With the patch
> > as is, any outstanding job fences would be marked with an error, and si=
gnalled so
> > userspace would see their jobs lost.
> [Zhang, Jesse(Jie)]   Is it possible to back up these commands in the top=
 helper ?
> This would avoid waiting for any unfinished fence synchronization.
> Because these commands might time out.

Not really if you want to salvage any currently active jobs.  Any jobs
that are already running either need to wait for completion or you
need to stop the queue and set error on the fence.  You could add a
function to try and salvage the unprocessed jobs, but the one(s)
already on the hardware would have to be lost.

Alex

> static int vcn_v4_0_3_reset_jpeg_pre_helper(struct amdgpu_device *adev, i=
nt inst)
> {
>         ...
>         for (i =3D 0; i < adev->jpeg.num_jpeg_rings; ++i) {
>                 ring =3D &adev->jpeg.inst[inst].ring_dec[i];
>
>                 drm_sched_wqueue_stop(&ring->sched);
>                 /* back up the non-guilty commands */
>                 amdgpu_ring_backup_unprocessed_commands(ring, guilty_fenc=
e);
>
>        }
> }
> Thanks
> Jesse.
>
> >
> > Alex
> >
> > >
> > > Thanks,
> > > Lijo
> > >
> > > > +
> > > > +unlock:
> > > > +     mutex_unlock(&vinst->engine_reset_mutex);
> > > > +
> > > > +     return r;
> > > >   }
> > > >
> > > >   static const struct amdgpu_ring_funcs
> > > > vcn_v4_0_3_unified_ring_vm_funcs =3D {
> > >
