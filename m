Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C436ED10F57
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 14:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71B5B10E63D;
	Wed, 26 Nov 2025 14:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iKsHOeHW";
	dkim-atps=neutral
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5D1910E646
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 14:46:47 +0000 (UTC)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b983fbc731bso752553a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764168407; x=1764773207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a7VniV7sYFYJMoEO+5/aK+ynqkXfB2us8Nn3hVqkTdg=;
 b=iKsHOeHWEK8hTvUcXx0wmedhDR+0bMsku1E5ZnOnZLOOSLRpjCOpZmEQzyrBHVclXe
 PRxm7WLhP2eB2lH7dSZaQTjzpdt/p92HYsIm/OJfLfE3M+V8S1h5uEwXdG5g+ME389xA
 WLXVwsMYPo20BTYzuU/u5d2sf/vyqJBqQGgbAKLJ6aJqu9e0b8lrm+8gXq538kOo5wTL
 mEM5B3F0B6oI1S/K2Ni/m3YYkGpRmkWanJof684G4GYcr6rGYCrOEOkG411x3hCJi7xw
 Zf1l1Nu5uSP6FWjnwq9QHmAh+4yUd76dcZNbitM9m1vu8SRM7QTBAW+z8O3z+fAzGBCw
 GwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764168407; x=1764773207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a7VniV7sYFYJMoEO+5/aK+ynqkXfB2us8Nn3hVqkTdg=;
 b=AukQ5YiXaNDDCGAkUSLIOk02LKa6dnTKhiJ4x0QxyrwwwCWs+9I1pOLP6RzikoSQng
 GBeq0JxWZeXrH09G0QPyQgzpCATS2lYCXHolobH9JDQaePKSqbj+LCqSbJJJrUIAjMwM
 kduQ6jMnmQhP7469HClWU1E31eu4AUwydpdaVtI88GOtRsAHHiOz15viooD6JcF+xIEf
 DDEMVe34UFVSDY/e8j2ipYny3hfEVxMBcXGclkzZLRWNdxewSyzPNSSJCwvdw+qrBH+/
 BVf4v5t2o8pbmwF7f8V+HeaPiBJ+Uic/+18ovVIVKZRgDk0UEDvuwvpiRZLYskXbJEEL
 ljFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB4aXf2vr+1nmTqAhgBiBEuVJoX3nVZVEs65W/WgUau78QPiZzsJ5+UsrNrhoE9J2foRPWFDS3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ8tcpgWa1ZU2jJwt75ztRl1evc8hRyx30jHoNejdW5cpEL+rj
 kUs4S1mHS+pDMwdgNzwYWZ0HJ5CvYWL0AtVUCZii+B6RGaAHB7Qc1EnhZZnBlzVe5lhOI8BtTvJ
 bpK8BJNk8+fpm3hM8RytaeqAbBtfAjKcHmw==
X-Gm-Gg: ASbGncsv/iJHsNQM/ZuhZxUhp6Z7at2PjjErVKSUHhocXYq5l3AUSwINOX6mPUe8L9O
 5Wqv7AXlaFwt1HjCa7oZVaKnF2mJgUwmrLE5mFx8WAHVuPkqySeawtjwmSwuVy7kXPtpjtnDFAU
 naAKZmfk+nIpwhDhm/kEM3TeF5xgUMrHYRd0oie97YM3qA6G749vZgjHwiaDykvXsRvYKBuw0yn
 Bw2bJ8pzZLI8T1Ix6tzOvN1Q+lropv1R1YFSkJDegpzlipoHHhMRJX86Pbk8PysxF+eh0o=
X-Google-Smtp-Source: AGHT+IGSBhLEGtalWFCmTTF/BxYIXpuRmJFJKsKcYCvU1fw8cP7A3hktZKnFfrBFLP1+F9oWHvqmIY/+hL7Jtk78jnk=
X-Received: by 2002:a05:7022:3c09:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-11c9d875313mr8006056c88.4.1764168407154; Wed, 26 Nov 2025
 06:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20251126132952.150452-1-timur.kristof@gmail.com>
 <b4747792-6f2d-4875-88e7-5ed953f94fd7@amd.com>
In-Reply-To: <b4747792-6f2d-4875-88e7-5ed953f94fd7@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Nov 2025 09:46:35 -0500
X-Gm-Features: AWmQ_bk5tiulVNkBQph8q_ntfj0fG66bicWDdM7-kN86XpOe4M1OR0GsjcGz7QA
Message-ID: <CADnq5_OQz+icin-nO7Zy9qMOB97sw-igm-2f8UPPgx5N7z8Y1g@mail.gmail.com>
Subject: Re: [PATCH 00/10] drm/amdgpu: Improve page fault handling on GMC v6-8
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
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

On Wed, Nov 26, 2025 at 9:29=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/26/25 14:29, Timur Krist=C3=B3f wrote:
> > Enable the soft IRQ handler ring on SI, CIK, VI and
> > delegate the processing of all VM faults to the soft
> > IRQ handler ring.
> >
> > Why?
> >
> > On old GPUs, it may be an issue that handling the interrupts from
> > VM faults is too slow and the interrupt handler (IH) ring may
> > overflow, which can cause an eventual hang. This is a concern
> > especially on SI and CIK where there are some HW limitations
> > regarding robustness features with some shader instructions,
> > which in practice means that users can see thousands of VM faults
> > during normal gaming use even when the game or the UMD don't do
> > anything wrong.
> >
> > With this series, we spend much less time in the IRQ handler that
> > interacts with the HW IH ring, which significantly reduces the
> > chance of hangs.
> >
> > There are also a few misc improvements to the GMC v6 code.
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com> for the enti=
re series.
>
> @Alex do you want to pick that up for amd-staging-drm-next or should I?

I'll be off the next few days so if you can pick it up, that would be great=
.

Thanks,

Alex

>
> Regards,
> Christian.
>
> >
> > Timur Krist=C3=B3f (10):
> >   drm/amdgpu/si_ih: Enable soft IRQ handler ring
> >   drm/amdgpu/cik_ih: Enable soft IRQ handler ring
> >   drm/amdgpu/iceland_ih: Enable soft IRQ handler ring
> >   drm/amdgpu/tonga_ih: Enable soft IRQ handler ring
> >   drm/amdgpu/cz_ih: Enable soft IRQ handler ring
> >   drm/amdgpu/gmc6: Don't print MC client as it's unknown
> >   drm/amdgpu/gmc6: Cache VM fault info
> >   drm/amdgpu/gmc6: Delegate VM faults to soft IRQ handler ring
> >   drm/amdgpu/gmc7: Delegate VM faults to soft IRQ handler ring
> >   drm/amdgpu/gmc8: Delegate VM faults to soft IRQ handler ring
> >
> >  drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 10 ++++++++++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c   | 20 ++++++++++++++------
> >  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  6 ++++++
> >  drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 10 ++++++++++
> >  drivers/gpu/drm/amd/amdgpu/si_ih.c      | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 10 ++++++++++
> >  8 files changed, 80 insertions(+), 6 deletions(-)
> >
>
