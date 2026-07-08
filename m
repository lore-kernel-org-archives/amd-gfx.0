Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3073BC44503
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 14:59:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C458E10F159;
	Wed,  8 Jul 2026 14:59:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+V4i/jh";
	dkim-atps=neutral
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A7E010F159
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 14:59:22 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-739906c1b32so35246137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 07:59:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783522761; cv=none;
 d=google.com; s=arc-20260327;
 b=JrIFIqeW09x8Fs200TTz209cII7Y33mzfcwFSsTNpN3Fan7HfTqNXyp6uk4Jzj24Mi
 AijhpVk/UobEpSC9DnNUlQAAW+m3Z4+FZQxi1EKq6fzLx52L87908j2ZU7CSUSanuwv8
 LdYWk+CxLe5QD4Moa1sWkbSw1JRNgxjcZ2BpG21dIbS2kKxznibfBv+a8JJ24pOh3Tl6
 3ltLTvl0Og1NmF4sbcw+AhxTVtTRjzPZBiB/7To4EC/O5fF76OCEDRcXu3gTOnjv7wgx
 imPgHu4q3g/9+pX9gbvG4ZTe8ys+ohWZNvqT2eLAXfYXD7yJjZ6B/STwEDJU/ruN8qyi
 HoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LCrjVVe17+O/9eLwZUtejIsIXo3Fk9JcjXroS+h8bas=;
 fh=lr2QF4JK/E244nctHSXeeqWYL7pbv2jQK0cTIze8bVE=;
 b=d0unSgTUI8d/dKMqFtQmpwm6nrAbKmfV4IcSpagiZ7C5ktypReCWKJAF34Q1KTqkE8
 ToA+0qy8qP5IVEgwAgWjyFxQpLipMfzeLXUjBhLTzb1dgQSjaSSaddNwC0UfrLxuZ2rr
 N52rQQ6Upnh8Pl5yyjUHEfmEWmdpXdYJlmcpR4cgQ31s9eEejPWfrK6TVKPbejtAZwBg
 jk/gA3/9fBDROQZEr+bSS4YyK3WUeu8a/3m3SG5KpAi1sg2bwiearykVj3/bWIdPco1W
 /Q30bWEohhAoR/6Mm5ITK9O5X0vMRCB1Z9FTYJbY0RoYo7PJqKR3RYdtGpPOwos9nD9O
 qDpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783522761; x=1784127561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LCrjVVe17+O/9eLwZUtejIsIXo3Fk9JcjXroS+h8bas=;
 b=E+V4i/jhwvOqWYsG+9lF8wpCo76E1REDDKpqlTyUKVY6DrWE0O1pW0vVH1hsmDxZu+
 Q2VcSbuiXh5hknSpp4Hj/BXgcJ624Wi3ib9NkOGdeGsbdchxD+oUVg9RSyK/LoFK9I14
 QAUKuV7+9MeSibLCoalCaXHJQQEnz6hsiUVAViurLlEJZxngfzyj+h3HxJPA+WdLO6lh
 Saa4qt2GMy0S4yPTNqxG4+c905wlcSkzkWshdpPHU61UWx3D5NxOlfPaDcRQtYGOmYax
 cw8zVRYm+ugD+MmdgFzeQF+/AkQy4vnYwrgm0gsWbhFazqTftruVjMfT0v0Eg09RWJ22
 X/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783522761; x=1784127561;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LCrjVVe17+O/9eLwZUtejIsIXo3Fk9JcjXroS+h8bas=;
 b=XGf5xKvlvXetbwzX4P/Gcnja5o03hFiD/0knUqDUD/0EtDZpe4DFd+qRPN4YYnyP9O
 qIGjktnLtdNV5NSlFAituI5Bsi4KXVphWeJB0snBJN0LSIu9+F8kEZYB0xXvCFpkZuDD
 Q8ZMfrEi5C8Hsfu6TWmjLBNbpDgIxQTmAKoyGHHpv09+iAdPj+qbFoK88KN5mTh9GsQS
 7VzyXYCr9fCvagAC9S3hgFNxmCzLJwvDvDccZ+xjjPMQ1U/1TA6wrDPdbcFULclN7IsF
 TfIsFMQWZXfit2miRKQUbVpavIMeLumnc80ejN7qKmBqiFuAQi9LHTp6lU20eJbOqIrm
 1RUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFoRFlz+5AsTbCgCTRCPzx8vwNnmRiw1ocwiY020d4e8nyu2caTEhEpzJzV1NqdV7iZm1UEh9U@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlMzWoEFaF6Hl/VC3SX8oYUzmzes0ErdujCFyD7UeyA2NBAFKY
 f1dwRQW3sW9v6g5VraRpJE7lpPJp220qcWpqSsiFsAU5GEMcVUOHl3KQq1JxFv/hJpW5IkIaluZ
 5LiSwfhL6St1yWaM+uL3JCxlBrFWWUXc=
X-Gm-Gg: AfdE7clcVOSAqQf7IKykt7Fnc83W6BHpCQD2A0wVqI810scZo3Z4NbX0yU3rq6ZcQnp
 pJk25Wyuz1AicEJ0xlBVi3p8Z+wWqR3IN4xP5hr6RGfRXbacJYkf4Kf77gPGyBEqsW+YZT8euPM
 F3hiI0FzatxL42Thb1LBA/y7OBHBUIfexrbgYisV+wtwBokAI/mDYk2ycl2si6nTSqItyldGPw/
 RYv8+tt1zy/u3iwVulMDmhz89wNGgU0/31+r+SiFYPahVHvorIhV0HHHli2hjsa2F4LFZbqPTa3
 UhYy7QA1d39+ElxaUde+UeTcBSokfq2Mwwbo2W/aYPe5nrPA5uUMKa1P1xo=
X-Received: by 2002:a05:6102:5f08:b0:632:9ebf:6069 with SMTP id
 ada2fe7eead31-744dfef0275mr610992137.4.1783522760996; Wed, 08 Jul 2026
 07:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260707143420.2104857-1-alexander.deucher@amd.com>
 <20260707143420.2104857-4-alexander.deucher@amd.com>
 <4730132e-8bd0-44c3-b639-3fb9e7f3c86f@amd.com>
 <CH0PR12MB51392C204D64BC4663A27850F7FF2@CH0PR12MB5139.namprd12.prod.outlook.com>
 <564d755f-4505-4213-879b-6c97277b8c33@amd.com>
In-Reply-To: <564d755f-4505-4213-879b-6c97277b8c33@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Jul 2026 10:59:08 -0400
X-Gm-Features: AUfX_myfmUy44ws6SW4RTCFSaKcWbzPGZZOv4b0hjaTUi2CrwiI0lps87i-8L0Y
Message-ID: <CADnq5_OG-R-4gRXnd0dFNJZmFftnADUii9BX1GjXNjyBpwsvxA@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: disallow gfxoff around gfx/compute/sdma
 KQ reset
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Wed, Jul 8, 2026 at 10:54=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 08-Jul-26 7:29 PM, Deucher, Alexander wrote:
> > AMD General
> >
> >> -----Original Message-----
> >> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> >> Sent: Tuesday, July 7, 2026 11:34 AM
> >> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> >> gfx@lists.freedesktop.org
> >> Subject: Re: [PATCH 4/6] drm/amdgpu: disallow gfxoff around
> >> gfx/compute/sdma KQ reset
> >>
> >>
> >>
> >> On 07-Jul-26 8:04 PM, Alex Deucher wrote:
> >>> If the engine is hung, we shouldn't need this since it won't be
> >>> powered down, but we could potentially have a case where a queue can
> >>> be preempted, but due to logic errors in the commands, the fence neve=
r
> >>> signals.  The engine could potentially go into the off state.  Protec=
t
> >>> against that.
> >>
> >> On a second thought, is this a real case? If engine already goes to of=
f state,
> >> wouldn't everything be reset by default once it comes back?
> >
> > I'm not sure if gfxoff will actually enter or not, but consider the cas=
e of an IB which is waiting for some memory location.  It's just waiting so=
 the queue can be preempted, but when it's resumed, it just goes back to wa=
iting so it needs to be reset even though it's not hung per se because it's=
 fence will never signal.  For compute queues at least, we peempt all the q=
ueues in the reset handler and then reset the bad queues.  In theory there =
could be a window there where gfxoff entry could happen and then we may acc=
ess a GC register via MMIO when we reset one of the bad queues.
> >
>
> I'm assuming IB execution will be considered as some part of GFX being
> active. A wakeup from gfxoff requires external intervention, so it's
> unlikely that it enters gfxoff during the wait. As far as I know, only
> doorbells could trigger external wakeup.

Couldn't gfxoff entry happen after MES preempts queues?  if we ring
the MES doorbell subsequently it should cause gfxoff entry, but in
some cases, we do the reset via MMIO.

Alex

>
> Thanks,
> Lijo
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 8 ++++++++
> >>>    1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> index b5c2d1d4d8839..c8a1aa88a9de0 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>> @@ -137,7 +137,15 @@ static enum drm_gpu_sched_stat
> >> amdgpu_job_timedout(struct drm_sched_job *s_job)
> >>>                      s_job->sched->name);
> >>>              /* Stop the scheduler to prevent anybody else from touch=
ing
> >> the ring buffer. */
> >>>              drm_sched_wqueue_stop(&ring->sched);
> >>> +           if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX ||
> >>> +               ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> >>> +               ring->funcs->type =3D=3D AMDGPU_RING_TYPE_SDMA)
> >>> +                   amdgpu_gfx_off_ctrl(adev, false);
> >>>              r =3D amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
> >>> +           if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX ||
> >>> +               ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE ||
> >>> +               ring->funcs->type =3D=3D AMDGPU_RING_TYPE_SDMA)
> >>> +                   amdgpu_gfx_off_ctrl(adev, true);
> >>>              if (!r) {
> >>>                      /* Start the scheduler again */
> >>>                      drm_sched_wqueue_start(&ring->sched);
> >
>
