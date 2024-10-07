Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C072CFB443
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 14:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B150410E3B9;
	Mon,  7 Oct 2024 14:39:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nB6Gosj2";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF9310E3B8
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Oct 2024 14:39:46 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2e13718283bso505163a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Oct 2024 07:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728311985; x=1728916785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15wIb8ttRxLf/hyoS17UfAq0Bhv4QPEjzd1UInzhbhs=;
 b=nB6Gosj2KMCLQ8ISNl9fxUxt+ON7i9d9TqjpdRSgUGzzb0bWVP+i2NXfCwS8zNq8MD
 HHPfL6AVUy95UbxdgIAmZDoB9FB/ofNYFXLjg8zGdTQ2i9q9hK0M8Cprl3oc1pxFEKqe
 T+BCwhdBqP43Rjdg35ZBo/u0tDla0hTccj8t9Ga/RHMMdsj6eRAe5Gg/hD9Q+RoLHLFV
 caHrkDMW+bDENz3T9zDUWMi1ZGCNjPrs+dhHBEwTYAWeVPsCOoME3l6KlyqWxxLIRQzW
 Bccr/2ypj9F1zFklNNqLT/ypkVivJGlJBYMuMarWPvRjhwIMEW8/w6AKxIUkJK/THrbj
 9+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728311985; x=1728916785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15wIb8ttRxLf/hyoS17UfAq0Bhv4QPEjzd1UInzhbhs=;
 b=nN8v6sbYx2VvaQ3xeEkAyCwhA7y9mPgAEvtQ2q2UZEw6MdRtFWoeEBfd8VgyBMxzO6
 rfwgGwjwpxCWA0yhK64hxq6ufky7/ban/E4nFAouqPAWjWTSDiRN+qOduX8ij9Cs9TKX
 nFPMekvQ3YfZBqqzkJncFCCh5tHk4VUItXLoAVs9fJ/pQmlvGE05Sqd00bcyGUjpZLCE
 vcp7+2uOH71/y4pEMTAo/nD4ExC+9WGSi75iJU/HI1/eDtIFkQgimjCQDYPT2XkH9QYv
 V3uGlOmYzv7NE76vYhAe5ji4XcH4CDr2z4925mm4VMyzD07+3SI1ODr4RtCQYgVlehZS
 ASGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmMVdKGRLdxoaX6m3Sep/JyQ50/SfskUB6tvg+XAMrQrBTfe0rOD1WYEFNihgcZz3term57MsY@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwDoHVbfO9MxjnnQ7iVfqIxpv0USpTNDotAp7aes8Yo+TwY3vsb
 McJvOvf5g1BNgkFKCeU2hsqc+z12v/NQl6P6wQpEKPgl5rxWGOyBswvdJn5y2a9kkiwVJZMbsoP
 5jvgFxLp/YhShDs0ys4VfHrC0dt4=
X-Google-Smtp-Source: AGHT+IFL8+Tq17neAnJK0eyM7wxxaQgRr41frW/Fby3Lhk19FeyrKShEzLpEk89FYm+ORDZxlqOmdrLqHU5yNiOcBZs=
X-Received: by 2002:a17:90a:e291:b0:2d3:b598:8daa with SMTP id
 98e67ed59e1d1-2e1e631b1a8mr6077893a91.4.1728311985490; Mon, 07 Oct 2024
 07:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240924095145.2281-1-tursulin@igalia.com>
 <20240924095145.2281-3-tursulin@igalia.com>
 <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
 <3e1ad979-a11e-43bd-8488-52712b58cec1@igalia.com>
 <CADnq5_MgTQxMwmoB2_XDFGqwma7=mqKhUPnhcRJ5YJrGk2wSFQ@mail.gmail.com>
 <f8073d28-111e-4bd3-90ae-f0d4ae3ebfb0@igalia.com>
In-Reply-To: <f8073d28-111e-4bd3-90ae-f0d4ae3ebfb0@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Oct 2024 10:39:34 -0400
Message-ID: <CADnq5_M8dru6p1OZguKxj7+eDL01fq2vbFpdA9Xn3xCqqO=+kQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Remove the while loop from
 amdgpu_job_prepare_job
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Tvrtko Ursulin <tursulin@igalia.com>, amd-gfx@lists.freedesktop.org,
 kernel-dev@igalia.com, Alex Deucher <alexander.deucher@amd.com>
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

On Mon, Oct 7, 2024 at 8:52=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 04/10/2024 15:15, Alex Deucher wrote:
> > Applied.  Thanks!
>
> Thanks Alex!
>
> Could you perhaps also merge
> https://lore.kernel.org/amd-gfx/20240813135712.82611-1-tursulin@igalia.co=
m/
> via your tree? If it still applies that is.

Just picked it up.  Thanks!

Alex

>
> Regards,
>
> Tvrtko
>
> > On Fri, Oct 4, 2024 at 3:28=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@i=
galia.com> wrote:
> >>
> >>
> >> On 24/09/2024 13:06, Christian K=C3=B6nig wrote:
> >>> Am 24.09.24 um 11:51 schrieb Tvrtko Ursulin:
> >>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>
> >>>> While loop makes it sound like amdgpu_vmid_grab() potentially needs =
to be
> >>>> called multiple times to produce a fence, while in reality all code =
paths
> >>>> either return an error, assign a valid job->vmid or assign a vmid wh=
ich
> >>>> will be valid once the returned fence signals.
> >>>>
> >>>> Therefore we can remove the loop to make it clear the call does not =
need
> >>>> to be repeated.
> >>>>
> >>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>
> >>> Oh yeah that's a leftover from when we still had the dependency handl=
ing
> >>> inside all this.
> >>>
> >>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the =
whole
> >>> series.
> >>
> >> Thanks - CC Alex if you could merge the trivial series please?
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>>> ---
> >>>> I stared for a good while, going back and forth, and couldn't see th=
at
> >>>> the
> >>>> while loop is needed. But maybe I missed something?
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> index d11cb0ad8c49..85f10b59d09c 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>> @@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job
> >>>> *sched_job,
> >>>>        if (job->gang_submit)
> >>>>            fence =3D amdgpu_device_switch_gang(ring->adev,
> >>>> job->gang_submit);
> >>>> -    while (!fence && job->vm && !job->vmid) {
> >>>> +    if (!fence && job->vm && !job->vmid) {
> >>>>            r =3D amdgpu_vmid_grab(job->vm, ring, job, &fence);
> >>>>            if (r) {
> >>>>                dev_err(ring->adev->dev, "Error getting VM ID (%d)\n"=
, r);
> >>>
