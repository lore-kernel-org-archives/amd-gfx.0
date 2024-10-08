Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF3CEF173
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Oct 2024 13:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87D3610E539;
	Tue,  8 Oct 2024 13:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="afj7+Bcb";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769ED10E539
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Oct 2024 13:36:13 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-7e9f8714b9bso450306a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Oct 2024 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728394573; x=1728999373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F5MyUhqHT/6oUHjQ8vErrYhWCcwBL3DxLEZeWICx5QU=;
 b=afj7+Bcb1OqMybnvFQrOnGScB2sMGvWivtI9cyRvQ2JA8yc83SI3NcA3Y4FEuvvGFZ
 yXDCbJYmAq51Cp4g2vZSD3mKPBTWEDp3tLxNQweIPkxmg9A3xk1Ucqx4AHF9Be9JfEbs
 ldlMvcWJdmXq90ZCaLIJftECQJuibl5PbM9Kk4Vm+jXS9U7ZLu6g4AqOBTxR9aaLwRPP
 hdNdO663CrCv47IOasZvkUCpH7qEnf5SwwvZEQeAcEOW1yVcFihb/On2OarGqKip+qlO
 mYVKvod4qDfqebkO7bwTl043uWSm1+B1D4qzhuVdr+oVTG6n6Fu8FfMR7VfioAGfqLoD
 wIuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728394573; x=1728999373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F5MyUhqHT/6oUHjQ8vErrYhWCcwBL3DxLEZeWICx5QU=;
 b=w2sMHH5uH6I+d7VwUxI+34rlV0vsmlKXmBkxJ6akVc5li+orM0VcGUyQXoFV1t7q9r
 OE4PnEIkRT884UmRgk3KqQr0pRRePJvaLiF+GN8A6Z/DiQoFW0/tRE89DRXMtzNotT79
 e7tb2svf0iSWXvuWhEB6Ptx1nt5apDu30gnEfLLLx+PWkzlxTiR9x6alS8sxX51znwle
 ikl0XWPYZgRN0w+eaPdQDjaKLyEn8b6eSx5FmHxAKk7xs+GkXRgOOB0DJARhAqiP0YT+
 mIwKR+xuHd+bIn9yPEdGMN9qE+b5m4T3QnYBUrpTyZc5JHDO1e6v/gzInCep/KxHWr9x
 7Dew==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4YXWcRxFh44h88rUQvuinJwqhZH4uwS7K448xLYXDcFKzC2LGugO5VhiXHbNf16qBFKBwLXHk@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyag2sCZDZ7QoQy2+LdVpGg9hTUC7fCoEV00MR6FyfyvPxnv7mE
 avic7KWtLC2auToMUQPQsOc78/MPz26ebgCEXuC/D+TipBRGrRXhnMAl08VpQT/thD6nAofEut+
 AH/CFBDKf0fZW8waNl+3FqN9nOu8=
X-Google-Smtp-Source: AGHT+IECXQmJJs9blxL6vwAcpZmrXjNkExa+CjJvK/J2rx3fmckScZhiDmxmrrBsXb7+D0luuXUI1tdSRaxAeI4LWzk=
X-Received: by 2002:a05:6a20:12c5:b0:1cf:3a64:cd5c with SMTP id
 adf61e73a8af0-1d6dfa24167mr11345881637.1.1728394572880; Tue, 08 Oct 2024
 06:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240924095145.2281-1-tursulin@igalia.com>
 <20240924095145.2281-3-tursulin@igalia.com>
 <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
 <3e1ad979-a11e-43bd-8488-52712b58cec1@igalia.com>
 <CADnq5_MgTQxMwmoB2_XDFGqwma7=mqKhUPnhcRJ5YJrGk2wSFQ@mail.gmail.com>
 <f8073d28-111e-4bd3-90ae-f0d4ae3ebfb0@igalia.com>
 <CADnq5_M8dru6p1OZguKxj7+eDL01fq2vbFpdA9Xn3xCqqO=+kQ@mail.gmail.com>
 <4cadbd87-4742-411f-b421-fdb43971ae75@igalia.com>
In-Reply-To: <4cadbd87-4742-411f-b421-fdb43971ae75@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Oct 2024 09:36:00 -0400
Message-ID: <CADnq5_M9BmX75KZHbC6Rc+9uZB3jQH9ocY5f4N1_B8PJGZJP2g@mail.gmail.com>
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

On Tue, Oct 8, 2024 at 4:20=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 07/10/2024 15:39, Alex Deucher wrote:
> > On Mon, Oct 7, 2024 at 8:52=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@i=
galia.com> wrote:
> >>
> >>
> >> On 04/10/2024 15:15, Alex Deucher wrote:
> >>> Applied.  Thanks!
> >>
> >> Thanks Alex!
> >>
> >> Could you perhaps also merge
> >> https://lore.kernel.org/amd-gfx/20240813135712.82611-1-tursulin@igalia=
.com/
> >> via your tree? If it still applies that is.
> >
> > Just picked it up.  Thanks!
>
> Did you get only 1/2? 2/2 needs more work/review you think or?

I picked up both.  The second patch was still in the CI pipeline when
I pushed out an updated branch yesterday.  I'll push an updated tree
today.

Alex

>
> Regards,
>
> Tvrtko
>
> > Alex
> >
> >>
> >> Regards,
> >>
> >> Tvrtko
> >>
> >>> On Fri, Oct 4, 2024 at 3:28=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin=
@igalia.com> wrote:
> >>>>
> >>>>
> >>>> On 24/09/2024 13:06, Christian K=C3=B6nig wrote:
> >>>>> Am 24.09.24 um 11:51 schrieb Tvrtko Ursulin:
> >>>>>> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>>>
> >>>>>> While loop makes it sound like amdgpu_vmid_grab() potentially need=
s to be
> >>>>>> called multiple times to produce a fence, while in reality all cod=
e paths
> >>>>>> either return an error, assign a valid job->vmid or assign a vmid =
which
> >>>>>> will be valid once the returned fence signals.
> >>>>>>
> >>>>>> Therefore we can remove the loop to make it clear the call does no=
t need
> >>>>>> to be repeated.
> >>>>>>
> >>>>>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>>>>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>>>>
> >>>>> Oh yeah that's a leftover from when we still had the dependency han=
dling
> >>>>> inside all this.
> >>>>>
> >>>>> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for th=
e whole
> >>>>> series.
> >>>>
> >>>> Thanks - CC Alex if you could merge the trivial series please?
> >>>>
> >>>> Regards,
> >>>>
> >>>> Tvrtko
> >>>>
> >>>>>> ---
> >>>>>> I stared for a good while, going back and forth, and couldn't see =
that
> >>>>>> the
> >>>>>> while loop is needed. But maybe I missed something?
> >>>>>> ---
> >>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
> >>>>>>     1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>>
> >>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> index d11cb0ad8c49..85f10b59d09c 100644
> >>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >>>>>> @@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job
> >>>>>> *sched_job,
> >>>>>>         if (job->gang_submit)
> >>>>>>             fence =3D amdgpu_device_switch_gang(ring->adev,
> >>>>>> job->gang_submit);
> >>>>>> -    while (!fence && job->vm && !job->vmid) {
> >>>>>> +    if (!fence && job->vm && !job->vmid) {
> >>>>>>             r =3D amdgpu_vmid_grab(job->vm, ring, job, &fence);
> >>>>>>             if (r) {
> >>>>>>                 dev_err(ring->adev->dev, "Error getting VM ID (%d)=
\n", r);
> >>>>>
