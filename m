Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93BEAC61CE8
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Jun 2025 13:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4834D10E371;
	Mon,  9 Jun 2025 13:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dHcO2Nex";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23BB310E371
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Jun 2025 13:33:53 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-b2ef619e80eso297874a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Jun 2025 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749476032; x=1750080832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyqzNoUCX6+hnH+aoVF05j/JSOBiVQu7zPEOPW/VEuQ=;
 b=dHcO2NexEVmZDH8MVpqe+iBVrEJd9eUrPykozRI4U9qTbRka3UkAXPjJtmSipD5PcW
 VDuuSmRpqOkbSQ7lU1eB8blJNWSIUZ2PLCGWf6VKML4uB0WCKlH2S0uZaoXiJj333hWa
 Bgn7wALsltqk1aNJpCjRe5ndpBFv+Eon5eKxcUQvpzP0yDMsGhvwtaeuX1L2B51Z7Ybm
 H91hRyE89MEFc7hRRvB6yKQb3LgConj/CbIOgGDt2BjW7PVxF5RlsbDnAKPgP783iPHb
 i/hO5pvUTFdGzM3hMh//5y0EYWESLDivOhUQUMPkaGu1zIYPZosr7tMFgS79rDujWIr2
 UXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749476032; x=1750080832;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyqzNoUCX6+hnH+aoVF05j/JSOBiVQu7zPEOPW/VEuQ=;
 b=XexDPS68xoJbAIwcCnTHyX4yAERZ0jlwJ29EYY38ClB+bKg36VQ4bYu8Yvlb2yZn01
 si3gZIrAI4alN1QFmwS2IJbhWieRIZTiIV/PIp3mS+P83zhLebceQ2ySviZZGplwiIkz
 i1GdY+SUUGnJQE/4gKC2Ifb28Rt48UcN/iO6prGsBB0oAtdHztFBeeqOIPUEoiZfmxBz
 HBB1hjn1vXg9KEGplxSrG/udK0woK1JZ8EQERKF7M868kR60MfFFGV7DgajdbWCgYpwQ
 npVkQVws3Zzn2m/toq4VW0DNDNzH/ojzt6oEmLKDidh26BA4H2KuEJegyILqMTpFlX47
 BfFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDEuRv85gY5S5bWnlvYLBnQjLTUBzvAxx1vg+F2qcVHlFwAojA7E8A4GowW45V+BHQcoVC4DTy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFn6sBEHaiIt0hEEHgVBTPH8msv+v2YjpPJG0ABUq53tyJ3j+n
 /q+IRBwDo6xo1mraL2TdNLIxIqTFzHlHNIRTfsBJs60jBdW4VDMKyYrba57KurkSGXBqS+iv+oa
 8rWRQ3tOsBNOzXygcGSG8eMSbk+2mtM8=
X-Gm-Gg: ASbGnct3d4lqnANeFULyoFVZOrClpC7BGzaDHTsbNOrX88DJZ/hn3TlzaJjX+BefhxA
 1ALUAqHAnQbJWQ3jSmwnXlHaV+O8CuhahgPHDlWIbJIYxwhgBjyb58yYfk03HTEOgK7j/FkgYek
 tN2IjRfa9Yffp4fL6gEU3QKQa0uP1tWbpxsElCK1fStL6/
X-Google-Smtp-Source: AGHT+IG1zY+5CmQnwankP+v0h+ZhT+zy3vzFvlcggb/BONmEXPCVlK9PV0NZsa+H+kJdjoMKLREB8uMB2JL7dxn3t0s=
X-Received: by 2002:a17:90b:1b51:b0:311:a314:c2c9 with SMTP id
 98e67ed59e1d1-3134708fe96mr7276942a91.1.1749476032050; Mon, 09 Jun 2025
 06:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250606064354.5858-1-alexander.deucher@amd.com>
 <20250606064354.5858-7-alexander.deucher@amd.com>
 <62a1601e-990a-498e-a64b-d96bfa5567e6@amd.com>
 <CADnq5_NVyLr6O71si=svVJr-Ev6TOGtLs4W32T6fayQPDyfr8Q@mail.gmail.com>
 <d7144d43-adf5-4f2f-b524-b918273ae85e@amd.com>
In-Reply-To: <d7144d43-adf5-4f2f-b524-b918273ae85e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Jun 2025 09:33:39 -0400
X-Gm-Features: AX0GCFv0296BzYdSWa2GNmaW6BojZjbPAYAkUh1fGtFqvqZ_8cvjeVJci1mBptE
Message-ID: <CADnq5_Mi5K0zXB827wZtnFM5WjJtQN2cSrgE6A0d+JZj+ca4Dg@mail.gmail.com>
Subject: Re: [PATCH 06/29] drm/amdgpu: update ring reset function signature
To: "Sundararaju, Sathishkumar" <sasundar@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Jun 9, 2025 at 8:43=E2=80=AFAM Sundararaju, Sathishkumar
<sasundar@amd.com> wrote:
>
>
>
> On 6/6/2025 9:30 PM, Alex Deucher wrote:
> > On Fri, Jun 6, 2025 at 7:41=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >> On 6/6/25 08:43, Alex Deucher wrote:
> >>> Going forward, we'll need more than just the vmid.  Everything
> >>> we need in currently in the amdgpu job structure, so just
> >>> pass that in.
> >> Please don't the job is just a container for the submission, it should=
 not be part of any reset handling.
> >>
> >> What information is actually needed here?
> > We need job->vmid, job->base.s_fence->finished, job->hw_fence.
> There's more/full ip specific reset control possible with job passed to
> reset callback and fence/guilty handling moved here.
> Wondering, if I can also try to enable reset on vcn non unified queues,
> this patch series has relevant examples and makes it
> possible to handle it all in the reset callback itself, can try it atop
> these changes.

Yes, older VCNs with multiple rings per engine could do something
similar to SDMA 4x-5x where we reset the instance so all rings on that
instance get reset.

Alex


>
> Regards,
> Sathish
> >
> > Alex
> >
> >> Regards,
> >> Christian.
> >>
> >>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  2 +-
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   |  7 ++++---
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 10 ++++++----
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 10 ++++++----
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  2 +-
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  |  2 +-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++--
> >>>   drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++--
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  3 ++-
> >>>   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  3 ++-
> >>>   22 files changed, 53 insertions(+), 33 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_job.c
> >>> index ddb9d3269357c..80d4dfebde24f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -155,7 +155,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedou=
t(struct drm_sched_job *s_job)
> >>>                if (is_guilty)
> >>>                        dma_fence_set_error(&s_job->s_fence->finished,=
 -ETIME);
> >>>
> >>> -             r =3D amdgpu_ring_reset(ring, job->vmid);
> >>> +             r =3D amdgpu_ring_reset(ring, job);
> >>>                if (!r) {
> >>>                        if (amdgpu_ring_sched_ready(ring))
> >>>                                drm_sched_stop(&ring->sched, s_job);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_ring.h
> >>> index e1f25218943a4..ab5402d7ce9c8 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> >>> @@ -268,7 +268,7 @@ struct amdgpu_ring_funcs {
> >>>        void (*patch_cntl)(struct amdgpu_ring *ring, unsigned offset);
> >>>        void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
> >>>        void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
> >>> -     int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
> >>> +     int (*reset)(struct amdgpu_ring *ring, struct amdgpu_job *job);
> >>>        void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
> >>>        bool (*is_guilty)(struct amdgpu_ring *ring);
> >>>   };
> >>> @@ -425,7 +425,7 @@ struct amdgpu_ring {
> >>>   #define amdgpu_ring_patch_cntl(r, o) ((r)->funcs->patch_cntl((r), (=
o)))
> >>>   #define amdgpu_ring_patch_ce(r, o) ((r)->funcs->patch_ce((r), (o)))
> >>>   #define amdgpu_ring_patch_de(r, o) ((r)->funcs->patch_de((r), (o)))
> >>> -#define amdgpu_ring_reset(r, v) (r)->funcs->reset((r), (v))
> >>> +#define amdgpu_ring_reset(r, j) (r)->funcs->reset((r), (j))
> >>>
> >>>   unsigned int amdgpu_ring_max_ibs(enum amdgpu_ring_type type);
> >>>   int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v10_0.c
> >>> index 75ea071744eb5..c58e7040c732a 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> @@ -9522,7 +9522,8 @@ static void gfx_v10_ring_insert_nop(struct amdg=
pu_ring *ring, uint32_t num_nop)
> >>>        amdgpu_ring_insert_nop(ring, num_nop - 1);
> >>>   }
> >>>
> >>> -static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int gfx_v10_0_reset_kgq(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> >>> @@ -9547,7 +9548,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>
> >>>        addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj) +
> >>>                offsetof(struct v10_gfx_mqd, cp_gfx_hqd_active);
> >>> -     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmi=
d);
> >>> +     tmp =3D REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << job=
->vmid);
> >>>        if (ring->pipe =3D=3D 0)
> >>>                tmp =3D REG_SET_FIELD(tmp, CP_VMID_RESET, PIPE0_QUEUES=
, 1 << ring->queue);
> >>>        else
> >>> @@ -9579,7 +9580,7 @@ static int gfx_v10_0_reset_kgq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>   }
> >>>
> >>>   static int gfx_v10_0_reset_kcq(struct amdgpu_ring *ring,
> >>> -                            unsigned int vmid)
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v11_0.c
> >>> index afd6d59164bfa..0ee7bdd509741 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>> @@ -6806,7 +6806,8 @@ static int gfx_v11_reset_gfx_pipe(struct amdgpu=
_ring *ring)
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int gfx_v11_0_reset_kgq(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int r;
> >>> @@ -6814,7 +6815,7 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>        if (amdgpu_sriov_vf(adev))
> >>>                return -EINVAL;
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, fal=
se);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid=
, false);
> >>>        if (r) {
> >>>
> >>>                dev_warn(adev->dev, "reset via MES failed and try pipe=
 reset %d\n", r);
> >>> @@ -6968,7 +6969,8 @@ static int gfx_v11_0_reset_compute_pipe(struct =
amdgpu_ring *ring)
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int gfx_v11_0_reset_kcq(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int r =3D 0;
> >>> @@ -6976,7 +6978,7 @@ static int gfx_v11_0_reset_kcq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>        if (amdgpu_sriov_vf(adev))
> >>>                return -EINVAL;
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, tru=
e);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid=
, true);
> >>>        if (r) {
> >>>                dev_warn(adev->dev, "fail(%d) to reset kcq and try pip=
e reset\n", r);
> >>>                r =3D gfx_v11_0_reset_compute_pipe(ring);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm=
/amd/amdgpu/gfx_v12_0.c
> >>> index 1234c8d64e20d..a26417d53411b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> >>> @@ -5307,7 +5307,8 @@ static int gfx_v12_reset_gfx_pipe(struct amdgpu=
_ring *ring)
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int r;
> >>> @@ -5315,7 +5316,7 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>        if (amdgpu_sriov_vf(adev))
> >>>                return -EINVAL;
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, fal=
se);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid=
, false);
> >>>        if (r) {
> >>>                dev_warn(adev->dev, "reset via MES failed and try pipe=
 reset %d\n", r);
> >>>                r =3D gfx_v12_reset_gfx_pipe(ring);
> >>> @@ -5421,7 +5422,8 @@ static int gfx_v12_0_reset_compute_pipe(struct =
amdgpu_ring *ring)
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int r;
> >>> @@ -5429,7 +5431,7 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>        if (amdgpu_sriov_vf(adev))
> >>>                return -EINVAL;
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, tru=
e);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, job->vmid=
, true);
> >>>        if (r) {
> >>>                dev_warn(adev->dev, "fail(%d) to reset kcq  and try pi=
pe reset\n", r);
> >>>                r =3D gfx_v12_0_reset_compute_pipe(ring);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v9_0.c
> >>> index d50e125fd3e0d..5e650cc5fcb26 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> >>> @@ -7153,7 +7153,7 @@ static void gfx_v9_ring_insert_nop(struct amdgp=
u_ring *ring, uint32_t num_nop)
> >>>   }
> >>>
> >>>   static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
> >>> -                           unsigned int vmid)
> >>> +                           struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[0];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/dr=
m/amd/amdgpu/gfx_v9_4_3.c
> >>> index c233edf605694..a7dadff3dca31 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> >>> @@ -3552,7 +3552,7 @@ static int gfx_v9_4_3_reset_hw_pipe(struct amdg=
pu_ring *ring)
> >>>   }
> >>>
> >>>   static int gfx_v9_4_3_reset_kcq(struct amdgpu_ring *ring,
> >>> -                             unsigned int vmid)
> >>> +                             struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_kiq *kiq =3D &adev->gfx.kiq[ring->xcc_id];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_0.c
> >>> index 4cde8a8bcc837..6cd3fbe00d6b9 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
> >>> @@ -764,7 +764,8 @@ static int jpeg_v2_0_process_interrupt(struct amd=
gpu_device *adev,
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> >>> +static int jpeg_v2_0_ring_reset(struct amdgpu_ring *ring,
> >>> +                             struct amdgpu_job *job)
> >>>   {
> >>>        jpeg_v2_0_stop(ring->adev);
> >>>        jpeg_v2_0_start(ring->adev);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v2_5.c
> >>> index 8b39e114f3be1..8ed41868f6c32 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
> >>> @@ -643,7 +643,8 @@ static int jpeg_v2_5_process_interrupt(struct amd=
gpu_device *adev,
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> >>> +static int jpeg_v2_5_ring_reset(struct amdgpu_ring *ring,
> >>> +                             struct amdgpu_job *job)
> >>>   {
> >>>        jpeg_v2_5_stop_inst(ring->adev, ring->me);
> >>>        jpeg_v2_5_start_inst(ring->adev, ring->me);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v3_0.c
> >>> index 2f8510c2986b9..3512fbb543301 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
> >>> @@ -555,7 +555,8 @@ static int jpeg_v3_0_process_interrupt(struct amd=
gpu_device *adev,
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> >>> +static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
> >>> +                             struct amdgpu_job *job)
> >>>   {
> >>>        jpeg_v3_0_stop(ring->adev);
> >>>        jpeg_v3_0_start(ring->adev);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm=
/amd/amdgpu/jpeg_v4_0.c
> >>> index f17ec5414fd69..c8efeaf0a2a69 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> >>> @@ -720,7 +720,8 @@ static int jpeg_v4_0_process_interrupt(struct amd=
gpu_device *adev,
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned i=
nt vmid)
> >>> +static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring,
> >>> +                             struct amdgpu_job *job)
> >>>   {
> >>>        if (amdgpu_sriov_vf(ring->adev))
> >>>                return -EINVAL;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/d=
rm/amd/amdgpu/jpeg_v4_0_3.c
> >>> index 79e342d5ab28d..8b07c3651c579 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
> >>> @@ -1143,7 +1143,8 @@ static void jpeg_v4_0_3_core_stall_reset(struct=
 amdgpu_ring *ring)
> >>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
> >>>   }
> >>>
> >>> -static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned=
 int vmid)
> >>> +static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> >>> +                               struct amdgpu_job *job)
> >>>   {
> >>>        if (amdgpu_sriov_vf(ring->adev))
> >>>                return -EOPNOTSUPP;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/d=
rm/amd/amdgpu/jpeg_v5_0_1.c
> >>> index 3b6f65a256464..0a21a13e19360 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
> >>> @@ -834,7 +834,8 @@ static void jpeg_v5_0_1_core_stall_reset(struct a=
mdgpu_ring *ring)
> >>>        WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CORE_RST_CTRL, 0x00);
> >>>   }
> >>>
> >>> -static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring, unsigned=
 int vmid)
> >>> +static int jpeg_v5_0_1_ring_reset(struct amdgpu_ring *ring,
> >>> +                               struct amdgpu_job *job)
> >>>   {
> >>>        if (amdgpu_sriov_vf(ring->adev))
> >>>                return -EOPNOTSUPP;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/d=
rm/amd/amdgpu/sdma_v4_4_2.c
> >>> index 9c169112a5e7b..ffd67d51b335f 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> >>> @@ -1667,7 +1667,8 @@ static bool sdma_v4_4_2_page_ring_is_guilty(str=
uct amdgpu_ring *ring)
> >>>        return sdma_v4_4_2_is_queue_selected(adev, instance_id, true);
> >>>   }
> >>>
> >>> -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring, unsigne=
d int vmid)
> >>> +static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> >>> +                                struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        u32 id =3D GET_INST(SDMA0, ring->me);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_0.c
> >>> index 9505ae96fbecc..46affee1c2da0 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> >>> @@ -1538,7 +1538,8 @@ static int sdma_v5_0_soft_reset(struct amdgpu_i=
p_block *ip_block)
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int sdma_v5_0_reset_queue(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        u32 inst_id =3D ring->me;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v5_2.c
> >>> index a6e612b4a8928..581e75b7d01a8 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
> >>> @@ -1451,7 +1451,8 @@ static int sdma_v5_2_wait_for_idle(struct amdgp=
u_ip_block *ip_block)
> >>>        return -ETIMEDOUT;
> >>>   }
> >>>
> >>> -static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int sdma_v5_2_reset_queue(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        u32 inst_id =3D ring->me;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v6_0.c
> >>> index 5a70ae17be04e..d9866009edbfc 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> >>> @@ -1537,7 +1537,8 @@ static int sdma_v6_0_ring_preempt_ib(struct amd=
gpu_ring *ring)
> >>>        return r;
> >>>   }
> >>>
> >>> -static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int i, r;
> >>> @@ -1555,7 +1556,7 @@ static int sdma_v6_0_reset_queue(struct amdgpu_=
ring *ring, unsigned int vmid)
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true=
);
> >>>        if (r)
> >>>                return r;
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm=
/amd/amdgpu/sdma_v7_0.c
> >>> index ad47d0bdf7775..c546e73642296 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
> >>> @@ -802,7 +802,8 @@ static bool sdma_v7_0_check_soft_reset(struct amd=
gpu_ip_block *ip_block)
> >>>        return false;
> >>>   }
> >>>
> >>> -static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        int i, r;
> >>> @@ -820,7 +821,7 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ri=
ng *ring, unsigned int vmid)
> >>>                return -EINVAL;
> >>>        }
> >>>
> >>> -     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
> >>> +     r =3D amdgpu_mes_reset_legacy_queue(adev, ring, job->vmid, true=
);
> >>>        if (r)
> >>>                return r;
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/=
amd/amdgpu/vcn_v4_0.c
> >>> index b5071f77f78d2..47a0deceff433 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> >>> @@ -1967,7 +1967,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(stru=
ct amdgpu_cs_parser *p,
> >>>        return 0;
> >>>   }
> >>>
> >>> -static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned in=
t vmid)
> >>> +static int vcn_v4_0_ring_reset(struct amdgpu_ring *ring,
> >>> +                            struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/dr=
m/amd/amdgpu/vcn_v4_0_3.c
> >>> index 5a33140f57235..d961a824d2098 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
> >>> @@ -1594,7 +1594,8 @@ static void vcn_v4_0_3_unified_ring_set_wptr(st=
ruct amdgpu_ring *ring)
> >>>        }
> >>>   }
> >>>
> >>> -static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        int r =3D 0;
> >>>        int vcn_inst;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/dr=
m/amd/amdgpu/vcn_v4_0_5.c
> >>> index 16ade84facc78..10bd714592278 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> >>> @@ -1465,7 +1465,8 @@ static void vcn_v4_0_5_unified_ring_set_wptr(st=
ruct amdgpu_ring *ring)
> >>>        }
> >>>   }
> >>>
> >>> -static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int vcn_v4_0_5_ring_reset(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/dr=
m/amd/amdgpu/vcn_v5_0_0.c
> >>> index f8e3f0b882da5..7e6a7ead9a086 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> >>> @@ -1192,7 +1192,8 @@ static void vcn_v5_0_0_unified_ring_set_wptr(st=
ruct amdgpu_ring *ring)
> >>>        }
> >>>   }
> >>>
> >>> -static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring, unsigned =
int vmid)
> >>> +static int vcn_v5_0_0_ring_reset(struct amdgpu_ring *ring,
> >>> +                              struct amdgpu_job *job)
> >>>   {
> >>>        struct amdgpu_device *adev =3D ring->adev;
> >>>        struct amdgpu_vcn_inst *vinst =3D &adev->vcn.inst[ring->me];
>
