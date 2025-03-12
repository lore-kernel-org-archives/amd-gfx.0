Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95518C28B28
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 14:18:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42D2210E711;
	Wed, 12 Mar 2025 14:18:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B8iibMI5";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5758910E711
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 14:18:03 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff5544af03so1792514a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741789083; x=1742393883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DovRau9dELCBxxkbzrSgJKJSLnHvbn5fKC70WeT30jA=;
 b=B8iibMI5qFKE9uCCGQWMVPLHn3k8ciF6ozmk3D9JFymv/+jvZM4ZK+sAAH3WVep5pM
 6PHKxE3yNXKsSCLJWbhfYZlUEataw2pfPOhsEDW+1UkvBZeXiDPSWdToY3O4y26gZk/H
 yh6T3VaHjRai57yVRHWYjaWinustIQ9vWHxRQo88obx8IOddeasS0tZlZvrgGHfTl7Du
 ocW6CciEoKCxHljCg02IzPCX9aZGBC/YD2VI8CnCIrjpu2HFkPf4/ZR47qrxxhL4qW4C
 PnaLF1dbDYj/fpNiqnudJv1sfAfReKaAHuYtRjmeWLZ6ww6sOjcdJbp8ZE4YMbfU5ibA
 tQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741789083; x=1742393883;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DovRau9dELCBxxkbzrSgJKJSLnHvbn5fKC70WeT30jA=;
 b=lf+Y7n+D2N+yeJtMPPZxr84+q/KmveYbmAT7XgomkRM/VQAO0C1JUXx+ZE9r8ZPXkx
 r6Ikyg4Uek55qsev0/dGNB00N0OwRU6aZWAXloZH+hSD1IaXmKRHJVkbZdi1j2oa1EhE
 +YmR/GLjXp4fi6frK7HNoiHwjNbAnPsdjUZqhnKYKAMQqB7hJff2JCHW2rybc6nE+9U1
 Tk+lrxHOHBZP46R6G2f+OkfHIDpKTuUsMrfppbPjJdMVpbb7NTSZnMS9BtwPXrDmE/YQ
 UWCJjv2BDzf/gn6frNJiBv1MR/gP2kFWDVU9RJ1qyGGkd7iA+wXVvUQkDiUiRUPjoXSA
 uF5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCNdjvMBmdiW/ByAoTTm3545wVBaLg5GfWxtukdFwY+Zukf63K2BegOc8LrbG5zq8KhlkhO75o@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDBjqyICYlGLZpOPl3V79Q4qkUtjR5FvTCUYQBuO7UMBP+rhxM
 B1SjE9zIALqgRKeirpcJ/9gtmy9TpJ3QIdHHd7O0p62Vl03pQqTRSOiCfbSU5W5sW+WSZJHVb2w
 bN3hcgJdMox5N57vgmbl38ya1pX6odQ==
X-Gm-Gg: ASbGncuTOcsiegXX9rU+mmp3rJ5E+XSC9k/nHiIcaJrRMOTaIbEvlF1PzXFAGI35945
 KocbVUFkCstuj5w4+N/o23pt9oIbE9XjPN4DqfPFZm0I4bzCjvsT3gjruWz3lw9Y79h1P/88LAY
 Uyj4vDu93ngCCOXNWdBBeIvAlFOw==
X-Google-Smtp-Source: AGHT+IF8qGfQdmI20Q5hxd1NmfEfSAgEvD7LiSNmQBuP/XLscnDTmdM8UudYCjTkNrnJ/N9A2wPoNufrv9lh1LDoLh0=
X-Received: by 2002:a17:90b:1b0a:b0:2ff:7b41:c3cf with SMTP id
 98e67ed59e1d1-300ff8b8a6fmr3923599a91.4.1741789082698; Wed, 12 Mar 2025
 07:18:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250311141711.1911564-1-alexander.deucher@amd.com>
 <BL1PR12MB515858DD811E9D3FEC3C71938ED02@BL1PR12MB5158.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB515858DD811E9D3FEC3C71938ED02@BL1PR12MB5158.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Mar 2025 10:17:50 -0400
X-Gm-Features: AQ5f1JpblDcNNDHXvujNlMtFf0a1ibIWIOVKv3AhnFy9hkw71RP_Gs7Z3IgALV0
Message-ID: <CADnq5_NqJtNvNu+ecYF61c-KJ5d4dS8mfYiamKEWY1krUxRNEA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based
 profile handling
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
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

On Wed, Mar 12, 2025 at 12:55=E2=80=AFAM Feng, Kenneth <Kenneth.Feng@amd.co=
m> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Alex,
> I tested this patch. After the desktop is launched, at a certain time, th=
e workload is set to 3d fullscreen twice, then
> The idle worker can't set it back to bootup default.
> Is it expected?

Not expected.  It was looking correct in my testing, but I think I
have a better solution.

Alex

> Thanks.
>
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Tuesday, March 11, 2025 10:17 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <Ke=
vinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH 1/3] drm/amdgpu/gfx: fix ref counting for ring based prof=
ile handling
>
> Only increment the power profile on the first submission.
> Since the decrement may end up being pushed out as new submissions come i=
n, we only need to increment it once.
>
> Fixes: 1443dd3c67f6 ("drm/amd/pm: fix and simplify workload handling=E2=
=80=9D)
> Cc: Yang Wang <kevinyang.wang@amd.com>
> Cc: Kenneth Feng <kenneth.feng@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 28 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 984e6ff6e4632..90396aa8ec9f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2142,12 +2142,25 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(st=
ruct amdgpu_ring *ring)
>                 amdgpu_gfx_kfd_sch_ctrl(adev, idx, true);  }
>
> +static unsigned int
> +amdgpu_gfx_get_kernel_ring_fence_counts(struct amdgpu_device *adev) {
> +       unsigned int i, fences =3D 0;
> +
> +       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> +       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> +
> +       return fences;
> +}
> +
>  void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)  {
>         struct amdgpu_device *adev =3D
>                 container_of(work, struct amdgpu_device, gfx.idle_work.wo=
rk);
>         enum PP_SMC_POWER_PROFILE profile;
> -       u32 i, fences =3D 0;
> +       unsigned int fences =3D 0;
>         int r;
>
>         if (adev->gfx.num_gfx_rings)
> @@ -2155,10 +2168,8 @@ void amdgpu_gfx_profile_idle_work_handler(struct w=
ork_struct *work)
>         else
>                 profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
>
> -       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> -               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> -       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> -               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> +       fences =3D amdgpu_gfx_get_kernel_ring_fence_counts(adev);
> +
>         if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, profile, fals=
e);
>                 if (r)
> @@ -2174,6 +2185,7 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgp=
u_ring *ring)  {
>         struct amdgpu_device *adev =3D ring->adev;
>         enum PP_SMC_POWER_PROFILE profile;
> +       unsigned int fences =3D 0;
>         int r;
>
>         if (adev->gfx.num_gfx_rings)
> @@ -2181,15 +2193,17 @@ void amdgpu_gfx_profile_ring_begin_use(struct amd=
gpu_ring *ring)
>         else
>                 profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
>
> -       atomic_inc(&adev->gfx.total_submission_cnt);
> +       fences =3D amdgpu_gfx_get_kernel_ring_fence_counts(adev);
>
> -       if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> +       if (!cancel_delayed_work_sync(&adev->gfx.idle_work) && !fences &&
> +           !atomic_read(&adev->gfx.total_submission_cnt)) {
>                 r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
>                 if (r)
>                         dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
>                                  profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
>                                  "fullscreen 3D" : "compute");
>         }
> +       atomic_inc(&adev->gfx.total_submission_cnt);
>  }
>
>  void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
> --
> 2.48.1
>
