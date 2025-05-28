Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8728C54ED1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 May 2025 03:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AAF10E16A;
	Wed, 28 May 2025 03:58:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jLSjSvZ+";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 063BF10E16A
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 May 2025 03:58:56 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-30e7ee5fe74so506638a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 May 2025 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748404736; x=1749009536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aPI9KYo37tePYX/w4uGjoRORUn+DSJHjMDO6cKd8iEQ=;
 b=jLSjSvZ+qonCjip3PHMoUGXYMwhI0SImTG0JXSsdmQpN/59zZVnXzGMaIPj2CG0+py
 xx1qZjTDMb8eRHxDRzXO7e4Zg/sF2eG0B47lm5ZylKTee42ZEjawXcZLbyuvivsE49pw
 BDq0KXZETwpnH2S+9yrBcujOTgyCJQbzlchX2Se1KJfeiCAZOrV1vcFe7J4h9P1stoF6
 E6QLn0ZoL7mEXJGLPEvjHnMTFSnxM3YC9mkyhzwUBntWsL3QFwArDh5lb0EifYfQY0LS
 2u6M/VlEafLztvTwZcAxuIjVCJuzS0GSTcuwMNTlDbjicVvUyYcAjs/F2frarqM+KSz6
 uXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748404736; x=1749009536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aPI9KYo37tePYX/w4uGjoRORUn+DSJHjMDO6cKd8iEQ=;
 b=KwZvXt8n5RAXIKDR/EU58h58UkPuKINvvTcvZZ9p9qTeUbeu7fmaiyJH/PM9LOmxfh
 uMTDP3ZUNlPMjsS4lmbjeG2WEgbeo7pwePIgve0bHJSgSGOP6CAbYGW/Eh63M11SRtsz
 6hYy0VekFQtVwrgfQBhfEVdVNU848uckBq3aYCQcHwHgtHo+OJB7+UwXY/+J+As0S1SE
 fZWT5dEgAxwKOrQSlwh0v0fr5U+nEeuQ8Hq59rdRM46NVVlr2lGsSXXZoc055jhzU8w2
 P1BTPQznHzbTVyAKWyIWNYqsyzZ2fsmiQykU9m6wvOPewCZrknbIWm6KbVlN6mxaZxM2
 o3+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUc8pEuGDcxGlwSNG8FBhn89kLrKnx7YZ6JMtayhiCxOhlzzzwDPkcpkCResWPG8yUIBlt+FACT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUQMGizPkmmL0gFesZDVcsH6gR95/bACWLd850kxQAUiYPhVL3
 ZKpEPNi7kuY8neUkh85do3aLaF4riS5a9zM4JO+6JHFf3QWMxn1hBlsE3cQd/kWDzg90H0/0+fC
 /hn6AcU5gPF1snIUzkVL+ilHTengR9iA=
X-Gm-Gg: ASbGncuAUzMI+X0yBUtyj0aMBmfyJV7/LOPbE+xXMf9eKqbwdRrBgepdohlX5Cf63xX
 Z8Ca/satr9bDpTtB8s1rjYDdlrYfXGTYji+PF8iD3EJiLIF/tEon6hNMr2DKV984Wb8ORJvGqqi
 87N971Z3/8mZq1QFKjtinoN2fujAgHG0wjeA==
X-Google-Smtp-Source: AGHT+IGYhCAktzkFuQml4fCq4838BydlhpHaktjCiGA73axl4zGndCl4yKF47C59EwGWfxDflbYmk2j0Fz+rMchQg08=
X-Received: by 2002:a17:90b:3912:b0:310:cf92:7899 with SMTP id
 98e67ed59e1d1-311e1813502mr674912a91.3.1748404736355; Tue, 27 May 2025
 20:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250522215559.14677-1-alexander.deucher@amd.com>
 <20250522215559.14677-3-alexander.deucher@amd.com>
 <mmoave25vjenpkpt3osch5kin5qnryurqaty5pmtsju7zh37xk@22wccbz47es6>
In-Reply-To: <mmoave25vjenpkpt3osch5kin5qnryurqaty5pmtsju7zh37xk@22wccbz47es6>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 May 2025 23:58:44 -0400
X-Gm-Features: AX0GCFuIhwwYDcmTa6o21O0i6qp607DTDd4CQ6vdZ2yyvThfwKPxid-5-UWMpec
Message-ID: <CADnq5_NB54fQoTg+i_TexTERRLizY_KbkMMZm+ypEoSzfx5RhA@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/amdgpu: rework queue reset scheduler interaction
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 christian.koenig@amd.com, 
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

On Tue, May 27, 2025 at 12:47=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.=
com> wrote:
>
> On 05/22, Alex Deucher wrote:
> > From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
> >
> > Stopping the scheduler for queue reset is generally a good idea because
> > it prevents any worker from touching the ring buffer.
> >
> > But using amdgpu_fence_driver_force_completion() before restarting it w=
as
> > a really bad idea because it marked fences as failed while the work was
> > potentially still running.
> >
> > Stop doing that and cleanup the comment a bit.
> >
> > v2: keep amdgpu_fence_driver_force_completion() for non-gfx rings
>
> Why keep this amdgpu_fence_driver_force_completion() for non-gfx is ok?
> From the commit descriptions, sounds like we want to avoid
> amdgpu_fence_driver_force_completion() before the driver restarts the
> queue.

It depends on what the queue reset actually does.  If the entire queue
is lost, then amdgpu_fence_driver_force_completion() is what we want.
If the queue reset is able to reset the queue and restore the
non-guilty state, then there is no need to call this because the
subsequent fences should signal and the rest of the jobs should
naturally complete.

Alex

>
> >
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 26 +++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index acb21fc8b3ce5..e57401ef85140 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -136,10 +136,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedou=
t(struct drm_sched_job *s_job)
> >       } else if (amdgpu_gpu_recovery && ring->funcs->reset) {
> >               bool is_guilty;
> >
> > -             dev_err(adev->dev, "Starting %s ring reset\n", s_job->sch=
ed->name);
> > -             /* stop the scheduler, but don't mess with the
> > -              * bad job yet because if ring reset fails
> > -              * we'll fall back to full GPU reset.
> > +             dev_err(adev->dev, "Starting %s ring reset\n",
> > +                     s_job->sched->name);
> > +
> > +             /*
> > +              * Stop the scheduler to prevent anybody else from touchi=
ng the
> > +              * ring buffer.
> >                */
> >               drm_sched_wqueue_stop(&ring->sched);
> >
> > @@ -157,19 +159,19 @@ static enum drm_gpu_sched_stat amdgpu_job_timedou=
t(struct drm_sched_job *s_job)
> >
> >               r =3D amdgpu_ring_reset(ring, job->vmid);
> >               if (!r) {
> > -                     if (amdgpu_ring_sched_ready(ring))
> > -                             drm_sched_stop(&ring->sched, s_job);
> >                       if (is_guilty) {
> >                               atomic_inc(&ring->adev->gpu_reset_counter=
);
> > -                             amdgpu_fence_driver_force_completion(ring=
);
> > +                             if (ring->funcs->type !=3D AMDGPU_RING_TY=
PE_GFX)
> > +                                     amdgpu_fence_driver_force_complet=
ion(ring);
> >                       }
> > -                     if (amdgpu_ring_sched_ready(ring))
> > -                             drm_sched_start(&ring->sched, 0);
> > -                     dev_err(adev->dev, "Ring %s reset succeeded\n", r=
ing->sched.name);
> > -                     drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE=
_RECOVERY_NONE);
> > +                     drm_sched_wqueue_start(&ring->sched);
> > +                     dev_err(adev->dev, "Ring %s reset succeeded\n",
> > +                             ring->sched.name);
> > +                     drm_dev_wedged_event(adev_to_drm(adev),
> > +                                          DRM_WEDGE_RECOVERY_NONE);
> >                       goto exit;
> >               }
> > -             dev_err(adev->dev, "Ring %s reset failure\n", ring->sched=
.name);
> > +             dev_err(adev->dev, "Ring %s reset failed\n", ring->sched.=
name);
> >       }
> >       dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> >
> > --
> > 2.49.0
> >
>
> --
> Rodrigo Siqueira
