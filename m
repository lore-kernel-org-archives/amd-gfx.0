From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6
Date: Fri, 2 Sep 2016 13:22:32 +1000
Message-ID: <717365b4-0cdd-95a4-9e8c-4b04660844c6@folklore1984.net>
References: <20160901174447.13037-1-tom.stdenis@amd.com>
 <20160901174447.13037-4-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0448590221=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160901174447.13037-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============0448590221==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gABrUkoCiXwIS5VL8RtsDgfuxxc04rxHH"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gABrUkoCiXwIS5VL8RtsDgfuxxc04rxHH
Content-Type: multipart/mixed; boundary="JB1MuHO72tT0qTNdXHexC7tlBFipx10Nn";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <717365b4-0cdd-95a4-9e8c-4b04660844c6-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amd/amdgpu: Various tidy ups for gfx6
References: <20160901174447.13037-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
 <20160901174447.13037-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20160901174447.13037-4-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--JB1MuHO72tT0qTNdXHexC7tlBFipx10Nn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 09/02/2016 03:44 AM, Tom St Denis wrote:
> Various whitespace and logical simplifications for gfx6.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 40 +++++----------------------=
--------
>  1 file changed, 5 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v6_0.c
> index 5f508c96496f..63ca77937714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -1211,11 +1211,8 @@ static void gfx_v6_0_gpu_init(struct amdgpu_devi=
ce *adev)
>  				 SC_EARLYZ_TILE_FIFO_SIZE(adev->gfx.config.sc_earlyz_tile_fifo_siz=
e)));
> =20
>  	WREG32(VGT_NUM_INSTANCES, 1);
> -
>  	WREG32(CP_PERFMON_CNTL, 0);
> -
>  	WREG32(SQ_CONFIG, 0);
> -
>  	WREG32(PA_SC_FORCE_EOV_MAX_CNTS, (FORCE_EOV_MAX_CLK_CNT(4095) |
>  					  FORCE_EOV_MAX_REZ_CNT(255)));
> =20
> @@ -1240,7 +1237,6 @@ static void gfx_v6_0_gpu_init(struct amdgpu_devic=
e *adev)
>  	WREG32(PA_CL_ENHANCE, CLIP_VTX_REORDER_ENA | NUM_CLIP_SEQ(3));
> =20
>  	udelay(50);
> -
>  }
> =20
> =20
> @@ -1661,21 +1657,14 @@ static int gfx_v6_0_cp_gfx_resume(struct amdgpu=
_device *adev)
> =20
>  static u32 gfx_v6_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
>  {
> -	u32 rptr;
> -
> -	rptr =3D ring->adev->wb.wb[ring->rptr_offs];
> -
> -	return rptr;
> +	return ring->adev->wb.wb[ring->rptr_offs];
>  }
> =20
>  static u32 gfx_v6_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
>  {
>  	struct amdgpu_device *adev =3D ring->adev;

Also adev seems to be unused here?

> -	u32 wptr;
> =20
> -	wptr =3D RREG32(CP_RB0_WPTR);
> -
> -	return wptr;
> +	return RREG32(CP_RB0_WPTR);
>  }
> =20
>  static void gfx_v6_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
> @@ -1688,9 +1677,7 @@ static void gfx_v6_0_ring_set_wptr_gfx(struct amd=
gpu_ring *ring)
> =20
>  static u32 gfx_v6_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
>  {
> -	u32 rptr =3D ring->adev->wb.wb[ring->rptr_offs];
> -
> -	return rptr;
> +	return ring->adev->wb.wb[ring->rptr_offs];
>  }
> =20
>  static u32 gfx_v6_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
> @@ -1770,14 +1757,12 @@ static int gfx_v6_0_cp_compute_resume(struct am=
dgpu_device *adev)
>  	ring->wptr =3D 0;
>  	WREG32(CP_RB1_WPTR, ring->wptr);
> =20
> -
>  	rptr_addr =3D adev->wb.gpu_addr + (ring->rptr_offs * 4);
>  	WREG32(CP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
>  	WREG32(CP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) & 0xFF);
> =20
>  	mdelay(1);
>  	WREG32(CP_RB1_CNTL, tmp);
> -
>  	WREG32(CP_RB1_BASE, ring->gpu_addr >> 8);
> =20
>  	ring =3D &adev->gfx.compute_ring[1];
> @@ -1797,7 +1782,6 @@ static int gfx_v6_0_cp_compute_resume(struct amdg=
pu_device *adev)
> =20
>  	mdelay(1);
>  	WREG32(CP_RB2_CNTL, tmp);
> -
>  	WREG32(CP_RB2_BASE, ring->gpu_addr >> 8);
> =20
>  	adev->gfx.compute_ring[0].ready =3D true;
> @@ -1825,12 +1809,7 @@ static void gfx_v6_0_cp_enable(struct amdgpu_dev=
ice *adev, bool enable)
> =20
>  static int gfx_v6_0_cp_load_microcode(struct amdgpu_device *adev)
>  {
> -	int r;
> -
> -	r =3D gfx_v6_0_cp_gfx_load_microcode(adev);
> -
> -	return r;
> -
> +	return gfx_v6_0_cp_gfx_load_microcode(adev);
>  }
> =20
>  static void gfx_v6_0_enable_gui_idle_interrupt(struct amdgpu_device *a=
dev,
> @@ -2172,7 +2151,6 @@ static void gfx_v6_0_rlc_stop(struct amdgpu_devic=
e *adev)
>  	WREG32(RLC_CNTL, 0);
> =20
>  	gfx_v6_0_enable_gui_idle_interrupt(adev, false);
> -
>  	gfx_v6_0_wait_for_rlc_serdes(adev);
>  }
> =20
> @@ -2223,11 +2201,8 @@ static int gfx_v6_0_rlc_resume(struct amdgpu_dev=
ice *adev)
>  		return -EINVAL;
> =20
>  	gfx_v6_0_rlc_stop(adev);
> -
>  	gfx_v6_0_rlc_reset(adev);
> -
>  	gfx_v6_0_init_pg(adev);
> -
>  	gfx_v6_0_init_cg(adev);
> =20
>  	WREG32(RLC_RL_BASE, 0);
> @@ -2254,7 +2229,6 @@ static int gfx_v6_0_rlc_resume(struct amdgpu_devi=
ce *adev)
>  	WREG32(RLC_UCODE_ADDR, 0);
> =20
>  	gfx_v6_0_enable_lbpw(adev, gfx_v6_0_lbpw_supported(adev));
> -
>  	gfx_v6_0_rlc_start(adev);
> =20
>  	return 0;
> @@ -2278,7 +2252,6 @@ static void gfx_v6_0_enable_cgcg(struct amdgpu_de=
vice *adev, bool enable)
>  		WREG32(RLC_SERDES_WR_CTRL, 0x00b000ff);
> =20
>  		gfx_v6_0_wait_for_rlc_serdes(adev);
> -
>  		gfx_v6_0_update_rlc(adev, tmp);
> =20
>  		WREG32(RLC_SERDES_WR_CTRL, 0x007000ff);
> @@ -2931,13 +2904,10 @@ static bool gfx_v6_0_is_idle(void *handle)
>  static int gfx_v6_0_wait_for_idle(void *handle)
>  {
>  	unsigned i;
> -	u32 tmp;
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> =20
>  	for (i =3D 0; i < adev->usec_timeout; i++) {
> -		tmp =3D RREG32(GRBM_STATUS) & GRBM_STATUS__GUI_ACTIVE_MASK;
> -
> -		if (!tmp)
> +		if (gfx_v6_0_is_idle(handle))
>  			return 0;
>  		udelay(1);
>  	}
>=20


--JB1MuHO72tT0qTNdXHexC7tlBFipx10Nn--

--gABrUkoCiXwIS5VL8RtsDgfuxxc04rxHH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXyPB4AAoJEP4bvbfZuWjbybEQANg3qox9/a6szuh6yqOSQvlb
gi9GLXovg+X/PfTHTn0ccBrjSmIX/HwEFVH42r06JsKw/jr/x9BgQx5JtaIAt62M
1KmhNj9MXewdwJ5jBptnJUJpImJILVP4vsRIlNTbli0JNnHeOwUzQ2fyBFJb527t
qDAnDesY/XhmdYZV9uABFxiLcFZiGMEBjBjKKLtR/tX6Yny/+bIh3EG3JlfTvhES
ucl7uWrOEleziMzDjG6KY6Cxe3p7JXCiu6tD179Z1hb+ZEvysgzqJXyxomdRTaKx
NZvOLD/8tWvvJYsuYibt4S55fJMLZO1ESUDMeL3vmu4uYJI0v5fLTsaum0k+sUn8
ncwhVTzpOQnVbrK1N5ZTj8aPhccwT9QM4XRiv1tVuj5qUuB2xLYqc3UKo0sbhBs4
vDAhVXTS7EyxkUFGXs0VwabLkER5dPvUeaDxDAw3Nj61HApaRx/YRfS/Gs8gLOOI
KCuMp3htlt1NIQOS5b90+hPws4L3xnnV5fBiy6CqSp8gF2yz+Mp5BFHTYutnXYbT
ImUG/UbJTe9UjE/QRS7BKakNHRCdKqA7OOgjiPfRjM8SpAxLA8HCg7sDjJPQvoQD
qPrfk5dgNS2cl0KYC+l+W0JTaqdGh7qrRPzAluwIa6Eod+VvsDIiTQdEwC32+0ma
jCMYcmCcEPsvWtWmWj1G
=Wt6h
-----END PGP SIGNATURE-----

--gABrUkoCiXwIS5VL8RtsDgfuxxc04rxHH--

--===============0448590221==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0448590221==--
