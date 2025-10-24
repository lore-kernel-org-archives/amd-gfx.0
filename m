Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D62FECCF9F0
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Oct 2025 09:35:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0841610E41F;
	Mon, 27 Oct 2025 09:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="pBcOtRfT";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA2110EB2D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 17:15:13 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id CAE1A4636C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:15:11 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id BF3B64612A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:15:10 +0300 (EEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 264471FEB95
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Oct 2025 20:15:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761326110;
 bh=vruJVPr4pz/gQKBf7VaVa6dcBEZJWbShxgS1Sc0nMQY=;
 h=Received:From:Subject:To;
 b=pBcOtRfTsI+R6UxaNSDmm3zhGDKM8dbCiAhtYmyudyB7X3LvKEG/Cfh/Azo+RiQoz
 JSFDxTBFPcd+WG6Jx9UiWJIH0JfBUd+U8xuKU4n66DqzgQh2LtRX7hY50jn8imtaAk
 l7AfHqQxV3rs10LNIUdWZecuFqQGxw6/rQUz0SRnwVtGtwPxkYtZrNMDxQokRYzk4A
 GFtSZVbt2RzuOGx9Cg5Hp/1tdXUWvDS2h2mOVtZINqsqHtW36Q3IAkzwV62jGGWouC
 mjFXdf/MG1tA8DoHNMZ+nHub81RS+mFEsUkYsrU4l8I56bHkvBU6B+KUIm8z/l/gn0
 JJ3otuuie1jig==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.179) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f179.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-378e0f355b9so11951231fa.0
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 24 Oct 2025 10:15:10 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx8XiujpYV1E0HTCSzXcaTi4yZ2nzlgMnSJIBNEjlgOME2C8Xqh
 F65dNvOjV+7wkBaw/V7+TwOlTE8rVdqZAj2V7/SlZ0B4sR2BlO7qgXWwH1bz9PHZk3iBz59giBg
 2Li/ldZr93ttLma5dK/3ounfAHdKA+o4=
X-Google-Smtp-Source: AGHT+IEE5O+KhOUBlPXgNsur1tB1VOIP8HA744+SBW63xhMi7r+LLEQXrZkG36F8pQkrcwv43CBaEQ79uuPgkt9kNTo=
X-Received: by 2002:a2e:bea3:0:b0:376:4320:e362 with SMTP id
 38308e7fff4ca-378e4642f7cmr9327921fa.48.1761326109716; Fri, 24 Oct 2025
 10:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
In-Reply-To: <20251024170811.57760-2-alexander.deucher@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 24 Oct 2025 19:14:58 +0200
X-Gmail-Original-Message-ID: <CAGwozwHnROrncN_bLAVqrd=XEV6FGS+sTLJx=wsXqx9GNsNiFQ@mail.gmail.com>
X-Gm-Features: AWmQ_bl4CrADGg7oLlA7L24JaWdRjuTxxpzcrGXUb7QK6IHP-jj-FE6x64abukE
Message-ID: <CAGwozwHnROrncN_bLAVqrd=XEV6FGS+sTLJx=wsXqx9GNsNiFQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bob.beckett@collabora.com,
 mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176132611035.2758470.11739259647117636544@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 27 Oct 2025 09:35:56 +0000
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

On Fri, 24 Oct 2025 at 19:08, Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Fix the flows for S0ix.  There is no need to stop
> rlc or reintialize PMFW in S0ix.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4659
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        | 6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c | 3 +++
>  2 files changed, 9 insertions(+)

Sleep failed on the Deck the same way as Mario's attempt

> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> index 10d42267085b0..5bee02f0ba867 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -2054,6 +2054,12 @@ static int smu_disable_dpms(struct smu_context *smu)
>             smu->is_apu && (amdgpu_in_reset(adev) || adev->in_s0ix))
>                 return 0;
>
> +       /* vangogh s0ix */
> +       if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 0) ||
> +            amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(11, 5, 2)) &&
> +           adev->in_s0ix)
> +               return 0;
> +
>         /*
>          * For gpu reset, runpm and hibernation through BACO,
>          * BACO feature has to be kept enabled.
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> index 53579208cffb4..9626da2dba584 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
> @@ -2219,6 +2219,9 @@ static int vangogh_post_smu_init(struct smu_context *smu)
>         uint32_t total_cu = adev->gfx.config.max_cu_per_sh *
>                 adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
>
> +       if (adev->in_s0ix)
> +               return 0;
> +
>         /* allow message will be sent after enable message on Vangogh*/
>         if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_GFXCLK_BIT) &&
>                         (adev->pg_flags & AMD_PG_SUPPORT_GFX_PG)) {
> --
> 2.51.0
>
>

