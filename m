From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: bump driver version for some new features
Date: Thu, 9 Mar 2017 10:34:47 +1100
Message-ID: <3db84254-d173-78ad-f871-688a388d7248@folklore1984.net>
References: <1489015136-7376-1-git-send-email-alexander.deucher@amd.com>
 <1489015136-7376-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1152367998=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1489015136-7376-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
--===============1152367998==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="47TR2tr663xRMSCo0kXisWngKvQmbuAIk"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--47TR2tr663xRMSCo0kXisWngKvQmbuAIk
Content-Type: multipart/mixed; boundary="kufMUFsqkKsvUuFVbGdoBtPad5e8eENsC";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
Message-ID: <3db84254-d173-78ad-f871-688a388d7248-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: bump driver version for some new features
References: <1489015136-7376-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
 <1489015136-7376-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1489015136-7376-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--kufMUFsqkKsvUuFVbGdoBtPad5e8eENsC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/09/2017 10:18 AM, Alex Deucher wrote:
> We added new gem ioctl flags and the new fences ioctl, but forgot
> to bump the version.
Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

Form which commit Alex? perhaps CC stable?

>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_drv.c
> index 75fc376..f7adbac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -59,9 +59,10 @@
>   * - 3.7.0 - Add support for VCE clock list packet
>   * - 3.8.0 - Add support raster config init in the kernel
>   * - 3.9.0 - Add support for memory query info about VRAM and GTT.
> + * - 3.10.0 - Add support for new fences ioctl, new gem ioctl flags
>   */
>  #define KMS_DRIVER_MAJOR	3
> -#define KMS_DRIVER_MINOR	9
> +#define KMS_DRIVER_MINOR	10
>  #define KMS_DRIVER_PATCHLEVEL	0
> =20
>  int amdgpu_vram_limit =3D 0;
>=20


--kufMUFsqkKsvUuFVbGdoBtPad5e8eENsC--

--47TR2tr663xRMSCo0kXisWngKvQmbuAIk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwJUXAAoJEP4bvbfZuWjbEKEP/iNCSVIVJgfIXnBGrRnS9xoD
VW6FT96FLSWXohTwBS+KiOHUqQtKBALKW2fSyytALST64/sWPWWTYteR7zbsoKvy
lRII/8cAPGkcCRpfZZv+0Yib0lFPyPxjoNmnIDUR375mIjLQ7F3kSnHDiOn/AR/s
OPp0XbkIv43UMWVT2LL1kd64g/3MyXMnHIB9Ps8J32440azq6RwQMTEtc1y2Ze32
NYGjUcSaZIYtJxC5EHVgUEjpRiWAfbUeHR1wVmJ2qftpPRJuvM1SVSqZQ0dYSdEh
3oDABilrliQgQaZLVKpATpfgx956Ama79w3Av982wLLRb5LYfzBCUL56KPJKExSg
1epgPUQdA6YQ5ZtDl2ZDGhSSfgEs8ZLUM9bB7loVUXTGtcCRPUlmtx0wZcen6oKb
bx16YpAvDbHKOoDADh6AQzkt6SpZlSOxysG/aYYbH24Rm/v+UINVswLGo+3Jf0UE
CqUiLMW4BSYvW64roDBgeM0OD40ZB2o2YkL5AUoZXYiPgpJmfRaSChrWA8OgAyUz
J9hhTHwhROtMkfw5h3kNXJ1Myg0RtQmKz78ppfPvDlM7dbT3IG34/hVbA74ICW3Z
gWwzt01YIpHJUr8VewrehkSBTa3KSP1GUKz+wpH65vEsZJ9YBbA/B8xzQW/xmqqY
w00UaBvRdAkH4+QbyQGb
=hU18
-----END PGP SIGNATURE-----

--47TR2tr663xRMSCo0kXisWngKvQmbuAIk--

--===============1152367998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1152367998==--
