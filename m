From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 12/19] drm/amd/display: Don't guard x86 in Makefile
Date: Wed, 31 May 2017 18:30:07 +0200
Message-ID: <be6d2090-7961-032b-c74d-e60f6abeafa1@dev.carbon-project.org>
References: <20170531155218.29934-1-harry.wentland@amd.com>
 <20170531155218.29934-13-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0258537850=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170531155218.29934-13-harry.wentland-5C7GfCeVMHo@public.gmane.org>
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
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============0258537850==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="3RaHqOOsOXSok7eRGHt0KHBeUOiGKX0fv"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3RaHqOOsOXSok7eRGHt0KHBeUOiGKX0fv
Content-Type: multipart/mixed; boundary="x3jo8mn2pehhftf42cg2mF17FHfW3rLKw";
 protected-headers="v1"
From: =?UTF-8?Q?Kai_Wasserb=c3=a4ch?= <kai-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
To: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>,
 amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Message-ID: <be6d2090-7961-032b-c74d-e60f6abeafa1-1ZKVMVCtJ2dx9oSEVPI0kiST3g8Odh+X@public.gmane.org>
Subject: Re: [PATCH 12/19] drm/amd/display: Don't guard x86 in Makefile
References: <20170531155218.29934-1-harry.wentland-5C7GfCeVMHo@public.gmane.org>
 <20170531155218.29934-13-harry.wentland-5C7GfCeVMHo@public.gmane.org>
In-Reply-To: <20170531155218.29934-13-harry.wentland-5C7GfCeVMHo@public.gmane.org>

--x3jo8mn2pehhftf42cg2mF17FHfW3rLKw
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hey Harry,
you should drop this patch and remove the addition from patch 3 AFAICT.


Cheers,
Kai

P.S.: IIRC the conclusion of the last discussion was, that this code is n=
eeded
on non-x86 hardware as well. Shouldn't there at least be some TODO added
somewhere in the DCN code or maybe now in the Kconfig option, stating tha=
t this
needs to be fixed for other arches?


Harry Wentland wrote on 31.05.2017 17:52:
> make-kpkg doesn't seem to like it
>=20
> Change-Id: Ia589318e8632de57286c4a3d63a0a92a6cb96af3
> Signed-off-by: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
> Reviewed-by: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
> Acked-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gp=
u/drm/amd/display/dc/calcs/Makefile
> index 2e4ce0918c02..a095472bf4b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -3,11 +3,9 @@
>  # It calculates Bandwidth and Watermarks values for HW programming
>  #
> =20
> -ifeq ($(ARCH),x86)
>  CFLAGS_dcn_calcs.o :=3D -mhard-float -msse -mpreferred-stack-boundary=3D=
4
>  CFLAGS_dcn_calc_auto.o :=3D -mhard-float -msse -mpreferred-stack-bound=
ary=3D4
>  CFLAGS_dcn_calc_math.o :=3D -mhard-float -msse -mpreferred-stack-bound=
ary=3D4
> -endif
> =20
>  BW_CALCS =3D dce_calcs.o bw_fixed.o custom_float.o


--x3jo8mn2pehhftf42cg2mF17FHfW3rLKw--

--3RaHqOOsOXSok7eRGHt0KHBeUOiGKX0fv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEBgCWzvPI5zPlthWHownXbOHeWdIFAlku748ACgkQownXbOHe
WdLnBAv+LysJCEvs6mDg2h7S5sgGSSZwzFPtc6N5HNnGzLxAKI6wca2mfbrHJuwP
oEA/ukU+3aeiQaDLoU/lB2nq/yqlkbNPmtVJXqOh+4CuYCScqsiH+MISKORYMG3E
iRlNUh5c3j7opZdcoKwrJX/04BUT55F8H58XCcI+5qTPFyyFM4/VEx5DS5fjOxT8
OdwUWi3xuqxz2QLPBjexDLrIj2iPRDEp1yLtaZj6KheCicuHowMCHk1rkGHOxUXA
QGEeuUPlh+GtdLtZhl8TKI+vhH6Ui2xzCmbJ7FyPtFLuDJmRp6ecJQoB0l/T/zDX
RPl49qUDTQ/cfitZDHWGh87PzzF2HkLQw6gvyS9L+/OoDWVqdhOZUJOwhz1U2wJI
DcuDkJ9iDI8KRtK6i8NZaBuW3xYe0+qxnUHIbwVwxjRrD0sp/WU4wmlLXaA1uuZ+
iUuOHTX6aO1G/vSptABgIV03FDkD1MOki9+FZOXzCCvT+LbBaKSBZ1Z55nrAvkNv
6zydgbGA
=FDwN
-----END PGP SIGNATURE-----

--3RaHqOOsOXSok7eRGHt0KHBeUOiGKX0fv--

--===============0258537850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0258537850==--
