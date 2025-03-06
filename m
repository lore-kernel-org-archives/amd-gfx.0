Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2816C282D1
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 21:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60ECF10E2DD;
	Thu,  6 Mar 2025 21:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ioC1JX/V";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC5610E2DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 21:10:13 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fd02536660so287433a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Mar 2025 13:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741295412; x=1741900212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJePKaLsT26p5riWUnWvqNuiXz+d7DdkzFfvuJu+uN0=;
 b=ioC1JX/VJN/JSBDocZWvryfRqVxs54zcTuXUtCScgAmKd3/PSSpHiZnkR7tJQfI96A
 HOUZC8yBFIgaaobOVGn9iXClhNmdNXQh3nErKAP3QvnQ7+Yw07UvvZtFxolv8iaCbe44
 slYyMFFxt3t/2Yz9lb5Rta1/Mqhn9lWS0onFd8XKm3gTpkhIOe+YFiuFqknWU6/5Ygpi
 qA0LJG3vfaBdqlHXIhbGjRbyGoTssa2FwkjYQbNf3mY8urJluq775r9Wsi8whowxrlFQ
 2cuDk6xeKSwoZOPb1lgGTNdNsdyodB4jc1DhMUp7QKsLqabPEudWi21bvYR0XcDfSCwd
 uOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741295412; x=1741900212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJePKaLsT26p5riWUnWvqNuiXz+d7DdkzFfvuJu+uN0=;
 b=jV56+wnL95m0cXUs41vQCx/pBhJM8qXEEoc877geceilIL4SFQziSy8Cp9SL8BYxE4
 ThmRUi85cMYpbzc1O0DWtxblDjONxr9mYTsfD+pV/tCFcwCeFtj6BKF/nc4TPLKBXJoU
 ojJhgc9pC636Fcu1H1bUoHljo75kRVlHTsWrMBj89JDObYB/zHjcGqsrAygDS9QxiACf
 2pW5p7ydx/0lHLeZ8od+TBE/xK15NB3ycCVta+mH7FnRFF+Awk3GoolSGETxENf4rFNV
 Xm3g2fZnjnFenqnyVzL/TWzyhE1WNILHFbt1IGRh092E6Fc00A1Y3q6MK65k+fbPTpDn
 NQyg==
X-Gm-Message-State: AOJu0Ywl5hY9bdV4B6HMUzXB3n2m4g2jw40Vj9PuWP2kHZdRm7+TjcPO
 JFI+xtkW2ouwU5aVpY4QOIeCoJTl7yCluMVNpbYRXdDGKVEDZiF375tAA5Rre0nnyd/amSbnBhr
 RUpgVot5gN2wqPpb32Egv3Lwf+hQ=
X-Gm-Gg: ASbGncs8HiIoors9An9dpjuO8KaoYcFxvsfJVUJNqPTAux/thvOsvt37Fj2QriNeQ/z
 1Jgj5BM8YPqzUfI0RX7ERXMYdAUYMtM9aA8jrrkLOnHiDJFWL4d97V2yGSR3C+HMAeEjlAt3DfA
 bsSaXrUbuyB3pQ3yrwUhHxfkqM6A==
X-Google-Smtp-Source: AGHT+IGoRynRzDpzllUqg8FtTvjhOKVwVQ9Wy3aijmrrF1GGciK2TvX0zpINoPYLq2BxjGLYVFJ9lK2kwGFlfMmsvE4=
X-Received: by 2002:a17:90b:1a8c:b0:2fe:a747:935a with SMTP id
 98e67ed59e1d1-2ff7cf1ec8dmr454149a91.4.1741295412275; Thu, 06 Mar 2025
 13:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20250306185124.44780-1-mario.limonciello@amd.com>
In-Reply-To: <20250306185124.44780-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Mar 2025 16:10:00 -0500
X-Gm-Features: AQ5f1JqI0RXG1JkMFo1Aq2bazrHC-pc-tuTcSmWNYAQh743GENST01uiQ2hnZDY
Message-ID: <CADnq5_NDS-rmDXM_z=2zPiodX+PiWmdOGGB=SBymVJ1OujY1hQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Keep display off while going into S4
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>, 
 Muhammad Usama Anjum <usama.anjum@collabora.com>
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

On Thu, Mar 6, 2025 at 1:51=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When userspace invokes S4 the flow is:
>
> 1) amdgpu_pmops_prepare()
> 2) amdgpu_pmops_freeze()
> 3) Create hibernation image
> 4) amdgpu_pmops_thaw()
> 5) Write out image to disk
> 6) Turn off system
>
> Then on resume amdgpu_pmops_restore() is called.
>
> This flow has a problem that because amdgpu_pmops_thaw() is called
> it will call amdgpu_device_resume() which will resume all of the GPU.
>
> This includes turning the display hardware back on and discovering
> connectors again.
>
> This is an unexpected experience for the display to turn back on.
> Adjust the flow so that during the S4 sequence display hardware is
> not turned back on.
>
> Reported-by: Xaver Hugl <xaver.hugl@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2038
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 11 +++++++++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b161daa90019..b54c4b2f3f7f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2565,7 +2565,6 @@ static int amdgpu_pmops_freeze(struct device *dev)
>         int r;
>
>         r =3D amdgpu_device_suspend(drm_dev, true);
> -       adev->in_s4 =3D false;

I double checked all of the places that check in_s4 and I'm reasonably
sure moving this around won't break anything.  It looks like we only
really are about it on the suspend/fini side.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>         if (r)
>                 return r;
>
> @@ -2577,8 +2576,13 @@ static int amdgpu_pmops_freeze(struct device *dev)
>  static int amdgpu_pmops_thaw(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int r;
>
> -       return amdgpu_device_resume(drm_dev, true);
> +       r =3D amdgpu_device_resume(drm_dev, true);
> +       adev->in_s4 =3D false;
> +
> +       return r;
>  }
>
>  static int amdgpu_pmops_poweroff(struct device *dev)
> @@ -2591,6 +2595,9 @@ static int amdgpu_pmops_poweroff(struct device *dev=
)
>  static int amdgpu_pmops_restore(struct device *dev)
>  {
>         struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +
> +       adev->in_s4 =3D false;
>
>         return amdgpu_device_resume(drm_dev, true);
>  }
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 6f9331fe91c3..5939796db74c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3431,6 +3431,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_bl=
ock)
>
>                 return 0;
>         }
> +
> +       /* leave display off for S4 sequence */
> +       if (adev->in_s4)
> +               return 0;
> +
>         /* Recreate dc_state - DC invalidates it when setting power state=
 to S3. */
>         dc_state_release(dm_state->context);
>         dm_state->context =3D dc_state_create(dm->dc, NULL);
> --
> 2.48.1
>
