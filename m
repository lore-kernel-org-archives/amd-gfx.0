Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CBE7716B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2004510E4C3;
	Wed,  4 Dec 2024 15:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZvtr9d/";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC09B10E4C3
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:31:36 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-724d5e309dfso451577b3a.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 07:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733326296; x=1733931096; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kqFnzU/SC8/giuRAe8Fi38o6RK02v0lAi6f0szPWypA=;
 b=jZvtr9d/VPTa1fV9y2kIq+xyEkk0yj5wJcErIVBaB2Ag+38CTb4hjx0p+sNhT7FTz8
 NfnNw/kGwYIpHu930gnUve9AAqcBKnLJzknZryg68qBTydA9d8wURU8+dGY9gPryh1LA
 lm9kFoIXzHj/0+PmcELyzx9ulriZuomUN1y5k/FrAKsagWMk/maUtWbGJGcGA8kfKGIF
 zrQ6qTK7a2nnUAxoncNp4Gx+MMVl4OLExEv72c1TyW9Igq8/O4eD89PARfgENmid0k2H
 Gea8xG4DkTGK0RYwgdiFr7naBpg4chP6Ma0LBhetivI+iRdyuP4lmehYQhYSaxkeso4u
 zm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733326296; x=1733931096;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kqFnzU/SC8/giuRAe8Fi38o6RK02v0lAi6f0szPWypA=;
 b=o1IrThEF0a0hayBHRT144jUsI+HFEa580+cHBpuy3VZqqPVRqRaB7MsrIk6JYoxxyr
 tTahb2ppWnofxnw3mrIS4qyUp+mqCBu2nv9OuSkgJwIOgqzBRz4gF83ArED6UbmPwboe
 GoOCL7MoUWlqdFgQFCL3bpFj6UwHrhlEZfkJhhoZM+1cZT8BiNNAKSgqPaq1+4VLH86u
 jFqdj/S+pruxABaYue0V0iKIidBBWP11OayXcS0aZ8POGMXDNA+K8gsTvDZspJ7aI4hc
 noBTlEhrRaBXn2RS7wGSGZ9cb6uH5VrcTJ45VYR6H1Pfnw844yWAdYws6w8hXiyx8fVJ
 42Gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ+9LHq/8QdHJhMNyjsi1a30YfPfhhVKHu/WG2ieu99yCd6e3fxJp5zXcpLxzT4cxEzP36PJOk@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwT5ecSQinhTeXyQ+1FST1orAtlzUhbwSFn+Kwh+yP7zlbGxOMU
 qlkjP0aAcZBvWF6qOuD1A08xEUwmlIQS139qvJMMCjTwnIRUEtIjGDQ4vyJADpT8kShnSuUMlm5
 hqW7D//imA10FdHDhSrHMQ2XUCZPLmQ==
X-Gm-Gg: ASbGnctTFwXYrPkV+B8wCTGDnRYxC640R1RlWoMQMSnYGe2UgLbnXgrICKv02ratbLU
 sjnA9ISJu6mqtoW9O30+1aw1ZdR/u9nQ=
X-Google-Smtp-Source: AGHT+IGFyZTmY4lR3OMlBFMobCU80VOgJqUhO1fUaxOV8KG+Hgd409WhNK0H4EO5gJAOOPN1/BezZ6TivJzfujL9aDw=
X-Received: by 2002:a05:6a00:2d20:b0:725:1257:bbc with SMTP id
 d2e1a72fcca58-7257fcdd318mr4178348b3a.7.1733326295998; Wed, 04 Dec 2024
 07:31:35 -0800 (PST)
MIME-Version: 1.0
References: <20241127194350.2085774-1-srinivasan.shanmugam@amd.com>
 <20241202163103.1347287-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20241202163103.1347287-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2024 10:31:24 -0500
Message-ID: <CADnq5_PpWrYMAV8xRHnbWYdWp0tcyzMHTB+-hdJSgD85xpky+A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Add Annotations to Process Isolation
 functions
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
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

On Mon, Dec 2, 2024 at 11:42=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This update adds explanations to key functions that manage how the
> Kernel Fusion Driver (KFD) and Kernel Graphics Driver (KGD) share the
> GPU.
>
> amdgpu_gfx_enforce_isolation_wait_for_kfd: Controls the waiting period
> for KFD to ensure it takes turns with KGD in using the GPU. It uses a
> mutex to safely manage shared data, like timing and state, and tracks
> when KFD starts and stops waiting.
>
> amdgpu_gfx_enforce_isolation_ring_begin_use: Ensures KFD has enough time
> to run before new tasks are submitted to the GPU ring. It uses a mutex
> to synchronize access and may adjust the KFD scheduler.
>
> amdgpu_gfx_enforce_isolation_ring_end_use: Handles cleanup and state
> updates when finishing the use of a GPU ring. It may also adjust the KFD
> scheduler, using a mutex to manage shared data access.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2:
>  - Incorporated feedbacks for function descriptions (Alex)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index e54f42e3797e..b1b133affbf9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1940,6 +1940,17 @@ void amdgpu_gfx_enforce_isolation_handler(struct w=
ork_struct *work)
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_wait_for_kfd - Manage KFD wait period fo=
r process isolation
> + * @adev: amdgpu_device pointer
> + * @idx: Index of the GPU partition
> + *
> + * When kernel submissions come in, the jobs are given a time slice and =
once
> + * that time slice is up, if there are KFD user queues active, kernel
> + * submissions are blocked until KFD has had its time slice. Once the KF=
D time
> + * slice is up, KFD user queues are preempted and kernel submissions are
> + * unblocked and allowed to run again.
> + */
>  static void
>  amdgpu_gfx_enforce_isolation_wait_for_kfd(struct amdgpu_device *adev,
>                                           u32 idx)
> @@ -1985,6 +1996,15 @@ amdgpu_gfx_enforce_isolation_wait_for_kfd(struct a=
mdgpu_device *adev,
>                 msleep(GFX_SLICE_PERIOD_MS);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_ring_begin_use - Begin use of a ring wit=
h enforced isolation
> + * @ring: Pointer to the amdgpu_ring structure
> + *
> + * Ring begin_use helper implementation for gfx which serializes access =
to the
> + * gfx IP between kernel submission IOCTLs and KFD user queues when isol=
ation
> + * enforcement is enabled. The kernel submission IOCTLs and KFD user que=
ues
> + * each get a time slice when both are active.
> + */
>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *rin=
g)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> @@ -2012,6 +2032,15 @@ void amdgpu_gfx_enforce_isolation_ring_begin_use(s=
truct amdgpu_ring *ring)
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>
> +/**
> + * amdgpu_gfx_enforce_isolation_ring_end_use - End use of a ring with en=
forced isolation
> + * @ring: Pointer to the amdgpu_ring structure
> + *
> + * Ring end_use helper implementation for gfx which serializes access to=
 the
> + * gfx IP between kernel submission IOCTLs and KFD user queues when isol=
ation
> + * enforcement is enabled. The kernel submission IOCTLs and KFD user que=
ues
> + * each get a time slice when both are active.
> + */
>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring)
>  {
>         struct amdgpu_device *adev =3D ring->adev;
> --
> 2.34.1
>
