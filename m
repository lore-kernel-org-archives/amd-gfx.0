Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD0CE77173
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 14:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20EE10F102;
	Fri,  6 Dec 2024 14:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GU5eMSOy";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B86110F102
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 14:19:22 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-7c3d415f85eso139303a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Dec 2024 06:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733494762; x=1734099562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6R3pMBsIboz9X/9ymT8ftiMAxffJmNWuxHcBzOkLOc=;
 b=GU5eMSOyfId1Gf6oirJ6caoPs03JKupMgKF8eI/gQ0EGwcaKjL2wp3SU8+TrfCCU5L
 oouY3gkY/REcfMnIG1sTFl3Wg0ABeoIEEBhFf4d8hnLZqYW0j5oZPoPuPdAtgZ3OEO5y
 MH7MSDLwU+cnb9UKuTDE38jkZSiTEva20T+dK2gBgWTaLftZYokFhX8ST8wZ+C4VtnHS
 PGz4EbwPYv88nZGepYU+IXcmawiQI4sZjJkrD9pt5h7QyJFN2+dcQNWRrJQjMT/UdHDe
 +EW/xssg1svK0CbGBxLI3u3JupxOVlTdNIjtmzE7IDa4JTaZlC8VM11IJP7yiMG8mCIV
 VSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733494762; x=1734099562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V6R3pMBsIboz9X/9ymT8ftiMAxffJmNWuxHcBzOkLOc=;
 b=V8kiiN27ctH//ZEDn047SVpRJe2NNU481sl+XjfQQfaRASkX4/c71DCV6mv4dVNRQt
 CK+moJW6xRDCk99YU6huX81nz0RXoGWfX0j9Fs5X0GWsalYSRx3xtW/r6oS9wX8JP+jK
 XmsgKfb7ttqjixNqyhFduWOQHGffgN+qzdITa2ltQ2cILHIHKH84FRRcqX7I33v029Nr
 LzDIRXDroCTyHLsbiFokuOkkFue6ESvwixLotYxNkYymG9qkXrTyyTP/Q37VYo5uH2uf
 EF+i6bMIgp1bTzCXm37+GRzGvtkAMEoGQc0iKGodh6Oe1k1iI36NafcTiSYh3LVAuq5G
 l2jA==
X-Gm-Message-State: AOJu0YyOvkj58+o1TI6lL6ItHn/AqwgYAz6sDPZQ4RLvURYKkxcIdFtz
 KOShsFF9lAT3TrlJ6j67M3w97uMtKxL1lUeF8KV8mvIqYjrVhENgBpwk82JWAOkLIxB8XWddkue
 9B8p2TIvGkHJhSQOF2p0bjdnof+U=
X-Gm-Gg: ASbGncuZUCS+iKAEf/W/T9M4eZEwPwuFeMHg2UFcMv8aGuZiyqmcxHtjPxSB182Q0t6
 TAgQIkakQ97841STG2CVJohFC2BrmQ1w=
X-Google-Smtp-Source: AGHT+IH4Ol42yHbCt2hfnZuS0mOJNSVVbChqXlDHrppugDVr4vtsoBeMLx5xNwad3hCGpCQrmak/KMrAwGhjEBn/1Dw=
X-Received: by 2002:a17:90b:38c5:b0:2ee:8648:9e8e with SMTP id
 98e67ed59e1d1-2ef6ab2a25dmr1871234a91.9.1733494761830; Fri, 06 Dec 2024
 06:19:21 -0800 (PST)
MIME-Version: 1.0
References: <20241206125955.3516880-1-lijo.lazar@amd.com>
In-Reply-To: <20241206125955.3516880-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Dec 2024 09:19:10 -0500
Message-ID: <CADnq5_M+HaYWv0VOGMmD9AtUD-7C2hh=r-H9EsgTw6=7cNA+Vg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Revert state if force level fails
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, kevinyang.wang@amd.com, 
 kenneth.feng@amd.com
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

On Fri, Dec 6, 2024 at 8:26=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Before forcing level, CG/PG is disabled or enabled depending on the new
> level. However if the force level operation fails, CG/PG state remains
> modified. Revert the state change on failure. Also, move invalid
> operation checks to the beginning before any logic that could change SOC
> state.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 58 +++++++++++++++++------------
>  1 file changed, 35 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm=
/amdgpu_dpm.c
> index 4d90e3f0bd17..6a9e26905edf 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -987,6 +987,24 @@ enum amd_dpm_forced_level amdgpu_dpm_get_performance=
_level(struct amdgpu_device
>         return level;
>  }
>
> +static void amdgpu_dpm_enter_umd_state(struct amdgpu_device *adev)
> +{
> +       /* enter UMD Pstate */
> +       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GF=
X,
> +                                              AMD_PG_STATE_UNGATE);
> +       amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GF=
X,
> +                                              AMD_CG_STATE_UNGATE);
> +}
> +
> +static void amdgpu_dpm_exit_umd_state(struct amdgpu_device *adev)
> +{
> +       /* exit UMD Pstate */
> +       amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_GF=
X,
> +                                              AMD_CG_STATE_GATE);
> +       amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_GF=
X,
> +                                              AMD_PG_STATE_GATE);
> +}
> +
>  int amdgpu_dpm_force_performance_level(struct amdgpu_device *adev,
>                                        enum amd_dpm_forced_level level)
>  {
> @@ -1007,6 +1025,10 @@ int amdgpu_dpm_force_performance_level(struct amdg=
pu_device *adev,
>         if (current_level =3D=3D level)
>                 return 0;
>
> +       if (!(current_level & profile_mode_mask) &&
> +           (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
> +               return -EINVAL;
> +
>         if (adev->asic_type =3D=3D CHIP_RAVEN) {
>                 if (!(adev->apu_flags & AMD_APU_IS_RAVEN2)) {
>                         if (current_level !=3D AMD_DPM_FORCED_LEVEL_MANUA=
L &&
> @@ -1018,35 +1040,25 @@ int amdgpu_dpm_force_performance_level(struct amd=
gpu_device *adev,
>                 }
>         }
>
> -       if (!(current_level & profile_mode_mask) &&
> -           (level =3D=3D AMD_DPM_FORCED_LEVEL_PROFILE_EXIT))
> -               return -EINVAL;
> -
> -       if (!(current_level & profile_mode_mask) &&
> -             (level & profile_mode_mask)) {
> -               /* enter UMD Pstate */
> -               amdgpu_device_ip_set_powergating_state(adev,
> -                                                      AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_PG_STATE_UNGAT=
E);
> -               amdgpu_device_ip_set_clockgating_state(adev,
> -                                                      AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_CG_STATE_UNGAT=
E);
> -       } else if ((current_level & profile_mode_mask) &&
> -                   !(level & profile_mode_mask)) {
> -               /* exit UMD Pstate */
> -               amdgpu_device_ip_set_clockgating_state(adev,
> -                                                      AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_CG_STATE_GATE)=
;
> -               amdgpu_device_ip_set_powergating_state(adev,
> -                                                      AMD_IP_BLOCK_TYPE_=
GFX,
> -                                                      AMD_PG_STATE_GATE)=
;
> -       }
> +       if (!(current_level & profile_mode_mask) && (level & profile_mode=
_mask))
> +               amdgpu_dpm_enter_umd_state(adev);
> +       else if ((current_level & profile_mode_mask) &&
> +                !(level & profile_mode_mask))
> +               amdgpu_dpm_exit_umd_state(adev);
>
>         mutex_lock(&adev->pm.mutex);
>
>         if (pp_funcs->force_performance_level(adev->powerplay.pp_handle,
>                                               level)) {
>                 mutex_unlock(&adev->pm.mutex);
> +               /* If new level failed, retain the umd state as before */
> +               if (!(current_level & profile_mode_mask) &&
> +                   (level & profile_mode_mask))
> +                       amdgpu_dpm_exit_umd_state(adev);
> +               else if ((current_level & profile_mode_mask) &&
> +                        !(level & profile_mode_mask))
> +                       amdgpu_dpm_enter_umd_state(adev);
> +
>                 return -EINVAL;
>         }
>
> --
> 2.25.1
>
