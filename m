Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC21C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Mar 2022 14:00:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AEF10EEB7;
	Tue,  1 Mar 2022 14:00:27 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6314910EEB7
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Mar 2022 14:00:26 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 s1-20020a056830148100b005acfdcb1f4bso12238060otq.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Mar 2022 06:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=T6tei8rQ64Uffbjfd2aMbLI6lk/q2LYvWuRgzJ4+cpI=;
 b=a+nIb06sRyE1NHi2ceQxHWycG7YWAIz7c5leJAn4CMs1/Wlav1ZXvRe1GpX7TxRD6t
 0QiuQN/vffmRMj5oP0slIemj+YWlJ39vHnzxniVGLwlghcLcfNntPAj3T8Ns9nNFNvoX
 IiUX4ju57YDeL4uWtw0CxDDIg+J9eZmqJNYU4FVr+sf1J1x1OX6XWtR9MO6Hw65wbZAP
 2cw4ng7jMuB01vtyr8ffIv6bwT/tvkuPGwpURgIdrpHUitBz/hNoK2j2NzdQi6fkVr90
 7VdASY7daDLkC6YWbMafrkNhTfQE0vM2Vt5j1m3Q8s+RL/DRXmXjc3P2R48U4NBbJu44
 /PZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=T6tei8rQ64Uffbjfd2aMbLI6lk/q2LYvWuRgzJ4+cpI=;
 b=FyBQut4dO1JRhAx/Mrum2jszp/hm+nWRQnwHxsJTX7sxKOULw5uapxyh2D2qYe3NYM
 Db9KIisDYEXjpz5Pv1pzFqVn1fxx3r4DTKXSwwAa9d2Lgb9RsHpwEtxFfZFdbGCPhEH8
 fxfxdBY2m8mr9XkgAOK89nC4M4rO/EsdqCB+roPkZcQt3e3YuceCNGtMi/0JgqLx6UEm
 cF+Pl8KECX1rjq/UexF4Y93cYfiK6EloFBZUPglVLcY7HDcpb930MN89Yw+xpcxuKOuz
 3OB1QlwOI3C7VYit5asrq7Gk80g4UOqkPnZjgBoi7ETlqJDnszBY/8/Q7Nsaokb+503k
 KBTg==
X-Gm-Message-State: AOAM532bcfZtbt+35lHZwCnFabCiPx0Egm4HcwCLa/K7CvTSV+A+eHfd
 GO+gIuCIuEKwD5VoI2gPVhS6ivjEOOt7FhY9Fkmk8Q4n
X-Google-Smtp-Source: ABdhPJwXtyz40xu8duoP2YzV7YP93UR7fB0WPXQnYFWf0HW+Ga4M9ThscC8LciZf2k1I6yD2vdXcb3Qw9omKfalW170=
X-Received: by 2002:a9d:5a06:0:b0:5af:b5fd:5b72 with SMTP id
 v6-20020a9d5a06000000b005afb5fd5b72mr12336001oth.200.1646143225636; Tue, 01
 Mar 2022 06:00:25 -0800 (PST)
MIME-Version: 1.0
References: <1646137694-12053-1-git-send-email-Prike.Liang@amd.com>
 <1646137694-12053-3-git-send-email-Prike.Liang@amd.com>
In-Reply-To: <1646137694-12053-3-git-send-email-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 1 Mar 2022 09:00:14 -0500
Message-ID: <CADnq5_ODoJeq+H0jSy-6EET6DJb1ELDS2KGf0MaHB=AL26znFg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: enable gfxoff routine for GC 10.3.7
To: Prike Liang <Prike.Liang@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Mar 1, 2022 at 7:30 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> Enable gfxoff routine for GC 10.3.7.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         | 3 +++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 1 +
>  2 files changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index e048635435a2..92fdccc4a905 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -6557,6 +6557,7 @@ static void gfx_v10_0_kiq_setting(struct amdgpu_ring *ring)
>         case IP_VERSION(10, 3, 5):
>         case IP_VERSION(10, 3, 6):
>         case IP_VERSION(10, 3, 3):
> +       case IP_VERSION(10, 3, 7):
>                 tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
>                 tmp &= 0xffffff00;
>                 tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
> @@ -7857,6 +7858,7 @@ static void gfx_v10_0_set_safe_mode(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 5):
>         case IP_VERSION(10, 3, 6):
>         case IP_VERSION(10, 3, 3):
> +       case IP_VERSION(10, 3, 7):
>                 WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
>
>                 /* wait for RLC_SAFE_MODE */
> @@ -7894,6 +7896,7 @@ static void gfx_v10_0_unset_safe_mode(struct amdgpu_device *adev)
>         case IP_VERSION(10, 3, 5):
>         case IP_VERSION(10, 3, 6):
>         case IP_VERSION(10, 3, 3):
> +       case IP_VERSION(10, 3, 7):
>                 WREG32_SOC15(GC, 0, mmRLC_SAFE_MODE_Sienna_Cichlid, data);
>                 break;
>         default:
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 261a3749c089..05783b9b4b9a 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -751,6 +751,7 @@ int smu_v13_0_gfx_off_control(struct smu_context *smu, bool enable)
>         switch (adev->ip_versions[MP1_HWIP][0]) {
>         case IP_VERSION(13, 0, 1):
>         case IP_VERSION(13, 0, 3):
> +       case IP_VERSION(13, 0, 8):
>                 if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                         return 0;
>                 if (enable)
> --
> 2.17.1
>
