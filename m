From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: don't succeed in getters if fan is
 missing
Date: Sun, 30 Oct 2016 16:05:14 +1100
Message-ID: <9903cfe8-3f4b-8ced-d87f-51afca5e4589@folklore1984.net>
References: <1477773164-23837-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2115628092=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477773164-23837-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============2115628092==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kXS7le4aubudenabIoTjErSiAVKO5jwoO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kXS7le4aubudenabIoTjErSiAVKO5jwoO
Content-Type: multipart/mixed; boundary="owKGuaieKh9IccOidGO6fSlBihVb8S6ti";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <9903cfe8-3f4b-8ced-d87f-51afca5e4589-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amd/powerplay: don't succeed in getters if fan is
 missing
References: <1477773164-23837-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <1477773164-23837-1-git-send-email-notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--owKGuaieKh9IccOidGO6fSlBihVb8S6ti
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 10/30/2016 07:32 AM, Grazvydas Ignotas wrote:
> Otherwise callers end up using uninitialized data.
>=20
> Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c b/drive=
rs/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
> index fb6c6f6..29d0319 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_thermal.c
> @@ -30,7 +30,7 @@ int smu7_fan_ctrl_get_fan_speed_info(struct pp_hwmgr =
*hwmgr,
>  		struct phm_fan_speed_info *fan_speed_info)
>  {
>  	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> -		return 0;
> +		return -ENODEV;
> =20
>  	fan_speed_info->supports_percent_read =3D true;
>  	fan_speed_info->supports_percent_write =3D true;
> @@ -60,7 +60,7 @@ int smu7_fan_ctrl_get_fan_speed_percent(struct pp_hwm=
gr *hwmgr,
>  	uint64_t tmp64;
> =20
>  	if (hwmgr->thermal_controller.fanInfo.bNoFan)
> -		return 0;
> +		return -ENODEV;
> =20
>  	duty100 =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_REG__=
SMC,
>  			CG_FDO_CTRL1, FMAX_DUTY100);
> @@ -89,7 +89,7 @@ int smu7_fan_ctrl_get_fan_speed_rpm(struct pp_hwmgr *=
hwmgr, uint32_t *speed)
>  	if (hwmgr->thermal_controller.fanInfo.bNoFan ||
>  			(hwmgr->thermal_controller.fanInfo.
>  				ucTachometerPulsesPerRevolution =3D=3D 0))
> -		return 0;
> +		return -ENODEV;
> =20
>  	tach_period =3D PHM_READ_VFPF_INDIRECT_FIELD(hwmgr->device, CGS_IND_R=
EG__SMC,
>  			CG_TACH_STATUS, TACH_PERIOD);
>=20


--owKGuaieKh9IccOidGO6fSlBihVb8S6ti--

--kXS7le4aubudenabIoTjErSiAVKO5jwoO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYFX+LAAoJEP4bvbfZuWjbTFUP/2UWrzAQyZGvJ5e8vKl6rlmD
DomQaSgY7daldFgd/laxH/FUK17ZhkOleH5vhiZJmZAkZ/QVaifzlNFFFzrFnRF1
o6EQfxAcuyM4IIrgLkk+ROoPtWwNulatfQJaowiHL30mennvRnIFx6ec9sXxI14I
4n8g6o/ESn/LaRe0XHcuh3D4OCIqgBgEptmQk8CwRJVplc/Lo3i58opQH+taS7We
Ui61w1oQ/b9zUnNMLUBtEVZ7gmZRO2eLAMb76vK6IALeVWtkYqebcmnr/HJzxNhC
gzLn+QyVQfFSVsMFKkiyKK++e494bYPWg+2Q7NEQtIbZqibRc16Hp724UuOirD1F
tpT7zfXeAi2iCkeCXDy9MtPybxBrmugCkogVhgP9206aMYcPDbRs2/28zfKllfz4
RfZRxu17JVJutnXMXbYjO/ti/uCgzm5bKlLzlDT0XfZVfm9QYDpaaTJlLvqNGDfn
9QSWvspVHR33oWh9eAlkWctuWg04mK/bB04RMosXkOmNdvOIcAvQZK2sLQ0/mNWf
pGOIS7ZCdqL1oN8Emp6CTae/RaTsIpsTT7rQSXS2lbITNA18Ap+eeWRGbuZ+h2k5
yMju2MPiXhLsQs7qdVN/qEB7UMsULTXVHKULK+pwRj7iPUO624PhAnBc/6KNQUaf
SPabenuEuoTXDp8XZdLR
=adyH
-----END PGP SIGNATURE-----

--kXS7le4aubudenabIoTjErSiAVKO5jwoO--

--===============2115628092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2115628092==--
