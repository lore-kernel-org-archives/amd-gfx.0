Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF264CFD313
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 17:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463010E30E;
	Mon, 24 Nov 2025 17:00:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ehm7B/OH";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D7F10E310
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 17:00:32 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-7ab689d3fa0so539238b3a.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 09:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764003632; x=1764608432; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5+07sI1jmTiqtdmgsqPFnBoQvREXcQ5XyKFGFT4H4n8=;
 b=Ehm7B/OHqGnKizD0WWv2bB1agiudXPPT/lwRc2uL8GrRBOdm2KEatTznqUEwJNnsOI
 mf77xnImvOdBwh9tm5JW/tAeDqzZ6572HnUcOQZYlPt/xIYi/gNSXutoLtCxhbv9FfQu
 kv+vdXVYOeZF7bBWv8kSFlvFbqaSPtjwDpy6VXf4JT+kr+nH/Ll2adPABL1Ofv/fmMQo
 7W66lMAUHSHR60kXvptwRMDa9zd0H4UsiESasQWcDTcuE1EsGQxrB+vCdroFhNa7XFJA
 sEhdm3lfFNepjqC4SEibHi6N3m06Klr4JKAquD6648ue3mDppGXV9cz3alfUt86JNScW
 rZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764003632; x=1764608432;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5+07sI1jmTiqtdmgsqPFnBoQvREXcQ5XyKFGFT4H4n8=;
 b=R+UqJE4eTeGF1FG1m0Zoqhc1gRw9KGP+mBY4S1Yb2bMFxaYWKzGhhQgSeli/F3U0n7
 aUG4Z4a2vABU3uVNIdrQS8ymoi/NHcExv5sMP7PjEzzsGztHRRjPCYbryX+RaatRbQ7k
 mcUWiTIwObSz7fAEHFA+V8tYh0ifH37VHNBvFPz0ksE4WSfQGr6xo7LyjpqIYaZT440s
 k1U2V4DL+KYbK36yGm8hho02WAXdyQgxHqqURwafWY85POH39AUY60HQBqsY175Cs77E
 CrIKF+YNk2f4Ir68XwAO771VpekbqdiP3J+yRqTVKX/5elFTkNNfsS25O/6KuntbAV+b
 SkqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEPrDKo0yY+1oexvcUlXUVImHoxFlESmTbCKcbwn/P+p7uZUinT2wLNSKtfNJqjojF+LdOt5Pu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz68CUvgmD9uI92r/R3fusJWf4zOjx0Ri/Qai5VAzDnKI/bekFB
 cich7yf7IweVdOwvyFVBohBFepU5CQfsdv3wFQfPjU52UVEx59COQ4SfMYLjl43zTvsn8uqT7qL
 +I7yaTAnvh+YS6eAMaJX52D+4LR+DFw/kdA==
X-Gm-Gg: ASbGnctDcKWuADYC1QIUa46O8R7S5aIgOKsR9nlRedMDz96QCeFO4WOrAOqT1Crjd43
 bVee4rXjursr0T2Mg7C4rrA5hjtw5LVsLbVjxsRCuvs5HsBgd7r3ejopsDgRzYUINBgQOlwjVkz
 7MkcNq7cQdc9Z9v4g4HjJ5u0rCrLnkLXFh4M8K2Z0j8MNJ2qp7GvLqLKN1rDFNsx2ZHykkxcYI8
 ZF+pItWocIgPylFY7RMGyqC5bBiGIfmCjtspaXq5FvMXcWwGwm7A827mK2CQqTDS0p15xY=
X-Google-Smtp-Source: AGHT+IH0bxO+rLSo8ZV5ToGoamqOSwZt9kWMFznXSJhOGP5uBimsN1SMbLsZ/76UkjiFdtVKGnCIY1sDMI70ddgT+b8=
X-Received: by 2002:a05:7022:441c:b0:119:e56b:c3f5 with SMTP id
 a92af1059eb24-11c9f38e94fmr6066643c88.5.1764003631612; Mon, 24 Nov 2025
 09:00:31 -0800 (PST)
MIME-Version: 1.0
References: <20251124163615.6388-1-pierre-eric.pelloux-prayer@amd.com>
 <20251124163615.6388-2-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20251124163615.6388-2-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Nov 2025 12:00:18 -0500
X-Gm-Features: AWmQ_bmY2SH9XIQVf7sd2ArHJctl1Zx6871JnFEGWQl00z-o6miHb19uzQgBuyI
Message-ID: <CADnq5_M0u3s-hVaZu63sSMsj_mTBAPGyS3QHkAbgAC6OqHi-hw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/amdgpu: free job fences on failure in
 amdgpu_job_alloc_with_ib
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Mon, Nov 24, 2025 at 11:44=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Otherwise we're leaking memory.
>
> Fixes: a35c520c1611 ("drm/amdgpu: clean up and unify hw fence handling")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 2fc3d9da0fe7..91f1232b7d41 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -246,6 +246,8 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *ad=
ev,
>         if (r) {
>                 if (entity)
>                         drm_sched_job_cleanup(&(*job)->base);
> +               kfree((*job)->hw_vm_fence);
> +               kfree((*job)->hw_fence);
>                 kfree(*job);
>                 *job =3D NULL;
>         }
> --
> 2.43.0
>
