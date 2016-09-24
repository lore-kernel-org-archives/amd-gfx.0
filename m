From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various cleanups for DCEv6
Date: Sat, 24 Sep 2016 22:31:47 +1000
Message-ID: <fde0b639-6018-36a1-adc5-a6192ea36277@folklore1984.net>
References: <20160922164347.6404-1-tom.stdenis@amd.com>
 <20160922164347.6404-4-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1250382112=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160922164347.6404-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1250382112==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vWktmWaWOa2LG3KJ4sqA4xUIEWdiOfws7"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vWktmWaWOa2LG3KJ4sqA4xUIEWdiOfws7
Content-Type: multipart/mixed; boundary="RjvLEpVo9QQcT3hFrpbP9xDv8fDDkhUBd";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <fde0b639-6018-36a1-adc5-a6192ea36277-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various cleanups for DCEv6
References: <20160922164347.6404-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20160922164347.6404-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20160922164347.6404-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--RjvLEpVo9QQcT3hFrpbP9xDv8fDDkhUBd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch is,
Review-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 09/23/2016 02:43 AM, Tom St Denis wrote:
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 46 ++++++++-------------------=
--------
>  1 file changed, 10 insertions(+), 36 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/dce_v6_0.c
> index dce5414f4ae3..a4fa30b9924a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -1474,10 +1474,7 @@ static void dce_v6_0_vga_enable(struct drm_crtc =
*crtc, bool enable)
>  	u32 vga_control;
> =20
>  	vga_control =3D RREG32(vga_control_regs[amdgpu_crtc->crtc_id]) & ~1;
> -	if (enable)
> -		WREG32(vga_control_regs[amdgpu_crtc->crtc_id], vga_control | 1);
> -	else
> -		WREG32(vga_control_regs[amdgpu_crtc->crtc_id], vga_control);
> +	WREG32(vga_control_regs[amdgpu_crtc->crtc_id], vga_control | (enable =
? 1 : 0));
>  }
> =20
>  static void dce_v6_0_grph_enable(struct drm_crtc *crtc, bool enable)
> @@ -1486,10 +1483,7 @@ static void dce_v6_0_grph_enable(struct drm_crtc=
 *crtc, bool enable)
>  	struct drm_device *dev =3D crtc->dev;
>  	struct amdgpu_device *adev =3D dev->dev_private;
> =20
> -	if (enable)
> -		WREG32(EVERGREEN_GRPH_ENABLE + amdgpu_crtc->crtc_offset, 1);
> -	else
> -		WREG32(EVERGREEN_GRPH_ENABLE + amdgpu_crtc->crtc_offset, 0);
> +	WREG32(EVERGREEN_GRPH_ENABLE + amdgpu_crtc->crtc_offset, enable ? 1 :=
 0);
>  }
> =20
>  static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
> @@ -1519,8 +1513,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_c=
rtc *crtc,
>  	if (atomic) {
>  		amdgpu_fb =3D to_amdgpu_framebuffer(fb);
>  		target_fb =3D fb;
> -	}
> -	else {
> +	} else {
>  		amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>  		target_fb =3D crtc->primary->fb;
>  	}
> @@ -1534,9 +1527,9 @@ static int dce_v6_0_crtc_do_set_base(struct drm_c=
rtc *crtc,
>  	if (unlikely(r !=3D 0))
>  		return r;
> =20
> -	if (atomic)
> +	if (atomic) {
>  		fb_location =3D amdgpu_bo_gpu_offset(abo);
> -	else {
> +	} else {
>  		r =3D amdgpu_bo_pin(abo, AMDGPU_GEM_DOMAIN_VRAM, &fb_location);
>  		if (unlikely(r !=3D 0)) {
>  			amdgpu_bo_unreserve(abo);
> @@ -1632,8 +1625,9 @@ static int dce_v6_0_crtc_do_set_base(struct drm_c=
rtc *crtc,
>  		fb_format |=3D EVERGREEN_GRPH_BANK_WIDTH(bankw);
>  		fb_format |=3D EVERGREEN_GRPH_BANK_HEIGHT(bankh);
>  		fb_format |=3D EVERGREEN_GRPH_MACRO_TILE_ASPECT(mtaspect);
> -	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) =3D=3D ARRAY_1=
D_TILED_THIN1)
> +	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) =3D=3D ARRAY_1=
D_TILED_THIN1) {
>  		fb_format |=3D EVERGREEN_GRPH_ARRAY_MODE(EVERGREEN_GRPH_ARRAY_1D_TIL=
ED_THIN1);
> +	}
> =20
>  	pipe_config =3D AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
>  	fb_format |=3D SI_GRPH_PIPE_CONFIG(pipe_config);
> @@ -1797,26 +1791,13 @@ static int dce_v6_0_pick_dig_encoder(struct drm=
_encoder *encoder)
> =20
>  	switch (amdgpu_encoder->encoder_id) {
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY:
> -		if (dig->linkb)
> -			return 1;
> -		else
> -			return 0;
> -		break;
> +		return dig->linkb ? 1 : 0;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY1:
> -		if (dig->linkb)
> -			return 3;
> -		else
> -			return 2;
> -		break;
> +		return dig->linkb ? 3 : 2;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY2:
> -		if (dig->linkb)
> -			return 5;
> -		else
> -			return 4;
> -		break;
> +		return dig->linkb ? 5 : 4;
>  	case ENCODER_OBJECT_ID_INTERNAL_UNIPHY3:
>  		return 6;
> -		break;
>  	default:
>  		DRM_ERROR("invalid encoder_id: 0x%x\n", amdgpu_encoder->encoder_id);=

>  		return 0;
> @@ -2051,7 +2032,6 @@ static void dce_v6_0_cursor_reset(struct drm_crtc=
 *crtc)
>  					    amdgpu_crtc->cursor_y);
> =20
>  		dce_v6_0_show_cursor(crtc);
> -
>  		dce_v6_0_lock_cursor(crtc, false);
>  	}
>  }
> @@ -2372,15 +2352,11 @@ static int dce_v6_0_sw_init(void *handle)
>  	adev->mode_info.mode_config_initialized =3D true;
> =20
>  	adev->ddev->mode_config.funcs =3D &amdgpu_mode_funcs;
> -
>  	adev->ddev->mode_config.async_page_flip =3D true;
> -
>  	adev->ddev->mode_config.max_width =3D 16384;
>  	adev->ddev->mode_config.max_height =3D 16384;
> -
>  	adev->ddev->mode_config.preferred_depth =3D 24;
>  	adev->ddev->mode_config.prefer_shadow =3D 1;
> -
>  	adev->ddev->mode_config.fb_base =3D adev->mc.aper_base;
> =20
>  	r =3D amdgpu_modeset_create_props(adev);
> @@ -2426,7 +2402,6 @@ static int dce_v6_0_sw_fini(void *handle)
>  	drm_kms_helper_poll_fini(adev->ddev);
> =20
>  	dce_v6_0_audio_fini(adev);
> -
>  	dce_v6_0_afmt_fini(adev);
> =20
>  	drm_mode_config_cleanup(adev->ddev);
> @@ -3054,7 +3029,6 @@ static void dce_v6_0_encoder_add(struct amdgpu_de=
vice *adev,
>  	}
> =20
>  	amdgpu_encoder->enc_priv =3D NULL;
> -
>  	amdgpu_encoder->encoder_enum =3D encoder_enum;
>  	amdgpu_encoder->encoder_id =3D (encoder_enum & OBJECT_ID_MASK) >> OBJ=
ECT_ID_SHIFT;
>  	amdgpu_encoder->devices =3D supported_device;
>=20


--RjvLEpVo9QQcT3hFrpbP9xDv8fDDkhUBd--

--vWktmWaWOa2LG3KJ4sqA4xUIEWdiOfws7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJX5nI0AAoJEP4bvbfZuWjbF98P/joL7HVYBcxFGas2INFfe7Dl
048wPsamNo3JS0SqqrOn4RNAgE7rZbz1wTrPhCqYSO8Nne136yv+/bB2q/cMtHNQ
eVU/Fa8Hrb9cA6Ni/pbWUnXi7V9SSolsEQZ9lJLn8jE8aHB4YITTQNyXH+XTBuVb
tokjA2O6eYFSkQs2fXGr4JCcGKm/VwjW5zN8HnCoyB9iYAMx4GqSG836cZBgqvxo
8U4PsY+nmSmYym751TifeR/xSUCSGB69j+wsRuA2GjJKhBVoPfMnlm03g2YAdF/K
S2i4a5V2usLdzPcyY1iq5okFrRt5iLQQgXtgxb3k3xq2hlAPwrtHbRPwFvjtJACc
oip0lVmHO7rSWcC14OFSpSJ359pWa6reJ3MGzLZb3kf4/hovKVn+y9xtF807KK0M
F6Kl6zejbsdtnwtOTc+xfCqS2lXZb8oGEm+gFCS1bY8KpUlAiGgc/6m6zuKbPcwG
vyfCfSIiEhKv4xFZtiQRlQjRbhSc69E56U9FSCBXFKo+CVZdEpL7PJEWp79GekJO
qmFn7UWA8v3l1Cw9vOYPX9j422WWj/P9GyX0MCBSxFnNoKHMC5lyJi9P5N0yA44V
VHx7CoEfqOWFxSfdsjGTUeYclHXXAHjyUcBhmO0RrWyS4O/KsMDPPKagJuS+FHUY
yRXBmZIf1DUok97uTqmz
=RZKe
-----END PGP SIGNATURE-----

--vWktmWaWOa2LG3KJ4sqA4xUIEWdiOfws7--

--===============1250382112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1250382112==--
