Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE161CEACEF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Nov 2025 08:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B0A589F41;
	Mon, 17 Nov 2025 08:02:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=antheas.dev header.i=@antheas.dev header.b="Abm3tCiO";
	dkim-atps=neutral
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D0810E099
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 09:55:43 +0000 (UTC)
Received: from relay10 (localhost.localdomain [127.0.0.1])
 by relay10.grserver.gr (Proxmox) with ESMTP id 41CEE3F4B6
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 11:55:41 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by relay10.grserver.gr (Proxmox) with ESMTPS id 657B33F3EA
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 11:55:40 +0200 (EET)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by linux3247.grserver.gr (Postfix) with ESMTPSA id B52671FD528
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Nov 2025 11:55:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
 s=default; t=1763200540;
 bh=hKfPhxLq0sL9NlIQ6S9WGxnfLDl46lZ3VOk7uF6HM4I=;
 h=Received:From:Subject:To;
 b=Abm3tCiOrBLtKmDePt6UDEqptX2iLHOJ3J06f3Ac/IJIFNg4NHZzrAgE+mr6/OXw2
 fp6i3h+HT5G7TY69H+Mb5Z4JTNndAhKP8J9Kpzwbbv+ASDf5I9DZZpLBx/GJuwvtIi
 bON96q9OjdVR6aAj6AlPjat5TatDM53eNUacpd6yhXLuj/kl9jkeaGp+hydTnKEIsD
 DaYzHULpemPjAJ3sL0SAycsDYjCBSP+7xzulOQXHiMGOqHXf9n6cERPh7SqlKf++TZ
 +Vkut5tMRq5ceqjSGDNtuwA4DacUgA5OjUvchn6mGnhNw1UAN5ggIfX/8xdT0TKk3L
 eFhgiJOvAUrRg==
Authentication-Results: linux3247.grserver.gr;
 spf=pass (sender IP is 209.85.208.174) smtp.mailfrom=lkml@antheas.dev
 smtp.helo=mail-lj1-f174.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3761e5287c9so21470231fa.2
 for <amd-gfx@lists.freedesktop.org>;
 Sat, 15 Nov 2025 01:55:39 -0800 (PST)
X-Gm-Message-State: AOJu0YzdxI/pqjabJ+Ax7XYUOgLG6IuVXuVzX9HM7Eeky2wHu3mxU5h3
 g4UnY6D5tc6ZxPYnMsxRI68LKdL7bZPDiwoLuPAqOasSdyV+q+me6zGunCZ20WRKtB5FdlLj0YL
 HFhCVa7qqKdyUyrzpf1QaXMSy6Bt+RKg=
X-Google-Smtp-Source: AGHT+IHZvIzui0AP3+W5R0dXnKvBHCZKiXglNLcTM5z5pdIRrdo4kFMh6NWF6IUob7n3k8X358ZJ5vboC7twE3ozUCM=
X-Received: by 2002:a2e:978f:0:b0:37a:3350:82bb with SMTP id
 38308e7fff4ca-37babbdc2cdmr12605091fa.19.1763200539165; Sat, 15 Nov 2025
 01:55:39 -0800 (PST)
MIME-Version: 1.0
References: <20250916191142.3504643-1-IVAN.LIPSKI@amd.com>
 <20250916191142.3504643-10-IVAN.LIPSKI@amd.com>
In-Reply-To: <20250916191142.3504643-10-IVAN.LIPSKI@amd.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sat, 15 Nov 2025 10:55:27 +0100
X-Gmail-Original-Message-ID: <CAGwozwFYd3_RMWk1BffAju6rgWGHbbqibpbA_kVEBP+1zSSbXg@mail.gmail.com>
X-Gm-Features: AWmQ_bkbPPMc-81nJUrid7lBKJab04QIOU-TpNFCOdgefFsFvZbvw1CgHjiWFMY
Message-ID: <CAGwozwFYd3_RMWk1BffAju6rgWGHbbqibpbA_kVEBP+1zSSbXg@mail.gmail.com>
Subject: Re: [PATCH 09/20] drm/amd/display: Use mpc.preblend flag to indicate
 preblend
To: Ivan Lipski <ivan.lipski@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alvin Lee <Alvin.Lee2@amd.com>,
 Dillon Varone <dillon.varone@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: <176320053996.1434312.11635239514546562658@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 17 Nov 2025 08:02:58 +0000
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

On Tue, 16 Sept 2025 at 22:09, <IVAN.LIPSKI@amd.com> wrote:
>
> From: Alvin Lee <Alvin.Lee2@amd.com>
>
> [Description]
> Modifications in per asic capability means mpc.preblend flag should be used
> to indicate preblend. Update relevant paths to use this flag.
>
> Reviewed-by: Dillon Varone <dillon.varone@amd.com>
> Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index c7387af725d6..b0ef157f1333 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -821,7 +821,7 @@ int amdgpu_dm_verify_lut3d_size(struct amdgpu_device *adev,
>         struct dm_plane_state *dm_plane_state = to_dm_plane_state(plane_state);
>         const struct drm_color_lut *shaper = NULL, *lut3d = NULL;
>         uint32_t exp_size, size, dim_size = MAX_COLOR_3DLUT_SIZE;
> -       bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut;
> +       bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
>
>         /* shaper LUT is only available if 3D LUT color caps */
>         exp_size = has_3dlut ? MAX_COLOR_LUT_ENTRIES : 0;
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b7c6e8d13435..96914f372d53 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1633,7 +1633,7 @@ dm_atomic_plane_attach_color_mgmt_properties(struct amdgpu_display_manager *dm,
>                 drm_object_attach_property(&plane->base,
>                                            dm->adev->mode_info.plane_ctm_property, 0);
>
> -       if (dpp_color_caps.hw_3d_lut) {
> +       if (dpp_color_caps.hw_3d_lut || dm->dc->caps.color.mpc.preblend) {

Hi,
this line here enables shaper_lut, shaper_tf, and lut3d. Does preblend
imply all three features?

Users with a RX7800XT and with a RX 9070 XT report that their hardware
incorrectly advertises these features, breaking non-compositing
rendering in gamescope [1][2; was necroed and bumped].

Reverting this commit, fixes the issue for those devices as it forces
compositing. It was also not an issue for devices connected to an HDR
display, as without dpp_color_caps.ogam_ram those GPUs are forced to
composite for the sRGB to PQ transition.

However, for the HX370, reverting this commit forces compositing even
though it supports these three features.

I recall this was a potential fix for 39923050615c ("drm/amd/display:
Clear DPP 3DLUT Cap").

Reverting both commits fixes the regression while the HX370 still does
direct scannout. Perhaps amdgpu_dm_verify_lut3d_size should be used to
check if the flags under color management should be shown?

Antheas

[1] https://github.com/ublue-os/bazzite/issues/3488
[2] https://github.com/ublue-os/bazzite/issues/1538


>                 drm_object_attach_property(&plane->base,
>                                            mode_info.plane_shaper_lut_property, 0);
>                 drm_object_attach_property(&plane->base,
> --
> 2.43.0
>

