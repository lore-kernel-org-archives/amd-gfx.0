Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8481CFA775
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 14:15:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B50110EA18;
	Fri,  4 Oct 2024 14:15:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CpGGMI+3";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F3810EA18
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 14:15:55 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-20b582aaf08so906925ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728051355; x=1728656155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kOCuourpoGxjm5B8AWYrWNltnKQ6Qz2CZAcPjQq7ZYI=;
 b=CpGGMI+36KTuSkF4QM853IP6CnQRhV9o9O/IfGyjeKIZlyuY4ZGuC4XkDSp+fThWTE
 pd0qHcZN5cnOKGpeA29SAeY9mh7BG/B1V0VwH+B8Sx3BVPZXq8wg7U8mgX/e/n2Q/3ZK
 SJFlujmG8lqxfH7SIe7vdA62TNFZrY1SU4Qk8jnCJDH2eHH2Rz5VqZw859Wd4BmvkXzC
 GfmJ8MX0hspy3+wAThJy/nV5kI2+sm6pO4k5ERMAKkJLq3wknG6Tx2AysvdvWwtOMXIF
 XQqjS4yQ+zswlz+4i+wwT3le5WNG8bNjNN+QQ4U7edkHVWLBrL8g5jbC98Kqa3LETB6S
 4XrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728051355; x=1728656155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kOCuourpoGxjm5B8AWYrWNltnKQ6Qz2CZAcPjQq7ZYI=;
 b=OWg6+5RWyPzMHQI4BRDytvK8CtxU6Ch+++NH8QAZ13QQwY/GPsoa0Rq7uMbLzeQMx3
 M6tmjHib/2gnQSRME//aUMplrrVjhGjbUrPxdsqjVS6ZYsN6QI94CG1aIjkwg6QyRm37
 W+gDz6ci2kI+cI4aKpSvIjWx+99H3gAPjTTDLcWyhgl6DCZqW42fjabNMjPys4KuRqE9
 sEOxrshm9G2ro+WUTbUJ4+TgWLhLiwoKk8Y4YUUrBE+VidkHJ0YD/P53lJs8bYyaX8+J
 yyEV6M3bqNg7fOGM1cv90Ch6LNQnRjGKCC4ggJpGSc25OLufh5GCGJraQ/XspELZBb7y
 kYFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU01I3tUMXs477+ZXAdYDCo8bEXBGJZti/bYnVs6/mpLW9Nj8hmsB+bdpF0JfE5d4/UFnhubf9i@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwFbBnT2lf5ynmcP6eptjjtykDRcxjhDmIJEDtGDUW/srJaF6yF
 BID2xkzxEOOeKpW9D/5cENhZ5IKtnqeMnDDCZy98lzFavy/mYe6RG5MgHi4dcm+JOrk/iCH5blv
 tDglhWELq5yJenBsmi+ldBagzo/k=
X-Google-Smtp-Source: AGHT+IHRDWa6IqnSA2gXgHPitGNm1bmNiVoKsWUiIkpkgmkklg1AB4oNQkolg8JKkg/GnudFZ8zLbNf+9fPmpZUsBEI=
X-Received: by 2002:a17:90a:e291:b0:2d3:b598:8daa with SMTP id
 98e67ed59e1d1-2e1e631b1a8mr1453982a91.4.1728051355232; Fri, 04 Oct 2024
 07:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240924095145.2281-1-tursulin@igalia.com>
 <20240924095145.2281-3-tursulin@igalia.com>
 <6a7005b4-6af3-48e3-be65-353ffb5961f5@amd.com>
 <3e1ad979-a11e-43bd-8488-52712b58cec1@igalia.com>
In-Reply-To: <3e1ad979-a11e-43bd-8488-52712b58cec1@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 4 Oct 2024 10:15:43 -0400
Message-ID: <CADnq5_MgTQxMwmoB2_XDFGqwma7=mqKhUPnhcRJ5YJrGk2wSFQ@mail.gmail.com>
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

Applied.  Thanks!

Alex

On Fri, Oct 4, 2024 at 3:28=E2=80=AFAM Tvrtko Ursulin <tvrtko.ursulin@igali=
a.com> wrote:
>
>
> On 24/09/2024 13:06, Christian K=C3=B6nig wrote:
> > Am 24.09.24 um 11:51 schrieb Tvrtko Ursulin:
> >> From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>
> >> While loop makes it sound like amdgpu_vmid_grab() potentially needs to=
 be
> >> called multiple times to produce a fence, while in reality all code pa=
ths
> >> either return an error, assign a valid job->vmid or assign a vmid whic=
h
> >> will be valid once the returned fence signals.
> >>
> >> Therefore we can remove the loop to make it clear the call does not ne=
ed
> >> to be repeated.
> >>
> >> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >
> > Oh yeah that's a leftover from when we still had the dependency handlin=
g
> > inside all this.
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the wh=
ole
> > series.
>
> Thanks - CC Alex if you could merge the trivial series please?
>
> Regards,
>
> Tvrtko
>
> >> ---
> >> I stared for a good while, going back and forth, and couldn't see that
> >> the
> >> while loop is needed. But maybe I missed something?
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> index d11cb0ad8c49..85f10b59d09c 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> >> @@ -356,7 +356,7 @@ amdgpu_job_prepare_job(struct drm_sched_job
> >> *sched_job,
> >>       if (job->gang_submit)
> >>           fence =3D amdgpu_device_switch_gang(ring->adev,
> >> job->gang_submit);
> >> -    while (!fence && job->vm && !job->vmid) {
> >> +    if (!fence && job->vm && !job->vmid) {
> >>           r =3D amdgpu_vmid_grab(job->vm, ring, job, &fence);
> >>           if (r) {
> >>               dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r=
);
> >
