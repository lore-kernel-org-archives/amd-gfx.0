Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDEFD2FFFA
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Oct 2024 15:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2F3310E148;
	Fri, 18 Oct 2024 15:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4unXJa8";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6D5110E148
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 15:48:11 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2e2af4dca5cso393529a91.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Oct 2024 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729266491; x=1729871291; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wJTv+exjLNuwkKZ7IsieDzYtlyORO+GIjOnAuHVDfA8=;
 b=f4unXJa8CpjDs0BRPujU51yVF9MOiV0d/iFxDCG8VBt9QbbPi6RKvl1EvjDKo36gnO
 QUik1ACEa4UqAXoMu4gmNVxlwFq2otkA8r+6bUohog3K66pSqslF5Bq1tU4xuFOvDo7K
 4aB8+O5I7ERKyJiF+PSc6pZlwfqlQZwtFdXVm99hHBDZJYpo23wZFO5RDxAvctv6aNYw
 +VpTFsgRpWdXkVjy8a4HTIU4JkQSVHuDCLlXTyo2Rb2IPk0RlUTGZNS1XnSij71GocUT
 N/bVzxfve40kmx5FmbdfI1qd6ND/4Jt6k779DnLbHeFb+Dcuh1ZRCqM0v/GqUIEI9qBJ
 AQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266491; x=1729871291;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wJTv+exjLNuwkKZ7IsieDzYtlyORO+GIjOnAuHVDfA8=;
 b=Zs6qaK0PQZd34G3hLwgHB9vSLoNSDpjU4UkmFmXds+GRCRA1scwbmAUMiqknQYPu6H
 20g8Rg2g79cw2adxe7uV8irgoalOvr/DPuFTG9tkOuTiNKFVt0WDD26lwxzaXGES5R/n
 IXGNP47OB3IZKggucCaXK/1JNrc4GyfHQtxjYRc8W+LL4NKmUIcPVxgrwW3kQf9ENPo/
 +7pIm7VFFZZTObkr21VqmBFJl6uYJi5Ojmf0vXbF+Q1uvAk6nns0rxVZlcGLKWfNeFSj
 vNgQ50Vgt30AIxfrFkAFAb/enuOALOKMU/bfK7NbtOvjg/G6hkFO16ltRb9x57As2Tuk
 J1Gg==
X-Gm-Message-State: AOJu0Yx8MlbRIbOfluLZBtPoqxSAEj7WJOXH4kD12zcPLjAtII3TvDjB
 FAzUGkKXIAILOg+XPsJ1N77E49oVWRIiMp9539zFBQxqP8UQfnLQoGFjo/h/wjaFw9bFYCU6ql6
 W5IxFhE4JngqS+gL8frGLwG+fX5TmjQ==
X-Google-Smtp-Source: AGHT+IFQ5VDeuti/wjM46O2ODm+zuVTGaXEUWP9eo3lnf/cZC4/yZmRZFkN7Re6vB1M1wIaBKuyh5MbSPg9cglcdpYg=
X-Received: by 2002:a17:90a:e296:b0:2e2:de92:2d52 with SMTP id
 98e67ed59e1d1-2e561a58096mr1482283a91.9.1729266491051; Fri, 18 Oct 2024
 08:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241015181541.2457526-1-alexander.deucher@amd.com>
In-Reply-To: <20241015181541.2457526-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 18 Oct 2024 11:47:59 -0400
Message-ID: <CADnq5_NHmJpZLbbrEsN75gkLOctFtS6nyNBHfgM-0=EpdyKFcA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add ring reset messages
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Tue, Oct 15, 2024 at 2:28=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Add messages to make it clear when a per ring reset
> happens.  This is helpful for debugging and aligns with
> other reset methods.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index 102742f1faa2..2d60552a13ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -137,6 +137,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>         /* attempt a per ring reset */
>         if (amdgpu_gpu_recovery &&
>             ring->funcs->reset) {
> +               dev_err(adev->dev, "Starting %s ring reset\n", s_job->sch=
ed->name);
>                 /* stop the scheduler, but don't mess with the
>                  * bad job yet because if ring reset fails
>                  * we'll fall back to full GPU reset.
> @@ -150,8 +151,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>                         amdgpu_fence_driver_force_completion(ring);
>                         if (amdgpu_ring_sched_ready(ring))
>                                 drm_sched_start(&ring->sched);
> +                       dev_err(adev->dev, "Ring reset success\n");
>                         goto exit;
>                 }
> +               dev_err(adev->dev, "Ring reset failure\n");
>         }
>
>         if (amdgpu_device_should_recover_gpu(ring->adev)) {
> --
> 2.46.2
>
