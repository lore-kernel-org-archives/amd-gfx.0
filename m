Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CECD2F347
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jan 2026 16:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA31510E357;
	Tue, 13 Jan 2026 16:47:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZQvR9scn";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7097410E357
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 16:47:06 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1233608c7e9so131c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jan 2026 08:47:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768322826; cv=none;
 d=google.com; s=arc-20240605;
 b=cADj9DuBAqphuaMchaVuSbgHTZ9GVcGQ8gs/QUjdptOPzKRfg4IqMAL+MG7JiJSEqL
 DOkC+0rgJw06+DgHgRPk4L+KYz9ZlugoufjJyNo56pGzJZT2WFqLv8txus2qx6MTOwzB
 rFMDeovo9WDWJw0QrcCjDovJRi8c+eBuVHl7r6DUYNEFdQ+Df+7TruXL25TxyXq2CdlW
 IuDWgNWNix1+iKVPptdetfkjulYSmzMLWEB8MhY6zYVDbqvAytVY4yJuuhWGuPZ9ExUE
 VeEcES28gBdEpxwQCalYkElRp+aJyyti4xikgFQ4M2/gF0UcbIR7y7Tb2j4aSXTRFzU2
 66Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WRovgbIN7H0c+SalTaRheGlY9W3tINrl6EzREZU0KSQ=;
 fh=xvkO7SHl2YsNHgjui81WjeZgYRa95kkKGelQQmNsqGo=;
 b=PYPv4rt9WtNcAWX2UDtGUdGIoTWoibILlhIncLyKku6UEYk4okH9GZB0tbF7RBGHz+
 DN14KBsZveXqFv5oNtMjIf5wYpBTgoj874woxa2vS05mxJyp0WNZquacfw4gBa3SnoZp
 G8LRNvjyLI8YqnuhccxPXVfWPaluh112iEMJV5p1nnPZR+HC7LoU3SB/Qjj1Mt+OKXqJ
 GtuKDtd/9OiSgIxO2r7ntwrtY8WvluUDZK0hUKQp7BHIu2i4JI2jv6km7DpzOLnYVP3U
 wdf0O0iDtP7e4/AFNDNrl/cFnyjyQtOyzF0AcEYYxj6hY778HcJUE3cIg5zsLcmq7CyG
 WuAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768322826; x=1768927626; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WRovgbIN7H0c+SalTaRheGlY9W3tINrl6EzREZU0KSQ=;
 b=ZQvR9scnHUcXaGkVbHNRLfSu2vcuT4ufDDcTktgjfc6bqhWf6GTtEojrTbyCaBaN8N
 P0uxExFcaytQuHsrqzWeHVVBGtGrQg4BGDkcJoNwMveGKxVRkdnm1/OI6U+JpWY3CLMq
 sTIjXLJFxn8yEisYxAKFegRVvbW3b/uJoHroPGYUF7ol1bynP1ngn1AVeojv4G4cHrT+
 LItXPiaFKIxX2x2QOM5sGewsoWcYwdKVgXWIg92TL6gCvd/I2AhIQp0hQJyjLGfIxK3W
 IYgiHfsut3UA+Ini240in0qpC0yf5BX1LAlQ59tO724N5F6BjljC0hq2oPMMb1MFdSgw
 zX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768322826; x=1768927626;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WRovgbIN7H0c+SalTaRheGlY9W3tINrl6EzREZU0KSQ=;
 b=KmvuwaBfIyAXJUyZi4ncyp3HSSJyYxF92bP/mHNls+odW+Uzh69t1W8EDsARv95cok
 qDXKu3F4zTzFEPFMUjdJI+GGWw/0TWDr2VxEz9Y63uxEtQYnWXM6/b/Ckn20TQbBL1M4
 8/W67ui3V+9mYzEVCyKC9hpGn7wHahc6Ybiy1Qa5SDCzv8Qa+bmn1mxho5LL8OQRIbAp
 9aEx/OAc2n8DTrFs1K/rzPMUgO737j9o5LQoOeVyWPMNcWlprcs2ZjaoeNEdrI9RVvbu
 GYtogRXPprjv473T60V5Gb2u6qQApn9wYd7Mey9WVUIdr/wC79qr5MPINhDrcy9szRN5
 nUTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGodJYoDy6CthejU9nFXLcY6KCLnsWhbl0nQw7yWc2sGLtDX/fhN+p86EKNvNqCaWElcgEUXIH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYuURX7avagvKzoqZqFuftU8JVYlCnBRLjS4CG6m0nBwPidRt6
 UgmceGAECRaBS6H9M0VfralqPmatZWya6QUJHNV/jZv9BfpyX+sl/Uphg+FEwKw2SqVi2zri9+i
 Pp1fyWQ1NA0BRK3GqVpMPQ6XWJRhiVKJKg+gn
X-Gm-Gg: AY/fxX4trFHD+5ti0YeD9zSsprga62G/lJJ/qBSExpJfZRHxwY6L2reGEHLPt6HgTe/
 b+j9IFTUIY9vND0uXyyviHQ2I5dWa9UwhBFKrR6gaqgndveEf65yVz3QQ92DP1taGbohqXwtZxR
 07/FmRCGcr6l2igBqruDExOjrRf8W6kD/OTDhmgRvA/tnQnlJDuOIiLwu4EOemG6Ya/BX3eITGC
 tHm65u7U0auAE9AvUGPiGFBZP63pxwwMkvXvd6VNc8Pf2+LAqezmiM0ZtQRjhKSt6qGLIXV
X-Google-Smtp-Source: AGHT+IFfoAKXcg/+AJ8vn/dffueNtmd92j2vTv6jef53C8DShAeFLlHKrejrIx5PVo9nqC9r1/fOcKlmGwQiyoPQJpc=
X-Received: by 2002:a05:7022:4199:b0:119:e55a:95a0 with SMTP id
 a92af1059eb24-121f8aff7dcmr13139169c88.2.1768322824087; Tue, 13 Jan 2026
 08:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20260108144843.493816-1-alexander.deucher@amd.com>
 <20260108144843.493816-30-alexander.deucher@amd.com>
 <08a6057a-7e95-4007-a4ee-ec8f6e3e5540@gmail.com>
 <8a8dbf04b6d13d67541dc2bc1fb91769def373c2.camel@mailbox.org>
 <bcd6ee8a-b951-4088-94c7-b9d260fe0c48@gmail.com>
In-Reply-To: <bcd6ee8a-b951-4088-94c7-b9d260fe0c48@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 Jan 2026 11:46:51 -0500
X-Gm-Features: AZwV_QgP1z91SfBgbexQBeG9QtSteznepjANcNNsJFWTRltzfzJMI_0fwaa1i_4
Message-ID: <CADnq5_PA1-OQku=BXuYDcAWDLmQ271Fv3XkfWJnmWiekskj+YA@mail.gmail.com>
Subject: Re: [PATCH 29/42] drm/amdgpu: don't call drm_sched_stop/start() in
 asic reset
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: phasta@kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Jan 13, 2026 at 10:57=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> On 1/13/26 14:34, Philipp Stanner wrote:
> > On Tue, 2026-01-13 at 14:17 +0100, Christian K=C3=B6nig wrote:
> >> On 1/8/26 15:48, Alex Deucher wrote:
> >>> We only want to stop the work queues, not mess with the
> >>> pending list so just stop the work queues.
> >
> > Ideally amdgpu could stop touching the pending_list altogether forever,
> > as discussed at XDC. Is work for that in the pipe? Is that what this
> > patch is for?
>
> Yes.
>
> >
> >>
> >> Oh, yes please! I can't remember how long we have worked towards that.
> >>
> >> But we also need to change the return code so that the scheduler now r=
e-inserts the job into the pending list.
> >
> > You're referring to false-positive timeouts. Porting users to that
> > typically consists of adding that return code and also removing
> > whatever the driver used to do to inject the non-timedout job into the
> > scheduler again.
> >
> > How is that being done here?
>
> Previously drm_sched_stop() would insert the job back into the pending li=
st after stopping the scheduler thread.
>
> But when that is replaced with drm_sched_wqueue_stop() then that won't ha=
ppen any more. That is a good thing and prevents us from running into probl=
ems like UAF because the HW fence signaled.
>
> As far as I can see we should start returning DRM_GPU_SCHED_STAT_NO_HANG =
from amdgpu even when there was actually a hang (maybe rename the return co=
de).
>

We already return DRM_GPU_SCHED_STAT_NOMINAL unconditionally.  The
only other option is DRM_GPU_SCHED_STAT_ENODEV which is not correct.

As far as I can see, there is nothing else to do.  The fence will be
signalled after the adapter reset.

Alex

> Regards,
> Christian.
>
> >
> > P.
> >
> >>
> >> Adding Philip on CC to double check what I say above.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
> >>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_device.c
> >>> index 80572f71ff627..868ab5314c0d1 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >>> @@ -6301,7 +6301,7 @@ static void amdgpu_device_halt_activities(struc=
t amdgpu_device *adev,
> >>>                     if (!amdgpu_ring_sched_ready(ring))
> >>>                             continue;
> >>>
> >>> -                   drm_sched_stop(&ring->sched, job ? &job->base : N=
ULL);
> >>> +                   drm_sched_wqueue_stop(&ring->sched);
> >>>
> >>>                     if (need_emergency_restart)
> >>>                             amdgpu_job_stop_all_jobs_on_sched(&ring->=
sched);
> >>> @@ -6385,7 +6385,7 @@ static int amdgpu_device_sched_resume(struct li=
st_head *device_list,
> >>>                     if (!amdgpu_ring_sched_ready(ring))
> >>>                             continue;
> >>>
> >>> -                   drm_sched_start(&ring->sched, 0);
> >>> +                   drm_sched_wqueue_start(&ring->sched);
> >>>             }
> >>>
> >>>             if (!drm_drv_uses_atomic_modeset(adev_to_drm(tmp_adev)) &=
& !job_signaled)
> >>
> >
>
