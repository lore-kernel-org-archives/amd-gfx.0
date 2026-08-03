Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3B7C55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 12:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C8610E64C;
	Mon,  3 Aug 2026 12:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I92SC1MD";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400A010E03A
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 12:48:17 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6a0ddef4e35so1596325a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 05:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785761295; x=1786366095; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hw+BUGFAnzO2/+3+71fJcVlk5CC9YTd76weOC0ZH9Rk=;
 b=I92SC1MDy6ODlFYuzR6xSgabeDDkmfxq2vvJAQLtXX5Fn/AcgbENJkYTAtxFBGZRqy
 nkWTGaA7HjgHK3OzKH0X2F43nKYP783MrpHtyG2u0nDsPZPAPpF2iYayXnevBAXzyyjm
 B+sa7YOA3uZ6Hy+Vkcc1+fEnWq0+XgHyRA0XZu2jBxMVWn1QYexy6TWsVgg23LysfJ53
 yUPcc+1+WZTGVrd3dKSA4N5V6hsAs9WWtK2oeCgDkRlRMmIX54I14o50pmZ4WS1UOPB+
 NRirfi6XG6RGKY83dGSETAR97kC5FD+qiyfvkr/8GpfW0LM2dkpHwhcHy1DqqADph7uL
 u9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785761295; x=1786366095;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hw+BUGFAnzO2/+3+71fJcVlk5CC9YTd76weOC0ZH9Rk=;
 b=aS5DmntVkQ3MSVWiNbjyoe8zBjsx1hha7XF9siUBRft4gDicmbJvdDfd7BczjDfmR8
 THtFJ68Z4rI29IQ/zH77eJ4dTqf8CiLN9A/MH5a2aSxsTjS3ur8dGkgxgTY3KWhiSIS5
 5aUtzBPwrrfUgp3jhb75FvV74nOhihACBC4/4t1pCtjTjA5vSs49TR9H3n+i/dbwY3yn
 2J9NBRWX6NxZx8b8BYB5bZxQ2X/QwrXqL+eWmgzvft3DXqKcKj1A+BBDUOYQhWTCriix
 NjLGXTEdBiyOVSoAYAx/dkNg9kJ378EQbCeZaunOrBDddgt6har+el5Q86Bd/NfzzfMC
 BL/A==
X-Gm-Message-State: AOJu0YxlKAWacK5WWRm1HMfowvnliWbnO+3eY23cGiAC4dz97fNB/3L6
 zQYZv29tMe52NlGqfr9bWmWan7gozH8J0ICSyCN01ufubl/2EuRr1hJPrKbBCvXQ
X-Gm-Gg: AR+sD129YqLQ605MONjUQXVdCgBNNNlKBbkY9PYQdHPLE9pHFki1gJubc4dndxV4Znb
 9nfAXWHeCmrhV7E19D39Qb1SwG+re/BqLLGM8ZxfoQtMlHQhkYB5gCNqRsHCQlotUa3+JA//1Lo
 kO8abS+qnOskJmO8NiMR4jjeRtKbZQI46CxL7QHSjvftrPMR7xmVfjpMnlvqLwfoFSRhynwW926
 6V1JFlyRt6pVX7SGJ4chauskYcfMhPm/qptrk+ytBadBgxt4SFBDN8ns72GCd7KFHD4TJvJ11OG
 0cTCwlam9fb3/ic1+HYhnU6rrJVFELBgRZ84ETrn+hHtFZ0ZE9WkcKiZ1tGsj8AlpqgdaWGKtKt
 oDSUt6hlRV4ZV221YR3GgguURaqm2Jsv7UR/5jvj0MPlFrHibI5BqTVUJZIwHCcDfng9nWuX8DI
 pzQxgpR9Lpd3kcQmgctQY1EWHa/h/eKSvzuz+ipRu1E8x9W/vGekLiMJd3Rnw7kBdikswOGHYiP
 rsvWax1SykoCqWtakzIdkMOgmAD+Hw/feDgs5BNo8gQV/g=
X-Received: by 2002:a17:907:c30b:b0:c12:979c:5a5e with SMTP id
 a640c23a62f3a-c1fefc04e48mr721728466b.0.1785761294813; 
 Mon, 03 Aug 2026 05:48:14 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D2B5.dsl.pool.telekom.hu.
 [84.1.210.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fd3c93a87sm552661966b.18.2026.08.03.05.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 05:48:14 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>,
 Alex Hung <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>,
 Chenyu Chen <Chen-Yu.Chen@amd.com>,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>
Subject: Re: [PATCH 17/49] drm/amd/display: add cursor module
Date: Mon, 03 Aug 2026 14:48:12 +0200
Message-ID: <QIaxY4saSrOXjv0fWPk8og@gmail.com>
In-Reply-To: <20260723201908.373300-18-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
 <20260723201908.373300-18-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, July 23, 2026 10:13:25=E2=80=AFPM Central European Summer Time=
 Fangzhi=20
Zuo wrote:
> From: Alex Hung <alex.hung@amd.com>
>=20
> [WHAT]
> Group the cursor policy and validation helpers from amdgpu_dm.c
> into a dedicated amdgpu_dm_cursor.c and amdgpu_dm_cursor.h.
> The moved functions are:
>=20
>   dm_check_cursor_fb, dm_check_native_cursor_state,
>   dm_should_update_native_cursor, dm_get_oriented_plane_size,
>   dm_get_plane_scale, dm_plane_color_pipeline_active,
>   dm_crtc_get_cursor_mode.
>=20
> The cursor helpers exposed by amdgpu_dm_cursor.h are called from
> amdgpu_dm.c, so give the three that lacked a namespace prefix the
> standard amdgpu_dm_ prefix: amdgpu_dm_check_native_cursor_state,
> amdgpu_dm_should_update_native_cursor and
> amdgpu_dm_crtc_get_cursor_mode.
>=20
> The descending-zpos plane iterator shared by these functions and
> amdgpu_dm_atomic_check (the for_each_oldnew_plane_in_descending_zpos
> macro and its __get_next_zpos helper) moves to amdgpu_dm.h, with
> the helper renamed amdgpu_dm_get_next_zpos and made non-static.
>=20
> Relocate the corresponding KUnit tests into amdgpu_dm_cursor_test.c.
>=20
> No functional change.

Hi,

This commit regresses a recent bug fix from commit "Set native cursor mode =
for=20
disabled CRTCs". The amdgpu_dm_crtc_get_cursor_mode() function that was add=
ed=20
to amdgpu_dm_cursor.c is not the same as was removed from amdgpu_dm.c

I've submitted a fix here:
https://lists.freedesktop.org/archives/amd-gfx/2026-August/149759.html
Please review.

Thanks & best regards,
Timur


>=20
> Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 436 +----------------
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  24 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  | 443 ++++++++++++++++++
>  .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |  52 ++
>  .../drm/amd/display/amdgpu_dm/tests/Makefile  |   1 +
>  .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 268 +++++++++++
>  .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 232 ---------
>  8 files changed, 796 insertions(+), 663 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_curso=
r.c
> create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor=
=2Eh
> create mode 100644
> drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile index
> 5cb8c143e72f..d1faf2d8370f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> @@ -46,7 +46,8 @@ AMDGPUDM =3D \
>  	amdgpu_dm_audio.o \
>  	amdgpu_dm_dmub.o \
>  	amdgpu_dm_connector.o \
> -	amdgpu_dm_freesync.o
> +	amdgpu_dm_freesync.o \
> +	amdgpu_dm_cursor.o
>=20
>  ifdef CONFIG_DRM_AMD_DC_FP
>  AMDGPUDM +=3D dc_fpu.o
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> c36eb8a1d2d1..217ec822e93e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -72,6 +72,7 @@
>  #include "amdgpu_dm_connector.h"
>  #include "amdgpu_dm_pp_smu.h"
>  #include "amdgpu_dm_freesync.h"
> +#include "amdgpu_dm_cursor.h"
>=20
>  #include "ivsrcid/ivsrcid_vislands30.h"
>=20
> @@ -5760,133 +5761,6 @@ static bool should_reset_plane(struct
> drm_atomic_commit *state, return false;
>  }
>=20
> -static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
> -			      struct drm_plane_state=20
*new_plane_state,
> -			      struct drm_framebuffer *fb)
> -{
> -	struct amdgpu_device *adev =3D drm_to_adev(new_acrtc->base.dev);
> -	struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(fb);
> -	unsigned int pitch;
> -	bool linear;
> -
> -	if (fb->width > new_acrtc->max_cursor_width ||
> -	    fb->height > new_acrtc->max_cursor_height) {
> -		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size=20
%dx%d\n",
> -				 new_plane_state->fb->width,
> -				 new_plane_state->fb->height);
> -		return -EINVAL;
> -	}
> -	if (new_plane_state->src_w !=3D fb->width << 16 ||
> -	    new_plane_state->src_h !=3D fb->height << 16) {
> -		drm_dbg_atomic(adev_to_drm(adev), "Cropping not=20
supported for cursor
> plane\n"); -		return -EINVAL;
> -	}
> -
> -	/* Pitch in pixels */
> -	pitch =3D fb->pitches[0] / fb->format->cpp[0];
> -
> -	if (fb->width !=3D pitch) {
> -		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d=20
doesn't match pitch
> %d", -				 fb->width, pitch);
> -		return -EINVAL;
> -	}
> -
> -	switch (pitch) {
> -	case 64:
> -	case 128:
> -	case 256:
> -		/* FB pitch is supported by cursor plane */
> -		break;
> -	default:
> -		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch=20
%d px\n", pitch);
> -		return -EINVAL;
> -	}
> -
> -	/* Core DRM takes care of checking FB modifiers, so we only need to
> -	 * check tiling flags when the FB doesn't have a modifier.
> -	 */
> -	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
> -		if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0) {
> -			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
GFX12_SWIZZLE_MODE) =3D=3D 0;
> -		} else if (adev->family >=3D AMDGPU_FAMILY_AI) {
> -			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
SWIZZLE_MODE) =3D=3D 0;
> -		} else {
> -			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
ARRAY_MODE) !=3D
> DC_ARRAY_2D_TILED_THIN1 && -				=20
AMDGPU_TILING_GET(afb->tiling_flags,
> ARRAY_MODE) !=3D DC_ARRAY_1D_TILED_THIN1 && -			=09
> AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) =3D=3D 0;
> -		}
> -		if (!linear) {
> -			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB=20
not linear");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
> -/*
> - * Helper function for checking the cursor in native mode
> - */
> -static int dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
> -					struct drm_plane=20
*plane,
> -					struct drm_plane_state=20
*new_plane_state,
> -					bool enable)
> -{
> -
> -	struct amdgpu_crtc *new_acrtc;
> -	int ret;
> -
> -	if (!enable || !new_plane_crtc ||
> -	    drm_atomic_plane_disabling(plane->state, new_plane_state))
> -		return 0;
> -
> -	new_acrtc =3D to_amdgpu_crtc(new_plane_crtc);
> -
> -	if (new_plane_state->src_x !=3D 0 || new_plane_state->src_y !=3D 0) {
> -		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not=20
supported for cursor
> plane\n"); -		return -EINVAL;
> -	}
> -
> -	if (new_plane_state->fb) {
> -		ret =3D dm_check_cursor_fb(new_acrtc, new_plane_state,
> -					=09
new_plane_state->fb);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
> -STATIC_IFN_KUNIT bool dm_should_update_native_cursor(struct
> drm_atomic_commit *state, -				=09
	     struct drm_crtc *old_plane_crtc,
> -						     struct=20
drm_crtc *new_plane_crtc,
> -						     bool=20
enable)
> -{
> -	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> -	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
> -
> -	if (!enable) {
> -		if (old_plane_crtc =3D=3D NULL)
> -			return true;
> -
> -		old_crtc_state =3D drm_atomic_get_old_crtc_state(
> -			state, old_plane_crtc);
> -		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);
> -
> -		return dm_old_crtc_state->cursor_mode =3D=3D=20
DM_CURSOR_NATIVE_MODE;
> -	} else {
> -		if (new_plane_crtc =3D=3D NULL)
> -			return true;
> -
> -		new_crtc_state =3D drm_atomic_get_new_crtc_state(
> -			state, new_plane_crtc);
> -		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
> -
> -		return dm_new_crtc_state->cursor_mode =3D=3D=20
DM_CURSOR_NATIVE_MODE;
> -	}
> -}
> -EXPORT_IF_KUNIT(dm_should_update_native_cursor);
> -
>  static int dm_update_plane_state(struct dc *dc,
>  				 struct drm_atomic_commit *state,
>  				 struct drm_plane *plane,
> @@ -5911,14 +5785,14 @@ static int dm_update_plane_state(struct dc *dc,
>  	dm_new_plane_state =3D to_dm_plane_state(new_plane_state);
>  	dm_old_plane_state =3D to_dm_plane_state(old_plane_state);
>=20
> -	update_native_cursor =3D dm_should_update_native_cursor(state,
> -							     =20
old_plane_crtc,
> -							     =20
new_plane_crtc,
> -							     =20
enable);
> +	update_native_cursor =3D amdgpu_dm_should_update_native_cursor(state,
> +							=09
     old_plane_crtc,
> +							=09
     new_plane_crtc,
> +							=09
     enable);
>=20
>  	if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR && update_native_cursor)=20
{
> -		ret =3D dm_check_native_cursor_state(new_plane_crtc,=20
plane,
> -						   =20
new_plane_state, enable);
> +		ret =3D=20
amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
> +							 =20
new_plane_state, enable);
>  		if (ret)
>  			return ret;
>=20
> @@ -6048,8 +5922,8 @@ static int dm_update_plane_state(struct dc *dc,
>  out:
>  	/* If enabling cursor overlay failed, attempt fallback to native=20
mode */
>  	if (enable && ret =3D=3D -EINVAL && plane->type =3D=3D=20
DRM_PLANE_TYPE_CURSOR) {
> -		ret =3D dm_check_native_cursor_state(new_plane_crtc,=20
plane,
> -						   =20
new_plane_state, enable);
> +		ret =3D=20
amdgpu_dm_check_native_cursor_state(new_plane_crtc, plane,
> +							 =20
new_plane_state, enable);
>  		if (ret)
>  			return ret;
>=20
> @@ -6059,37 +5933,6 @@ static int dm_update_plane_state(struct dc *dc,
>  	return ret;
>  }
>=20
> -STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state
> *plane_state, -					 int=20
*src_w, int *src_h)
> -{
> -	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> -	case DRM_MODE_ROTATE_90:
> -	case DRM_MODE_ROTATE_270:
> -		*src_w =3D plane_state->src_h >> 16;
> -		*src_h =3D plane_state->src_w >> 16;
> -		break;
> -	case DRM_MODE_ROTATE_0:
> -	case DRM_MODE_ROTATE_180:
> -	default:
> -		*src_w =3D plane_state->src_w >> 16;
> -		*src_h =3D plane_state->src_h >> 16;
> -		break;
> -	}
> -}
> -EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
> -
> -STATIC_IFN_KUNIT void
> -dm_get_plane_scale(struct drm_plane_state *plane_state,
> -		   int *out_plane_scale_w, int *out_plane_scale_h)
> -{
> -	int plane_src_w, plane_src_h;
> -
> -	dm_get_oriented_plane_size(plane_state, &plane_src_w,=20
&plane_src_h);
> -	*out_plane_scale_w =3D plane_src_w ? plane_state->crtc_w * 1000 /
> plane_src_w : 0; -	*out_plane_scale_h =3D plane_src_h ? plane_state-
>crtc_h *
> 1000 / plane_src_h : 0; -}
> -EXPORT_IF_KUNIT(dm_get_plane_scale);
> -
>  /*
>   * The normalized_zpos value cannot be used by this iterator directly. I=
t's
> only * calculated for enabled planes, potentially causing normalized_zpos
> collisions @@ -6097,7 +5940,7 @@ EXPORT_IF_KUNIT(dm_get_plane_scale);
>   * so that the iterator will not generate the same object twice, or loop
>   * indefinitely.
>   */
> -static inline struct __drm_planes_state *__get_next_zpos(
> +struct __drm_planes_state *amdgpu_dm_get_next_zpos(
>  	struct drm_atomic_commit *state,
>  	struct __drm_planes_state *prev)
>  {
> @@ -6135,19 +5978,6 @@ static inline struct __drm_planes_state
> *__get_next_zpos( return &state->planes[highest_i];
>  }
>=20
> -/*
> - * Use the uniqueness of the plane's (zpos, drm obj ID) combination to
> iterate - * by descending zpos, as read from the new plane state. This is
> the same - * ordering as defined by drm_atomic_normalize_zpos().
> - */
> -#define for_each_oldnew_plane_in_descending_zpos(__state, plane,
> old_plane_state, new_plane_state) \ -	for (struct __drm_planes_state *__i=
 =3D
> __get_next_zpos((__state), NULL); \ -	     __i !=3D NULL; __i =3D
> __get_next_zpos((__state), __i))		\
> -		for_each_if(((plane) =3D __i->ptr,		=09
	\
> -			     (void)(plane) /* Only to avoid unused-
but-set-variable warning */,
> \ -			     (old_plane_state) =3D __i->old_state,	=09
\
> -			     (new_plane_state) =3D __i->new_state, 1))
> -
>  static int add_affected_mst_dsc_crtcs(struct drm_atomic_commit *state,
> struct drm_crtc *crtc) {
>  	struct drm_connector *connector;
> @@ -6178,244 +6008,6 @@ static int add_affected_mst_dsc_crtcs(struct
> drm_atomic_commit *state, struct dr return
> drm_dp_mst_add_affected_dsc_crtcs(state, &aconnector->mst_root->mst_mgr);=
 }
>=20
> -/**
> - * DOC: Cursor Modes - Native vs Overlay
> - *
> - * In native mode, the cursor uses a integrated cursor pipe within each =
DCN
> hw - * plane. It does not require a dedicated hw plane to enable, but it =
is
> - * subjected to the same z-order and scaling as the hw plane. It also has
> format - * restrictions, a RGB cursor in native mode cannot be enabled
> within a non-RGB - * hw plane.
> - *
> - * In overlay mode, the cursor uses a separate DCN hw plane, and thus has
> its - * own scaling and z-pos. It also has no blending restrictions. It
> lends to a - * cursor behavior more akin to a DRM client's expectations.
> However, it does - * occupy an extra DCN plane, and therefore will only be
> used if a DCN plane is - * available.
> - */
> -
> -/**
> - * dm_plane_color_pipeline_active() - Check if a plane's color pipeline
> active. - * @state: DRM atomic state
> - * @plane: DRM plane to check
> - * @use_old: if true, inspect the old colorop states; otherwise the new
> ones - *
> - * A color pipeline may be selected (color_pipeline !=3D NULL) but still=
 is
> - * inactive if every colorop in the chain is bypassed.  Only return
> - * true when at least one colorop has bypass =3D=3D false, meaning the c=
ursor
> - * would be subjected to the transformation in native mode.
> - *
> - * Return: true if the pipeline modifies pixels, false otherwise.
> - */
> -static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *sta=
te,
> -					   struct drm_plane=20
*plane,
> -					   bool use_old)
> -{
> -	struct drm_colorop *colorop;
> -	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
> -	int i;
> -
> -	for_each_oldnew_colorop_in_state(state, colorop,=20
old_colorop_state,
> new_colorop_state, i) { -		struct drm_colorop_state *cstate =3D=20
use_old ?
> old_colorop_state : new_colorop_state; -
> -		if (cstate->colorop->plane !=3D plane)
> -			continue;
> -		if (!cstate->bypass)
> -			return true;
> -	}
> -	return false;
> -}
> -
> -/**
> - * dm_crtc_get_cursor_mode() - Determine the required cursor mode on crtc
> - * @adev: amdgpu device
> - * @state: DRM atomic state
> - * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
> - * @cursor_mode: Returns the required cursor mode on dm_crtc_state
> - *
> - * Get whether the cursor should be enabled in native mode, or overlay
> mode, on - * the dm_crtc_state.
> - *
> - * The cursor should be enabled in overlay mode if there exists an
> underlying - * plane - on which the cursor may be blended - that is either
> YUV formatted, - * scaled differently from the cursor, or has a color
> pipeline active. - *
> - * Since zpos info is required, drm_atomic_normalize_zpos must be called
> before - * calling this function.
> - *
> - * Return: 0 on success, or an error code if getting the cursor plane st=
ate
> - * failed.
> - */
> -static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
> -				   struct drm_atomic_commit=20
*state,
> -				   struct dm_crtc_state=20
*dm_crtc_state,
> -				   enum amdgpu_dm_cursor_mode=20
*cursor_mode)
> -{
> -	struct drm_plane_state *old_plane_state, *plane_state,=20
*cursor_state;
> -	struct drm_crtc_state *crtc_state =3D &dm_crtc_state->base;
> -	struct drm_plane *plane;
> -	bool consider_mode_change =3D false;
> -	bool entire_crtc_covered =3D false;
> -	bool cursor_changed =3D false;
> -	int underlying_scale_w, underlying_scale_h;
> -	int cursor_scale_w, cursor_scale_h;
> -	int i;
> -
> -	/* Overlay cursor not supported on HW before DCN
> -	 * DCN401/420 does not have the cursor-on-scaled-plane or
> cursor-on-yuv-plane restrictions -	 * as previous DCN generations, so
> enable native mode on DCN401/420 -	 *
> -	 * Always set native cursor mode when the CRTC is disabled,
> -	 * to make sure it doesn't cause atomic commits to fail when
> -	 * they are trying to disable the CRTC.
> -	 */
> -	if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1) ||
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 0) ||
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1) ||
> -	    !dm_crtc_state->base.enable) {
> -		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> -		return 0;
> -	}
> -
> -	/* Init cursor_mode to be the same as current */
> -	*cursor_mode =3D dm_crtc_state->cursor_mode;
> -
> -	/*
> -	 * Cursor mode can change if a plane's format changes, scale=20
changes, is
> -	 * enabled/disabled, z-order changes, or color management=20
properties
> change. -	 */
> -	for_each_oldnew_plane_in_state(state, plane, old_plane_state,=20
plane_state,
> i) { -		int new_scale_w, new_scale_h, old_scale_w,=20
old_scale_h;
> -
> -		/* Only care about planes on this CRTC */
> -		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D=20
0)
> -			continue;
> -
> -		if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> -			cursor_changed =3D true;
> -
> -		if (drm_atomic_plane_enabling(old_plane_state,=20
plane_state) ||
> -		    drm_atomic_plane_disabling(old_plane_state,=20
plane_state) ||
> -		    old_plane_state->fb->format !=3D plane_state->fb-
>format) {
> -			consider_mode_change =3D true;
> -			break;
> -		}
> -
> -		dm_get_plane_scale(plane_state, &new_scale_w,=20
&new_scale_h);
> -		dm_get_plane_scale(old_plane_state, &old_scale_w,=20
&old_scale_h);
> -		if (new_scale_w !=3D old_scale_w || new_scale_h !=3D=20
old_scale_h) {
> -			consider_mode_change =3D true;
> -			break;
> -		}
> -
> -		/*
> -		 * A non-cursor plane moving or resizing (without a=20
scale change)
> -		 * changes how much of the CRTC it covers. This can=20
create or
> -		 * remove a hole under the cursor and thus flip the=20
required
> -		 * cursor mode (native vs overlay), so its destination=20
rect must
> -		 * be re-evaluated too.
> -		 *
> -		 * The cursor plane itself is deliberately excluded:=20
the cursor
> -		 * mode depends on the underlying planes' coverage, not=20
on the
> -		 * cursor's position (see the entire_crtc_covered logic=20
below).
> -		 * Triggering on cursor movement would force every=20
legacy cursor
> -		 * update off its fast path, and in a cursor-only commit=20
=2D where
> -		 * the underlying planes are not part of the state -=20
the coverage
> -		 * loop would see no covering plane and misevaluate the=20
mode as
> -		 * overlay, regressing flip-vs-cursor-legacy.
> -		 */
> -		if (plane->type !=3D DRM_PLANE_TYPE_CURSOR &&
> -		    (old_plane_state->crtc_x !=3D plane_state->crtc_x ||
> -		     old_plane_state->crtc_y !=3D plane_state->crtc_y ||
> -		     old_plane_state->crtc_w !=3D plane_state->crtc_w ||
> -		     old_plane_state->crtc_h !=3D plane_state->crtc_h)) {
> -			consider_mode_change =3D true;
> -			break;
> -		}
> -
> -		if (dm_plane_color_pipeline_active(state, plane, true)=20
!=3D
> -		    dm_plane_color_pipeline_active(state, plane,=20
false)) {
> -			consider_mode_change =3D true;
> -			break;
> -		}
> -	}
> -
> -	if (!consider_mode_change && !crtc_state->zpos_changed)
> -		return 0;
> -
> -	/*
> -	 * If no cursor change on this CRTC, and not enabled on this CRTC,=20
then
> -	 * no need to set cursor mode. This avoids needlessly locking the=20
cursor
> -	 * state.
> -	 */
> -	if (!cursor_changed &&
> -	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state-
>plane_mask))
> { -		return 0;
> -	}
> -
> -	cursor_state =3D drm_atomic_get_plane_state(state,
> -						 =20
crtc_state->crtc->cursor);
> -	if (IS_ERR(cursor_state))
> -		return PTR_ERR(cursor_state);
> -
> -	/* Cursor is disabled */
> -	if (!cursor_state->fb)
> -		return 0;
> -
> -	/* For all planes in descending z-order (all of which are below=20
cursor
> -	 * as per zpos definitions), check their scaling and format
> -	 */
> -	for_each_oldnew_plane_in_descending_zpos(state, plane,=20
old_plane_state,
> plane_state) { -
> -		/* Only care about non-cursor planes on this CRTC */
> -		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D=20
0 ||
> -		    plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> -			continue;
> -
> -		/* Underlying plane is YUV format - use overlay cursor=20
*/
> -		if (amdgpu_dm_plane_is_video_format(plane_state->fb-
>format->format)) {
> -			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> -			return 0;
> -		}
> -
> -		/* Underlying plane has an active color pipeline -=20
cursor would be
> transformed */ -		if (dm_plane_color_pipeline_active(state,=20
plane, false))
> {
> -			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> -			return 0;
> -		}
> -
> -		dm_get_plane_scale(plane_state,
> -				   &underlying_scale_w,=20
&underlying_scale_h);
> -		dm_get_plane_scale(cursor_state,
> -				   &cursor_scale_w,=20
&cursor_scale_h);
> -
> -		/* Underlying plane has different scale - use overlay=20
cursor */
> -		if (cursor_scale_w !=3D underlying_scale_w &&
> -		    cursor_scale_h !=3D underlying_scale_h) {
> -			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> -			return 0;
> -		}
> -
> -		/* If this plane covers the whole CRTC, no need to=20
check planes
> underneath */ -		if (plane_state->crtc_x <=3D 0 &&=20
plane_state->crtc_y <=3D 0
> &&
> -		    plane_state->crtc_x + plane_state->crtc_w >=3D
> crtc_state->mode.hdisplay && -		    plane_state->crtc_y +
> plane_state->crtc_h >=3D crtc_state->mode.vdisplay) { -		=09
entire_crtc_covered
> =3D true;
> -			break;
> -		}
> -	}
> -
> -	/* If planes do not cover the entire CRTC, use overlay mode to=20
enable
> -	 * cursor over holes
> -	 */
> -	if (entire_crtc_covered)
> -		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> -	else
> -		*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> -
> -	return 0;
> -}
> -
>  static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
>  					    struct=20
drm_atomic_commit *state,
>  					    struct=20
drm_crtc_state *crtc_state)
> @@ -6619,8 +6211,8 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev, for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>  		dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
>=20
> -		ret =3D dm_crtc_get_cursor_mode(adev, state,=20
dm_new_crtc_state,
> -					     =20
&dm_new_crtc_state->cursor_mode);
> +		ret =3D amdgpu_dm_crtc_get_cursor_mode(adev, state,=20
dm_new_crtc_state,
> +						    =20
&dm_new_crtc_state->cursor_mode);
>  		if (ret) {
>  			drm_dbg(dev, "Failed to determine cursor=20
mode: %pe\n", ERR_PTR(ret));
>  			goto fail;
> @@ -6754,8 +6346,8 @@ static int amdgpu_dm_atomic_check(struct drm_device
> *dev, }
>=20
>  		/* If HW can only do native cursor, check restrictions=20
again */
> -		ret =3D dm_crtc_get_cursor_mode(adev, state,=20
dm_new_crtc_state,
> -					     =20
&required_cursor_mode);
> +		ret =3D amdgpu_dm_crtc_get_cursor_mode(adev, state,=20
dm_new_crtc_state,
> +						    =20
&required_cursor_mode);
>  		if (ret) {
>  			drm_dbg_driver(crtc->dev,
>  				       "[CRTC:%d:%s] Checking=20
cursor mode failed\n",
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h index
> 1ef92a28e3e9..1ddf5bc88a03 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -1141,6 +1141,22 @@ void amdgpu_dm_emulated_link_detect(struct dc_link
> *link); void amdgpu_dm_apply_delay_after_dpcd_poweroff(struct amdgpu_devi=
ce
> *adev, struct dc_sink *sink);
>=20
> +struct __drm_planes_state *amdgpu_dm_get_next_zpos(struct drm_atomic_com=
mit
> *state, +						   struct=20
__drm_planes_state *prev);
> +
> +/*
> + * Use the uniqueness of the plane's (zpos, drm obj ID) combination to
> iterate + * by descending zpos, as read from the new plane state. This is
> the same + * ordering as defined by drm_atomic_normalize_zpos().
> + */
> +#define for_each_oldnew_plane_in_descending_zpos(__state, plane,
> old_plane_state, new_plane_state) \ +	for (struct __drm_planes_state *__i=
 =3D
> amdgpu_dm_get_next_zpos((__state), NULL); \ +	     __i !=3D NULL; __i =3D
> amdgpu_dm_get_next_zpos((__state), __i))		\ +	=09
for_each_if(((plane) =3D
> __i->ptr,				\
> +			     (void)(plane) /* Only to avoid unused-
but-set-variable warning */,
> \ +			     (old_plane_state) =3D __i->old_state,	=09
\
> +			     (new_plane_state) =3D __i->new_state, 1))
> +
>  #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
>  struct amdgpu_ip_block;
>  bool dm_is_idle(struct amdgpu_ip_block *ip_block);
> @@ -1157,19 +1173,11 @@ int dm_crtc_get_scanoutpos(struct amdgpu_device
> *adev, int crtc, struct dm_atomic_state *dm_atomic_get_new_state(struct
> drm_atomic_commit *state); void dm_atomic_destroy_state(struct
> drm_private_obj *obj,
>  			     struct drm_private_state *state);
> -bool dm_should_update_native_cursor(struct drm_atomic_commit *state,
> -				    struct drm_crtc=20
*old_plane_crtc,
> -				    struct drm_crtc=20
*new_plane_crtc,
> -				    bool enable);
>  int dm_plane_layer_index_cmp(const void *a, const void *b);
>  int fill_plane_color_attributes(const struct drm_plane_state *plane_stat=
e,
>  				const enum surface_pixel_format=20
format,
>  				enum dc_color_space=20
*color_space);
>  bool modereset_required(struct drm_crtc_state *crtc_state);
> -void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
> -				int *src_w, int *src_h);
> -void dm_get_plane_scale(struct drm_plane_state *plane_state,
> -			int *out_plane_scale_w, int=20
*out_plane_scale_h);
>  bool is_scaling_state_different(const struct dm_connector_state *dm_stat=
e,
>  				const struct dm_connector_state=20
*old_dm_state);
>  void set_multisync_trigger_params(struct dc_stream_state *stream);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c new file mode
> 100644
> index 000000000000..ab50d58896ab
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.c
> @@ -0,0 +1,443 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"), + * to deal in the Software without restriction, including
> without limitation + * the rights to use, copy, modify, merge, publish,
> distribute, sublicense, + * and/or sell copies of the Software, and to
> permit persons to whom the + * Software is furnished to do so, subject to
> the following conditions: + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> OR + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E=20
> IN NO EVENT SHALL + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
> ANY CLAIM, DAMAGES OR + * OTHER LIABILITY, WHETHER IN AN ACTION OF
> CONTRACT, TORT OR OTHERWISE, + * ARISING FROM, OUT OF OR IN CONNECTION WI=
TH
> THE SOFTWARE OR THE USE OR + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_blend.h>
> +#include <drm/drm_fourcc.h>
> +#include <drm/drm_framebuffer.h>
> +#include <drm/drm_plane.h>
> +#include <drm/drm_colorop.h>
> +
> +#include "dc.h"
> +#include "dal_asic_id.h"
> +#include "amdgpu.h"
> +#include "amdgpu_display.h"
> +#include "amdgpu_dm.h"
> +#include "amdgpu_dm_plane.h"
> +#include "amdgpu_dm_cursor.h"
> +#include "dm_helpers.h"
> +
> +static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
> +			      struct drm_plane_state=20
*new_plane_state,
> +			      struct drm_framebuffer *fb)
> +{
> +	struct amdgpu_device *adev =3D drm_to_adev(new_acrtc->base.dev);
> +	struct amdgpu_framebuffer *afb =3D to_amdgpu_framebuffer(fb);
> +	unsigned int pitch;
> +	bool linear;
> +
> +	if (fb->width > new_acrtc->max_cursor_width ||
> +	    fb->height > new_acrtc->max_cursor_height) {
> +		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size=20
%dx%d\n",
> +				 new_plane_state->fb->width,
> +				 new_plane_state->fb->height);
> +		return -EINVAL;
> +	}
> +	if (new_plane_state->src_w !=3D fb->width << 16 ||
> +	    new_plane_state->src_h !=3D fb->height << 16) {
> +		drm_dbg_atomic(adev_to_drm(adev), "Cropping not=20
supported for cursor
> plane\n"); +		return -EINVAL;
> +	}
> +
> +	/* Pitch in pixels */
> +	pitch =3D fb->pitches[0] / fb->format->cpp[0];
> +
> +	if (fb->width !=3D pitch) {
> +		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d=20
doesn't match pitch
> %d", +				 fb->width, pitch);
> +		return -EINVAL;
> +	}
> +
> +	switch (pitch) {
> +	case 64:
> +	case 128:
> +	case 256:
> +		/* FB pitch is supported by cursor plane */
> +		break;
> +	default:
> +		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch=20
%d px\n", pitch);
> +		return -EINVAL;
> +	}
> +
> +	/* Core DRM takes care of checking FB modifiers, so we only need to
> +	 * check tiling flags when the FB doesn't have a modifier.
> +	 */
> +	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
> +#if defined(CONFIG_DRM_AMD_DC_DCN6_0) || defined(CONFIG_DRM_AMD_DC_DCN5_=
0)
> +		if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0
> +		    || adev->family =3D=3D AMDGPU_FAMILY_GC_13_0_1) {
> +#else
> +		if (adev->family =3D=3D AMDGPU_FAMILY_GC_12_0_0) {
> +#endif
> +			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
GFX12_SWIZZLE_MODE) =3D=3D 0;
> +		} else if (adev->family >=3D AMDGPU_FAMILY_AI) {
> +			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
SWIZZLE_MODE) =3D=3D 0;
> +		} else {
> +			linear =3D AMDGPU_TILING_GET(afb->tiling_flags,=20
ARRAY_MODE) !=3D
> DC_ARRAY_2D_TILED_THIN1 && +				=20
AMDGPU_TILING_GET(afb->tiling_flags,
> ARRAY_MODE) !=3D DC_ARRAY_1D_TILED_THIN1 && +			=09
> AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) =3D=3D 0;
> +		}
> +		if (!linear) {
> +			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB=20
not linear");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Helper function for checking the cursor in native mode
> + */
> +int amdgpu_dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
> +					struct drm_plane=20
*plane,
> +					struct drm_plane_state=20
*new_plane_state,
> +					bool enable)
> +{
> +
> +	struct amdgpu_crtc *new_acrtc;
> +	int ret;
> +
> +	if (!enable || !new_plane_crtc ||
> +	    drm_atomic_plane_disabling(plane->state, new_plane_state))
> +		return 0;
> +
> +	new_acrtc =3D to_amdgpu_crtc(new_plane_crtc);
> +
> +	if (new_plane_state->src_x !=3D 0 || new_plane_state->src_y !=3D 0) {
> +		drm_dbg_atomic(new_plane_crtc->dev, "Cropping not=20
supported for cursor
> plane\n"); +		return -EINVAL;
> +	}
> +
> +	if (new_plane_state->fb) {
> +		ret =3D dm_check_cursor_fb(new_acrtc, new_plane_state,
> +					=09
new_plane_state->fb);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *sta=
te,
> +					   struct drm_crtc=20
*old_plane_crtc,
> +					   struct drm_crtc=20
*new_plane_crtc,
> +					   bool enable)
> +{
> +	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +	struct dm_crtc_state *dm_old_crtc_state, *dm_new_crtc_state;
> +
> +	if (!enable) {
> +		if (old_plane_crtc =3D=3D NULL)
> +			return true;
> +
> +		old_crtc_state =3D drm_atomic_get_old_crtc_state(
> +			state, old_plane_crtc);
> +		dm_old_crtc_state =3D to_dm_crtc_state(old_crtc_state);
> +
> +		return dm_old_crtc_state->cursor_mode =3D=3D=20
DM_CURSOR_NATIVE_MODE;
> +	}
> +
> +	if (new_plane_crtc =3D=3D NULL)
> +		return true;
> +
> +	new_crtc_state =3D drm_atomic_get_new_crtc_state(
> +		state, new_plane_crtc);
> +	dm_new_crtc_state =3D to_dm_crtc_state(new_crtc_state);
> +
> +	return dm_new_crtc_state->cursor_mode =3D=3D DM_CURSOR_NATIVE_MODE;
> +}
> +EXPORT_IF_KUNIT(amdgpu_dm_should_update_native_cursor);
> +
> +STATIC_IFN_KUNIT void dm_get_oriented_plane_size(struct drm_plane_state
> *plane_state, +					 int=20
*src_w, int *src_h)
> +{
> +	switch (plane_state->rotation & DRM_MODE_ROTATE_MASK) {
> +	case DRM_MODE_ROTATE_90:
> +	case DRM_MODE_ROTATE_270:
> +		*src_w =3D plane_state->src_h >> 16;
> +		*src_h =3D plane_state->src_w >> 16;
> +		break;
> +	case DRM_MODE_ROTATE_0:
> +	case DRM_MODE_ROTATE_180:
> +	default:
> +		*src_w =3D plane_state->src_w >> 16;
> +		*src_h =3D plane_state->src_h >> 16;
> +		break;
> +	}
> +}
> +EXPORT_IF_KUNIT(dm_get_oriented_plane_size);
> +
> +STATIC_IFN_KUNIT void
> +dm_get_plane_scale(struct drm_plane_state *plane_state,
> +		   int *out_plane_scale_w, int *out_plane_scale_h)
> +{
> +	int plane_src_w, plane_src_h;
> +
> +	dm_get_oriented_plane_size(plane_state, &plane_src_w,=20
&plane_src_h);
> +	*out_plane_scale_w =3D plane_src_w ? plane_state->crtc_w * 1000 /
> plane_src_w : 0; +	*out_plane_scale_h =3D plane_src_h ? plane_state-
>crtc_h *
> 1000 / plane_src_h : 0; +}
> +EXPORT_IF_KUNIT(dm_get_plane_scale);
> +
> +/**
> + * DOC: Cursor Modes - Native vs Overlay
> + *
> + * In native mode, the cursor uses a integrated cursor pipe within each =
DCN
> hw + * plane. It does not require a dedicated hw plane to enable, but it =
is
> + * subjected to the same z-order and scaling as the hw plane. It also has
> format + * restrictions, a RGB cursor in native mode cannot be enabled
> within a non-RGB + * hw plane.
> + *
> + * In overlay mode, the cursor uses a separate DCN hw plane, and thus has
> its + * own scaling and z-pos. It also has no blending restrictions. It
> lends to a + * cursor behavior more akin to a DRM client's expectations.
> However, it does + * occupy an extra DCN plane, and therefore will only be
> used if a DCN plane is + * available.
> + */
> +
> +/**
> + * dm_plane_color_pipeline_active() - Check if a plane's color pipeline
> active. + * @state: DRM atomic state
> + * @plane: DRM plane to check
> + * @use_old: if true, inspect the old colorop states; otherwise the new
> ones + *
> + * A color pipeline may be selected (color_pipeline !=3D NULL) but still=
 is
> + * inactive if every colorop in the chain is bypassed.  Only return
> + * true when at least one colorop has bypass =3D=3D false, meaning the c=
ursor
> + * would be subjected to the transformation in native mode.
> + *
> + * Return: true if the pipeline modifies pixels, false otherwise.
> + */
> +static bool dm_plane_color_pipeline_active(struct drm_atomic_commit *sta=
te,
> +					   struct drm_plane=20
*plane,
> +					   bool use_old)
> +{
> +	struct drm_colorop *colorop;
> +	struct drm_colorop_state *old_colorop_state, *new_colorop_state;
> +	int i;
> +
> +	for_each_oldnew_colorop_in_state(state, colorop, old_colorop_state,
> new_colorop_state, i) { +		struct drm_colorop_state *cstate =3D=20
use_old ?
> old_colorop_state : new_colorop_state; +
> +		if (cstate->colorop->plane !=3D plane)
> +			continue;
> +		if (!cstate->bypass)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * amdgpu_dm_crtc_get_cursor_mode() - Determine the required cursor mode=
 on
> crtc + * @adev: amdgpu device
> + * @state: DRM atomic state
> + * @dm_crtc_state: amdgpu state for the CRTC containing the cursor
> + * @cursor_mode: Returns the required cursor mode on dm_crtc_state
> + *
> + * Get whether the cursor should be enabled in native mode, or overlay
> mode, on + * the dm_crtc_state.
> + *
> + * The cursor should be enabled in overlay mode if there exists an
> underlying + * plane - on which the cursor may be blended - that is either
> YUV formatted, + * scaled differently from the cursor, or has a color
> pipeline active. + *
> + * Since zpos info is required, drm_atomic_normalize_zpos must be called
> before + * calling this function.
> + *
> + * Return: 0 on success, or an error code if getting the cursor plane st=
ate
> + * failed.
> + */
> +int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
> +				   struct drm_atomic_commit=20
*state,
> +				   struct dm_crtc_state=20
*dm_crtc_state,
> +				   enum amdgpu_dm_cursor_mode=20
*cursor_mode)
> +{
> +	struct drm_plane_state *old_plane_state, *plane_state,=20
*cursor_state;
> +	struct drm_crtc_state *crtc_state =3D &dm_crtc_state->base;
> +	struct drm_plane *plane;
> +	bool consider_mode_change =3D false;
> +	bool entire_crtc_covered =3D false;
> +	bool cursor_changed =3D false;
> +	int underlying_scale_w, underlying_scale_h;
> +	int cursor_scale_w, cursor_scale_h;
> +	int i;
> +
> +	/* Overlay cursor not supported on HW before DCN
> +	 * DCN401/420 does not have the cursor-on-scaled-plane or
> cursor-on-yuv-plane restrictions +	 * as previous DCN generations, so
> enable native mode on DCN401/420 +	 */
> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 0, 1) ||
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 0) ||
> +#if defined(CONFIG_DRM_AMD_DC_DCN6_0)
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1) ||
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(6, 0, 0)) {
> +#else
> +	    amdgpu_ip_version(adev, DCE_HWIP, 0) =3D=3D IP_VERSION(4, 2, 1)) {
> +#endif
> +		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> +		return 0;
> +	}
> +
> +	/* Init cursor_mode to be the same as current */
> +	*cursor_mode =3D dm_crtc_state->cursor_mode;
> +
> +	/*
> +	 * Cursor mode can change if a plane's format changes, scale=20
changes, is
> +	 * enabled/disabled, z-order changes, or color management=20
properties
> change. +	 */
> +	for_each_oldnew_plane_in_state(state, plane, old_plane_state,=20
plane_state,
> i) { +		int new_scale_w, new_scale_h, old_scale_w,=20
old_scale_h;
> +
> +		/* Only care about planes on this CRTC */
> +		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D=20
0)
> +			continue;
> +
> +		if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> +			cursor_changed =3D true;
> +
> +		if (drm_atomic_plane_enabling(old_plane_state,=20
plane_state) ||
> +		    drm_atomic_plane_disabling(old_plane_state,=20
plane_state) ||
> +		    old_plane_state->fb->format !=3D plane_state->fb-
>format) {
> +			consider_mode_change =3D true;
> +			break;
> +		}
> +
> +		dm_get_plane_scale(plane_state, &new_scale_w,=20
&new_scale_h);
> +		dm_get_plane_scale(old_plane_state, &old_scale_w,=20
&old_scale_h);
> +		if (new_scale_w !=3D old_scale_w || new_scale_h !=3D=20
old_scale_h) {
> +			consider_mode_change =3D true;
> +			break;
> +		}
> +
> +		/*
> +		 * A non-cursor plane moving or resizing (without a=20
scale change)
> +		 * changes how much of the CRTC it covers. This can=20
create or
> +		 * remove a hole under the cursor and thus flip the=20
required
> +		 * cursor mode (native vs overlay), so its destination=20
rect must
> +		 * be re-evaluated too.
> +		 *
> +		 * The cursor plane itself is deliberately excluded: the=20
cursor
> +		 * mode depends on the underlying planes' coverage, not=20
on the
> +		 * cursor's position (see the entire_crtc_covered logic=20
below).
> +		 * Triggering on cursor movement would force every=20
legacy cursor
> +		 * update off its fast path, and in a cursor-only commit=20
=2D where
> +		 * the underlying planes are not part of the state - the=20
coverage
> +		 * loop would see no covering plane and misevaluate the=20
mode as
> +		 * overlay, regressing flip-vs-cursor-legacy.
> +		 */
> +		if (plane->type !=3D DRM_PLANE_TYPE_CURSOR &&
> +		    (old_plane_state->crtc_x !=3D plane_state->crtc_x ||
> +		     old_plane_state->crtc_y !=3D plane_state->crtc_y ||
> +		     old_plane_state->crtc_w !=3D plane_state->crtc_w ||
> +		     old_plane_state->crtc_h !=3D plane_state->crtc_h)) {
> +			consider_mode_change =3D true;
> +			break;
> +		}
> +
> +		if (dm_plane_color_pipeline_active(state, plane, true) !
=3D
> +		    dm_plane_color_pipeline_active(state, plane, false))=20
{
> +			consider_mode_change =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!consider_mode_change && !crtc_state->zpos_changed)
> +		return 0;
> +
> +	/*
> +	 * If no cursor change on this CRTC, and not enabled on this CRTC,=20
then
> +	 * no need to set cursor mode. This avoids needlessly locking the=20
cursor
> +	 * state.
> +	 */
> +	if (!cursor_changed &&
> +	    !(drm_plane_mask(crtc_state->crtc->cursor) & crtc_state-
>plane_mask))
> { +		return 0;
> +	}
> +
> +	cursor_state =3D drm_atomic_get_plane_state(state,
> +						 =20
crtc_state->crtc->cursor);
> +	if (IS_ERR(cursor_state))
> +		return PTR_ERR(cursor_state);
> +
> +	/* Cursor is disabled */
> +	if (!cursor_state->fb)
> +		return 0;
> +
> +	/* For all planes in descending z-order (all of which are below=20
cursor
> +	 * as per zpos definitions), check their scaling and format
> +	 */
> +	for_each_oldnew_plane_in_descending_zpos(state, plane,=20
old_plane_state,
> plane_state) { +
> +		/* Only care about non-cursor planes on this CRTC */
> +		if ((drm_plane_mask(plane) & crtc_state->plane_mask) =3D=3D=20
0 ||
> +		    plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> +			continue;
> +
> +		/* Underlying plane is YUV format - use overlay cursor=20
*/
> +		if (amdgpu_dm_plane_is_video_format(plane_state->fb-
>format->format)) {
> +			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> +			return 0;
> +		}
> +
> +		/* Underlying plane has an active color pipeline -=20
cursor would be
> transformed */ +		if (dm_plane_color_pipeline_active(state,=20
plane, false))
> {
> +			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> +			return 0;
> +		}
> +
> +		dm_get_plane_scale(plane_state,
> +				   &underlying_scale_w,=20
&underlying_scale_h);
> +		dm_get_plane_scale(cursor_state,
> +				   &cursor_scale_w,=20
&cursor_scale_h);
> +
> +		/* Underlying plane has different scale - use overlay=20
cursor */
> +		if (cursor_scale_w !=3D underlying_scale_w &&
> +		    cursor_scale_h !=3D underlying_scale_h) {
> +			*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> +			return 0;
> +		}
> +
> +		/* If this plane covers the whole CRTC, no need to check=20
planes
> underneath */ +		if (plane_state->crtc_x <=3D 0 &&=20
plane_state->crtc_y <=3D 0
> &&
> +		    plane_state->crtc_x + plane_state->crtc_w >=3D
> crtc_state->mode.hdisplay && +		    plane_state->crtc_y +
> plane_state->crtc_h >=3D crtc_state->mode.vdisplay) { +		=09
entire_crtc_covered
> =3D true;
> +			break;
> +		}
> +	}
> +
> +	/* If planes do not cover the entire CRTC, use overlay mode to=20
enable
> +	 * cursor over holes
> +	 */
> +	if (entire_crtc_covered)
> +		*cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> +	else
> +		*cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h new file mode
> 100644
> index 000000000000..5f619e4474aa
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_cursor.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> "Software"), + * to deal in the Software without restriction, including
> without limitation + * the rights to use, copy, modify, merge, publish,
> distribute, sublicense, + * and/or sell copies of the Software, and to
> permit persons to whom the + * Software is furnished to do so, subject to
> the following conditions: + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS
> OR + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY, + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT=
=2E=20
> IN NO EVENT SHALL + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR
> ANY CLAIM, DAMAGES OR + * OTHER LIABILITY, WHETHER IN AN ACTION OF
> CONTRACT, TORT OR OTHERWISE, + * ARISING FROM, OUT OF OR IN CONNECTION WI=
TH
> THE SOFTWARE OR THE USE OR + * OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * Authors: AMD
> + *
> + */
> +
> +#ifndef __AMDGPU_DM_CURSOR_H__
> +#define __AMDGPU_DM_CURSOR_H__
> +
> +int amdgpu_dm_check_native_cursor_state(struct drm_crtc *new_plane_crtc,
> +					struct drm_plane=20
*plane,
> +					struct drm_plane_state=20
*new_plane_state,
> +					bool enable);
> +
> +bool amdgpu_dm_should_update_native_cursor(struct drm_atomic_commit *sta=
te,
> +					   struct drm_crtc=20
*old_plane_crtc,
> +					   struct drm_crtc=20
*new_plane_crtc,
> +					   bool enable);
> +
> +int amdgpu_dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
> +				   struct drm_atomic_commit=20
*state,
> +				   struct dm_crtc_state=20
*dm_crtc_state,
> +				   enum amdgpu_dm_cursor_mode=20
*cursor_mode);
> +
> +#if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
> +void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
> +				int *src_w, int *src_h);
> +void dm_get_plane_scale(struct drm_plane_state *plane_state,
> +			int *out_plane_scale_w, int=20
*out_plane_scale_h);
> +#endif /* CONFIG_DRM_AMD_DC_KUNIT_TEST */
> +
> +#endif /* __AMDGPU_DM_CURSOR_H__ */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile index
> e58ffc4dcd84..3a51fccc2a5e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
> @@ -30,6 +30,7 @@ obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D
> amdgpu_dm_mst_types_test.o obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D
> amdgpu_dm_pp_smu_test.o
>  obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_test.o
>  obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_freesync_test.o
> +obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_cursor_test.o
>  obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_crtc_test.o
>  obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_services_test.o
>  obj-$(CONFIG_DRM_AMD_DC_KUNIT_TEST) +=3D amdgpu_dm_helpers_test.o
> diff --git
> a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c new
> file mode 100644
> index 000000000000..3da76794ece9
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_cursor_test.c
> @@ -0,0 +1,268 @@
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
> +/*
> + * KUnit tests for amdgpu_dm_cursor.c
> + *
> + * Copyright 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <kunit/test.h>
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_blend.h>
> +#include <drm/drm_crtc.h>
> +#include <drm/drm_plane.h>
> +
> +#include "dc.h"
> +#include "amdgpu.h"
> +#include "amdgpu_mode.h"
> +#include "amdgpu_dm.h"
> +#include "amdgpu_dm_cursor.h"
> +
> +/* Tests for amdgpu_dm_should_update_native_cursor() */
> +
> +/**
> + * dm_test_should_update_native_cursor_without_crtc - Test NULL crtc cas=
es
> update native cursor + * @test: The KUnit test context
> + */
> +static void dm_test_should_update_native_cursor_without_crtc(struct kunit
> *test) +{
> +	KUNIT_EXPECT_TRUE(test, amdgpu_dm_should_update_native_cursor(NULL,=20
NULL,
> NULL, false)); +	KUNIT_EXPECT_TRUE(test,
> amdgpu_dm_should_update_native_cursor(NULL, NULL, NULL, true)); +}
> +
> +/**
> + * dm_test_should_update_native_cursor_disable_native - Test disable path
> reads old crtc cursor mode + * @test: The KUnit test context
> + */
> +static void dm_test_should_update_native_cursor_disable_native(struct ku=
nit
> *test) +{
> +	struct dm_crtc_state *dm_crtc_state;
> +	struct drm_atomic_commit *state;
> +	struct drm_crtc *crtc;
> +
> +	state =3D kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, state);
> +
> +	crtc =3D kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> +
> +	dm_crtc_state =3D kunit_kzalloc(test, sizeof(*dm_crtc_state),=20
GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
> +
> +	state->crtcs =3D kunit_kzalloc(test, sizeof(*state->crtcs),=20
GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
> +
> +	crtc->index =3D 0;
> +	dm_crtc_state->cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> +	state->crtcs[0].old_state =3D &dm_crtc_state->base;
> +
> +	KUNIT_EXPECT_TRUE(test,
> +			 =20
amdgpu_dm_should_update_native_cursor(state, crtc, NULL, false));
> +}
> +
> +/**
> + * dm_test_should_update_native_cursor_enable_overlay - Test enable path
> reads new crtc cursor mode + * @test: The KUnit test context
> + */
> +static void dm_test_should_update_native_cursor_enable_overlay(struct ku=
nit
> *test) +{
> +	struct dm_crtc_state *dm_crtc_state;
> +	struct drm_atomic_commit *state;
> +	struct drm_crtc *crtc;
> +
> +	state =3D kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, state);
> +
> +	crtc =3D kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, crtc);
> +
> +	dm_crtc_state =3D kunit_kzalloc(test, sizeof(*dm_crtc_state),=20
GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
> +
> +	state->crtcs =3D kunit_kzalloc(test, sizeof(*state->crtcs),=20
GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
> +
> +	crtc->index =3D 0;
> +	dm_crtc_state->cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> +	state->crtcs[0].new_state =3D &dm_crtc_state->base;
> +
> +	KUNIT_EXPECT_FALSE(test,
> +			  =20
amdgpu_dm_should_update_native_cursor(state, NULL, crtc, true));
> +}
> +
> +/* Tests for dm_get_oriented_plane_size() */
> +
> +/**
> + * dm_test_oriented_plane_size_rotate_0 - Test Oriented plane size rotat=
e 0
> + * @test: The KUnit test context
> + */
> +static void dm_test_oriented_plane_size_rotate_0(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int src_w =3D 0;
> +	int src_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +
> +	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> +
> +	KUNIT_EXPECT_EQ(test, src_w, 1920);
> +	KUNIT_EXPECT_EQ(test, src_h, 1080);
> +}
> +
> +/**
> + * dm_test_oriented_plane_size_rotate_90 - Test Oriented plane size rota=
te
> 90 + * @test: The KUnit test context
> + */
> +static void dm_test_oriented_plane_size_rotate_90(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int src_w =3D 0;
> +	int src_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_90;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +
> +	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> +
> +	KUNIT_EXPECT_EQ(test, src_w, 1080);
> +	KUNIT_EXPECT_EQ(test, src_h, 1920);
> +}
> +
> +/**
> + * dm_test_oriented_plane_size_rotate_180 - Test Oriented plane size rot=
ate
> 180 + * @test: The KUnit test context
> + */
> +static void dm_test_oriented_plane_size_rotate_180(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int src_w =3D 0;
> +	int src_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_180;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +
> +	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> +
> +	KUNIT_EXPECT_EQ(test, src_w, 1920);
> +	KUNIT_EXPECT_EQ(test, src_h, 1080);
> +}
> +
> +/**
> + * dm_test_oriented_plane_size_rotate_270 - Test Oriented plane size rot=
ate
> 270 + * @test: The KUnit test context
> + */
> +static void dm_test_oriented_plane_size_rotate_270(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int src_w =3D 0;
> +	int src_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_270;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +
> +	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> +
> +	KUNIT_EXPECT_EQ(test, src_w, 1080);
> +	KUNIT_EXPECT_EQ(test, src_h, 1920);
> +}
> +
> +/* Tests for dm_get_plane_scale() */
> +
> +/**
> + * dm_test_get_plane_scale_identity - Test Get plane scale identity
> + * @test: The KUnit test context
> + */
> +static void dm_test_get_plane_scale_identity(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int scale_w =3D 0;
> +	int scale_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +	plane_state.crtc_w =3D 1920;
> +	plane_state.crtc_h =3D 1080;
> +
> +	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> +
> +	KUNIT_EXPECT_EQ(test, scale_w, 1000);
> +	KUNIT_EXPECT_EQ(test, scale_h, 1000);
> +}
> +
> +/**
> + * dm_test_get_plane_scale_rotate_90_identity - Test Get plane scale rot=
ate
> 90 identity + * @test: The KUnit test context
> + */
> +static void dm_test_get_plane_scale_rotate_90_identity(struct kunit *tes=
t)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int scale_w =3D 0;
> +	int scale_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_90;
> +	plane_state.src_w =3D 1920 << 16;
> +	plane_state.src_h =3D 1080 << 16;
> +	plane_state.crtc_w =3D 1080;
> +	plane_state.crtc_h =3D 1920;
> +
> +	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> +
> +	KUNIT_EXPECT_EQ(test, scale_w, 1000);
> +	KUNIT_EXPECT_EQ(test, scale_h, 1000);
> +}
> +
> +/**
> + * dm_test_get_plane_scale_zero_src_width - Test Get plane scale zero src
> width + * @test: The KUnit test context
> + */
> +static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
> +{
> +	struct drm_plane_state plane_state =3D { 0 };
> +	int scale_w =3D 0;
> +	int scale_h =3D 0;
> +
> +	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> +	plane_state.src_w =3D 0;
> +	plane_state.src_h =3D 1080 << 16;
> +	plane_state.crtc_w =3D 100;
> +	plane_state.crtc_h =3D 200;
> +
> +	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> +
> +	KUNIT_EXPECT_EQ(test, scale_w, 0);
> +	KUNIT_EXPECT_EQ(test, scale_h, 185);
> +}
> +
> +static struct kunit_case amdgpu_dm_cursor_tests[] =3D {
> +	/* amdgpu_dm_should_update_native_cursor */
> +	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
> +	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
> +	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
> +	/* dm_get_oriented_plane_size */
> +	KUNIT_CASE(dm_test_oriented_plane_size_rotate_0),
> +	KUNIT_CASE(dm_test_oriented_plane_size_rotate_90),
> +	KUNIT_CASE(dm_test_oriented_plane_size_rotate_180),
> +	KUNIT_CASE(dm_test_oriented_plane_size_rotate_270),
> +	/* dm_get_plane_scale */
> +	KUNIT_CASE(dm_test_get_plane_scale_identity),
> +	KUNIT_CASE(dm_test_get_plane_scale_rotate_90_identity),
> +	KUNIT_CASE(dm_test_get_plane_scale_zero_src_width),
> +	{}
> +};
> +
> +static struct kunit_suite amdgpu_dm_cursor_test_suite =3D {
> +	.name =3D "amdgpu_dm_cursor",
> +	.test_cases =3D amdgpu_dm_cursor_tests,
> +};
> +
> +kunit_test_suite(amdgpu_dm_cursor_test_suite);
> +
> +MODULE_AUTHOR("AMD");
> +MODULE_DESCRIPTION("KUnit tests for amdgpu_dm_cursor");
> +MODULE_LICENSE("Dual MIT/GPL");
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c index
> 428d24259198..3c10eec9b1e0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
> @@ -227,76 +227,6 @@ static void dm_test_atomic_get_new_state_match(struct
> kunit *test) KUNIT_EXPECT_PTR_EQ(test, dm_atomic_get_new_state(state),
> dm_state); }
>=20
> -/**
> - * dm_test_should_update_native_cursor_without_crtc - Test NULL crtc cas=
es
> update native cursor - * @test: The KUnit test context
> - */
> -static void dm_test_should_update_native_cursor_without_crtc(struct kunit
> *test) -{
> -	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL, NULL,=20
NULL,
> false)); -	KUNIT_EXPECT_TRUE(test, dm_should_update_native_cursor(NULL,
> NULL, NULL, true)); -}
> -
> -/**
> - * dm_test_should_update_native_cursor_disable_native - Test disable path
> reads old crtc cursor mode - * @test: The KUnit test context
> - */
> -static void dm_test_should_update_native_cursor_disable_native(struct ku=
nit
> *test) -{
> -	struct dm_crtc_state *dm_crtc_state;
> -	struct drm_atomic_commit *state;
> -	struct drm_crtc *crtc;
> -
> -	state =3D kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, state);
> -
> -	crtc =3D kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, crtc);
> -
> -	dm_crtc_state =3D kunit_kzalloc(test, sizeof(*dm_crtc_state),=20
GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
> -
> -	state->crtcs =3D kunit_kzalloc(test, sizeof(*state->crtcs),=20
GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
> -
> -	crtc->index =3D 0;
> -	dm_crtc_state->cursor_mode =3D DM_CURSOR_NATIVE_MODE;
> -	state->crtcs[0].old_state =3D &dm_crtc_state->base;
> -
> -	KUNIT_EXPECT_TRUE(test,
> -			  dm_should_update_native_cursor(state,=20
crtc, NULL, false));
> -}
> -
> -/**
> - * dm_test_should_update_native_cursor_enable_overlay - Test enable path
> reads new crtc cursor mode - * @test: The KUnit test context
> - */
> -static void dm_test_should_update_native_cursor_enable_overlay(struct ku=
nit
> *test) -{
> -	struct dm_crtc_state *dm_crtc_state;
> -	struct drm_atomic_commit *state;
> -	struct drm_crtc *crtc;
> -
> -	state =3D kunit_kzalloc(test, sizeof(*state), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, state);
> -
> -	crtc =3D kunit_kzalloc(test, sizeof(*crtc), GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, crtc);
> -
> -	dm_crtc_state =3D kunit_kzalloc(test, sizeof(*dm_crtc_state),=20
GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, dm_crtc_state);
> -
> -	state->crtcs =3D kunit_kzalloc(test, sizeof(*state->crtcs),=20
GFP_KERNEL);
> -	KUNIT_ASSERT_NOT_NULL(test, state->crtcs);
> -
> -	crtc->index =3D 0;
> -	dm_crtc_state->cursor_mode =3D DM_CURSOR_OVERLAY_MODE;
> -	state->crtcs[0].new_state =3D &dm_crtc_state->base;
> -
> -	KUNIT_EXPECT_FALSE(test,
> -			   dm_should_update_native_cursor(state,=20
NULL, crtc, true));
> -}
> -
>  /**
>   * dm_test_atomic_destroy_state_no_context - Test destroying DM atomic
> state without a DC context * @test: The KUnit test context
> @@ -599,156 +529,6 @@ static void
> dm_test_modereset_not_required_when_inactive_without_modeset(struct
> KUNIT_EXPECT_FALSE(test, modereset_required(&crtc_state));
>  }
>=20
> -/* Tests for dm_get_oriented_plane_size() */
> -
> -/**
> - * dm_test_oriented_plane_size_rotate_0 - Test Oriented plane size rotat=
e 0
> - * @test: The KUnit test context
> - */
> -static void dm_test_oriented_plane_size_rotate_0(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int src_w =3D 0;
> -	int src_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -
> -	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> -
> -	KUNIT_EXPECT_EQ(test, src_w, 1920);
> -	KUNIT_EXPECT_EQ(test, src_h, 1080);
> -}
> -
> -/**
> - * dm_test_oriented_plane_size_rotate_90 - Test Oriented plane size rota=
te
> 90 - * @test: The KUnit test context
> - */
> -static void dm_test_oriented_plane_size_rotate_90(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int src_w =3D 0;
> -	int src_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_90;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -
> -	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> -
> -	KUNIT_EXPECT_EQ(test, src_w, 1080);
> -	KUNIT_EXPECT_EQ(test, src_h, 1920);
> -}
> -
> -/**
> - * dm_test_oriented_plane_size_rotate_180 - Test Oriented plane size rot=
ate
> 180 - * @test: The KUnit test context
> - */
> -static void dm_test_oriented_plane_size_rotate_180(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int src_w =3D 0;
> -	int src_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_180;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -
> -	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> -
> -	KUNIT_EXPECT_EQ(test, src_w, 1920);
> -	KUNIT_EXPECT_EQ(test, src_h, 1080);
> -}
> -
> -/**
> - * dm_test_oriented_plane_size_rotate_270 - Test Oriented plane size rot=
ate
> 270 - * @test: The KUnit test context
> - */
> -static void dm_test_oriented_plane_size_rotate_270(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int src_w =3D 0;
> -	int src_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_270;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -
> -	dm_get_oriented_plane_size(&plane_state, &src_w, &src_h);
> -
> -	KUNIT_EXPECT_EQ(test, src_w, 1080);
> -	KUNIT_EXPECT_EQ(test, src_h, 1920);
> -}
> -
> -/* Tests for dm_get_plane_scale() */
> -
> -/**
> - * dm_test_get_plane_scale_identity - Test Get plane scale identity
> - * @test: The KUnit test context
> - */
> -static void dm_test_get_plane_scale_identity(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int scale_w =3D 0;
> -	int scale_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -	plane_state.crtc_w =3D 1920;
> -	plane_state.crtc_h =3D 1080;
> -
> -	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> -
> -	KUNIT_EXPECT_EQ(test, scale_w, 1000);
> -	KUNIT_EXPECT_EQ(test, scale_h, 1000);
> -}
> -
> -/**
> - * dm_test_get_plane_scale_rotate_90_identity - Test Get plane scale rot=
ate
> 90 identity - * @test: The KUnit test context
> - */
> -static void dm_test_get_plane_scale_rotate_90_identity(struct kunit *tes=
t)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int scale_w =3D 0;
> -	int scale_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_90;
> -	plane_state.src_w =3D 1920 << 16;
> -	plane_state.src_h =3D 1080 << 16;
> -	plane_state.crtc_w =3D 1080;
> -	plane_state.crtc_h =3D 1920;
> -
> -	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> -
> -	KUNIT_EXPECT_EQ(test, scale_w, 1000);
> -	KUNIT_EXPECT_EQ(test, scale_h, 1000);
> -}
> -
> -/**
> - * dm_test_get_plane_scale_zero_src_width - Test Get plane scale zero src
> width - * @test: The KUnit test context
> - */
> -static void dm_test_get_plane_scale_zero_src_width(struct kunit *test)
> -{
> -	struct drm_plane_state plane_state =3D { 0 };
> -	int scale_w =3D 0;
> -	int scale_h =3D 0;
> -
> -	plane_state.rotation =3D DRM_MODE_ROTATE_0;
> -	plane_state.src_w =3D 0;
> -	plane_state.src_h =3D 1080 << 16;
> -	plane_state.crtc_w =3D 100;
> -	plane_state.crtc_h =3D 200;
> -
> -	dm_get_plane_scale(&plane_state, &scale_w, &scale_h);
> -
> -	KUNIT_EXPECT_EQ(test, scale_w, 0);
> -	KUNIT_EXPECT_EQ(test, scale_h, 185);
> -}
> -
>  /* Tests for is_scaling_state_different() */
>=20
>  /**
> @@ -1386,9 +1166,6 @@ static struct kunit_case amdgpu_dm_tests[] =3D {
>  	KUNIT_CASE(dm_test_crtc_get_scanoutpos_no_stream),
>  	KUNIT_CASE(dm_test_atomic_get_new_state_empty),
>  	KUNIT_CASE(dm_test_atomic_get_new_state_match),
> -	KUNIT_CASE(dm_test_should_update_native_cursor_without_crtc),
> -	KUNIT_CASE(dm_test_should_update_native_cursor_disable_native),
> -	KUNIT_CASE(dm_test_should_update_native_cursor_enable_overlay),
>  	KUNIT_CASE(dm_test_atomic_destroy_state_no_context),
>  	/* dm_plane_layer_index_cmp */
>  	KUNIT_CASE(dm_test_plane_layer_index_cmp_equal),
> @@ -1407,15 +1184,6 @@ static struct kunit_case amdgpu_dm_tests[] =3D {
>  	KUNIT_CASE(dm_test_modereset_required_when_inactive_and_modeset),
>  =09
KUNIT_CASE(dm_test_modereset_not_required_when_active_and_modeset),
>  =09
KUNIT_CASE(dm_test_modereset_not_required_when_inactive_without_modeset),
> -	/* dm_get_oriented_plane_size */
> -	KUNIT_CASE(dm_test_oriented_plane_size_rotate_0),
> -	KUNIT_CASE(dm_test_oriented_plane_size_rotate_90),
> -	KUNIT_CASE(dm_test_oriented_plane_size_rotate_180),
> -	KUNIT_CASE(dm_test_oriented_plane_size_rotate_270),
> -	/* dm_get_plane_scale */
> -	KUNIT_CASE(dm_test_get_plane_scale_identity),
> -	KUNIT_CASE(dm_test_get_plane_scale_rotate_90_identity),
> -	KUNIT_CASE(dm_test_get_plane_scale_zero_src_width),
>  	/* is_scaling_state_different */
>  	KUNIT_CASE(dm_test_scaling_state_same),
>  	KUNIT_CASE(dm_test_scaling_state_scaling_changed),




