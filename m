Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909CDCD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 20 May 2026 13:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE9510ECB7;
	Wed, 20 May 2026 13:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PZmRksBg";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D393510EC24
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 13:23:27 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-56fadbf56c2so256793e0c.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 May 2026 06:23:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779283407; cv=none;
 d=google.com; s=arc-20240605;
 b=P8woVABBjB+lSiVUYruKGLs0f/BrWM93Qnk7Ykx6vCZiYmu6IWAY9p9G5X2XIb6Emd
 AYlrmoFbgQFd/t+ywJ7w61mIIMGTvz1KSm4DO8TfdWOFvmx9V5ElTJGqtp9cb9oaa/1p
 nk2R2WZskfYQfOveOU58iJI+Zs59uqUDYoxeecFjFfk2/ZdBNgc/HLzfXtC5Djwp1tBj
 s9abkOrrtE2JiAMr2SrFxsFxWtida5FrZn79RZh3gX9BsOxoahUnEq1wn45OS0YzDDs0
 0ucoTgkbr8cSUmYLyu/5d4slirHwDS7UjRAuKpxjf6CoYLoTLtUhSF7PnRv+hyNTzrvg
 RN7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=s952dEocL2LUiLuud/jfMece80/St42Nkk9Q0Xd2scM=;
 fh=HJ504a3IBN+LNYDHKEC0SSOlXuElfg77UzHR4NmnjOM=;
 b=dxoQbwVDn5Ub6RQBSBdt8Xv9nUA2d/RFQWnKvUw8mXvaKWzGKZdWajVqeDb5YYmiP6
 wBEaSgLnMP67dL/aytFWx1DO9qDfrMpcP3uqZgsjScUFKcV+HRjBdzwSWr5n1pBGjHr0
 0VM9w4OTwRN0fNPtBk/3oIMOkNTcxBQLRo1skT2etRyB+6R49e/cvF71ZMlrO35Cc78Y
 jGmA46UY8EZT1svlFgIV0+5Sb13C4kjCk+c6Yj5pGKlK8JBnJSR9vxmcTPXBpxVA1U6y
 OCxwghLa5jAWKx1zdd9sisjmX1FyIXMpQO15SzBw6mvKE3LICALL7vAbV2J+aa4GOGAO
 caKA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779283407; x=1779888207; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s952dEocL2LUiLuud/jfMece80/St42Nkk9Q0Xd2scM=;
 b=PZmRksBgyzavPnOSJ3NCCki2wl3h3S+LTckdTaQoWMD5vUq+CshdgD4klM9OCTcFm8
 X7QdSoMwZYVvSrAlu/QqAhB0a97eu+EziVOWrv8Rop/GBBawsAZfeuqo8lIG1zSDgonZ
 Hz1WwKxXtm31wflQifd7IE72DHbtvQyuJMzsvz/6NtN3SWVaIIFnnAb6ZVYfSUQsuJ4e
 ZS6PDXkrh8fdYdLisHamUEsu9G7xgZ9MmaYW+xyxv3jH9FATOyqb3siJshqRReNPe3gd
 dOfxF2dMQL9Op/VgX0tnPC6IH9oMwK5jhYEgJoJxi9cSEI6VJ3y2XC9pqqQ1aFzSk/Vb
 QsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779283407; x=1779888207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s952dEocL2LUiLuud/jfMece80/St42Nkk9Q0Xd2scM=;
 b=p1VedmdyShZmO2xb1Xek5i7cL9pBj3FTByo+TutOpbnK73mUMBtGCE+gEDXFqBBlWy
 yWQBznzRH1WgN2aHEDzwMMp+9Kd7du100CPHfR65cObduNxECbY68YHHz8p+1zDH2qFE
 myIR1CYDcAIdXDwfJyo1RcZaITaGLG/dDM6Gu/jouFi03S//nR7jzVEjyeRee/Td47+t
 Sy1ggfi1fGDfVqxsAxPS1qzdJgD7kGXtXC518kGxQPUXDK19uQzqvb8M222pQuPSdIKJ
 9UXdBedkjeOpTnqiVnRZw/+ylsSTMnt7j1xwBfowlamC92/q1a/uXYrtE4H4p6e82b3u
 mSYw==
X-Gm-Message-State: AOJu0YwvUWSpFCm92A6Iq2mM1u4E6L9EJAapz3TnOso2W80NDtyYAwWh
 QUkqeG8Cf33lBQqIuBBb13qz6b0zflmFXC1vF8pzZp7IFdwCVnX4csT/QmiSMvlSb/XQnnveCZX
 mpG8i+Duz3gTEUSklKJtVTvfuT/lLrak=
X-Gm-Gg: Acq92OEtCSm0Jnls7IxQQhxxnE9Kd2+Tw9FwYKiuQDBT9zHAioJ6722uxjUg0HpZePN
 sMdodWVNOnxqHVubyUaj6PpK2ibx2Z5uWmI9X3lgrhoskQM95YzEK4+glGZx1kS2X19uelXAvKW
 knqLu1Fmon+RG/NPSle30pzu390ldvzNMyLeXsLU59ha9/pTVDCb+0iEXjdtVIxWtlx3xXx9NI7
 5k4hsSjtPhEIHYWEaCBMwxzhb/BmLvgmtUKnEjc8hklO37TZhIGlgMmosaBBfq0xH8kULUp2O/R
 1YDVLYwfrfQzw5qhtQAdqkQOa0orttLZy6r7jgR5t0qRFAtjPSR8yDx5ngdUsgaIkcZmCg==
X-Received: by 2002:a67:f109:0:b0:612:13af:f5de with SMTP id
 ada2fe7eead31-63a3ec8bb31mr4192067137.3.1779283406433; Wed, 20 May 2026
 06:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260520055018.800558-1-ray.wu@amd.com>
In-Reply-To: <20260520055018.800558-1-ray.wu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 May 2026 09:23:13 -0400
X-Gm-Features: AVHnY4ITMl9sdHvkJ50xpJ04TMCIOQjt3usmxFk4Lkb-LsDzOz4FrrJIOqQNW10
Message-ID: <CADnq5_N4z=1rPw3Qauv1z=UEDy1b748LxqA5D4G6r88J=XtJPA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix amdgpu_dm KUnit allmodconfig build
To: Ray Wu <ray.wu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>
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

On Wed, May 20, 2026 at 1:50=E2=80=AFAM Ray Wu <ray.wu@amd.com> wrote:
>
> [Why]
> With CONFIG_DRM_AMD_DC_KUNIT_TEST=3Dm, allmodconfig only defines the
> _MODULE variant. Four KUnit helper headers gate their declarations
> with #ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST, so the declarations vanish
> while the matching .c files (driven by IS_ENABLED() via
> STATIC_IFN_KUNIT) keep the functions non-static. The build breaks
> with implicit declarations and -Werror=3Dmissing-prototypes.
>
> amdgpu_dm_crc.h additionally uses symbols that its test file does not
> pull in indirectly, amdgpu_dm_colorop_test.c has a copy-paste
> duplicate function, and the three colorop TF bitmasks are not
> exported for modpost.
>
> [How]
> - Switch the crc/hdcp/color/psr KUnit guards to IS_ENABLED().
> - Make amdgpu_dm_crc.h self-contained (dc_types.h + forward decl).
> - Rename the duplicated shaper test back to its intended name.
> - Export amdgpu_dm_supported_{degam,shaper,blnd}_tfs via
>   EXPORT_IF_KUNIT().
>
> Assisted-by: Copilot:claude-4-opus
>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h      | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c    | 4 ++++
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h        | 5 ++++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h       | 2 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h        | 2 +-
>  .../drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.c | 2 +-
>  6 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
> index 5e484359b8a7..19d3a13572f5 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
> @@ -42,7 +42,7 @@ struct dc_rgb;
>  struct fixed31_32;
>  struct tetrahedral_params;
>
> -#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
> +#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
>  /*
>   * Prototypes for functions exposed to KUnit tests. The enum types
>   * used below (dc_transfer_func_predefined, amdgpu_transfer_function,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 212c13b745d0..7c83fe6df395 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> @@ -31,6 +31,7 @@
>
>  #include "amdgpu.h"
>  #include "amdgpu_dm_colorop.h"
> +#include "amdgpu_dm_kunit_helpers.h"
>  #include "dc.h"
>
>  const u64 amdgpu_dm_supported_degam_tfs =3D
> @@ -38,18 +39,21 @@ const u64 amdgpu_dm_supported_degam_tfs =3D
>         BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>         BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
>         BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> +EXPORT_IF_KUNIT(amdgpu_dm_supported_degam_tfs);
>
>  const u64 amdgpu_dm_supported_shaper_tfs =3D
>         BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
>         BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
>         BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
>         BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
> +EXPORT_IF_KUNIT(amdgpu_dm_supported_shaper_tfs);
>
>  const u64 amdgpu_dm_supported_blnd_tfs =3D
>         BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>         BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
>         BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
>         BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
> +EXPORT_IF_KUNIT(amdgpu_dm_supported_blnd_tfs);
>
>  #define MAX_COLOR_PIPELINE_OPS 10
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
> index 76731ee44e13..c9aa0c82038f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
> @@ -27,8 +27,11 @@
>  #ifndef AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_
>  #define AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_
>
> +#include "dc_types.h"
> +
>  struct drm_crtc;
>  struct dm_crtc_state;
> +struct amdgpu_device;
>
>  enum amdgpu_dm_pipe_crc_source {
>         AMDGPU_DM_PIPE_CRC_SOURCE_NONE =3D 0,
> @@ -148,7 +151,7 @@ void amdgpu_dm_crtc_secure_display_create_contexts(st=
ruct amdgpu_device *adev);
>  #define amdgpu_dm_crtc_secure_display_create_contexts(x)
>  #endif
>
> -#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
> +#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
>  enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source);
>  bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src);
>  bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> index 4bb072cfac1e..90b18c450ca6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> @@ -94,7 +94,7 @@ void hdcp_destroy(struct kobject *kobj, struct hdcp_wor=
kqueue *work);
>
>  struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev,=
 struct cp_psp *cp_psp, struct dc *dc);
>
> -#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
> +#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
>  void process_output(struct hdcp_workqueue *hdcp_work);
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h b/driv=
ers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
> index 1a41d9b99eb4..9f3e22520ca0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h
> @@ -40,7 +40,7 @@ bool amdgpu_dm_psr_set_event(struct amdgpu_display_mana=
ger *dm,
>                 struct dc_stream_state *stream, bool set_event, enum psr_=
event event,
>                 bool wait_for_disable);
>
> -#ifdef CONFIG_DRM_AMD_DC_KUNIT_TEST
> +#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
>  void amdgpu_dm_psr_fill_caps(struct dc_link *link, struct psr_caps *caps=
);
>  #endif
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_coloro=
p_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_te=
st.c
> index 8bdebcaf42b2..30b5adb23570 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.=
c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_colorop_test.=
c
> @@ -72,7 +72,7 @@ static void dm_test_supported_shaper_tfs_has_gamma22(st=
ruct kunit *test)
>                           BIT(DRM_COLOROP_1D_CURVE_GAMMA22));
>  }
>
> -static void dm_test_supported_degam_tfs_no_extra_bits(struct kunit *test=
)
> +static void dm_test_supported_shaper_tfs_no_extra_bits(struct kunit *tes=
t)
>  {
>         u64 expected =3D BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
>                        BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
> --
> 2.43.0
>
