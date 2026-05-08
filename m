Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DEDCD3436
	for <amd-gfx@archiver.kernel.org>; Fri,  8 May 2026 13:42:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D6310F4CB;
	Fri,  8 May 2026 13:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOpDTp6F";
	dkim-atps=neutral
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com
 [209.85.217.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E4910F4CB
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 May 2026 13:42:28 +0000 (UTC)
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-63146151764so13332137.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 May 2026 06:42:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778247747; cv=none;
 d=google.com; s=arc-20240605;
 b=cE+xnKToqaxbbi2MIHirOXqNTutDaUAQ/cNzl/ra15EPOMFKUkn0MSNrNqCAAplDx2
 8gt3oydB2QgdQ9VJzU+vITFSqvBEFIXA9sQSvis85eIzZ2or+UClMTJWhjF8+6P/sCoG
 23tJY8vZubtVBOyQqWIIdvZ/IIa5JWawCDeSgq9yntJ5fZfcVxjSPH2lEQE+qHmgCn20
 9qdABUBAtR26vgV91LTdafuUA9CkYQgsm1u5WoM1JOj9i/A7tCXUikNBNc2N/s0/m8Pe
 LsURbo5CWXUy21Qbus7a4A4RcjqhrOTvhF+8oYcmtgky4Gc14TboFkWgszs2JwLVo/Ax
 FHTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=us15Pwh2cK3D6lBgx+sifezEQ5mxvDZxOi2s1DJNE5I=;
 fh=W1eZMmFCQzUTPA4y9+cWRftzxeLRWlTTzJrsdW3PRoU=;
 b=VBqcNkOQZbJ9nglNsqDwNg3U1JumIWC6P2hsJSn7M6JTG3NoumbSAegqum6lKRIhDa
 1cFQVEQNe1VhEPzuQ46r9BSeGM+1kCKy/nqCVT84YDuTQ7VXgyvP2rX3Jj5BlM1C2OEh
 Otz6MHZpbKM/J5sCnd5C6kidgb6KOfX1ZBx0KwlVAp2e5tmyJSQp/zDFw8szl3X2HYNk
 D+IAdYIeZTib9OnMrLYLIC0NU0Xf5A/0BK6ek8MQ4OWXu4H1AlqkXeKYQAs7JEyTgKj6
 22eacWny4wyie9NpmTb8aHU/U4tzuHoDComAKSMlu4ftaQctxQlOFQwp0Db1i16AKHGi
 NapA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778247747; x=1778852547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=us15Pwh2cK3D6lBgx+sifezEQ5mxvDZxOi2s1DJNE5I=;
 b=nOpDTp6F+vnZsde6SqmfwQ03ekRzJjJa93tOCvbwqiTsehPvxaPvt3V5p0TDQX9Ivi
 E9YMEbZKSQs0HOoAWo9P9jr+RWfMQLpFaeNGmVljg/H3m34x9JU5dVsEYrintD/fNz2h
 24EKUGSkRa65wcdgOzrXPxADrrLpNlKsgPWbV9z8K+mn3F2m7seXT/1HduprS+XpVJ1Z
 ZNlW1Y392EhV8mEV5l4B3umZedgoA8+0aejHbZku9NvCCBlPLArav+GL2VxB8we61Lk1
 R3Ae9S/vLpbt67uXK18gGY/q0VzEty0iLl4RLDykn0zKAVQBmRlNyebyqJ3olaGlXMNN
 MvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778247747; x=1778852547;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=us15Pwh2cK3D6lBgx+sifezEQ5mxvDZxOi2s1DJNE5I=;
 b=pW3IjQHwT+Z5apjo5ALqF+ONJw5eMgcs2dxWV4ivp4Cz2udf33EhJRDTPTQxX0tz+b
 TFhGPqgT77Un/7s0gE6Fhczey5eRsArTH5Fhm1jyL9DGuryWrZM1hPzFBZA/esxTIReE
 zk0EflebyjJ7QsBRhwgKF3+HhYRGyjYfs832EsxV7XaevGdQIFCz7NSrsXPLixWMvZ3Z
 dKErjVlS36iTWdpy2zRUWjPYSxYfYKI8zmYlQGERcyHKG11+GkmDjpQk2i0iWFa+5/sl
 +oif/QRKTRd4sbW9PaxFiQwPtev/UPhu4P/sSIVRMMV7xd25hXYFqvJlMEEJtj2j+s0g
 C09Q==
X-Gm-Message-State: AOJu0YzipMVpR6vh8iz8K2FhVBZEoF3ka7AWBPfuVlgG15F00XMQhrmE
 kr5mXZFRAPzjoVQlfN+HzesaAaLlQ7AIVVRzWrzy4uiHCzRQOUoa+Nk3bzzRi8OPNsS9IAdMqi7
 83YqjDnRObvbHjHO3Cl19Mpz1Co3dlwA=
X-Gm-Gg: Acq92OFjj0esy1Nm2/rV32TX6S0jQ7myJrAlXAUcRAISyO+lk+tjc13MzhhtHRCt4wh
 sJEr3qy9QdoB7a4HgGEhsmwV2SNfY8KldfBX60LHQGLVgYOMdYIUnMls/ciXoc1z57P5wfpccdS
 TPNUvA81a7VLwY0827z94lAIU4wUQlcxrI9scx3hRrdPszvDgUySc4+R9FN3tJMekRXUG1jA54u
 SnSCyki4AJS3TxoEvRPD8jiR9fhwPg3c45ysHpZVN96r8bJs7VgtZF3+A+x86tzXqjdgKgO4wLC
 FIEJ9gZU9ZFP4aXPAVf9THEkHqHESlc5M5WrtvGcHtRwXReUBg1U2o4Qnh0Z5Xyr03HiBA==
X-Received: by 2002:a05:6102:66d0:b0:62f:2e5d:11d6 with SMTP id
 ada2fe7eead31-630f8c1fdeemr2088900137.0.1778247747336; Fri, 08 May 2026
 06:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260508071351.442816-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260508071351.442816-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 May 2026 09:42:14 -0400
X-Gm-Features: AVHnY4KMEYmFP4tP5V621sozO6Y15xOcmhuuu2xm0nLIHrk14RDA6vis3oKofBA
Message-ID: <CADnq5_P3FgGjgrsXt9C0izPsre5+jA4jyQSdRpuB1rL5uVZ5Qw@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/amdgpu: add MEC pipe reset helpers
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>,
 Manu Rastogi <manu.rastogi@amd.com>
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

On Fri, May 8, 2026 at 3:14=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Add IP-agnostic helpers to coordinate a MEC pipe reset across all KCQs on
> the same (me, pipe): prepare (back up siblings, stop schedulers, stop KFD=
),
> restart_schedulers, and recover_queues (re-init/remap KCQs and run
> amdgpu_ring_reset_helper_end on each =E2=80=94 guilty gets the timeout fe=
nce,
> siblings get a synthetic context so collateral work is reemitted).
>
> Suggested-by: Manu Rastogi <manu.rastogi@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 115 ++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  11 +++
>  2 files changed, 126 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 515cc4a2aeb4..8cfb73fda4bb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -69,6 +69,121 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu=
_device *adev, int bit,
>
>  }
>
> +static bool amdgpu_gfx_ring_on_mec_pipe(struct amdgpu_ring *ring, u32 me=
, u32 pipe)
> +{
> +       if (!ring || !ring->funcs || ring->funcs->type !=3D AMDGPU_RING_T=
YPE_COMPUTE)
> +               return false;
> +       if (ring->no_scheduler)
> +               return false;
> +
> +       return ring->me =3D=3D me && ring->pipe =3D=3D pipe;
> +}
> +
> +static unsigned int amdgpu_gfx_mec_pipe_compute_ring_base(struct amdgpu_=
device *adev,
> +                                                        u32 xcc_id)
> +{
> +       int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) =
: 1;
> +
> +       if (num_xcc <=3D 1)
> +               return 0;
> +       return xcc_id * adev->gfx.num_compute_rings;
> +}
> +
> +void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
> +                                      struct amdgpu_ring *guilty)
> +{
> +       struct amdgpu_ring *r;
> +       unsigned int j, base;
> +
> +       base =3D amdgpu_gfx_mec_pipe_compute_ring_base(adev, guilty->xcc_=
id);
> +       for (j =3D 0; j < adev->gfx.num_compute_rings; j++) {
> +               r =3D &adev->gfx.compute_ring[base + j];
> +               if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->p=
ipe))
> +                       continue;
> +               if (r !=3D guilty)
> +                       amdgpu_ring_backup_unprocessed_commands(r, NULL);
> +               if (amdgpu_ring_sched_ready(r))
> +                       drm_sched_wqueue_stop(&r->sched);
> +       }
> +
> +       if (adev->kfd.init_complete)
> +               amdgpu_amdkfd_stop_sched(adev, guilty->xcc_id);
> +}
> +
> +void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
> +                                           u32 me, u32 pipe, u32 xcc_id)
> +{
> +       struct amdgpu_ring *r;
> +       unsigned int j, base;
> +
> +       base =3D amdgpu_gfx_mec_pipe_compute_ring_base(adev, xcc_id);
> +       for (j =3D 0; j < adev->gfx.num_compute_rings; j++) {
> +               r =3D &adev->gfx.compute_ring[base + j];
> +               if (!amdgpu_gfx_ring_on_mec_pipe(r, me, pipe))
> +                       continue;
> +               if (amdgpu_ring_sched_ready(r))
> +                       drm_sched_wqueue_start(&r->sched);
> +       }
> +
> +       if (adev->kfd.init_complete)
> +               amdgpu_amdkfd_start_sched(adev, xcc_id);
> +}
> +
> +int amdgpu_gfx_mec_pipe_reset_recover_queues(struct amdgpu_device *adev,
> +                                            struct amdgpu_ring *guilty,
> +                                            struct amdgpu_fence *timedou=
t_fence,
> +                                            amdgpu_gfx_kcq_init_queue_t =
kcq_init)
> +{
> +       struct amdgpu_fence collateral_reemit =3D {};
> +       struct amdgpu_ring *r;
> +       unsigned int j, base;
> +       int err =3D 0;
> +
> +       if (!timedout_fence)
> +               return -EINVAL;
> +
> +       collateral_reemit.context =3D (u64)-1;
> +
> +       base =3D amdgpu_gfx_mec_pipe_compute_ring_base(adev, guilty->xcc_=
id);
> +       for (j =3D 0; j < adev->gfx.num_compute_rings; j++) {
> +               r =3D &adev->gfx.compute_ring[base + j];
> +               if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->p=
ipe))
> +                       continue;
> +
> +               err =3D kcq_init(r, true);
> +               if (err)
> +                       goto err_sched;
> +               err =3D amdgpu_mes_map_legacy_queue(adev, r, 0);
> +               if (err)
> +                       goto err_sched;
> +       }
> +
> +       amdgpu_gfx_mec_pipe_restart_schedulers(adev, guilty->me, guilty->=
pipe,
> +                                              guilty->xcc_id);
> +
> +       for (j =3D 0; j < adev->gfx.num_compute_rings; j++) {
> +               r =3D &adev->gfx.compute_ring[base + j];
> +               if (!amdgpu_gfx_ring_on_mec_pipe(r, guilty->me, guilty->p=
ipe))
> +                       continue;
> +
> +               err =3D amdgpu_ring_reset_helper_end(
> +                       r, r =3D=3D guilty ? timedout_fence : &collateral=
_reemit);

I don't think this will work.  We don't actually know which job hung
the pipe so we can't resubmit all of the jobs.  We either need to
discard all jobs (amdgpu_fence_driver_force_completion()) or just the
ones associated with the context from the earliest job on the queue.
Rather than stopping the jobs and doing all of the resets here, it
might be cleaner to have a worker thread which schedules a call to
drm_sched_fault() for all of the affected queues.  Then each queue
reset will run sequentially.  You need to be careful however since you
could get into a loop where each reset ends up scheduling more resets
if we end up falling back to the pipe reset handler for some reason.

Alex


> +               if (err) {
> +                       dev_err(adev->dev,
> +                               "ring %s failed recover after MEC pipe re=
set (%d)\n",
> +                               r->name, err);
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +
> +err_sched:
> +       amdgpu_gfx_mec_pipe_restart_schedulers(adev, guilty->me, guilty->=
pipe,
> +                                              guilty->xcc_id);
> +       return err;
> +}
> +
>  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
>                                      int xcc_id, int mec, int pipe, int q=
ueue)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 77050f9884f2..38b317b91bbe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -603,6 +603,17 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device=
 *adev, int mec,
>                                 int pipe, int queue);
>  void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int =
bit,
>                                  int *mec, int *pipe, int *queue);
> +
> +typedef int (*amdgpu_gfx_kcq_init_queue_t)(struct amdgpu_ring *ring, boo=
l clear);
> +
> +void amdgpu_gfx_mec_pipe_reset_prepare(struct amdgpu_device *adev,
> +                                      struct amdgpu_ring *guilty);
> +void amdgpu_gfx_mec_pipe_restart_schedulers(struct amdgpu_device *adev,
> +                                           u32 me, u32 pipe, u32 xcc_id)=
;
> +int amdgpu_gfx_mec_pipe_reset_recover_queues(
> +       struct amdgpu_device *adev, struct amdgpu_ring *guilty,
> +       struct amdgpu_fence *timedout_fence,
> +       amdgpu_gfx_kcq_init_queue_t kcq_init);
>  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc=
_id,
>                                      int mec, int pipe, int queue);
>  bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *ade=
v,
> --
> 2.49.0
>
