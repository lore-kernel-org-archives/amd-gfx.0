From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Fix ring offset to dword instead of bytes
Date: Thu, 9 Mar 2017 09:53:35 +1100
Message-ID: <b199e65e-135e-bb82-2694-2d2ff778cbbf@folklore1984.net>
References: <20170308163139.20015-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1531333110=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170308163139.20015-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
--===============1531333110==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jh2aMSB6GbJCBf2jWJKot3KPQpaNg9JV4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jh2aMSB6GbJCBf2jWJKot3KPQpaNg9JV4
Content-Type: multipart/mixed; boundary="uGMs1x8tcROwkAaDlje0EhDQspm7LD9c5";
 protected-headers="v1"
From: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
Message-ID: <b199e65e-135e-bb82-2694-2d2ff778cbbf-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>
Subject: Re: [PATCH umr] Fix ring offset to dword instead of bytes
References: <20170308163139.20015-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170308163139.20015-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>

--uGMs1x8tcROwkAaDlje0EhDQspm7LD9c5
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Acked-by: Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>

On 03/09/2017 03:31 AM, Tom St Denis wrote:
> This allows you to specify (say)
>=20
> -R gfx[16:32] to read words 16 through 32 which is
> consistent with how the data is presented.
>=20
> This patch also correctly enables the PM4 decoder
> when specifying a range of words.
>=20
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
> ---
>  src/app/ring_read.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/src/app/ring_read.c b/src/app/ring_read.c
> index 970310b9bf52..d6b3df58be4d 100644
> --- a/src/app/ring_read.c
> +++ b/src/app/ring_read.c
> @@ -96,7 +96,10 @@ void umr_read_ring(struct umr_asic *asic, char *ring=
path)
>  		} else {
>  			sscanf(from, "%"SCNu32, &start);
>  			sscanf(to, "%"SCNu32, &end);
> +			start *=3D 4;
> +			end *=3D 4;
>  			use_decoder =3D 1;
> +			decoder.pm4.cur_opcode =3D 0xFFFFFFFF;
>  		}
>  	}
>  	end %=3D ringsize;
>=20


--uGMs1x8tcROwkAaDlje0EhDQspm7LD9c5--

--jh2aMSB6GbJCBf2jWJKot3KPQpaNg9JV4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYwItvAAoJEP4bvbfZuWjbHeIP/jhdCFu83hR6XwIzXQglbzxv
KCUyc/CE0UQJaaLw1uZj1JSwxEc4sp02BpZV2zl6SqGdikJeGGcm3iskAVDeF8r1
1h5ZyuSfBgTaz3/ycZYXXxB3ZwVUwMFMZXZuBKM0iez8ojxN1h3Q0bltJ0xxGuPk
RxYYY0GH3qi7gnXT1CxOZrTZ6JRWsaKyJgHO82GdperaU6DYNwfAADGX+5LgBlWO
6OYDFSlhN7xYHs5qaHsotjZb9cdz3Cb0zTkFb7fNL/T6k1zw5kxWHbEj5T93XXcM
6GH1tRjCmHMX1fuDwOFigMiJ46Vdgt8p4MWG1Kkazv4t9AI8KOMh1WMRikLZASJJ
A7imzq2AN9x/HDre280zDFrVHV7wVj4Tee9+HgTiZG7jsI1qyCMahiCc7dQlhxum
iWD49GUUapnfMj6tF1T9zVIzTcetezyR7ZfGrVqvN8bis/tHRMY2gjP8T935c+AT
CA+8oGRTogVfV66KZYLJfRCO6OqCJ8HGfx2YUh8U6INGYIlKM68nEACZFy+Y1sa1
O3tlnIQF2euvPU1b3SX9t6INBp3L5zwXZ1zH5zJZ0oWcjFsFKIuMs0fiSI3QAuSD
rcveQr1k+ioMRBoYz7Rs5Lk4N/+7QGEFCADO1tL7knwoF8SyrUbgF4runrecOX0j
/FIF6iKYfEAmAmNFDi1u
=djxt
-----END PGP SIGNATURE-----

--jh2aMSB6GbJCBf2jWJKot3KPQpaNg9JV4--

--===============1531333110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1531333110==--
