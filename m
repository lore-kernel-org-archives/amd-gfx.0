From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] Fix a misspelling of 'acceleration' in amdgpu_kms.c
Date: Sun, 26 Mar 2017 01:01:16 +1100
Message-ID: <1ac881b5-93b5-e8e1-a364-50820e995ff9@folklore1984.net>
References: <468268f9-149e-7c62-1bcc-bccb67e2b364@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0163176755=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <468268f9-149e-7c62-1bcc-bccb67e2b364-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Nicholas Molloy <nick.a.molloy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0163176755==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lGc78WnrEtV5OBfFvscsLIoP3VVB4CgIR"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lGc78WnrEtV5OBfFvscsLIoP3VVB4CgIR
Content-Type: multipart/mixed; boundary="HagAOq57mq29usd3tdvqKvlG77dx3jvfn";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Nicholas Molloy <nick.a.molloy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Message-ID: <1ac881b5-93b5-e8e1-a364-50820e995ff9-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH] Fix a misspelling of 'acceleration' in amdgpu_kms.c
References: <468268f9-149e-7c62-1bcc-bccb67e2b364-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <468268f9-149e-7c62-1bcc-bccb67e2b364-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

--HagAOq57mq29usd3tdvqKvlG77dx3jvfn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/26/2017 12:38 AM, Nicholas Molloy wrote:
> ---
>  src/amdgpu_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/amdgpu_kms.c b/src/amdgpu_kms.c
> index 4821e93..c4ac90d 100644
> --- a/src/amdgpu_kms.c
> +++ b/src/amdgpu_kms.c
> @@ -1796,7 +1796,7 @@ Bool AMDGPUScreenInit_KMS(SCREEN_INIT_ARGS_DECL)
>  			xf86DrvMsg(pScrn->scrnIndex, X_INFO, "3D acceleration disabled\n");=

>  		xf86DrvMsg(pScrn->scrnIndex, X_INFO, "2D acceleration disabled\n");
>  	} else {
> -		xf86DrvMsg(pScrn->scrnIndex, X_INFO, "2D and 3D cceleration disabled=
\n");
> +		xf86DrvMsg(pScrn->scrnIndex, X_INFO, "2D and 3D acceleration disable=
d\n");
>  	}
> =20
>  	/* Init DPMS */
>=20


--HagAOq57mq29usd3tdvqKvlG77dx3jvfn--

--lGc78WnrEtV5OBfFvscsLIoP3VVB4CgIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY1ngtAAoJEP4bvbfZuWjbDxgQAKNMXHQTZEEAMpG6xv7nlcRL
/r/HLFPfFJPa+SkgT5fQY/URsvhT7wFug/XqquKRjD8o9zn24K23V82QNIYvw+oV
ah2s7j5am/C53/0xXOxrG782R8+1DEtxiiXnA8ZeeXzbOwXuEn/lz/Hd6+m5Aamc
tFYuBRXgVunmfmlmisVS3lWPvdqmu9c5XbxJKzp3rLUORIqA/zDawoetHDu1ToLr
xtcAyrQlPwS9xxo7cLLxx8n4rd1Pe7nDjB+qRmfpwsr96X6Q3YAlrhocY3p1ugr1
gkJJzOV8IFPDm6Xfv4QIVohYeaKZpUDZOnwXvkl2GmKoAnbcaUF46chAB8qLnYBo
YdhhhvN6e3VdXgml14s01egKeI5PpOFVfY9bV6dyLQpDSbQ5j0btgnz7QlttBlL6
uJoW4BsuDBpUmVUa/xueyJ0GueP8AO7cZYD7bU/9pgeyKHZuD11SS9C95seSYhAE
oWb7QExJf6BzH8G1wQIq+RyLxA5w8Ta2CIz+EaDpirM6J88ODgo//dBABvnWLx0r
JQ1T/w2h6RgJp0tUfiN66w1/hjOq1rFrUAov7ViQw65pUljd2hnyXVFgUZpCyhg9
GWA70JYpiPPWjtcRnG7Nj2lZfrVR9KrIdPSahYbgb42BsSQbT5U3FeVDL6/fVvo0
zclQQGfKAtgE2T9ylq5r
=achH
-----END PGP SIGNATURE-----

--lGc78WnrEtV5OBfFvscsLIoP3VVB4CgIR--

--===============0163176755==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0163176755==--
