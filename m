From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc7: add missing mullins case
Date: Sat, 30 Jul 2016 13:22:08 +1000
Message-ID: <1d490b03-806e-cc6c-d14d-e159d10521db@folklore1984.net>
References: <1469829970-15466-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0175030361=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1469829970-15466-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0175030361==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PseWV5Oohn4M5j0oorOLePEhkhnSi4934"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PseWV5Oohn4M5j0oorOLePEhkhnSi4934
Content-Type: multipart/mixed; boundary="kADHculfRSkcuBIWjxiDNtfOwJfE201qx"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1d490b03-806e-cc6c-d14d-e159d10521db-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc7: add missing mullins case
References: <1469829970-15466-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <1469829970-15466-1-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>

--kADHculfRSkcuBIWjxiDNtfOwJfE201qx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 07/30/2016 08:06 AM, Alex Deucher wrote:
> Looks like this got missed when we ported the code from radeon.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> ---
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v7_0.c
> index d24a82b..0b0f086 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -144,6 +144,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_de=
vice *adev)
>  		break;
>  	case CHIP_KAVERI:
>  	case CHIP_KABINI:
> +	case CHIP_MULLINS:
>  		return 0;
>  	default: BUG();
>  	}
>=20


--kADHculfRSkcuBIWjxiDNtfOwJfE201qx--

--PseWV5Oohn4M5j0oorOLePEhkhnSi4934
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXnB1gAAoJEP4bvbfZuWjbWD8QAJdTUCcn+PDKBsrTzJU7IHN6
Id1RRVgFyOGGBaOIGChNpmnaoMguOY5j0mtXNKz3Th4i7uP8VUrzQx692M4TnQ1M
jIPCvN2hj3wQAa0M9l9uV0gUxwj+xhyeQLLOYRXNNdIvD7TFbCFdp4r3vhOJ12aN
F1X355yKjkJWCENd9bJpoY2e2j6YS+AU6kXRGeECPpK9rpVJHareXnOu8EEpuqey
aO7LN/dhAOGxH6p35Lt0iBTVxyRu+3AHEiQHNQ97q/wnmDWvj/IsLcSj11emZjTN
gAgvyqiAMeImJwXdTPf/oktLj3RXbdfSHZfZJC8I3ZqlQigv9m7SmGksnLdLFE9w
5DcU6b+pwc+c4kkMaO4Q6m+Rky39bAVBIneFC/j0L6C+5OTO4xiSspbqpNs49pna
pQy1PrLfmxMvqif/kU6444NPa+IclNTubtFGHGzuarrVDxnObfqp2SojJfoEaJab
4yjryNdowwDtXSobZHvtMkUkHoyu+cZ8uc2G5fABSo6voa+8OfbpEHZb1Z7WnkJX
kJNjpf1f9f0wYbdH0jXLlgKhnyVQdA1rvK4UcsPsyd3z+U/1felmPwmv3UnrcF3B
ZAEYDk9G7IpcENcj8lX9Cj4ZHNvMmKbxix7/9JpJ+5vVCWstq8Y4TVUuSeFDDUfT
xUew56Uv8HTktyfeL+Kv
=948n
-----END PGP SIGNATURE-----

--PseWV5Oohn4M5j0oorOLePEhkhnSi4934--

--===============0175030361==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0175030361==--
