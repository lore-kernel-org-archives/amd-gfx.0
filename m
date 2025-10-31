Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832ACCCFA07
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C15A10EBC6;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="CB488Cyo";
	dkim-atps=neutral
X-Greylist: delayed 456 seconds by postgrey-1.36 at gabe;
 Fri, 31 Oct 2025 12:09:49 UTC
Received: from relay14.grserver.gr (relay14.grserver.gr [46.224.16.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EB410EB1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 12:09:49 +0000 (UTC)
Received: from relay14 (localhost [127.0.0.1])
 by relay14.grserver.gr (Proxmox) with ESMTP id B0F3A43E7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 12:02:11 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay14.grserver.gr (Proxmox) with ESMTPS id A0A4643F52
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 12:02:10 +0000 (UTC)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com
 [209.85.208.177])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 1FB8B1FF1A5
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 14:02:10 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761912130;
 bh=R/j5cdkBM7Sh/pgwtw7CGjxF21211Lkf1zQraIrMxTc=;
 h=Received:From:Subject:To;
 b=CB488Cyoe5zvZbTeY4cNuixOSdIFHc/NTxv7knXi0av1s2EAWkEOo6k+EsglNfmvT
 gwVBcvuOY59j6Rhyf+54oeZLASGbySfQbaVSWeoTVpx1dhX4tA/dSSnTZpVKqMcnMv
 kR3/pdNuLjQUx0hvnLg3kF708Bb6ewQUZw4ovfjLJbwcwKMprBczdF24tbHKwPFZhF
 ZriyJJsU/JoDRTi+XUg5e5pQxJMKPbFaL3FTpacO+yssvaZk4WCu3Kk54zN0K8OXRN
 K8wCmBZUmEibQHHAxQljA5S+zFjFFCqYQoFSrrsI7ngdq6wXZLFB3VkzvglftgD0th
 VBeEl8n1tkWCg==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.177) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f177.google.com with SMTP id
 38308e7fff4ca-378cfd75fb0so25204251fa.1
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 31 Oct 2025 05:02:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yym864FCsNpgUXAn4wUiHVms8potTI4zBZrSJ49+TVDGVIRWGys
 ntrgrveUIg8ZV1Iuj4UCzBO4NpIt81Ktpa8XtA9E0026KWQjuCDCkmd7PdJdy7d7jPYNAo/hrzY
 xxyMCnTNjG9hO8zhKpG+29xcqmpRNR0s=
X-Google-Smtp-Source: AGHT+IEMLk+fAn8h8r1bhS4gk0+Gw9VBkU0ykzrpSa4Ic4/20JQ9buoYLRSMIybAH0GUi7SuCQ/1JlCH1FyoEsra2Vk=
X-Received: by 2002:a05:651c:2209:b0:364:45a:5159 with SMTP id
 38308e7fff4ca-37a18dc75bamr12265321fa.30.1761912129609; Fri, 31 Oct 2025
 05:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251026042942.549389-1-superm1@kernel.org>
 <20251026042942.549389-2-superm1@kernel.org>
In-Reply-To: <20251026042942.549389-2-superm1@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 31 Oct 2025 13:01:58 +0100
X-Gmail-Original-Message-ID: <CAGwozwHcbfct6REgHA1fb3rLFiNrpcb4nek+FYP7np15Laibng@mail.gmail.com>
X-Gm-Features: AWmQ_bnlPD36OqVMs3UuSLgoW2n1FvIruvWwmKyhbE2qFWV2sznsF7uG9A0Ljls
Message-ID: <CAGwozwHcbfct6REgHA1fb3rLFiNrpcb4nek+FYP7np15Laibng@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] drm/amdgpu: Drop PMFW RLC notifier from
 amdgpu_device_suspend()
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176191213035.2909356.5305628377478794144@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Oct 2025 14:16:25 +0000
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

On Sun, 26 Oct 2025 at 05:30, Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> For S3 on vangogh, PMFW needs to be notified before the
> driver powers down RLC.  This already happens in smu_disable_dpms()
> so drop the superfluous call in amdgpu_device_suspend().
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Co-developed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Just for this patch:

Tested-by: Antheas Kapenekakis <lkml@antheas.dev>

If the subject is refactored to take into account that it fixes sleep add:
#Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
#Reported-by: Antheas Kapenekakis <lkml@antheas.dev>

Tested on a Steam Deck OLED and Xbox Ally.

@Mario: For my series, can you have a look at the first two patches
and if they are ok push forward with merging? Also, reminder for the
Legion Go 2 quirk.

Best,
Antheas

> ---
> Cc: lkml@antheas.dev
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ----
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 18 ------------------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 --
>  3 files changed, 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b8d91247f51a..f6850b86e96f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5280,10 +5280,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_release_full_gpu(adev, false);
>
> -       r = amdgpu_dpm_notify_rlc_state(adev, false);
> -       if (r)
> -               return r;
> -
>         return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 5d08dc3b7110..5c4d0eb198c4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -195,24 +195,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>         return ret;
>  }
>
> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en)
> -{
> -       int ret = 0;
> -       const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> -
> -       if (pp_funcs && pp_funcs->notify_rlc_state) {
> -               mutex_lock(&adev->pm.mutex);
> -
> -               ret = pp_funcs->notify_rlc_state(
> -                               adev->powerplay.pp_handle,
> -                               en);
> -
> -               mutex_unlock(&adev->pm.mutex);
> -       }
> -
> -       return ret;
> -}
> -
>  int amdgpu_dpm_is_baco_supported(struct amdgpu_device *adev)
>  {
>         const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 3bce74f8bb0a..c7ea29385682 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -424,8 +424,6 @@ int amdgpu_dpm_mode1_reset(struct amdgpu_device *adev);
>  int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
>                              enum pp_mp1_state mp1_state);
>
> -int amdgpu_dpm_notify_rlc_state(struct amdgpu_device *adev, bool en);
> -
>  int amdgpu_dpm_set_gfx_power_up_by_imu(struct amdgpu_device *adev);
>
>  int amdgpu_dpm_baco_exit(struct amdgpu_device *adev);
> --
> 2.51.1
>
>

