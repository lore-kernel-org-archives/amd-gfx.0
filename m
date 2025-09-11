Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBFCAC587
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 13:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E3DB10E0F7;
	Thu, 11 Sep 2025 13:14:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SEcAMygT";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A87510EB2D
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 13:14:17 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-25bf9dda1fdso1174495ad.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 06:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757596457; x=1758201257; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW7pYn6MSzFc07H84x4gcuRhgehc51GHQvDrTGzWmCE=;
 b=SEcAMygTMuSJQWnxpY4WlcFPg6zbn/DhrA4XKZ6DEPQmPyOJBhOFmCuZzpL3aqsQsi
 wU2+Uzgmr3cfPLOsAmKil/EyrCauEpHYGXvxwf3sav7Cz9ZvlJ9bWj7+BgqGPu9zUciI
 cEp2vm8H4p3cBwc3Pkpe8PLvhhvyMmLjP9xQmoNy/QSr3tDKficwRhaMu4HAdk271gaW
 13GheRU1YtdclG4m3l3AWYrvRHNCbRlRp5vWY2gguLV5p/wy99H+N7yhYwvd8BZmOJk1
 eWlIIM2xebiH2jLriiotacbs15hL7UDFAKHEVbazNCX+n3a+R/EJ1Dl35wPyePb6aUtC
 7yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757596457; x=1758201257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eW7pYn6MSzFc07H84x4gcuRhgehc51GHQvDrTGzWmCE=;
 b=whSqOB+y748TC0wEWZyXsruCZM9fPQ+J6u8gkzI8Ll6lSzKuBIKkhzZF5sENMFwj51
 /76SGmsY1GiKDJleB9j9c+zAqvGEjz8ctIEDNEH7kXyx0dm++VoYEgUg4HEgYfyQ8B16
 157Z9EgOblnHOdLXt2Uc0CaCLKqC/SozRPXMXix2knXCopVBGQSp2Thu3Rqh5R1d9Dkj
 k2n+L8aT/BCCNJwbXPcB1KrkvUaGjiqLDmCaffGKK5H2R29EY5Ne1yQCwmtEsdg6HsWO
 UhZRj9YBlLV/PblFYV1mk3PoHLHcyPE3QR/B7rHmFGIUIHJ2CHyyBm7tM7IQZvb4SRd4
 FM4Q==
X-Gm-Message-State: AOJu0Yzc0maTEoPppKtHCfw1NGRJUdHW58xH69Q32i5As+G6ujxwXG5C
 RfP7o1BcokJ2nho8BjHJtQhJGSXpYtq0UlM+rg/e9VIOCLLkq09fwQwqhn9MHJdd0ty+h5+eAKP
 eetMbRZ9d+pt78v1+PPQwC5eylA7OSt4SqA==
X-Gm-Gg: ASbGncuXLPiCysuXEiiJlJ+AiSeaAP0KfutJ9CGnzkKZFHrkHW3wXHWrZYgY2XWechf
 m1cy11bLH0sswKBJzuxC5ihr+df3TUixAvIERUJGbtEXmowbTc1orhld+zhBdKXiQuadKbI8F8F
 v30At40xwUacl/pRrh1wQDCaHj5mSSr9d44z/ZUUxyKQBlDb74Mx8X1TsFrTLsV7rmq0Hk/ewTC
 vjRPaVeibQolyqWJQ==
X-Google-Smtp-Source: AGHT+IGSlP0V+eCIkZTtxz/2NTj8OazdQ/c9OdTPhYAnNNS1+O4/0LskQD5UBSNy2NOG6TsjNa/Sj7ut08CNGOzRH7w=
X-Received: by 2002:a17:902:c40b:b0:243:589d:148e with SMTP id
 d9443c01a7336-2516f23de24mr131226375ad.5.1757596456495; Thu, 11 Sep 2025
 06:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250910184030.3773845-1-mario.limonciello@amd.com>
In-Reply-To: <20250910184030.3773845-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 11 Sep 2025 09:14:04 -0400
X-Gm-Features: Ac12FXxv3XdY4FuytgghTH9br4yZocxTsMzzlfD7BmnFwyWnSz5hKYiLDbDxt9I
Message-ID: <CADnq5_PZy1d2gwVi2dQJyQdbksmSrZs1hKC7Yqn+Pxja68_APQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Duplicate DC_FEATURE_MASK and DC_DEBUG_MASK enum
 values into kdoc
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Sep 10, 2025 at 4:39=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> When kernel documentation is generated the enum values themselves don't
> end up in the documentation.  This makes browsing them in HTML a lot
> less useful.
>
> [How]
> Copy DC_DEBUG_MASK and DC_FEATURE_MASK enum values into matching kdoc
> comments.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  Documentation/gpu/amdgpu/driver-core.rst |  2 +-
>  drivers/gpu/drm/amd/include/amd_shared.h | 98 ++++++++++++++++--------
>  2 files changed, 67 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index bd4be32f2725..3ce276272171 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -210,4 +210,4 @@ IP Blocks
>     :doc: IP Blocks
>
>  .. kernel-doc:: drivers/gpu/drm/amd/include/amd_shared.h
> -   :identifiers: amd_ip_block_type amd_ip_funcs DC_DEBUG_MASK
> +   :identifiers: amd_ip_block_type amd_ip_funcs DC_FEATURE_MASK DC_DEBUG=
_MASK
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/a=
md/include/amd_shared.h
> index bfb446736ca8..75efda2969cf 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -239,18 +239,51 @@ enum amd_harvest_ip_mask {
>      AMD_HARVEST_IP_DMU_MASK =3D 0x4,
>  };
>
> +/**
> + * enum DC_FEATURE_MASK - Bits that control DC feature defaults
> + */
>  enum DC_FEATURE_MASK {
>         //Default value can be found at "uint amdgpu_dc_feature_mask"
> -       DC_FBC_MASK =3D (1 << 0), //0x1, disabled by default
> -       DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D (1 << 1), //0x2, enabled by =
default
> -       DC_DISABLE_FRACTIONAL_PWM_MASK =3D (1 << 2), //0x4, disabled by d=
efault
> -       DC_PSR_MASK =3D (1 << 3), //0x8, disabled by default for dcn < 3.=
1
> -       DC_EDP_NO_POWER_SEQUENCING =3D (1 << 4), //0x10, disabled by defa=
ult
> -       DC_DISABLE_LTTPR_DP1_4A =3D (1 << 5), //0x20, disabled by default
> -       DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6), //0x40, disabled by default
> -       DC_PSR_ALLOW_SMU_OPT =3D (1 << 7), //0x80, disabled by default
> -       DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8), //0x100, disabled by de=
fault
> -       DC_REPLAY_MASK =3D (1 << 9), //0x200, disabled by default for dcn=
 < 3.1.4
> +       /**
> +        * @DC_FBC_MASK: (0x1) disabled by default
> +        */
> +       DC_FBC_MASK =3D (1 << 0),
> +       /**
> +        * @DC_MULTI_MON_PP_MCLK_SWITCH_MASK: (0x2) enabled by default
> +        */
> +       DC_MULTI_MON_PP_MCLK_SWITCH_MASK =3D (1 << 1),
> +       /**
> +        * @DC_DISABLE_FRACTIONAL_PWM_MASK: (0x4) disabled by default
> +        */
> +       DC_DISABLE_FRACTIONAL_PWM_MASK =3D (1 << 2),
> +       /**
> +        * @DC_PSR_MASK: (0x8) disabled by default for DCN < 3.1
> +        */
> +       DC_PSR_MASK =3D (1 << 3),
> +       /**
> +        * @DC_EDP_NO_POWER_SEQUENCING: (0x10) disabled by default
> +        */
> +       DC_EDP_NO_POWER_SEQUENCING =3D (1 << 4),
> +       /**
> +        * @DC_DISABLE_LTTPR_DP1_4A: (0x20) disabled by default
> +        */
> +       DC_DISABLE_LTTPR_DP1_4A =3D (1 << 5),
> +       /**
> +        * @DC_DISABLE_LTTPR_DP2_0: (0x40) disabled by default
> +        */
> +       DC_DISABLE_LTTPR_DP2_0 =3D (1 << 6),
> +       /**
> +        * @DC_PSR_ALLOW_SMU_OPT: (0x80) disabled by default
> +        */
> +       DC_PSR_ALLOW_SMU_OPT =3D (1 << 7),
> +       /**
> +        * @DC_PSR_ALLOW_MULTI_DISP_OPT: (0x100) disabled by default
> +        */
> +       DC_PSR_ALLOW_MULTI_DISP_OPT =3D (1 << 8),
> +       /**
> +        * @DC_REPLAY_MASK: (0x200) disabled by default for DCN < 3.1.4
> +        */
> +       DC_REPLAY_MASK =3D (1 << 9),
>  };
>
>  /**
> @@ -258,64 +291,64 @@ enum DC_FEATURE_MASK {
>   */
>  enum DC_DEBUG_MASK {
>         /**
> -        * @DC_DISABLE_PIPE_SPLIT: If set, disable pipe-splitting
> +        * @DC_DISABLE_PIPE_SPLIT: (0x1) If set, disable pipe-splitting
>          */
>         DC_DISABLE_PIPE_SPLIT =3D 0x1,
>
>         /**
> -        * @DC_DISABLE_STUTTER: If set, disable memory stutter mode
> +        * @DC_DISABLE_STUTTER: (0x2) If set, disable memory stutter mode
>          */
>         DC_DISABLE_STUTTER =3D 0x2,
>
>         /**
> -        * @DC_DISABLE_DSC: If set, disable display stream compression
> +        * @DC_DISABLE_DSC: (0x4) If set, disable display stream compress=
ion
>          */
>         DC_DISABLE_DSC =3D 0x4,
>
>         /**
> -        * @DC_DISABLE_CLOCK_GATING: If set, disable clock gating optimiz=
ations
> +        * @DC_DISABLE_CLOCK_GATING: (0x8) If set, disable clock gating o=
ptimizations
>          */
>         DC_DISABLE_CLOCK_GATING =3D 0x8,
>
>         /**
> -        * @DC_DISABLE_PSR: If set, disable Panel self refresh v1 and PSR=
-SU
> +        * @DC_DISABLE_PSR: (0x10) If set, disable Panel self refresh v1 =
and PSR-SU
>          */
>         DC_DISABLE_PSR =3D 0x10,
>
>         /**
> -        * @DC_FORCE_SUBVP_MCLK_SWITCH: If set, force mclk switch in subv=
p, even
> +        * @DC_FORCE_SUBVP_MCLK_SWITCH: (0x20) If set, force mclk switch =
in subvp, even
>          * if mclk switch in vblank is possible
>          */
>         DC_FORCE_SUBVP_MCLK_SWITCH =3D 0x20,
>
>         /**
> -        * @DC_DISABLE_MPO: If set, disable multi-plane offloading
> +        * @DC_DISABLE_MPO: (0x40) If set, disable multi-plane offloading
>          */
>         DC_DISABLE_MPO =3D 0x40,
>
>         /**
> -        * @DC_ENABLE_DPIA_TRACE: If set, enable trace logging for DPIA
> +        * @DC_ENABLE_DPIA_TRACE: (0x80) If set, enable trace logging for=
 DPIA
>          */
>         DC_ENABLE_DPIA_TRACE =3D 0x80,
>
>         /**
> -        * @DC_ENABLE_DML2: If set, force usage of DML2, even if the DCN =
version
> +        * @DC_ENABLE_DML2: (0x100) If set, force usage of DML2, even if =
the DCN version
>          * does not default to it.
>          */
>         DC_ENABLE_DML2 =3D 0x100,
>
>         /**
> -        * @DC_DISABLE_PSR_SU: If set, disable PSR SU
> +        * @DC_DISABLE_PSR_SU: (0x200) If set, disable PSR SU
>          */
>         DC_DISABLE_PSR_SU =3D 0x200,
>
>         /**
> -        * @DC_DISABLE_REPLAY: If set, disable Panel Replay
> +        * @DC_DISABLE_REPLAY: (0x400) If set, disable Panel Replay
>          */
>         DC_DISABLE_REPLAY =3D 0x400,
>
>         /**
> -        * @DC_DISABLE_IPS: If set, disable all Idle Power States, all th=
e time.
> +        * @DC_DISABLE_IPS: (0x800) If set, disable all Idle Power States=
, all the time.
>          * If more than one IPS debug bit is set, the lowest bit takes
>          * precedence. For example, if DC_FORCE_IPS_ENABLE and
>          * DC_DISABLE_IPS_DYNAMIC are set, then DC_DISABLE_IPS_DYNAMIC ta=
kes
> @@ -324,56 +357,57 @@ enum DC_DEBUG_MASK {
>         DC_DISABLE_IPS =3D 0x800,
>
>         /**
> -        * @DC_DISABLE_IPS_DYNAMIC: If set, disable all IPS, all the time=
,
> +        * @DC_DISABLE_IPS_DYNAMIC: (0x1000) If set, disable all IPS, all=
 the time,
>          * *except* when driver goes into suspend.
>          */
>         DC_DISABLE_IPS_DYNAMIC =3D 0x1000,
>
>         /**
> -        * @DC_DISABLE_IPS2_DYNAMIC: If set, disable IPS2 (IPS1 allowed) =
if
> +        * @DC_DISABLE_IPS2_DYNAMIC: (0x2000) If set, disable IPS2 (IPS1 =
allowed) if
>          * there is an enabled display. Otherwise, enable all IPS.
>          */
>         DC_DISABLE_IPS2_DYNAMIC =3D 0x2000,
>
>         /**
> -        * @DC_FORCE_IPS_ENABLE: If set, force enable all IPS, all the ti=
me.
> +        * @DC_FORCE_IPS_ENABLE: (0x4000) If set, force enable all IPS, a=
ll the time.
>          */
>         DC_FORCE_IPS_ENABLE =3D 0x4000,
>         /**
> -        * @DC_DISABLE_ACPI_EDID: If set, don't attempt to fetch EDID for
> +        * @DC_DISABLE_ACPI_EDID: (0x8000) If set, don't attempt to fetch=
 EDID for
>          * eDP display from ACPI _DDC method.
>          */
>         DC_DISABLE_ACPI_EDID =3D 0x8000,
>
>         /**
> -        * @DC_DISABLE_HDMI_CEC: If set, disable HDMI-CEC feature in amdg=
pu driver.
> +        * @DC_DISABLE_HDMI_CEC: (0x10000) If set, disable HDMI-CEC featu=
re in amdgpu driver.
>          */
>         DC_DISABLE_HDMI_CEC =3D 0x10000,
>
>         /**
> -        * @DC_DISABLE_SUBVP_FAMS: If set, disable DCN Sub-Viewport & Fir=
mware Assisted
> +        * @DC_DISABLE_SUBVP_FAMS: (0x20000) If set, disable DCN Sub-View=
port & Firmware Assisted
>          * Memory Clock Switching (FAMS) feature in amdgpu driver.
>          */
>         DC_DISABLE_SUBVP_FAMS =3D 0x20000,
>         /**
> -        * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: If set, disable support f=
or custom brightness curves
> +        * @DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE: (0x40000) If set, disable=
 support for custom
> +        * brightness curves
>          */
>         DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE =3D 0x40000,
>
>         /**
> -        * @DC_HDCP_LC_FORCE_FW_ENABLE: If set, use HDCP Locality Check F=
W
> +        * @DC_HDCP_LC_FORCE_FW_ENABLE: (0x80000) If set, use HDCP Locali=
ty Check FW
>          * path regardless of reported HW capabilities.
>          */
>         DC_HDCP_LC_FORCE_FW_ENABLE =3D 0x80000,
>
>         /**
> -        * @DC_HDCP_LC_ENABLE_SW_FALLBACK: If set, upon HDCP Locality Che=
ck FW
> +        * @DC_HDCP_LC_ENABLE_SW_FALLBACK: (0x100000) If set, upon HDCP L=
ocality Check FW
>          * path failure, retry using legacy SW path.
>          */
>         DC_HDCP_LC_ENABLE_SW_FALLBACK =3D 0x100000,
>
>         /**
> -        * @DC_SKIP_DETECTION_LT: If set, skip detection link training
> +        * @DC_SKIP_DETECTION_LT: (0x200000) If set, skip detection link =
training
>          */
>         DC_SKIP_DETECTION_LT =3D 0x200000,
>  };
> --
> 2.50.1
>
