Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A506CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBAA10EBCB;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=temperror (0-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="RCv6JPCq";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698A810EB1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 11:59:08 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id 6A14345F54
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:59:06 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id 4545441F35
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:59:05 +0200 (EET)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id 9F1AA1FC583
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:59:04 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1761911944;
 bh=ezmMeIAGlL1p0rcbQZaN16PF5C3rDoG8Uh08eods8rw=;
 h=Received:From:Subject:To;
 b=RCv6JPCqnHEKgO0YErILjbu0U35V/Rd3BHt8mr9a5VoOEoS2WjCQ8suMZEXe6ngtq
 15R3xy5fkavSUr7rKCPFIVSbcms4gLbbL7HcWrvLy4QH/AeOEZe1UiB/+Vn5oiZt2o
 BVA0SMNdsD1k5kZxxUqraOtcGwGnYMwhP2E/prfPUm+QP10x5yIoMmROZioRB1c/Ti
 koXsxiUhZQdrvWpr3Xnz6UGQbkF7bXqtqeFW/oUD2eZLyR5Oy8nVD6oH6qxDNKHZhC
 8FHEB4pb7XKk9vj3i6xYN/rIcMZ1oJHFIxlDJRy/z+Rxv/o9iYcbeaccoEbTAI0Jp+
 NQU2TnPSGkzmA==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.170) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f170.google.com with SMTP id
 38308e7fff4ca-378d50e1c77so19667011fa.0
 for <amd-gfx@lists.freedesktop.org>;
 Fri, 31 Oct 2025 04:59:04 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywzr7g0aRboznRsEHT0dmRCkm7OSmnRo5F29SNz3fivPKlKopFq
 d8k1v3dAXL8LoVsSdDO4Jv+BFvTWjqFXkqUIxeUhsdHh3Ot/CTV1YjKngk5oJih7g4tweYRDlPG
 ebAQqpVYIb473D9Lsk1DqmlANwi0mSdg=
X-Google-Smtp-Source: AGHT+IFcxqA9JhfTAesJy2+pbUXXy45iktmwEOIY3kepurKURRO8XlswiFIPQ1hljaaFOivbgmdRa+QJ0EK5uh2VYa4=
X-Received: by 2002:a2e:8752:0:b0:378:cdf0:ad53 with SMTP id
 38308e7fff4ca-37a18df5999mr7951151fa.46.1761911944141; Fri, 31 Oct 2025
 04:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20251024170811.57760-1-alexander.deucher@amd.com>
 <20251024170811.57760-2-alexander.deucher@amd.com>
In-Reply-To: <20251024170811.57760-2-alexander.deucher@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 31 Oct 2025 12:58:52 +0100
X-Gmail-Original-Message-ID: <CAGwozwH0A83OEDJ04Oq7UDQRszXejfhTioTau3Q4LB39yRqJpg@mail.gmail.com>
X-Gm-Features: AWmQ_blxs_UrsY0GBbouM9eGRQGImE04qjVYvcLkrptFkZrGw6H-7jgvLXN0Q1g
Message-ID: <CAGwozwH0A83OEDJ04Oq7UDQRszXejfhTioTau3Q4LB39yRqJpg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu/smu: Handle S0ix for vangogh
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, bob.beckett@collabora.com,
 mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176191194482.2893662.11571539876145772266@linux3247.grserver.gr>
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

Just for this patch:

Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
Tested-by: Antheas Kapenekakis <lkml@antheas.dev>

Tested on a Steam Deck OLED and Xbox Ally.

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
>
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

