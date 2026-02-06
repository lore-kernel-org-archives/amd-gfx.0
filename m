Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CAF9EE6B69
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 22:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB0F310E945;
	Fri,  6 Feb 2026 22:06:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jIX8QeUR";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA26C10E946
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 22:06:30 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2b703e04984so318643eec.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 14:06:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770415590; cv=none;
 d=google.com; s=arc-20240605;
 b=bkl+OqJGpXBffTo3l3RJtYumh38prGL4e3RnYV0PFQq5JXMFxmZev085SzcbWX1Bce
 iBdmeRqlp5hnAR0ixWX5p9a7QQnbawxRVGRbU1tA2oDeZvICdAb8CLuUbdljDQLdt1SL
 uEbPqQF/FH/Z3NBYn1JQ1qxuMGtH8uEDgQVAZ0idz2SvuM8MOX/xLLpAZYBuVjs3rWHJ
 l0aw5+MjaK0BeVE2FE+uxugg7zeVdJRtN5B8ZkPnHtXp8lGqCKd2rj0cnTJ1XdvECTHb
 HpJZRfRg6PsF7xpmzIK2tOYBVwnRRua7b0HP545G6YZzVf2c1j1jiBCLwgj4TCgzqita
 64rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=t9JUCkixPVH7e1MZ+SkL97/AHvO6ZFT/H4gh0z3m0gI=;
 fh=P0+DghOinuCpWBck027cfh34jwF1iWjxJBCLrXK7iMc=;
 b=kh4CVBbjvS/D804aVA7QagKYMwqlO+Ar6/Wp0gWYEEVFMQm2nG9NiyXqt4h+gbl0z6
 hrRcutDXJEOS+Fv28nlWgLydDDTu45+RPOJeloQ5j1qwVM7tDWJwYWEZb5hYrFgq9qIM
 vebdfwFdv3TX2J1js5oVPDLx030TlxHilhN7PNTG9T997xwj7KJ0zFaQ+WWu75bNNG8e
 zBlL9ntnuxLWXGLoBgoRsadDXGoha4QYuG7BBOPp8pXyCni4/mnJBxbvLmGKKot8R361
 Zgohpnvxzsfk2bReuzn+/wbvusUCPh4mF4MvRuvj2S/vRoxa+/C/5N8R5WVWNm3Qmd9+
 SSyg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770415590; x=1771020390; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9JUCkixPVH7e1MZ+SkL97/AHvO6ZFT/H4gh0z3m0gI=;
 b=jIX8QeURnv9Y0FoKimHY+ytgmf3wDXPsDz+0JspbEkcHM2pN5N8lTsgmghth6kGhrL
 Vw4D98G40E+sFfBhieG51Xz1CtW5s+ohCt0Wocx5QCiklw86+uL81j/fyBPe2c3RXmAX
 KcKOY0v87uRhlTisgvRD4jDsp4Zvjof2U7vpiQkwpx/5vGYB7c4uLD2xAL0VurJQ5rV5
 iQNEev1FQdhXveznX1mCfr9gIHj2j3d9gHQBhlcs7Rb2qpldo03a51Rw9ec5MhGD70Yv
 BfyIrT21F1Y7YPfn8M8QlFic+PRR/dCejQ+1OA79nAuMoUCEgby6bnQkCZ92MhmCbEY/
 +7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770415590; x=1771020390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t9JUCkixPVH7e1MZ+SkL97/AHvO6ZFT/H4gh0z3m0gI=;
 b=TRmVT/4vzh70SFGNi4MavqZhQH3tMSPtUqIFz56DZQaRSyS5jiJrYrE/owMTEaSpC4
 Woe9qjpa0sSkB+rQbF/7aqGIwDw87WuxFxyqWlJOztgMRH+RyR7WSUCLghbPzQCxuPbz
 M0bPKzLryTO6eb3b01KLXqJUgyQXvhRZKFrdgQdD9JWU8P15RNqOw/Qe7CrmQfCprTda
 2mmTpK50+ATby44n7frCRe8Cq8OZNcm1DocFPdmhveMAMoZ3YKmj4OGNQsf8NGXsQ4t0
 ediyyOuxgZBxNBALdhRV+6j45Q19XcQxwsEThJrr2fe+zAtluln4Q0a5DRft8TOmIoZ6
 stXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdc1wuDDT9PryvIAS4ZqrTie94R82bQluDwMxjcriOutk79xzQDDlv8MXhkH45GHdNU8qNIMBX@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCUYBXaYj6v2BneaBR2KiyYzWrriT4y/R8/IhuTkAt0GLFktjy
 a9zu2lT6mYxKEGJrhZbRr99Gs/LCBcBctO1AMJ+KhP8i/KFEc88OntkxL4Xx9OXrqpC3kFIf3nY
 5wEH1vODx6r6m6/MvbaEW5YP0Nq7Bps8=
X-Gm-Gg: AZuq6aLjJWPy/qW9BCj0OKAgl/V3glWRASnRmdom0L7Ct6ZL5DJD05vFxpca8dgeG6w
 TChJVAzl3vAXFz236jZ+YVlQZABWgRABlKz7hih/lJ/euF0cBnqhaCDBsqBFc8YcKnYFna+EuXt
 fOzWSPJq9Nbrol5QpPC+N3hi8OTq0JIwUothlBoTi1YyaROSIvpA47vo4l5NiWqoxMz6wLDFoAf
 SustLjEoZq8VpYr2UGbyIyI3N3J30ddNgpQsO2Tb7Z51Am9bgN+2Y9YDU9/Z5A1P3sUoaDc
X-Received: by 2002:a05:7300:5721:b0:2b7:1c58:dc9e with SMTP id
 5a478bee46e88-2b85671db42mr976513eec.9.1770415589926; Fri, 06 Feb 2026
 14:06:29 -0800 (PST)
MIME-Version: 1.0
References: <20260203185626.55428-1-tomasz.pakula.oficjalny@gmail.com>
 <20260203185626.55428-20-tomasz.pakula.oficjalny@gmail.com>
In-Reply-To: <20260203185626.55428-20-tomasz.pakula.oficjalny@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Feb 2026 17:06:18 -0500
X-Gm-Features: AZwV_Qh0tTckj59GVgrqkBR4zfCFR6o2l2IYC3E9lcEzFllb9aXm2dUuZwlqjqM
Message-ID: <CADnq5_OPP+bbJ9OXGSUEN9EC=hseY4DCfKngpAoA2keMbG5z7g@mail.gmail.com>
Subject: Re: [PATCH v3 19/19] drm/amd/display: Add HDMI VRR desktop mode
To: =?UTF-8?Q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, siqueira@igalia.com, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, bernhard.berger@gmail.com, 
 michel.daenzer@mailbox.org, daniel@fooishbar.org, admin@ptr1337.dev
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

On Tue, Feb 3, 2026 at 2:07=E2=80=AFPM Tomasz Paku=C5=82a
<tomasz.pakula.oficjalny@gmail.com> wrote:
>
> [Why]
> Many TVs and other HDMI sinks suffer from blanking and possibly other
> glitches when VRR is toggled. With FreeSync present on such sinks, they
> behave like the signal is always variable, even in fixed refresh rate
> situations.
>
> [How]
> Keep HDMI VRR toggled if it's supported and not explicitly disabled.
> Additionnally, add module parameter which allows users to configure HDMI
> VRR triggering to only happen when the signal is truly asking for
> variable state. This is useful if end user has a TV that automatically
> toggles ALLM/Game mode when VRR is active and such user doesn't want
> gaming mode in normal desktop usage.
>
> Signed-off-by: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h                 |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c             | 13 +++++++++++++
>  .../amd/display/modules/info_packet/info_packet.c   |  9 +++++++--
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 312aa32064d5..d49cd55e0f35 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -269,6 +269,7 @@ extern int amdgpu_rebar;
>  extern int amdgpu_wbrf;
>  extern int amdgpu_user_queue;
>  extern uint amdgpu_allm_mode;
> +extern bool amdgpu_hdmi_vrr_desktop_mode;
>
>  extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 4b038c8bbf9f..f53c2ffeffa2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -249,6 +249,7 @@ int amdgpu_rebar =3D -1; /* auto */
>  int amdgpu_user_queue =3D -1;
>  uint amdgpu_hdmi_hpd_debounce_delay_ms;
>  uint amdgpu_allm_mode =3D 1;
> +bool amdgpu_hdmi_vrr_desktop_mode =3D true;
>
>  DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, =
0,
>                         "DRM_UT_CORE",
> @@ -1146,6 +1147,18 @@ module_param_named(hdmi_hpd_debounce_delay_ms, amd=
gpu_hdmi_hpd_debounce_delay_ms
>  MODULE_PARM_DESC(allm_mode, "Changes ALLM trigger mode (0 =3D disable, 1=
 =3D enable (default), 2 =3D force enable)");
>  module_param_named(allm_mode, amdgpu_allm_mode, uint, 0644);
>
> +/**
> + * DOC: hdmi_vrr_on_dekstop (bool)

*desktop

> + * Enables FreeSync behavior mimicking by keeping HDMI VRR signalling ac=
tive in
> + * fixed refresh rate conditions like normal desktop work/web browsing.
> + * Possible values:
> + *
> + * - false =3D HDMI VRR is only enabled if refresh rate is truly variabl=
e
> + * - true  =3D Mimics FreeSync behavior and keeps HDMI VRR always active
> + */
> +MODULE_PARM_DESC(hdmi_vrr_desktop_mode, "Changes HDMI VRR desktop mode (=
false =3D disable, true =3D enable (default))");
> +module_param_named(hdmi_vrr_desktop_mode, amdgpu_hdmi_vrr_desktop_mode, =
bool, 0644);

This also seems like it would be better to be a KMS property.

Alex

> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.=
c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> index 5fd9e8aadc98..b41e2240e1ae 100644
> --- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> +++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
> @@ -654,8 +654,13 @@ static void build_vtem_infopacket_data(const struct =
dc_stream_state *stream,
>         bool vrr_active =3D false;
>         bool rb =3D false;
>
> -       vrr_active =3D vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABLE ||
> -                    vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED;
> +       if (amdgpu_hdmi_vrr_desktop_mode) {
> +               vrr_active =3D vrr->state !=3D VRR_STATE_UNSUPPORTED &&
> +                            vrr->state !=3D VRR_STATE_DISABLED;
> +       } else {
> +               vrr_active =3D vrr->state =3D=3D VRR_STATE_ACTIVE_VARIABL=
E ||
> +                            vrr->state =3D=3D VRR_STATE_ACTIVE_FIXED;
> +       }
>
>         infopacket->sb[VTEM_MD0] =3D VTEM_M_CONST << VTEM_M_CONST_BIT;
>         infopacket->sb[VTEM_MD0] |=3D VTEM_FVA_FACTOR << VTEM_FVA_BIT;
> --
> 2.52.0
>
