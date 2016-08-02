From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amd/powerplay: delete useless code in hwmgr.
Date: Tue, 2 Aug 2016 10:27:13 +1000
Message-ID: <983e0860-ffc6-ebaa-1978-cf825f514550@folklore1984.net>
References: <1470051207-28808-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1053828759=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1470051207-28808-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1053828759==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IfCwakKlVSSdbKmfsR3tM0EHwK38CX4fF"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfCwakKlVSSdbKmfsR3tM0EHwK38CX4fF
Content-Type: multipart/mixed; boundary="3Lo1nNd0K6Qgr73CEQtlS3IgGIxsI3txm"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <983e0860-ffc6-ebaa-1978-cf825f514550-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 1/5] drm/amd/powerplay: delete useless code in hwmgr.
References: <1470051207-28808-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1470051207-28808-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>

--3Lo1nNd0K6Qgr73CEQtlS3IgGIxsI3txm
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This series is,

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 08/01/2016 09:33 PM, Rex Zhu wrote:
> Change-Id: I047ed9679598b0e519e49b12414ca7f629c67870
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c |  36 ----------
>  drivers/gpu/drm/amd/powerplay/inc/hwmgr.h   | 108 ++------------------=
--------
>  2 files changed, 7 insertions(+), 137 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/=
drm/amd/powerplay/hwmgr/hwmgr.c
> index 384b425..ba8f57a 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
> @@ -206,29 +206,7 @@ int phm_wait_on_register(struct pp_hwmgr *hwmgr, u=
int32_t index,
>  	return 0;
>  }
> =20
> -int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
> -				uint32_t index, uint32_t value, uint32_t mask)
> -{
> -	uint32_t i;
> -	uint32_t cur_value;
> -
> -	if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL) {
> -		printk(KERN_ERR "[ powerplay ] Invalid Hardware Manager!");
> -		return -EINVAL;
> -	}
> -
> -	for (i =3D 0; i < hwmgr->usec_timeout; i++) {
> -		cur_value =3D cgs_read_register(hwmgr->device, index);
> -		if ((cur_value & mask) !=3D (value & mask))
> -			break;
> -		udelay(1);
> -	}
> =20
> -	/* timeout means wrong logic*/
> -	if (i =3D=3D hwmgr->usec_timeout)
> -		return -1;
> -	return 0;
> -}
> =20
> =20
>  /**
> @@ -251,21 +229,7 @@ void phm_wait_on_indirect_register(struct pp_hwmgr=
 *hwmgr,
>  	phm_wait_on_register(hwmgr, indirect_port + 1, mask, value);
>  }
> =20
> -void phm_wait_for_indirect_register_unequal(struct pp_hwmgr *hwmgr,
> -					uint32_t indirect_port,
> -					uint32_t index,
> -					uint32_t value,
> -					uint32_t mask)
> -{
> -	if (hwmgr =3D=3D NULL || hwmgr->device =3D=3D NULL) {
> -		printk(KERN_ERR "[ powerplay ] Invalid Hardware Manager!");
> -		return;
> -	}
> =20
> -	cgs_write_register(hwmgr->device, indirect_port, index);
> -	phm_wait_for_register_unequal(hwmgr, indirect_port + 1,
> -				      value, mask);
> -}
> =20
>  bool phm_cf_want_uvd_power_gating(struct pp_hwmgr *hwmgr)
>  {
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/dr=
m/amd/powerplay/inc/hwmgr.h
> index 911081c..36b4ec9 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
> @@ -639,16 +639,7 @@ extern int hw_init_power_state_table(struct pp_hwm=
gr *hwmgr);
>  extern int phm_wait_on_register(struct pp_hwmgr *hwmgr, uint32_t index=
,
>  				uint32_t value, uint32_t mask);
> =20
> -extern int phm_wait_for_register_unequal(struct pp_hwmgr *hwmgr,
> -				uint32_t index, uint32_t value, uint32_t mask);
> =20
> -extern uint32_t phm_read_indirect_register(struct pp_hwmgr *hwmgr,
> -		uint32_t indirect_port, uint32_t index);
> -
> -extern void phm_write_indirect_register(struct pp_hwmgr *hwmgr,
> -		uint32_t indirect_port,
> -		uint32_t index,
> -		uint32_t value);
> =20
>  extern void phm_wait_on_indirect_register(struct pp_hwmgr *hwmgr,
>  				uint32_t indirect_port,
> @@ -656,12 +647,7 @@ extern void phm_wait_on_indirect_register(struct p=
p_hwmgr *hwmgr,
>  				uint32_t value,
>  				uint32_t mask);
> =20
> -extern void phm_wait_for_indirect_register_unequal(
> -				struct pp_hwmgr *hwmgr,
> -				uint32_t indirect_port,
> -				uint32_t index,
> -				uint32_t value,
> -				uint32_t mask);
> +
> =20
>  extern bool phm_cf_want_uvd_power_gating(struct pp_hwmgr *hwmgr);
>  extern bool phm_cf_want_vce_power_gating(struct pp_hwmgr *hwmgr);
> @@ -699,43 +685,7 @@ extern void phm_apply_dal_min_voltage_request(stru=
ct pp_hwmgr *hwmgr);
>  	 PHM_FIELD_SHIFT(reg, field))
> =20
> =20
> -#define PHM_WAIT_REGISTER_GIVEN_INDEX(hwmgr, index, value, mask)	\
> -	phm_wait_on_register(hwmgr, index, value, mask)
> -
> -#define PHM_WAIT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, index, value, mas=
k)	\
> -	phm_wait_for_register_unequal(hwmgr, index, value, mask)
> -
> -#define PHM_WAIT_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, index, val=
ue, mask)	\
> -	phm_wait_on_indirect_register(hwmgr, mm##port##_INDEX, index, value, =
mask)
> -
> -#define PHM_WAIT_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, port, in=
dex, value, mask)	\
> -	phm_wait_for_indirect_register_unequal(hwmgr, mm##port##_INDEX, index=
, value, mask)
> =20
> -#define PHM_WAIT_VFPF_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, index=
, value, mask)	\
> -	phm_wait_on_indirect_register(hwmgr, mm##port##_INDEX_0, index, value=
, mask)
> -
> -#define PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, por=
t, index, value, mask)	\
> -	phm_wait_for_indirect_register_unequal(hwmgr, mm##port##_INDEX_0, ind=
ex, value, mask)
> -
> -/* Operations on named registers. */
> -
> -#define PHM_WAIT_REGISTER(hwmgr, reg, value, mask)	\
> -	PHM_WAIT_REGISTER_GIVEN_INDEX(hwmgr, mm##reg, value, mask)
> -
> -#define PHM_WAIT_REGISTER_UNEQUAL(hwmgr, reg, value, mask)	\
> -	PHM_WAIT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, mm##reg, value, mask)
> -
> -#define PHM_WAIT_INDIRECT_REGISTER(hwmgr, port, reg, value, mask)	\
> -	PHM_WAIT_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, ix##reg, value, m=
ask)
> -
> -#define PHM_WAIT_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, value, ma=
sk)	\
> -	PHM_WAIT_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, port, ix##reg, =
value, mask)
> -
> -#define PHM_WAIT_VFPF_INDIRECT_REGISTER(hwmgr, port, reg, value, mask)=
	\
> -	PHM_WAIT_VFPF_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, ix##reg, val=
ue, mask)
> -
> -#define PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, valu=
e, mask)	\
> -	PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, port, ix##=
reg, value, mask)
> =20
>  /* Operations on named fields. */
> =20
> @@ -764,60 +714,16 @@ extern void phm_apply_dal_min_voltage_request(str=
uct pp_hwmgr *hwmgr);
>  			PHM_SET_FIELD(cgs_read_ind_register(device, port, ix##reg),	\
>  				reg, field, fieldval))
> =20
> -#define PHM_WAIT_FIELD(hwmgr, reg, field, fieldval)	\
> -	PHM_WAIT_REGISTER(hwmgr, reg, (fieldval)	\
> -			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> -
> -#define PHM_WAIT_INDIRECT_FIELD(hwmgr, port, reg, field, fieldval)	\
> -	PHM_WAIT_INDIRECT_REGISTER(hwmgr, port, reg, (fieldval)	\
> -			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> +#define PHM_WAIT_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, index, val=
ue, mask)        \
> +       phm_wait_on_indirect_register(hwmgr, mm##port##_INDEX, index, v=
alue, mask)
> =20
> -#define PHM_WAIT_VFPF_INDIRECT_FIELD(hwmgr, port, reg, field, fieldval=
)	\
> -	PHM_WAIT_VFPF_INDIRECT_REGISTER(hwmgr, port, reg, (fieldval)	\
> -			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> =20
> -#define PHM_WAIT_FIELD_UNEQUAL(hwmgr, reg, field, fieldval)	\
> -	PHM_WAIT_REGISTER_UNEQUAL(hwmgr, reg, (fieldval)	\
> -			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> -
> -#define PHM_WAIT_INDIRECT_FIELD_UNEQUAL(hwmgr, port, reg, field, field=
val)	\
> -	PHM_WAIT_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, (fieldval)	\
> -			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> +#define PHM_WAIT_INDIRECT_REGISTER(hwmgr, port, reg, value, mask)     =
 \
> +       PHM_WAIT_INDIRECT_REGISTER_GIVEN_INDEX(hwmgr, port, ix##reg, va=
lue, mask)
> =20
> -#define PHM_WAIT_VFPF_INDIRECT_FIELD_UNEQUAL(hwmgr, port, reg, field, =
fieldval)	\
> -	PHM_WAIT_VFPF_INDIRECT_REGISTER_UNEQUAL(hwmgr, port, reg, (fieldval)	=
\
> +#define PHM_WAIT_INDIRECT_FIELD(hwmgr, port, reg, field, fieldval)	\
> +	PHM_WAIT_INDIRECT_REGISTER(hwmgr, port, reg, (fieldval)	\
>  			<< PHM_FIELD_SHIFT(reg, field), PHM_FIELD_MASK(reg, field))
> =20
> -/* Operations on arrays of registers & fields. */
> -
> -#define PHM_READ_ARRAY_REGISTER(device, reg, offset)	\
> -	cgs_read_register(device, mm##reg + (offset))
> -
> -#define PHM_WRITE_ARRAY_REGISTER(device, reg, offset, value)	\
> -	cgs_write_register(device, mm##reg + (offset), value)
> -
> -#define PHM_WAIT_ARRAY_REGISTER(hwmgr, reg, offset, value, mask)	\
> -	PHM_WAIT_REGISTER_GIVEN_INDEX(hwmgr, mm##reg + (offset), value, mask)=

> -
> -#define PHM_WAIT_ARRAY_REGISTER_UNEQUAL(hwmgr, reg, offset, value, mas=
k)	\
> -	PHM_WAIT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, mm##reg + (offset), valu=
e, mask)
> -
> -#define PHM_READ_ARRAY_FIELD(hwmgr, reg, offset, field) \
> -	PHM_GET_FIELD(PHM_READ_ARRAY_REGISTER(hwmgr->device, reg, offset), re=
g, field)
> -
> -#define PHM_WRITE_ARRAY_FIELD(hwmgr, reg, offset, field, fieldvalue)	\=

> -	PHM_WRITE_ARRAY_REGISTER(hwmgr->device, reg, offset,	\
> -			PHM_SET_FIELD(PHM_READ_ARRAY_REGISTER(hwmgr->device, reg, offset),	=
\
> -				reg, field, fieldvalue))
> -
> -#define PHM_WAIT_ARRAY_FIELD(hwmgr, reg, offset, field, fieldvalue)	\
> -	PHM_WAIT_REGISTER_GIVEN_INDEX(hwmgr, mm##reg + (offset),	\
> -			(fieldvalue) << PHM_FIELD_SHIFT(reg, field),	\
> -			PHM_FIELD_MASK(reg, field))
> -
> -#define PHM_WAIT_ARRAY_FIELD_UNEQUAL(hwmgr, reg, offset, field, fieldv=
alue)	\
> -	PHM_WAIT_REGISTER_UNEQUAL_GIVEN_INDEX(hwmgr, mm##reg + (offset),	\
> -			(fieldvalue) << PHM_FIELD_SHIFT(reg, field),	\
> -			PHM_FIELD_MASK(reg, field))
> =20
>  #endif /* _HWMGR_H_ */
>=20


--3Lo1nNd0K6Qgr73CEQtlS3IgGIxsI3txm--

--IfCwakKlVSSdbKmfsR3tM0EHwK38CX4fF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXn+jqAAoJEP4bvbfZuWjbz4oP/i6/hifQO0q/X1HetnHQzlJX
n4L1KkrnogbGlXrGjesl6Py58iCOb3+gkfEKG1tqzm6sr/GPaxuxEVSoebbYBv21
t5pXRMxO+bqNQwgaHGgWecvrOqQdW/9GyND5/6r5ats/xeuH60e5X+RwDtN3oTQD
MP6WcagOJg7/ciP7lFCccYQP9BC3P/Mf01BSWe7WGRNMi7ru+8edVx2NFGF+nmUJ
MSC5EVOe4chObxMmppL9SpaiqEcAb6AlKoLl3tU+FpOfDDRWGoKxQCLDls+k9dMN
nK+LpXL9LVU0nKulKCyOupY9X0xQXgvOMbJaUr6UaP0CHJwYCP5h09lb9zi0mVHJ
6jd00q/ytzXahs9zseJuMeuJRX7CAnxize7PixI03s88F9Qn78yxUPE5DqaMEwAN
OuWtUzercCEqxpOz7kWy/dMGkhK6vXtg3PAD3M3yDp46saO3PLp+v+fh0OoVnssI
puxmSaUgsa0Nx3izb6Wdr3rRW/IiF1i09z6wgJshZ9z1r9AulOJzRvryVfTTn/j9
4SCD5Z8ZbccnKe1sgSQqxcEUc7Q7stpBJF71tkGsXQFFr6wMPNvERc6W+Zn8c5/d
mIONGUlfR2WCTOcpM+n+X+RuG/wEndqAONcwJqAwikL/kP2G/LnKjisAWD3nAgP3
O228lFWUHMWP2odZbI7s
=5vKH
-----END PGP SIGNATURE-----

--IfCwakKlVSSdbKmfsR3tM0EHwK38CX4fF--

--===============1053828759==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1053828759==--
