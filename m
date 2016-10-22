From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use amdgpu_bo_[create|free]_kernel for wb
Date: Sat, 22 Oct 2016 19:20:32 +1100
Message-ID: <0851af1f-0e53-b0aa-10a7-432f6fad68dd@folklore1984.net>
References: <1477078293-23098-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1234952908=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1477078293-23098-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1234952908==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SJhjLkh3WEIXhaPhgN1QniCtmfL2ruuGN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SJhjLkh3WEIXhaPhgN1QniCtmfL2ruuGN
Content-Type: multipart/mixed; boundary="LBgiCxQVpKfATeQMApIsEaTjVx8CoOFDU";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <0851af1f-0e53-b0aa-10a7-432f6fad68dd-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: use amdgpu_bo_[create|free]_kernel for wb
References: <1477078293-23098-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1477078293-23098-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--LBgiCxQVpKfATeQMApIsEaTjVx8CoOFDU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 10/22/2016 06:31 AM, Alex Deucher wrote:
> Rather than open coding it.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++----------------=
--------
>  1 file changed, 7 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> index b7b6542..314295f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -443,13 +443,9 @@ void amdgpu_doorbell_get_kfd_info(struct amdgpu_de=
vice *adev,
>  static void amdgpu_wb_fini(struct amdgpu_device *adev)
>  {
>  	if (adev->wb.wb_obj) {
> -		if (!amdgpu_bo_reserve(adev->wb.wb_obj, false)) {
> -			amdgpu_bo_kunmap(adev->wb.wb_obj);
> -			amdgpu_bo_unpin(adev->wb.wb_obj);
> -			amdgpu_bo_unreserve(adev->wb.wb_obj);
> -		}
> -		amdgpu_bo_unref(&adev->wb.wb_obj);
> -		adev->wb.wb =3D NULL;
> +		amdgpu_bo_free_kernel(&adev->wb.wb_obj,
> +				      &adev->wb.gpu_addr,
> +				      (void **)&adev->wb.wb);
>  		adev->wb.wb_obj =3D NULL;
>  	}
>  }
> @@ -468,33 +464,14 @@ static int amdgpu_wb_init(struct amdgpu_device *a=
dev)
>  	int r;
> =20
>  	if (adev->wb.wb_obj =3D=3D NULL) {
> -		r =3D amdgpu_bo_create(adev, AMDGPU_MAX_WB * 4, PAGE_SIZE, true,
> -				     AMDGPU_GEM_DOMAIN_GTT, 0,  NULL, NULL,
> -				     &adev->wb.wb_obj);
> +		r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MAX_WB * 4,
> +					    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
> +					    &adev->wb.wb_obj, &adev->wb.gpu_addr,
> +					    (void **)&adev->wb.wb);
>  		if (r) {
>  			dev_warn(adev->dev, "(%d) create WB bo failed\n", r);
>  			return r;
>  		}
> -		r =3D amdgpu_bo_reserve(adev->wb.wb_obj, false);
> -		if (unlikely(r !=3D 0)) {
> -			amdgpu_wb_fini(adev);
> -			return r;
> -		}
> -		r =3D amdgpu_bo_pin(adev->wb.wb_obj, AMDGPU_GEM_DOMAIN_GTT,
> -				&adev->wb.gpu_addr);
> -		if (r) {
> -			amdgpu_bo_unreserve(adev->wb.wb_obj);
> -			dev_warn(adev->dev, "(%d) pin WB bo failed\n", r);
> -			amdgpu_wb_fini(adev);
> -			return r;
> -		}
> -		r =3D amdgpu_bo_kmap(adev->wb.wb_obj, (void **)&adev->wb.wb);
> -		amdgpu_bo_unreserve(adev->wb.wb_obj);
> -		if (r) {
> -			dev_warn(adev->dev, "(%d) map WB bo failed\n", r);
> -			amdgpu_wb_fini(adev);
> -			return r;
> -		}
> =20
>  		adev->wb.num_wb =3D AMDGPU_MAX_WB;
>  		memset(&adev->wb.used, 0, sizeof(adev->wb.used));
>=20


--LBgiCxQVpKfATeQMApIsEaTjVx8CoOFDU--

--SJhjLkh3WEIXhaPhgN1QniCtmfL2ruuGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCyFQAAoJEP4bvbfZuWjbGq0P/j8foauaG8JcGpvWwtY0CgWY
Isk1nzRsgg43uy8/qBSs2ZMKl4uiMszKRnWwsS7luL3zQcf4tnAQ122EcPWIlJRM
yu4rvENv9nhqNVl5D9p8IdAF/pvYVWbnwqXqywQCVltc22j9KgfcWiCTqkrdvPvk
4pmq2iunKt9xGrenrWRbVp1nUaWJJJZZvxtevlELo9h8q7MZoXLiWbrCTXbpfwN6
86sAiMWWOCfQmCj6OX789Lt36v+GOwvWa/jfWwJq6eEjeH2DY054Fpd3tZ6Qofc4
6l4xkL96oe8H5TupZjMxcyZX/f9V/sGc9S+XiUZzOWGAh5DSuXxV8dTO3ftB08dz
iBQboOAOHKNQOAbyP4OSdX61NHQc+N0k275i0TtxgvU10DI841g71s813MQhoA8M
S7LzdIFCn2CdhLECnOPmRNFad3VZsNCe6HvcPviO8qtnNfhUaAcMmthK4Jc09f5H
qv1n6x9FHEup665PCqCLWjvV0khe0JKCukf4z7BjWPj4jzSLRLN1UQm+UjMcQF3t
B+/K7IJgrnEoGKgmEcJ0j5sKE12Y5aIAxab07yB2Xcqo1Q5IdiBLgpyVDH6+CPL5
SsACyYlYh/3FCc2l9yB82Y5EfUqklEeW22iTqmB2fXJEyrnJU5Xkz0YjSOjukii/
DaZnrY+Xy9dnTVGywYtn
=6HUB
-----END PGP SIGNATURE-----

--SJhjLkh3WEIXhaPhgN1QniCtmfL2ruuGN--

--===============1234952908==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1234952908==--
