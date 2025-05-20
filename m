Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AB4C3DA6D
	for <amd-gfx@archiver.kernel.org>; Tue, 20 May 2025 16:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D577210E56C;
	Tue, 20 May 2025 16:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGWro/TY";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF5210E56C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 16:39:09 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b2700de85d0so323343a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 May 2025 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747759149; x=1748363949; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrLiE9/h7nJ7/iOPVlrdOFHPG92ELwhmQ+wsvFH9czs=;
 b=PGWro/TYxVpxTCA4Z4BKIqiOdSDslLQVKDpcf57OEMaEiKLKw6pC9LQTH31XY9D8PA
 qZVOem1JeQThF/I9Op1PwaM++5vnVRnrbRAtaKUQ9LQwYohcbmWrZ6Jf+PLnu8NbLk9D
 mFxIQAtQdeBgKk5sWW2FpiNEc6LwMWncRLAYYm1GuEoUg3xYnUu06j/5RwWWS0y0mzJY
 3VWB5FuGblLlex1QQJidPMqAyCMuEfO87dN8S60jYFggCF2q3RvB1jUQPwLPEat4H50W
 WgycIS1A3eYGGW0SZeZE7t4fyX46DmJ1FLmqZmxEw1Zsb1fth8crnVkIMn+FMdAtu+Dl
 cuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747759149; x=1748363949;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrLiE9/h7nJ7/iOPVlrdOFHPG92ELwhmQ+wsvFH9czs=;
 b=oIQu/j9V0huYQ45+cZLGmlr2YNhO1ZjDL5hDDFDvKMhptL7g0yFpeQ3/huM27PyfZi
 zJak3mNTcC+OISZUkvA45O+BFw1VXGJKJJrzADfAaZ4svUk09rnlRkljLFW1N7SUi3xS
 BO+cRt7D44u3GmqO51beAxYwGSllfJ3vY3wddxg5EvQrN6xr92rG+rwXvbN5JltNXNFF
 tWhsEQyRjYMYBvA6R9L3jrzS6lkLCVqOsPYDB8KSDRQfaxiC8TTqhQMaTGGCY0CgTzXf
 Op1uuYCxVAGfYOOr4q8vWwJe8oIOq5cAl2TH/QihT6iiSmVxZ+P6QJEWsp+W/Dkle786
 rfug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn+TkiQzAxw6GIDeKe3ME6skDAIw+4wvuv5uU/+9XCRIbI60ylorwVAUcU8xfMoIucd/4l4iCy@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXkFPATUJWVDZDO3if8GSAdqkp2AGUru47f2ZEeRBOuu8GCrOH
 VPgiq+NlpDX5Gi5g8ElcxDyt/2+Ttcw0NWjlHx9YE4NBeivtjl3vsaFMl/16Y0XWSyaN6cQ+KI1
 U0TBBxQjGtB1kQBW+IMX0oR2BIDgWfMU=
X-Gm-Gg: ASbGncsF8KyV1YkzHPoRsfD/P1eRWbhUhoODDUoJpRWdGbxqFRwh6+0ARAuwTi8spQ+
 KCgE/kYHSJQZ5yxMJ0qazyE0fz2+nV7Y1kbclxJnf5cpYD7Fj6vxuJf5fXOXTiXifKj8OmYQunQ
 xJWYNLwjY7yx3dn7MpPNHjEuGWmFMwH4X8HMJ6oEIbm22i
X-Google-Smtp-Source: AGHT+IEFih7WQDx683DZ6ahg9xbZjffqdbvWdjx9OgI/v1pMOiEvtsuPHAyNHEixiGazFMbNB6PF3DhcCVzHqOus/vI=
X-Received: by 2002:a17:903:2ed0:b0:224:1785:8044 with SMTP id
 d9443c01a7336-231d43980eemr85404935ad.4.1747759148638; Tue, 20 May 2025
 09:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250519182209.18273-1-alexander.deucher@amd.com>
 <20250519182209.18273-2-alexander.deucher@amd.com>
 <CADnq5_OWC6ueeMbsgmahQuAULjms3c-dWfFRNLibmrEVMP9KvQ@mail.gmail.com>
 <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
In-Reply-To: <ce89c13b-a7ad-424e-9cad-141b97138e64@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 May 2025 12:38:56 -0400
X-Gm-Features: AX0GCFvHz-4A9lULJpemFfHZhPaIk3fE0cX4OrUK5SE6EZBG6uSL21CQyN4L4vk
Message-ID: <CADnq5_PrNiZmgUnBH_p9w70wyczK6RtQnNptKQS9FO7ERHhaPg@mail.gmail.com>
Subject: Re: [PATCH 2/8] drm/amdgpu: rework queue reset scheduler interaction
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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

On Tue, May 20, 2025 at 9:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/20/25 15:09, Alex Deucher wrote:
> > On Mon, May 19, 2025 at 2:30=E2=80=AFPM Alex Deucher <alexander.deucher=
@amd.com> wrote:
> >>
> >> From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> >>
> >> Stopping the scheduler for queue reset is generally a good idea becaus=
e
> >> it prevents any worker from touching the ring buffer.
> >>
> >> But using amdgpu_fence_driver_force_completion() before restarting it =
was
> >> a really bad idea because it marked fences as failed while the work wa=
s
> >> potentially still running.
> >>
> >> Stop doing that and cleanup the comment a bit.
> >>
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 27 ++++++++++++------------=
-
> >>  1 file changed, 13 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_job.c
> >> index acb21fc8b3ce5..a0fab947143b5 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedo=
ut(struct drm_sched_job *s_job)
> >>         } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> >>                 bool is_guilty;
> >>
> >> -               dev_err(adev->dev, "Starting %s ring reset\n", s_job->=
sched->name);
> >> -               /* stop the scheduler, but don't mess with the
> >> -                * bad job yet because if ring reset fails
> >> -                * we'll fall back to full GPU reset.
> >> +               dev_err(adev->dev, "Starting %s ring reset\n",
> >> +                       s_job->sched->name);
> >> +
> >> +               /*
> >> +                * Stop the scheduler to prevent anybody else from tou=
ching the
> >> +                * ring buffer.
> >>                  */
> >>                 drm_sched_wqueue_stop(&ring->sched);
> >>
> >> @@ -157,19 +159,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedo=
ut(struct drm_sched_job *s_job)
> >>
> >>                 r =3D amdgpu_ring_reset(ring, job->vmid);
> >>                 if (!r) {
> >> -                       if (amdgpu_ring_sched_ready(ring))
> >> -                               drm_sched_stop(&ring->sched, s_job);
> >> -                       if (is_guilty) {
> >> +                       if (is_guilty)
> >>                                 atomic_inc(&ring->adev->gpu_reset_coun=
ter);
> >> -                               amdgpu_fence_driver_force_completion(r=
ing);
> >
> > Do we still need this in the case of rings where we reset the entire
> > queue?  E.g., compute or VCN?  In which case we should move this to
> > the ring->reset callback.
>
> No, it shouldn't be necessary in the first place as long as the rings sti=
ll execute their fence packages.
>
> And that should be the case at least for both graphics and compute.
>
> Forcing completion only makes sense when the whole ASIC was resetted and =
nothing executed any more.

This seems to result in a deadlock if you reset the entire queue
rather than just the vmid.   I.e., if you test with just this patch
and not any of the following patches.  In that case, the queue is
reset so none of the fences are signaled.

Alex


>
> Regards,
> Christian.
>
>
> >
> > Alex
> >
> >> -                       }
> >> -                       if (amdgpu_ring_sched_ready(ring))
> >> -                               drm_sched_start(&ring->sched, 0);
> >> -                       dev_err(adev->dev, "Ring %s reset succeeded\n"=
, ring->sched.name);
> >> -                       drm_dev_wedged_event(adev_to_drm(adev), DRM_WE=
DGE_RECOVERY_NONE);
> >> +                       drm_sched_wqueue_start(&ring->sched);
> >> +                       dev_err(adev->dev, "Ring %s reset succeeded\n"=
,
> >> +                               ring->sched.name);
> >> +                       drm_dev_wedged_event(adev_to_drm(adev),
> >> +                                            DRM_WEDGE_RECOVERY_NONE);
> >>                         goto exit;
> >>                 }
> >> -               dev_err(adev->dev, "Ring %s reset failure\n", ring->sc=
hed.name);
> >> +               dev_err(adev->dev, "Ring %s reset failed\n", ring->sch=
ed.name);
> >>         }
> >>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> >>
> >> --
> >> 2.49.0
> >>
>
