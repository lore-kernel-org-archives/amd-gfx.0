Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAB2E77197
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jan 2025 17:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75E8510EE51;
	Thu,  9 Jan 2025 17:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VnwKANlO";
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0EAC10EE51
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 17:04:25 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ee9b1a2116so224925a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Jan 2025 09:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736442265; x=1737047065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SsZi6r/XeZUzAZahJ3GzZo3CPnk9Dv25wlYZRXrlHTY=;
 b=VnwKANlOt6gWFno20DBgrU2ItczYfhBkirVfKEPxNDPPvtSAgu8yS8VTMPjlhZmxD/
 X0PuR9h+LxNQqm11fAqDtPOHcmvBJ5sK8pPJWx73H3/7QZIuk2zELt05WGjitUdUeaN2
 i5S+/mQpePQfG6ykQhCQLs3Eo/cDLI/MbPcZ+REHNLSTmZHKJ8Z85WAR9Roln3odMChZ
 h5643VKJP47yH7en/eYqKWHnmVHfmJmvGZFK808DqvbH6K3Ql7h3fbvF/6Zeiq4XN0uk
 Z+GyGEgdjQZTbUxgFhQMb8SH3cs3M60sw3Rs+Ve2r74BLznrcMu+xOQ3KlUPI+OAgHrW
 ubLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736442265; x=1737047065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SsZi6r/XeZUzAZahJ3GzZo3CPnk9Dv25wlYZRXrlHTY=;
 b=ttZMJ0s4/FbSJ/zSrGepnL/Rmx7OsiFoAAQmNby5YhcZwPQk+cjq29Es+Xnno/NzaX
 PJ1AExLqSPtcOmERptjnljdbHXeiXzqoOpm8jWP8wlveGu+eDGA1mBn7h9Hlq9p5POGj
 k5Gvg8fLyP1GVbvt15LbIxjpCQOIt5sp/XcDMkiq8XSZDMk/WMdJIYZtaeGlOehIT6nb
 Y0G3yU8QMSP5Y3nEGk1nywzafpw8ppEfFMvkz4iXkBNqXHLh2zsXhqiEVu6BMpGluPol
 bHMsyycGMADx6T1Sc+M5KWDUN36HJQF/uGrE2R2L0NtVzaG/K011ngjHtfrKbpMzT6ti
 QY3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUU2rtAv2VeXWHPPnABrSvpzbkAriq0xCm5EIqUyvvvISdN1PpzYg8bkM2edWyQpY3b/S2xcwQ1@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyb9xmWhq9U68ucMTD9frZG25VZ0IFgYtZKETwiLTOZJxXDxuX4
 VZGfvRNM9GRBSwg/SWoCPPG6FRm6FtK83nMNUTiPuTvpLAaJxTMvPYnsefACe7wGDkihEQOy3NI
 oCZZH8xK/loMxmHyyNlXLNiwEYkpvPw==
X-Gm-Gg: ASbGncuLPvGj+5uQm8LIyyK+9EmBDk5VhIrXcAvy3tJOp553mBkekugzz63pSMm6FB9
 nI5sFRIg5SPG0+HzIoaipyeNUTz+vXl/SGrKaFg==
X-Google-Smtp-Source: AGHT+IF8B3Hqp+M8IpjfAViy5BpECY+1+7TKaMYeOvQBaJXbCZSq/YbaWkqmY6tC1dqpuLKQeiad+cMSiGj9xiHnYUo=
X-Received: by 2002:a17:90a:da88:b0:2ee:f440:bb93 with SMTP id
 98e67ed59e1d1-2f548f2449fmr3915999a91.4.1736442265171; Thu, 09 Jan 2025
 09:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <DM4PR12MB5165AC72A93B485D3B07F7958E132@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165AC72A93B485D3B07F7958E132@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Jan 2025 12:04:13 -0500
X-Gm-Features: AbW1kvZtnXDYbF-hpZRLy3te-XHcuXFyyJ1NXUi_ON9OJDBvXOsYl9gXZ078aY0
Message-ID: <CADnq5_Of6kZ_uA6ceH6gtReaUoTZy-x9=1mzP8ABi+9rODrdMQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
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

On Wed, Jan 8, 2025 at 11:17=E2=80=AFPM Feng, Kenneth <Kenneth.Feng@amd.com=
> wrote:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> -----Original Message-----
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: Thursday, January 9, 2025 6:56 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workloa=
d profile
>
> Add helpers to switch the workload profile dynamically when commands are =
submitted.  This allows us to switch to the FULLSCREEN3D or COMPUTE profile=
 when work is submitted.
> Add a delayed work handler to delay switching out of the selected profile=
 if additional work comes in.  This works the same as the VIDEO profile for=
 VCN.  This lets dynamically enable workload profiles on the fly and then m=
ove back to the default when there is no work.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++++  =
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
>  2 files changed, 68 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.c
> index 6d5d81f0dc4e7..c542617121393 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use(str=
uct amdgpu_ring *ring)
>         mutex_unlock(&adev->enforce_isolation_mutex);
>  }
>
> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work) {
> +       struct amdgpu_device *adev =3D
> +               container_of(work, struct amdgpu_device, gfx.idle_work.wo=
rk);
> +       enum PP_SMC_POWER_PROFILE profile;
> +       u32 i, fences =3D 0;
> +       int r;
> +
> +       if (adev->gfx.num_gfx_rings)
> +               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +       else
> +               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
>
>
> [Kenneth] - there is KFD code amdgpu_amdkfd_set_compute_idle() to manage =
the compute workload, is it necessary to control compute workload here?

This only adjusts submissions to kernel queues.  If there are no KFD
user queues, then we wouldn't set the compute profile.  Also, at the
moment, I've only enabled this for gfx10 and newer.

Alex

>
> +
> +       for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_rin=
g[i]);
> +       for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INSTA=
NCES); ++i)
> +               fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compute=
_ring[i]);
> +       if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, profile, fals=
e);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> +                                profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> +                                "fullscreen 3D" : "compute");
> +       } else {
> +               schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE_I=
DLE_TIMEOUT);
> +       }
> +}
> +
> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring) {
> +       struct amdgpu_device *adev =3D ring->adev;
> +       enum PP_SMC_POWER_PROFILE profile;
> +       int r;
> +
> +       if (adev->gfx.num_gfx_rings)
> +               profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> +       else
> +               profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> +
> +       atomic_inc(&adev->gfx.total_submission_cnt);
> +
> +       if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> +               r =3D amdgpu_dpm_switch_power_profile(adev, profile, true=
);
> +               if (r)
> +                       dev_warn(adev->dev, "(%d) failed to disable %s po=
wer profile mode\n", r,
> +                                profile =3D=3D PP_SMC_POWER_PROFILE_FULL=
SCREEN3D ?
> +                                "fullscreen 3D" : "compute");
> +       }
> +}
> +
> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring) {
> +       atomic_dec(&ring->adev->gfx.total_submission_cnt);
> +
> +       schedule_delayed_work(&ring->adev->gfx.idle_work,
> +GFX_PROFILE_IDLE_TIMEOUT); }
> +
>  /*
>   * debugfs for to enable/disable gfx job submission to specific core.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 7f9e261f47f11..6c84598caec21 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {  #define AMDGPU_GFX_QUE=
UE_PRIORITY_MINIMUM  0  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
>
> +/* 1 second timeout */
> +#define GFX_PROFILE_IDLE_TIMEOUT       msecs_to_jiffies(1000)
> +
>  enum amdgpu_gfx_partition {
>         AMDGPU_SPX_PARTITION_MODE =3D 0,
>         AMDGPU_DPX_PARTITION_MODE =3D 1,
> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
>         bool                            kfd_sch_inactive[MAX_XCP];
>         unsigned long                   enforce_isolation_jiffies[MAX_XCP=
];
>         unsigned long                   enforce_isolation_time[MAX_XCP];
> +
> +       atomic_t                        total_submission_cnt;
> +       struct delayed_work             idle_work;
>  };
>
>  struct amdgpu_gfx_ras_reg_entry {
> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_de=
vice *adev,  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *=
work);  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring=
 *ring);  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring=
 *ring);
> +
> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring); void
> +amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> +
>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);  vo=
id amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
>
> --
> 2.47.1
>
