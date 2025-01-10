Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8C6E7719C
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 15:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B9EB10F0F5;
	Fri, 10 Jan 2025 15:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jpr9wHe1";
	dkim-atps=neutral
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5F210F0F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 15:03:16 +0000 (UTC)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8ac69faso4067245ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2025 07:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736521396; x=1737126196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M7andlCDqaKn4az1Mus781i12xpNcIcapGRNdLiClsI=;
 b=jpr9wHe1vdCMQZEDWA7nx2fmMPcVXr6GFPPC4QhuMUqSuzvW+zR9kStxfaKO6PJykk
 R2Xk582AFertXXwY2TNqrlkUywrSUzSaFnCAVLRD4n/15kXI4Xc4Yx2TVhyFgSdu5ZJv
 w7wkkhK8aTl853jCECDWUEXtuIU6NfqYqGhX09FRJn3NBoDspUpGUi/adTiX9nXkERnI
 Sq6vzhwui9cKeZo534lAopK1nQXQgFnMn+Mi1mWNmfQW6fep4hA4IE0tHE2pMPSoIWiO
 yTMveJlvuldeVt/uU0ufCgUwdNpGj2GzJ11kgob9Lw5vLdN1lU7XV09B2cI//8eXzhpM
 U62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736521396; x=1737126196;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M7andlCDqaKn4az1Mus781i12xpNcIcapGRNdLiClsI=;
 b=YXcv0vfbp+4gpvlFc8YZ47AcKtzZLq4XJfluShunEc4O3+L+H+HdLMu66PMuHIsXFe
 gTFcVJ6XMqWgX50rBDOYcH+8i4BWJAyxxGQzW0ui/FTMuJ4V47Vfr8kXQNQRNj0FAUcv
 d1x3lnOWo5SYnbR+ZsC5FUdMCrZfBuhu5av1H9U9OY1EBA/sNq88HRH/0F/k83KdP176
 Kn64qNBnJuQzg/U8uwBfuS8SuzaF+ijs5fX3kSiAMZ4DIZUe8B27hNTnz4C9G28O/21p
 NxIAg+aPRWTWTxZcIJfTY4aGpVngiQUE/e8xQelEsVdo3VLJK9Oce6cPZ1mSrnJzDWZV
 +axg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLJWxSAE65lOREd2OcN/b+dXbg8FLWZDaU9IjtnuSjt5e9z/mVr2ElNWRNBqi64I0aNB47qh6z@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmxrxFOG3BjyAy1BrDUJFU48VKl3d1X0e/ChIsH7dlbtEMXK7i
 TFr2yj/Rf5pwAuI1Qy+1SavXr9u4oCWGPPlQCephTm9dU7XSkRp9EJqCH7Z5pwzK3axaWrlIBZv
 9xeIL7zYMI5lLqAEQc6ncVV91YHA=
X-Gm-Gg: ASbGnctDRn/1jCPuuhrHjQoX5LKXGZAx/hjR2WwVprvfrpshO2C/kyotJweizXcQaRc
 XFd0bqSE48d/q7+Ynz0zHwJZ1Wb0QODm7y28AYw==
X-Google-Smtp-Source: AGHT+IHm8hFySDY1DaXzismGFaQKikOridoS3F+zHxzglFoNw7pmPjUO1lTgf+0hkdD8mhTDw/uORQ8NUWHihIaxn3Y=
X-Received: by 2002:a17:902:d582:b0:216:536a:9d3b with SMTP id
 d9443c01a7336-21a83f32f11mr61153965ad.1.1736521396179; Fri, 10 Jan 2025
 07:03:16 -0800 (PST)
MIME-Version: 1.0
References: <20250108225627.14063-1-alexander.deucher@amd.com>
 <589ecdc0-9f5d-4b79-b11d-01b6d22fbf15@amd.com>
 <CADnq5_NrJ7xqkxk-ccYnQeuVRoWuN95Wyq59UVYtdRUMVVqCvw@mail.gmail.com>
 <7bf342e7-72ad-4ed0-a45d-ad933db28753@amd.com>
In-Reply-To: <7bf342e7-72ad-4ed0-a45d-ad933db28753@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2025 10:03:04 -0500
X-Gm-Features: AbW1kvb1mA7Jq_LJ5KwyRsPEeRiAdc5yCBXwRrQvx4QJEMvys1FhXKME_HuLTMg
Message-ID: <CADnq5_N_S6Cv57zAgroHJ2e7KbvmQ_8QcPHrryEtatpaAWR87w@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/amdgpu/gfx: add ring helpers for setting workload
 profile
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 aurabindo.pillai@amd.com, kenneth.feng@amd.com
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

On Thu, Jan 9, 2025 at 10:30=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 1/9/2025 10:36 PM, Alex Deucher wrote:
> > On Thu, Jan 9, 2025 at 12:59=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com=
> wrote:
> >>
> >>
> >>
> >> On 1/9/2025 4:26 AM, Alex Deucher wrote:
> >>> Add helpers to switch the workload profile dynamically when
> >>> commands are submitted.  This allows us to switch to
> >>> the FULLSCREEN3D or COMPUTE profile when work is submitted.
> >>> Add a delayed work handler to delay switching out of the
> >>> selected profile if additional work comes in.  This works
> >>> the same as the VIDEO profile for VCN.  This lets dynamically
> >>> enable workload profiles on the fly and then move back
> >>> to the default when there is no work.
> >>>
> >>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >>> ---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 57 +++++++++++++++++++++++=
++
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 11 +++++
> >>>  2 files changed, 68 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gfx.c
> >>> index 6d5d81f0dc4e7..c542617121393 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> >>> @@ -2110,6 +2110,63 @@ void amdgpu_gfx_enforce_isolation_ring_end_use=
(struct amdgpu_ring *ring)
> >>>       mutex_unlock(&adev->enforce_isolation_mutex);
> >>>  }
> >>>
> >>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work)
> >>> +{
> >>> +     struct amdgpu_device *adev =3D
> >>> +             container_of(work, struct amdgpu_device, gfx.idle_work.=
work);
> >>> +     enum PP_SMC_POWER_PROFILE profile;
> >>> +     u32 i, fences =3D 0;
> >>> +     int r;
> >>> +
> >>> +     if (adev->gfx.num_gfx_rings)
> >>> +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >>> +     else
> >>> +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >>
> >> Since profile selection is in generic code, it makes sense to first
> >> check if the profile is supported for the family. Otherwise, this need=
s
> >> to be passed by the respective GFX family.
> >
> > The generic code already handles this.  If you select an unsupported
> > profile, it's ignored when the mask is updated.
> >
>
> That is strange. Does that mean user never gets an error if user
> attempts to set an unsupported profile?

If you use sysfs, you can only select from the available options
supported by the chip so there is no way to select a non-supported
profile.  For the internal driver API, we just silently ignore it.

>
> Another problem is this could override the user set profile now. Is that
> intended? In the current logic, whenever user sets a profile, the
> current profile is removed. With this one, another profile gets added
> and the user preference could be ignored depending on the priority.

Yes, I think.  For VCN we already select the video profile in a
similar manner and for ROCm we already select the compute profile,
this just extends that to gfx.  This doesn't really change the
behavior compared to the current state of the driver.  At the moment
we default to fullscreen3d on navi chips and on MI chips we always
enable compute when ROCm is active.  The change here is that we
eventually fall back to the bootup profile by default when the GPU is
idle.  This allows PMFW to enable additional power saving features
while still providing a boost when applications are running.

Alex

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Thanks,
> >> Lijo
> >>
> >>> +
> >>> +     for (i =3D 0; i < AMDGPU_MAX_GFX_RINGS; ++i)
> >>> +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.gfx_r=
ing[i]);
> >>> +     for (i =3D 0; i < (AMDGPU_MAX_COMPUTE_RINGS * AMDGPU_MAX_GC_INS=
TANCES); ++i)
> >>> +             fences +=3D amdgpu_fence_count_emitted(&adev->gfx.compu=
te_ring[i]);
> >>> +     if (!fences && !atomic_read(&adev->gfx.total_submission_cnt)) {
> >>> +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, fa=
lse);
> >>> +             if (r)
> >>> +                     dev_warn(adev->dev, "(%d) failed to disable %s =
power profile mode\n", r,
> >>> +                              profile =3D=3D PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D ?
> >>> +                              "fullscreen 3D" : "compute");
> >>> +     } else {
> >>> +             schedule_delayed_work(&adev->gfx.idle_work, GFX_PROFILE=
_IDLE_TIMEOUT);
> >>> +     }
> >>> +}
> >>> +
> >>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
> >>> +{
> >>> +     struct amdgpu_device *adev =3D ring->adev;
> >>> +     enum PP_SMC_POWER_PROFILE profile;
> >>> +     int r;
> >>> +
> >>> +     if (adev->gfx.num_gfx_rings)
> >>> +             profile =3D PP_SMC_POWER_PROFILE_FULLSCREEN3D;
> >>> +     else
> >>> +             profile =3D PP_SMC_POWER_PROFILE_COMPUTE;
> >>> +
> >>> +     atomic_inc(&adev->gfx.total_submission_cnt);
> >>> +
> >>> +     if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
> >>> +             r =3D amdgpu_dpm_switch_power_profile(adev, profile, tr=
ue);
> >>> +             if (r)
> >>> +                     dev_warn(adev->dev, "(%d) failed to disable %s =
power profile mode\n", r,
> >>> +                              profile =3D=3D PP_SMC_POWER_PROFILE_FU=
LLSCREEN3D ?
> >>> +                              "fullscreen 3D" : "compute");
> >>> +     }
> >>> +}
> >>> +
> >>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
> >>> +{
> >>> +     atomic_dec(&ring->adev->gfx.total_submission_cnt);
> >>> +
> >>> +     schedule_delayed_work(&ring->adev->gfx.idle_work, GFX_PROFILE_I=
DLE_TIMEOUT);
> >>> +}
> >>> +
> >>>  /*
> >>>   * debugfs for to enable/disable gfx job submission to specific core=
.
> >>>   */
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gfx.h
> >>> index 7f9e261f47f11..6c84598caec21 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> >>> @@ -57,6 +57,9 @@ enum amdgpu_gfx_pipe_priority {
> >>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> >>>  #define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> >>>
> >>> +/* 1 second timeout */
> >>> +#define GFX_PROFILE_IDLE_TIMEOUT     msecs_to_jiffies(1000)
> >>> +
> >>>  enum amdgpu_gfx_partition {
> >>>       AMDGPU_SPX_PARTITION_MODE =3D 0,
> >>>       AMDGPU_DPX_PARTITION_MODE =3D 1,
> >>> @@ -477,6 +480,9 @@ struct amdgpu_gfx {
> >>>       bool                            kfd_sch_inactive[MAX_XCP];
> >>>       unsigned long                   enforce_isolation_jiffies[MAX_X=
CP];
> >>>       unsigned long                   enforce_isolation_time[MAX_XCP]=
;
> >>> +
> >>> +     atomic_t                        total_submission_cnt;
> >>> +     struct delayed_work             idle_work;
> >>>  };
> >>>
> >>>  struct amdgpu_gfx_ras_reg_entry {
> >>> @@ -585,6 +591,11 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgp=
u_device *adev,
> >>>  void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
> >>>  void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring =
*ring);
> >>>  void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *r=
ing);
> >>> +
> >>> +void amdgpu_gfx_profile_idle_work_handler(struct work_struct *work);
> >>> +void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring);
> >>> +void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring);
> >>> +
> >>>  void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
> >>>  void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *ad=
ev);
> >>>
> >>
>
